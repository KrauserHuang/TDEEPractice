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
    
//    struct BmrInfo {
//        var sex: String
//        var age: String
//        var height: String
//        var weight: String
//        var activitySelection: String
//    }
        
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
            }
            view.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if ageTextField.text?.isEmpty == false,
           heightTextField.text?.isEmpty == false,
           weightTextField.text?.isEmpty == false,
           activityButtonText.titleLabel?.text?.isEmpty == false {
            return true
        } else {
            let controller = UIAlertController(title: "Please fill in all the blank", message: "You need to fill all the blank to calculate your BMR & TDEE", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
            return false
            }
    }
    
    @IBSegueAction func showResult(_ coder: NSCoder) -> ResultViewController? {
        let sex = sexSegmented.titleForSegment(at: sexSegmented.selectedSegmentIndex) ?? "Male"
        let age = ageTextField.text!
        let height = heightTextField.text!
        let weight = weightTextField.text!
        let activitySelection = activityButtonText.titleLabel?.text ?? "Sedentary(office job)"
        let controller = ResultViewController(coder: coder)
        controller?.bmrInfo = BmrInfo(sex: sex, age: age, height: height, weight: weight, activitySelection: activitySelection)
        return controller
    }
}
