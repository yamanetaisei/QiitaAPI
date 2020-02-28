//
//  ViewController.swift
//  QiitaAPI
//
//  Created by 山根大生 on 2020/02/27.
//  Copyright © 2020 taisei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    var articles = [[String: AnyObject]]()
    
    func getArticleData() {
                
        let baseURl = "https://qiita.com/api/v2/items"
        
        AF.request(baseURl, method: .get)
            .responseJSON{ response in
                switch response.result {
                case .success(let value):
                    print("Success! Got the data")
                    let articles : JSON = JSON(value)
                        if let article = articles.arrayObject {
                            self.articles = article as! [[String: AnyObject]]
                            print(articles)
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getArticleData()
    }


}

