//
//  CustomCell.swift
//  GithubSearch
//
//  Created by yongwoo on 2022/11/04.
//

import UIKit

class CustomCell: UITableViewCell {
    static var identifier = "CustomCell"

    let labelFrameView = UIView().then {
        $0.backgroundColor = UIColor.red
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    let imgView = UIImageView()

    let label = UILabel().then {
        $0.textColor = UIColor.blue
        $0.font = .systemFont(ofSize: 15)
        $0.numberOfLines = 7
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupLayout() {
        self.addSubview(labelFrameView)
        self.selectionStyle = .none
        labelFrameView.addSubview(label)
        self.addSubview(imgView)

        labelFrameView.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview().inset(10)
            $0.left.equalTo(60)
        }
        
        imgView.snp.makeConstraints {
            $0.left.equalTo(10)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(30)
        }

        label.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(20)
        }
    }
    
    func setCell(title: String, imageUrl: String) {
        self.label.text = title
        if let url = URL(string: imageUrl) {
            imgView.kf.setImage(with: url)
        }
    }
}
