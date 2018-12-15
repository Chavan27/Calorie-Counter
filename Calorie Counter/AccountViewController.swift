//
//  AccountViewController.swift
//  Calorie Counter
//
//  Created by Surabhi chavan on 07/12/18.
//  Copyright © 2018 Surabhi chavan. All rights reserved.
//

import UIKit
import CoreML
import Vision


class AccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var foodItem = ["ORANGE", "STRAWBERRY", "BANANA"]
    var foodCalories = [45, 4, 100]
    
    var resultCalories = 0
    
    @IBOutlet weak var addedView: UIView!
    //CoreML Model :
    let model = Resnet50()
    
        //image picker :
    @IBOutlet weak var imageView: UIImageView!
    
    var picker = UIImagePickerController()
        
    @IBOutlet weak var result: UILabel!
    
    
    @IBAction func addFoodItem(_ sender: Any) {
        MainViewController.eatenCalories = MainViewController.eatenCalories + self.resultCalories
        MainViewController.remainingCalories
            = MainViewController.remainingCalories - self.resultCalories
        self.addedView.isHidden = false
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
            self.addedView.isHidden = true
        }
        
    }
  
    @IBAction func openPhoneCamera(_ sender: Any) {
        openCamera()
    }
    
    //Entry Point :
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            picker.delegate = self 
            addedView.isHidden = true
            
            
        }
    @IBAction func captureImageAction(_ sender: UIButton) {
        openPhotoLibrary()
        
    }
    
        @objc func openCamera() {
            
            picker.sourceType = .camera
            picker.allowsEditing = true
            
            self.present(picker, animated: true, completion: nil)
        }
        
        
        @objc func openPhotoLibrary() {
            
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            
            self.present(picker, animated: true, completion: nil)
        }
        

        
        
     @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            
            if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
                
                self.imageView.image = image
                
            }
            
            guard let image = imageView.image, let ciImage = CIImage(image: image) else {return}
            
            detect(image: ciImage)
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
        
        func detect(image: CIImage) {
           
            guard let model = try? VNCoreMLModel(for: model.model) else {fatalError()}
            
            let request = VNCoreMLRequest(model: model) { (request, error) in
                guard let results = request.results as? [VNClassificationObservation],
                    let topResult = results.first else {fatalError()}
                
                DispatchQueue.main.async {
                   let resultantString = topResult.identifier.uppercased()
                    
                    switch(resultantString) {
                    case "ORANGE" :   self.resultCalories = self.foodCalories[0]
                    case "STRAWBERRY" :  self.resultCalories = self.foodCalories[1]
                    case "BANANA" :   self.resultCalories = self.foodCalories[2]
                    default : break
                    }
                    
                    
                   
                    self.result.text = resultantString + " : " + String(self.resultCalories) + " calories"
                    
                }
            }
            
            let handler = VNImageRequestHandler(ciImage: image)
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    try handler.perform([request])
                }catch {
                    print(error)
                }
            }
        }
    }


