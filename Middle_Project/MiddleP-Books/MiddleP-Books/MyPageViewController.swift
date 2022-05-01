//
//  MyPageViewController.swift
//  MiddleP-Books
//
//  Created by LeeHsss on 2022/05/01.
//

import Foundation
import UIKit
import SnapKit

class MyPageViewController: UIViewController {
    
    var bookList: [Book]?
    
    lazy var emptyTextLabel: UILabel = {
        let label = UILabel()
        label.text = "도서 목록이 비어있습니다."
        
        return label
    }()
    
    func layoutSubView() {
        [emptyTextLabel].forEach {
            view.addSubview($0)
        }
        
        emptyTextLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutSubView()
        
        if let bookList = self.bookList {
            if bookList.isEmpty {
                self.emptyTextLabel.isHidden = false
            } else {
                self.emptyTextLabel.isHidden = true
            }
        } else {
            NSLog("Error: Optional UnWrapping, bookList")
        }
    }
}
