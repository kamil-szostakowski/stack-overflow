//
//  ExpandableCell.swift
//  table-view
//
//  Created by szostakowskik on 16.10.2017.
//  Copyright © 2017 Kamil Szostakowski. All rights reserved.
//

import UIKit
import Foundation

protocol ExpandableCell: class
{
    var model: ItemModel! { get set }
    var onExpandRequest: (() -> Void)? { get set }
}

class StaticExpandableCell: UITableViewCell, ExpandableCell
{
    // MARK: Interface
    
    var onExpandRequest: (() -> Void)?
    
    var model: ItemModel! {
        didSet {
            contentTitleLabel.text = model.title
            contentTextLabel.text = model.description
            contentTextLabel.isHidden = !model.isExpanded
        }
    }
    
    // MARK: Internals
    
    @IBOutlet private weak var contentTextLabel: UILabel!
    @IBOutlet private weak var contentTitleLabel: UILabel!
}

class EditableExpandableCell: UITableViewCell, UITextViewDelegate, ExpandableCell
{
    // MARK: Interface
    var onModelChange: ((ItemModel) -> Void)?
    var onExpandRequest: (() -> Void)?
    
    var model: ItemModel! {
        didSet {
            contentTitleLabel.text = model.title
            contentTextView.text = model.description
            descriptionTextHeight.constant = contentTextView.contentSize.height
            contentTextView.isHidden = !model.isExpanded
        }
    }
    
    // MARK: Internals
        
    @IBOutlet weak var descriptionTextHeight: NSLayoutConstraint!
    @IBOutlet private weak var contentTextView: UITextView!
    @IBOutlet private weak var contentTitleLabel: UILabel!
    
    func textViewDidChange(_ textView: UITextView)
    {
        let oldHeight = descriptionTextHeight.constant
        let newHeight = contentTextView.contentSize.height        
        
        model.description = contentTextView.text
        onModelChange?(model)                
        
        if abs(oldHeight-newHeight) > 1 {
            onExpandRequest?()
        }
    }
}
