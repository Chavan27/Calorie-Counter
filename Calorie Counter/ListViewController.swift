//
//  ListViewController.swift
//  Calorie Counter
//
//  Created by Surabhi chavan on 07/12/18.
//  Copyright © 2018 Surabhi chavan. All rights reserved.
//

import UIKit

class ListViewController:UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var itemAddedView: UIView!
    
    var foodNameArray = ["Eggs","Apple","Banana"]
    var caloriesArray = [150, 60, 100]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodNameArray.count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemAddedView.isHidden =   true
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.itemAddedView.isHidden =   false
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
        self.itemAddedView.isHidden =   true
        }
        
        MainViewController.eatenCalories =  MainViewController.eatenCalories +  caloriesArray[indexPath.row]
        MainViewController.remainingCalories = MainViewController.remainingCalories - caloriesArray[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodListCell", for: indexPath)  as!  FoodListCell
        
        cell.foodName.text =  foodNameArray[indexPath.row]
        cell.calories.text =   String(caloriesArray[indexPath.row])
     
        
        return cell
    }
    
    

}
