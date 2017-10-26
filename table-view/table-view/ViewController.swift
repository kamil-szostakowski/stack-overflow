//
//  ViewController.swift
//  table-view
//
//  Created by szostakowskik on 16.10.2017.
//  Copyright © 2017 Kamil Szostakowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource = [ItemModel]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupDataSource()
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
    }    
    
    // MARK: Setup methods
    
    func setupDataSource()
    {
        dataSource = Array(0...20).map(){
            let title = "Item title, row: \($0)"
            let description = "\($0) Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse quis lectus ultrices, porta eros sit amet, auctor elit. Etiam ut faucibus tellus, vitae consequat magna."
            
            var
            model = ItemModel(title: title, description: description)
            model.isEditable = $0 % 2 == 0
            model.isExpanded = false
            
            return model
        }
    }
    
    // MARK: UITableViewDelegateMethods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let model = dataSource[indexPath.row]
        let cellClass = dataSource[indexPath.row].tableViewCellClass
        
        let
        cell = tableView.dequeueReusableCell(of: cellClass, for: indexPath) as! ExpandableCell & UITableViewCell
        cell.model = model
        
        cell.onExpandRequest = { () -> Void in
            tableView.beginUpdates()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        
        if let editableCell = cell as? EditableExpandableCell {
            editableCell.onModelChange = { model in
                self.dataSource[indexPath.row] = model
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let isExpanded = dataSource[indexPath.row].isExpanded
        dataSource[indexPath.row].isExpanded = !isExpanded
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}

extension UITableView
{    
    func dequeueReusableCell<Cell: UITableViewCell>(of cellClass: Cell.Type, for indexPath: IndexPath) -> Cell
    {
        return self.dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as! Cell
    }
}

