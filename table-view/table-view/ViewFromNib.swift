//
//  ViewFromNib.swift
//  table-view
//
//  Created by szostakowskik on 30.10.2017.
//  Copyright © 2017 Kamil Szostakowski. All rights reserved.
//

import UIKit

class ViewFromNib : UIView
{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fill(with: loadViewHierarhyFromNib()!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fill(with: loadViewHierarhyFromNib()!)
    }
}

extension UIView
{
    func loadViewHierarhyFromNib() -> UIView?
    {
        let bundle = Bundle(for: type(of: self))
        let nibName = String(describing: type(of: self))
        
        return bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView
    }
    
    func fill(with view: UIView)
    {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate(NSLayoutConstraint.fillingContrainsts(for: view))
    }
}

extension NSLayoutConstraint
{
    static func fillingContrainsts(for view: UIView) -> [NSLayoutConstraint]
    {
        let bindings = ["view": view]
        let options = NSLayoutFormatOptions(rawValue: 0)
        
        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: options, metrics: nil, views: bindings)
        
        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: options, metrics: nil, views: bindings)
        
        return horizontal + vertical
    }
}
