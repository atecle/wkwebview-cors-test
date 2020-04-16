//
//  ViewController.swift
//  cors-test
//
//  Created by Alastair on 8/26/19.
//  Copyright © 2019 alastair. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let config = WKWebViewConfiguration()
        let wkview = WKWebView(frame: self.view.frame, configuration: config)
        self.view.addSubview(wkview)

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

        let baseURL = URL(string: "https://validbaseurl.com")!
        wkview.loadHTMLString(html, baseURL: baseURL)
        //wkview.load(html.data(using: .utf8)!, mimeType: "text/html", characterEncodingName: "UTF-8", baseURL: baseURL)
    }

}

