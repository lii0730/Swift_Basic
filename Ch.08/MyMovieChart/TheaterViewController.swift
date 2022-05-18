//
//  TheaterViewController.swift
//  MyMovieChart
//
//  Created by LeeHsss on 2022/05/18.
//

import UIKit
import MapKit

class TheaterViewController: UIViewController {
    
    // 전달되는 데이터를 전달받을 변수
    var param: NSDictionary!
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.param["상영관명"] as? String
        
        // 위도, 경도 추출하여 Double Value로 캐스팅
        let lat = (self.param?["위도"] as! NSString).doubleValue
        let lng = (self.param?["경도"] as! NSString).doubleValue
        
        // 위도와 경도를 인수로 가지는 2D위치 정보 객체
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        // 지도에 표현될 거리(단위: m)
        let regionRadius: CLLocationDistance = 100
        // 거리를 반영한 지역 정보를 조합한 지도 데이터 생성
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        self.map.setRegion(coordinateRegion, animated: true)
        
        let point = MKPointAnnotation()
        point.coordinate = location
        self.map.addAnnotation(point)
    }
}
