//
//  goForWardViewController.swift
//  WebViewProject
//
//  Created by MacOS on 11.01.2022.
//

import UIKit
import WebKit
class GoForWardViewController: UIViewController {

    var webView = WebViewContainerViewController()
    @IBOutlet weak var goWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.webView.goForward()
  
    }
    



}
