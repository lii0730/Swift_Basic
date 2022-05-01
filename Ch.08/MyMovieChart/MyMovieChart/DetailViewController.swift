//
//  DetialViewController.swift
//  MyMovieChart
//
//  Created by LeeHsss on 2022/04/28.
//

import Foundation
import UIKit
import WebKit


class DetailViewController: UIViewController {
    @IBOutlet var wv: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var mvo: MovieVO!
    
    override func viewDidLoad() {
        self.wv.navigationDelegate = self
        
        NSLog("linkUrl: \(self.mvo.detail!), title: \(self.mvo.title!)")
        
        let naviBar = self.navigationItem
        naviBar.title = self.mvo.title!
        
        let url = URL(string: self.mvo.detail!)
        let request = URLRequest(url: url!)
        
        self.wv.load(request)
    }
}

extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.spinner.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.spinner.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating()
        
//        let alert = UIAlertController(title: "오류", message: "상세페이지를 읽어오지 못했습니다", preferredStyle: .alert)
//
//        let cancelAction = UIAlertAction(title: "확인", style: .cancel) { _ in
//            _ = self.navigationController?.popViewController(animated: true)
//        }
//
//        alert.addAction(cancelAction)
//        self.present(alert, animated: true)
        
        self.alert("상세페이지를 읽어오지 못했습니다") {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating()
        
        self.alert("상세페이지를 읽어오지 못했습니다") {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
}

extension UIViewController {
    func alert(_ message: String, onClick: (() -> Void)? = nil) {
        let controller = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            onClick?()
        }))
        
        DispatchQueue.main.async {
            self.present(controller, animated: true)
        }
    }
}
