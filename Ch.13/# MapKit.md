# MapKit

인앱 프레임워크  
> 번들 프로그램을 앱 내부에서 사용하여 기능을 손쉽게 확장할 수 있도록 제공하는 별도의 프레임워크  
> 앱 내부에서 외부 앱 기능을 사용할 수 있도록 지원하는 프레임워크

## 인앱 프레임워크 종류
- `Cocoa Touch ` : iOS 앱을 개발하기 위한 각종 핵심 프레임워크 포함 
    * Foundation  
    * UIKit  
    * Address Book UI
    * Event Kit:  
        시스템에 등록되어 있거나, 애플계정으로 연동된 일정 및 스케줄 정보를 달력 형태로 표현해주는 뷰컨트롤러 제공
    * Message UI:  
        Message 기능을 사용할 수 있도록 지원
    * iAd Framework:  
        광고관련 프레임워크
    * Game Kit:  
        게임 센터를 이용하여 게임 사용자들을 서로 이어줄 수 있도록 지원
    * `Map Kit` :  
        애플에서 제공하는 지도에 관련된 기능을 사용할 수 있도록 지원

- Media
    * Video  
    * Core Animation  
    * Core Audio  
    * Quartz  
    * etc...

- Core Service  
    * Core Foundation  
    * CFNetwork  
    * Address Book  
    * Core Location
    * etc...

- Core OS
    * Kernel API

# MapKit Framework 사용
- CLLocationCoordinate2D:   
2차원 평면 형태의 위치 정보를 저장하는 객체로, 맵킷뷰에서 나타낼 맵의 중심 좌표를 정하는 역할

- CLLocationDistance:  
맵에 표현될 지도의 너비를 설정, 단위는 m  
값이 크면 클수록 축척이 작아져서 더 넓은 범위가 맵뷰에 표현된다.  

- MKCoordinateRegion:  
맵뷰에 전달될 객체

- MKPointAnnotation:  
지도에 특정위치를 표시해주는 기능  
    * coordinate: 표시할 위치 좌표를 받음 (CLLocationCoordinate2D)
    * addAnnotation(): MKPointAnnotation 객체를 맵뷰에 등록