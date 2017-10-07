//
//  P4ViewController.swift
//  StackOverflow
//
//  Created by szostakowskik on 06.10.2017.
//  Copyright © 2017 Kamil Szostakowski. All rights reserved.
//

import UIKit
import Foundation

class P4ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    let data = [["AAA", "BBB"], ["aaa", "bbbb", "ccc", "dddd", "eee"], ["1234", "2345", "3456", "4567"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[component][row]
    }
}
