//
//  DetailViewController.swift
//  QiitaAPI
//
//  Created by 山根大生 on 2020/03/02.
//  Copyright © 2020 taisei. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController{
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = NSURL(string: detailUrl!){
            let request = NSURLRequest(url: url as URL)
            webView.load(request as URLRequest)
        }
    }
}
