//
//  ViewController.swift
//  WebViewProject
//
//  Created by MacOS on 11.01.2022.
//

import UIKit
import WebKit

class WebViewContainerViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let url = URL(string: HTMLCodeString.googleString.rawValue)
    var isTheOtherSideButtonTapped : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWebView()
        configureActivityIndicator()
        
    }
    
    @IBAction func backWardButton(_ sender: Any) {
        webView?.goBack()
        
    }
    
    @IBAction func openInSafariButton(_ sender: Any) {
        guard let url = webView?.url else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    @IBAction func goForWardButton(_ sender: Any) {
        webView?.goForward()
    }
    
    @IBAction func goToOtherSide(_ sender: Any) {
        if isTheOtherSideButtonTapped == 1 {
            let fontSetting = "<span style=\"font-family: \("PingFangSC-Light");font-size: \(40)\"</span>"
            //Display html code with font settings
            let HTMLString = fontSetting + HTMLCodeString.aboutUsHTML.rawValue
            webView?.loadHTMLString(HTMLString, baseURL: nil)
            load(HTMLString: HTMLString)
        }else if isTheOtherSideButtonTapped == 2 {
            guard let url = URL(string: HTMLCodeString.googleString.rawValue) else { return }
            let urlRequest = URLRequest(url: url)
            load(urlRequest: urlRequest)
        }else {
        }
    }
    
    func configureWebView() {
        guard let url = URL(string: HTMLCodeString.googleString.rawValue) else { return }
        let urlRequest = URLRequest(url: url)
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        //webView.configuration = configuration
        webView?.uiDelegate = self
        webView?.navigationDelegate = self
        webView?.allowsBackForwardNavigationGestures = true
        webView?.addObserver(self,
                             forKeyPath: #keyPath(WKWebView.isLoading),
                             options: .new,
                             context: nil)
        //load(urlRequest: urlRequest)
        //set html code font and size
        let fontSetting = "<span style=\"font-family: \("PingFangSC-Light");font-size: \(40)\"</span>"
        //Display html code with font settings
        let HTMLString = fontSetting + HTMLCodeString.aboutUsHTML.rawValue
        load(HTMLString: HTMLString)
        print(isTheOtherSideButtonTapped)
    }
    
    func configureActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.color = .systemMint
        activityIndicator.hidesWhenStopped = true
    }
    
    func load(urlRequest: URLRequest){
        isTheOtherSideButtonTapped = 1
        webView?.load(urlRequest)
        
    }
    
    func load(HTMLString: String){
        isTheOtherSideButtonTapped = 2
        webView?.loadHTMLString(HTMLString, baseURL: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        
        if keyPath == "loading" {
            webView!.isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }
    }
}

extension WebViewContainerViewController: WKNavigationDelegate {
    
}

extension WebViewContainerViewController: WKUIDelegate {
    
}
