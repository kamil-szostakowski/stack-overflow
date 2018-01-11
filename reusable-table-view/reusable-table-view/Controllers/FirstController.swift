//
//  FirstController.swift
//  reusable-table-view
//
//  Created by szostakowskik on 11.01.2018.
//  Copyright © 2018 Kamil Szostakowski. All rights reserved.
//

import UIKit

class FirstController : UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    var reusableTableView: ReusableTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reusableTableView = ReusableTableView(tableView, ["Lorem", "ipsum", "dolor", "sit", "amet", "consectur"])
    }
}
