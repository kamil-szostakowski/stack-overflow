//
//  ViewController.swift
//  image-frame
//
//  Created by szostakowskik on 26.10.2017.
//  Copyright © 2017 Kamil Szostakowski. All rights reserved.
//

import UIKit

class TwoImagesViewController: UIViewController
{
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var frameImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "portrait")!
        let aspectRatio = image.size.height / image.size.width
        
        let aspectRatioConstraint = NSLayoutConstraint(item: userImageView,attribute: .height,relatedBy: .equal,toItem: userImageView,attribute: .width,multiplier: aspectRatio,constant: 0)
        
        userImageView.image = image
        userImageView.addConstraint(aspectRatioConstraint)
        
        frameImageView.image = UIImage(named: "landscape-frame")
    }
}
