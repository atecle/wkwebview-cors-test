//
//  ViewController.swift
//  cors-test
//
//  Created by Alastair on 8/26/19.
//  Copyright © 2019 alastair. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKURLSchemeHandler {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let config = WKWebViewConfiguration()
        config.setURLSchemeHandler(self, forURLScheme: "test")
        
        let wkview = WKWebView(frame: self.view.frame, configuration: config)
        self.view.addSubview(wkview)
        wkview.load(URLRequest(url: URL(string: "test://host-one/index.html")!))
    }
    
    func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        if urlSchemeTask.request.url?.absoluteString == "test://host-one/index.html" {
            urlSchemeTask.didReceive(HTTPURLResponse(url: urlSchemeTask.request.url!, statusCode: 200, httpVersion: nil, headerFields: [
                "Content-Type": "text/html"
                ])!)
            
            let html = """
                <html>
                    <head>
                    </head>
                    <body>
                        <h1>Hello.</h1>
                        <script>
                            fetch('//host-two/index.html')
                            .then(res => res.json())
                            .then(json => {
                                document.body.innerHTML += "<h3>Success!</h3>";
                            })
                            .catch(err => {
                                document.body.innerHTML += "<h3>Failure.</h3>";
                                console.log(err);
                            });
                        </script>
                    </body>
                </html>
            """
            
            urlSchemeTask.didReceive(html.data(using: .utf8)!)
            urlSchemeTask.didFinish()
        } else if urlSchemeTask.request.url?.absoluteString == "test://host-two/test.json" {
            urlSchemeTask.didReceive(HTTPURLResponse(url: urlSchemeTask.request.url!, statusCode: 200, httpVersion: nil, headerFields: [
                "Content-Type": "application.json"
                ])!)
            
            let json = "{'test': true}"
            urlSchemeTask.didReceive(json.data(using: .utf8)!)
            urlSchemeTask.didFinish()
        } else {
            print("Received request for \(String(describing: urlSchemeTask.request.url))")
            urlSchemeTask.didReceive(HTTPURLResponse(url: urlSchemeTask.request.url!, statusCode: 404, httpVersion: nil, headerFields: [
                "Content-Type": "application.json"
                ])!)
            urlSchemeTask.didFinish()
        }
    }
    
    func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {
        
    }


}

