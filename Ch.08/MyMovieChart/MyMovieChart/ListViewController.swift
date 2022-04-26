//
//  ListViewController.swift
//  MyMovieChart
//
//  Created by LeeHsss on 2022/04/24.
//

import Foundation
import UIKit

class ListViewController: UITableViewController {
    
    @IBOutlet var moreButton: UIButton!
    
    var page = 1
//    var dataSet = [
//        ("다크나이트", "영웅물에 철학에 음악까지 더해져 예술이 되다.", "2008-09-04", 8.95, "banana.png"),
//        ("호우시절", "때를 알고 내리는 좋은 비", "2009-10-08", 7.31, "kiwi.png"),
//        ("말할 수 없는 비밀", "여기서 너까지 다섯 걸음", "2015-05-07", 9.19, "mango.png")
//    ]
    
    lazy var list: [MovieVO] = {
        var dataList = [MovieVO]()
//        for (title, desc, opendate, rating, thumbnail) in self.dataSet {
//            let mvo = MovieVO()
//            mvo.title = title
//            mvo.description = desc
//            mvo.opendate = opendate
//            mvo.rating = rating
//            mvo.thumbnail = thumbnail
//
//            dataList.append(mvo)
//        }
        
        return dataList
    }()
    
    override func viewDidLoad() {
        tableView.delegate = self
        
        //MARK: - RESTful API 호출
        self.callMovieAPI()
        
    }
    
    @IBAction func more(_ sender: UIButton) {
        self.page += 1
        self.callMovieAPI()
        self.tableView.reloadData()
    }
    
    private func callMovieAPI() {
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=\(self.page)&count=30&genreId=&order=releasedateasc"
        
        let apiURI: URL! = URL(string: url)
        let apiData = try! Data(contentsOf: apiURI)
        
        let log = NSString(data: apiData, encoding: String.Encoding.utf8.rawValue) ?? "데이터가 없습니다"
        
        NSLog("API Result = \(log)")
        
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apiData, options: []) as! NSDictionary
            
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            for row in movie {
                let r = row as! NSDictionary
                
                
                
                let mvo = MovieVO()
                mvo.title = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail = r["thumbnailImage"] as? String
                mvo.detail = r["linkUrl"] as? String
                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
                
                let url: URL! = URL(string: mvo.thumbnail!)
                let imageData = try! Data(contentsOf: url)
                mvo.thumbnailImage = UIImage(data: imageData)
                
                self.list.append(mvo)
                
                let totalCount = ((hoppin["totalCount"] as? NSString)!.integerValue)
                
                if self.list.count >= totalCount {
                    self.moreButton.isHidden = true
                }
                
            }
        } catch {
            
        }
    }
    
    
    //MARK: - 생성해야 할 행의 개수를 반환하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.list.count
    }
    
    //MARK: - 테이블 뷰 행을 구성하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        NSLog("제목: \(row.title!) 호출된 행번호: \(indexPath.row)")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        //dequeueReusableCell: 인자값으로 입력받은 아이디를 이용해서 스토리보드에 정의된 프로토타입 셀을 찾고 인스턴스로 생성하여 제공함
        
        // 구식 (deprecated 예정)
//        cell.textLabel?.text = row.title
//        cell.detailTextLabel?.text = row.description
        
        // 최신 UIListConfiguration 객체를 사용
//        var content = cell.defaultContentConfiguration()
//        content.text = row.title
//        content.secondaryText = row.description
//        cell.contentConfiguration = content
//        return cell
        
        //MARK: - Custom Cell Tag 이용
//        let title = cell.viewWithTag(101) as? UILabel
//        let desc = cell.viewWithTag(102) as? UILabel
//        let opendate = cell.viewWithTag(103) as? UILabel
//        let rating = cell.viewWithTag(104) as? UILabel
//
//        title?.text = row.title
//        desc?.text = row.description
//        opendate?.text = row.opendate
//        rating?.text = "\(row.rating!)"
        
        //MARK: - 커스텀 클래스 이용
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? MovieCell else { return UITableViewCell()}
        cell.title.text = row.title
        cell.desc.text = row.description
        cell.openDate.text = row.opendate
        cell.rating.text = "\(row.rating!)"
        
//        let url: URL! = URL(string: row.thumbnail!)
//        let imageData = try! Data(contentsOf: url)
//        cell.thumbnail.image = row.thumbnailImage
        
        //MARK: - 비동기 방식으로 처리
        DispatchQueue.main.async {
            cell.thumbnail.image = self.getThumbnailImage(indexPath.row)
        }
        
        return cell
    }
    
    private func getThumbnailImage(_ index: Int) -> UIImage {
        let mvo = self.list[index]
        
        if let savedImage = mvo.thumbnailImage {
            return savedImage
        } else {
            let url: URL! = URL(string: mvo.thumbnail!)
            let data = try! Data(contentsOf: url)
            mvo.thumbnailImage = UIImage(data: data)
            return mvo.thumbnailImage!
        }
    }
    
    //MARK: - 테이블 셀을 클릭하거나 터치했을 때 액션 처리를 위한 메서드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.section)섹션의 \(indexPath.row) 번째 행입니다.")
        print("section \(indexPath.section)")
        print("row \(indexPath.row)")
        print("item \(indexPath.item)")
        print("description \(indexPath.description)")
        print(indexPath)
    }
    
    //MARK: - 섹션의 개수 설정
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: - Section별 Header 지정
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Header1"
        case 1:
            return "Header2"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 80
        case 1:
            return 120
        case 2:
            return 300
        default:
            return 80
        }
    }
}
