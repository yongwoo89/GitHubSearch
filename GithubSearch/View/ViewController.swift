//
//  ViewController.swift
//  GithubSearch
//
//  Created by yongwoo on 2022/11/04.
//

import UIKit
import Then
import SnapKit
import Kingfisher
import RxSwift

class ViewController: UIViewController {

    private var result: [String] = []
    
    private let viewModel = ViewModel()
    private let disposeBag = DisposeBag()
    
    let naviView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    let contentsView = UIView().then {
        $0.backgroundColor = .blue
    }
    
    let searchTf = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.placeholder = "검색어를 입력하세요."
        $0.autocapitalizationType = .none
    }
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .red

        setupLayout()
        
        bindViewModel()
    }
    
    private func setupLayout() {
        view.addSubview(naviView)
        naviView.addSubview(searchTf)
        view.addSubview(contentsView)
        contentsView.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCell.self,
                           forCellReuseIdentifier: CustomCell.identifier)
        
        naviView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        searchTf.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        contentsView.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
        }
        
        tableView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
    private func bindViewModel() {
        let input = ViewModel.Input(searchString: searchTf.rx.text.orEmpty.asObservable())
        let output = viewModel.transform(input: input)
        output.result.subscribe {(val) in
            guard let result = val.element else { return }
            self.result = result
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
}


// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.result.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier) as? CustomCell else {
            return UITableViewCell()
        }
        let title = result[indexPath.row]

        cell.setCell(title: title,
                     imageUrl: "https://picsum.photos/200/300")

        return cell
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelect")
    }
}
