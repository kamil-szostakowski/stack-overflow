//
//  SecondController.swift
//  reusable-table-view
//
//  Created by szostakowskik on 11.01.2018.
//  Copyright © 2018 Kamil Szostakowski. All rights reserved.
//

import UIKit

class SecondController : UIViewController
{
    var reusableTableView: ReusableTableView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reusableTableView = ReusableTableView(tableView, ["consectur", "amet", "dolor", "sit", "ipsum", "lorem"])
    }
}
