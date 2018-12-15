//
//  TargetViewController.swift
//  Calorie Counter
//
//  Created by Surabhi chavan on 07/12/18.
//  Copyright © 2018 Surabhi chavan. All rights reserved.
//

import UIKit

class TargetViewController: UIViewController {
    @IBOutlet weak var targetCalories: UITextField!
    
    @IBOutlet weak var invalidInputLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invalidInputLabel.isHidden = true

    }

    @IBAction func donePressed(_ sender: Any) {
        
//        if targetCalories.text == "" || !(targetCalories.text?.isNumber)!  {
//            invalidInputLabel.isHidden = false
//            
//            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
//                self.invalidInputLabel.isHidden = true
//            }
            
    
            
        MainViewController.targetCalories = self.targetCalories.text!
       
    }
    
}


extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
