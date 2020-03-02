//
//  TableViewController.swift
//  QiitaAPI
//
//  Created by 山根大生 on 2020/02/28.
//  Copyright © 2020 taisei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewConroller:UITableViewController,UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var articles = [[String: AnyObject]]()
    let baseURL = "https://qiita.com/api/v2/items"
    
    func getArticleData(url : String){
        //urlの受け渡し
        AF.request(baseURL, method: .get)
            //↑に対するレスポンスについて
            .responseJSON{ response in
                switch response.result {
                //レスポンスがきた
                case .success(let value):
                    print("Success! Got the data")
                    let articles : JSON = JSON(value)
                        if let article = articles.arrayObject {
                            self.articles = article as! [[String: AnyObject]]
                            print(articles)
                    }
                //返ってこない
                case .failure(let error):
                    print(error)
                }
                if self.articles.count > 0{
                    self.tableView?.reloadData()
                }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getArticleData(url: baseURL + "?page=1&query=tag%3A" + searchBar.text!)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getArticleData(url: baseURL)
    }
}

extension TableViewConroller{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let articlePath = articles[indexPath.row]
        cell?.textLabel?.text = articlePath["title"] as? String
        return cell!
    }
}
