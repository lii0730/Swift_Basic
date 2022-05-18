//
//  MyPageViewController.swift
//  MiddleP-Books
//
//  Created by LeeHsss on 2022/05/01.
//

import Foundation
import UIKit
import SnapKit

protocol DeleteDelegate {
    func Deleted(book: Book)
}

class MyPageViewController: UIViewController {
    
    var bookList: [Book]?
    
    var delegate: DeleteDelegate?
    
    lazy var emptyTextLabel: UILabel = {
        let label = UILabel()
        label.text = "도서 목록이 비어있습니다."
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        
        return tableView
    }()
    
    func layoutSubView() {
        [emptyTextLabel, tableView].forEach {
            view.addSubview($0)
        }
        
        emptyTextLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let bookList = self.bookList {
            if bookList.isEmpty {
                self.emptyTextLabel.isHidden = false
                self.tableView.isHidden = true
            } else {
                self.emptyTextLabel.isHidden = true
                self.tableView.isHidden = false
            }
        } else {
            NSLog("Error: Optional Not UnWrapping, bookList")
        }
        
        layoutSubView()
        
        tableView.register(SelectedBookCell.self, forCellReuseIdentifier: "SelectedBookCell")
        tableView.rowHeight = 120
        
    }
}

extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let bookList = self.bookList else { return 0 }
        
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedBookCell") as? SelectedBookCell else {
            return UITableViewCell()
        }
        
        guard let bookList = self.bookList else { return UITableViewCell() }
        let book = bookList[indexPath.row]
        
        cell.bookImageView.image = UIImage(named: book.imageURL)
        cell.titleLabel.text = book.title
        
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(OnClick(_:)), for: .touchUpInside)
        
        return cell
    }
}

extension MyPageViewController {
    @objc func OnClick(_ sender: UIButton) {
        let deletedBook = self.bookList?.remove(at: sender.tag)
        
        guard var book = deletedBook else { return }
        book.isGood = false
        delegate?.Deleted(book: book)
        self.tableView.reloadData()
        
        if(self.bookList?.count == 0) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
