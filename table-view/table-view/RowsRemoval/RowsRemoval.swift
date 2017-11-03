//
//  RowsRemoval.swift
//  table-view
//
//  Created by szostakowskik on 03.11.2017.
//  Copyright © 2017 Kamil Szostakowski. All rights reserved.
//

import UIKit

class RemovableCell: UITableViewCell
{
    // MARK: Interface
    
    var cellDidRequestRemoval: (() -> Void)?
    
    var contentText: String? {
        get { return contentLabel.text }
        set { contentLabel.text = newValue }
    }
    
    // MARK: Outlets
    
    var spViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var suplementaryViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var suplementaryViewContainer: UIView!
    @IBOutlet weak var contentViewContainer: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBAction func didTapRemoveButton(_ sender: UIButton)
    {
        let cellHeight = suplementaryViewContainer.frame.size.height
        
        suplementaryViewHeightConstraint.isActive = false
        spViewConstraint = suplementaryViewContainer.heightAnchor.constraint(equalToConstant: cellHeight)
        spViewConstraint.isActive = true        
        
        hideContentViewAnimated() { _ in
            self.contentViewContainer.isHidden = true
            self.cellDidRequestRemoval?()
            self.hideSuplementaryViewAnimated(completion: { _ in })
        }
    }
    
    // MARK: Helper methods    
    
    func hideContentViewAnimated(completion: @escaping (Bool) -> Void)
    {
        contentViewLeadingConstraint.constant = contentViewContainer.frame.size.width
        
        let animation = {
            self.suplementaryViewContainer.alpha = 1
            self.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.5, animations: animation, completion: completion)
    }
    
    func hideSuplementaryViewAnimated(completion: @escaping (Bool) -> Void)
    {
        spViewConstraint.constant = 0
        
        let animation = { () -> Void in
            self.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.3, animations: animation, completion: completion)
    }
}

class RowsRemovalController: UIViewController
{
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    fileprivate var tableData = [
        "Malesuada lorem ac, rutrum justo",
        "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
        "Cras eu pulvinar erat",
        "Consectetur adipiscing elit, Consectetur adipiscing elit, Consectetur adipiscing elit",
        "Phasellus et quam aliquet",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
}

extension RowsRemovalController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return indexPath.row % 2 == 0 ? 60 : 90
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let
        cell = tableView.dequeueReusableCell(of: RemovableCell.self, for: indexPath)
        cell.contentText = tableData[indexPath.row]
        cell.cellDidRequestRemoval = { [weak tableView] in
            
            guard let tableview = tableView else { return }
            guard let indexpath = tableview.indexPath(for: cell) else { return }
            
            self.tableView(tableview, commit: .delete, forRowAt: indexpath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            tableData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }
}

extension UITableView
{
    func dequeueReusableCell<Cell: UITableViewCell>(of cellClass: Cell.Type, for indexPath: IndexPath) -> Cell
    {
        return self.dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as! Cell
    }
}

