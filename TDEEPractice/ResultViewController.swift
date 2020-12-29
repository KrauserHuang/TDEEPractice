//
//  ResultViewController.swift
//  TDEEPractice
//
//  Created by Tai Chin Huang on 2020/8/31.
//  Copyright © 2020 Tai Chin Huang. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var bmrLabel: UILabel!
    @IBOutlet weak var tdeeLabel: UILabel!
    
//    var demandCalories: Int?
//    var BMR: Double?
    var bmrInfo: BmrInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showYourResult()
    }
    
    func showYourResult() {
        var demandCalories: Int?
        var BMR: Double?
        if bmrInfo.sex == "Male"{
            //Male formula
            BMR = 10 * Double(bmrInfo.weight)! + 6.25 * Double(bmrInfo.height)! - 5 * Double(bmrInfo.age)! + 5
        } else {
            //Female formula
            BMR = 10 * Double(bmrInfo.weight)! + 6.25 * Double(bmrInfo.height)! - 5 * Double(bmrInfo.age)! - 161
        }
        switch bmrInfo.activitySelection {
        case "Sedentary(office job)" :
            demandCalories = Int(BMR! * 1.2)
        case "Light Exercise(1-2 days/week)" :
            demandCalories = Int(BMR! * 1.375)
        case "Moderate Exercise(3-5 days/week)" :
            demandCalories = Int(BMR! * 1.55)
        case "Heavy Exercise(6-7 days/week)" :
            demandCalories = Int(BMR! * 1.725)
        //"Athlete(2x per day)"
        default:
            demandCalories = Int(BMR! * 1.9)
        }
        if let demandCalories = demandCalories {
            bmrLabel.text = "\(Int(BMR!)) Cal"
            tdeeLabel.text = "\(demandCalories) Cal"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
