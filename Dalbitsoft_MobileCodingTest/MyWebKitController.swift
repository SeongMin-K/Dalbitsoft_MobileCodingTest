//
//  MyWebKitController.swift
//  Dalbitsoft_MobileCodingTest
//
//  Created by SeongMinK on 2021/10/09.
//

import UIKit
import WebKit

class MyWebKitController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, "called")
        loadWebPage("https://www.naver.com")
    }
    
    private func loadWebPage(_ url: String) {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
