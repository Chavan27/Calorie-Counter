//
//  MainViewController.swift
//  Calorie Counter
//
//  Created by Surabhi chavan on 07/12/18.
//  Copyright © 2018 Surabhi chavan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var totalCalories: UILabel!
    
    @IBOutlet weak var remainingValue: UILabel!
    
    @IBOutlet weak var eatenValue: UILabel!
    
    static var eatenCalories = 0
    static var targetCalories = ""
    static var remainingCalories = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        totalCalories.text  = MainViewController.targetCalories
        eatenValue.text = String(MainViewController.eatenCalories)
        MainViewController.remainingCalories = Int(MainViewController.targetCalories)!
        remainingValue.text = String(MainViewController.remainingCalories)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        eatenValue.text = String(MainViewController.eatenCalories)
        remainingValue.text = String(MainViewController.remainingCalories)
    }
    

}
