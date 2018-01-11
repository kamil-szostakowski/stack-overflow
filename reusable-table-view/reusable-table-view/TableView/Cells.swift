//
//  FirstCell.swift
//  reusable-table-view
//
//  Created by szostakowskik on 11.01.2018.
//  Copyright © 2018 Kamil Szostakowski. All rights reserved.
//

import UIKit

protocol LabeledCell
{
    var titleLabel: UILabel! { get }
}

class FirstCell : UITableViewCell, LabeledCell
{
    @IBOutlet weak var titleLabel: UILabel!    
}

class SecondCell : UITableViewCell, LabeledCell
{    
    @IBOutlet weak var titleLabel: UILabel!
}
