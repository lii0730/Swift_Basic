//
//  ViewController.swift
//  MyMovieChart-SpinOff
//
//  Created by LeeHsss on 2022/04/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("\(indexPath.row) 번째 데이터가 클릭됨")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
//        var content = cell.defaultContentConfiguration()
//        content.text = "\(indexPath.row)번째 데이터입니다."
//        cell.contentConfiguration = content
        cell.textLabel?.text = "Hello"
        cell.detailTextLabel?.text = "world"
        return cell
    }
}
