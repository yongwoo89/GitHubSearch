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
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }

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

        labelFrameView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(10)
        }

        label.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(20)
        }
    }
    
    func setCell(title: String) {
        self.label.text = title
    }
}
