//
//  ReusableTableView.swift
//  reusable-table-view
//
//  Created by szostakowskik on 11.01.2018.
//  Copyright © 2018 Kamil Szostakowski. All rights reserved.
//

import UIKit
import Foundation

class ReusableTableView: NSObject, UITableViewDataSource, UITableViewDelegate
{
    var tableView: UITableView
    var tableViewData: [String]
    
    init(_ tv: UITableView, _ data: [String])
    {
        tableViewData = data
        tableView = tv
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Register all of your cells
        tableView.register(UINib(nibName: "FirstCell", bundle: nil), forCellReuseIdentifier: "odd-id")
        tableView.register(UINib(nibName: "SecondCell", bundle: nil), forCellReuseIdentifier: "even-id")        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = indexPath.row % 2 == 0 ? "even-id" : "odd-id"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! LabeledCell & UITableViewCell
        cell.titleLabel.text = tableViewData[indexPath.row]
        
        return cell
    }
}
