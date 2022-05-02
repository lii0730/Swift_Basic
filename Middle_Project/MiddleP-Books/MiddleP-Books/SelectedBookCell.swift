//
//  SelectedBookCell.swift
//  MiddleP-Books
//
//  Created by LeeHsss on 2022/05/02.
//

import Foundation
import UIKit

class SelectedBookCell: UITableViewCell {
    
    lazy var bookImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Test Label"
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.bin.circle"), for: .normal)
        button.tintColor = UIColor.red
        return button
    }()
    
    override func layoutSubviews() {
        [bookImageView, titleLabel, deleteButton].forEach {
            addSubview($0)
        }
        
        bookImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(100)
            $0.leading.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(bookImageView.snp.trailing).offset(20)
            $0.top.equalTo(bookImageView.snp.top).inset(10)
            $0.width.equalTo(100)
//            $0.trailing.equalTo(deleteButton.snp.leading).offset(10)
        }
        
        deleteButton.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(20)
            $0.centerY.equalTo(bookImageView)
        }
    }
    
}
