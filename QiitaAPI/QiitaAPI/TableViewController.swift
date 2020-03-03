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

var articlePath: [String : AnyObject]?
var path: Int?
var detailUrl:String?

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
                    let articles: JSON = JSON(value)
                    // APIから取得した値が配列の形か判定
                        if let article = articles.arrayObject {
                            // JSONの形式からString型へ強制キャスト
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
        articlePath = articles[indexPath.row]
        cell?.textLabel?.text = articlePath?["title"] as? String
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        path = indexPath.row
        let articleDetail = articles[indexPath.row]
        detailUrl = articleDetail["url"] as? String
    }
}
