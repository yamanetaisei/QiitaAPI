//
//  TableViewController.swift
//  
//
//  Created by 山根大生 on 2020/02/26.
//

import UIKit
import SwiftyJSON
import Alamofire

class TableViewController:UITableViewController,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var articles = [[String: AnyObject]]()
    let baseURL = "https://qiita.com/api/v2/items"

}
