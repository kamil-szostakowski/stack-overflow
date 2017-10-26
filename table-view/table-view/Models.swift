//
//  Models.swift
//  table-view
//
//  Created by szostakowskik on 17.10.2017.
//  Copyright © 2017 Kamil Szostakowski. All rights reserved.
//

import UIKit
import Foundation

struct ItemModel
{
    var title: String
    var description: String
    var isExpanded: Bool = false
    var isEditable: Bool = false
    
    init(title titleString: String, description descString: String) {
        title = titleString
        description = descString
    }
}

extension ItemModel
{
    var tableViewCellClass: UITableViewCell.Type {
        switch isEditable
        {
            case true:
            return EditableExpandableCell.self
            
            case false:
            return StaticExpandableCell.self
        }
    }
}

