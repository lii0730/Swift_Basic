//
//  ListViewController.swift
//  TableView-CellHeight
//
//  Created by LeeHsss on 2022/04/24.
//

import Foundation
import UIKit

class ListViewController: UITableViewController {
    var list = [String]()
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "목록입력", message: "추가될 글을 작성해주세요", preferredStyle: .alert)
        
        alert.addTextField { tf in
            tf.placeholder = "내용 입력"
        }
        
        let ok = UIAlertAction(title: "OK", style: .default) { _ in
            if let title = alert.textFields?[0].text {
                self.list.append(title)
                self.tableView.reloadData()
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // A ?? B : A가 nil이 아닐 경우 옵셔널 해제, nil인 경우 B값을 대신 사용
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        
        var content = cell.defaultContentConfiguration()
        content.text = list[indexPath.row]
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    //MARK: - height를 고정값으로 두면 컨텐츠의 길이가 길든 짧든 고정된 값으로 생성
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let row = self.list[indexPath.row]
//
//        let height = CGFloat(60 + (row.count / 30) * 20)
//        return height
//
//    }
    
    //MARK: - height를 고정값으로 주어도 컨텐츠에 따라 자동으로 cell의 Height이 변경됨
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        let row = self.list[indexPath.row]

//        let height = CGFloat(60 + (row.count / 30) * 20)
//        let height = CGFloat(60.0)
//        return height
        
        var height: CGFloat = 30
        tableView.rowHeight = UITableView.automaticDimension
        
        switch indexPath.row {
        case 0:
            return height
        case 1:
            return height * 2
        case 2:
            return height * 3
        default:
            return height * 4
        }
    }
}
