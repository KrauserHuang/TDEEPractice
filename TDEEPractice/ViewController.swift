//
//  ViewController.swift
//  TDEEPractice
//
//  Created by Tai Chin Huang on 2020/8/31.
//  Copyright © 2020 Tai Chin Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Choose your sex
    @IBOutlet weak var sexSegmented: UISegmentedControl!
    //Enter your age/height/weight
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    //Display activity text from activityPickerView
    @IBOutlet weak var activityButtonText: UIButton!
    //Display warning label if not fill all the parameter
    @IBOutlet weak var warningLabel: UILabel!
    //Show result of your BMR/TDEE
    @IBOutlet weak var bmrLabel: UILabel!
    @IBOutlet weak var tdeeLabel: UILabel!
    //Merge activityPickerView & doneButton into activitySelectView
    @IBOutlet weak var activitySelectView: UIView!
    @IBOutlet weak var activityPickerView: UIPickerView!
    //When press this button, show activitySelectView(activityPickerView & doneButton)
    @IBAction func activityChooseButton(_ sender: Any) {
        activitySelectView.isHidden = false
        view.endEditing(true)
    }
    
    //Array for activityPickerView
    let exercise = ["Sedentary(office job)","Light Exercise(1-2 days/week)","Moderate Exercise(3-5 days/week)","Heavy Exercise(6-7 days/week)","Athlete(2x per day)"]
//    let exercise = ["Sedentary","Light Exercise","Moderate Exercise","Heavy Exercise","Athlete"]
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return exercise.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return exercise[row]
    }
    
    //When finish picking your activity status, close the activitySelectView
    @IBAction func doneButton(_ sender: Any) {
        //Select any item to return corresponding index
        let activitySelection = exercise[activityPickerView.selectedRow(inComponent: 0)]
        //Change activityButtonText to corresponding text
        activityButtonText.setTitle(activitySelection, for: .normal)
        activitySelectView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Hide activitySelectView & warningLabel when first loading view
        if activitySelectView.isHidden == false {
            activitySelectView.isHidden = true
            warningLabel.isHidden = true
            }
            view.endEditing(true)
    }
    @IBAction func calculateButton(_ sender: Any) {
        view.endEditing(true)
        if let sex = sexSegmented.titleForSegment(at: sexSegmented.selectedSegmentIndex), let height = heightTextField.text, let weight = weightTextField.text, let age = ageTextField.text, let activitySelection = activityButtonText.titleLabel?.text{
            var demandCalories : Int?
            var BMR : Double?
            if weight != "",height != "",age != ""{
                if sex == "Male"{
                    //Male formula
                    BMR = 10 * Double(weight)! + 6.25 * Double(height)! - 5 * Double(age)! + 5
                } else {
                    //Female formula
                    BMR = 10 * Double(weight)! + 6.25 * Double(height)! - 5 * Double(age)! - 161
                }
                //TDEE result with each activitySelection
                switch activitySelection {
                case "Sedentary(office job)" :
                    demandCalories = Int(BMR! * 1.2)
                case "Light Exercise(1-2 days/week)" :
                    demandCalories = Int(BMR! * 1.375)
                case "Moderate Exercise(3-5 days/week)" :
                    demandCalories = Int(BMR! * 1.55)
                case "Heavy Exercise(6-7 days/week)" :
                    demandCalories = Int(BMR! * 1.725)
                case "Athlete(2x per day)":
                    demandCalories = Int(BMR! * 1.9)
                default :
                    warningLabel.isHidden = false
                }
                if let demandCalories = demandCalories {
                    bmrLabel.text = "\(Int(BMR!)) Cal"
                    tdeeLabel.text = "\(demandCalories) Cal"
                    warningLabel.isHidden = true
                }
            } else {
                warningLabel.isHidden = false
            }
            
        }
    }
    

}

