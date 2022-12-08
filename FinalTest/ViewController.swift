//
//  ViewController.swift
//  FinalTest
//
//  Created by Mingyuan Xie on 12/8/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textfield_name: UITextField!
    @IBOutlet weak var textfield_age: UITextField!
    @IBOutlet weak var textfield_weight: UITextField!
    @IBOutlet weak var textfield_height: UITextField!
    @IBOutlet weak var label_BMImessage: UILabel!
    @IBOutlet weak var label_BMIResult: UILabel!
    var currentMeasurement:String = "metric"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentMeasurement = "metric"
        textfield_weight.placeholder = "example: 60 kilograms (number only)"
        textfield_height.placeholder = "example: 178 centimeters (number only)"
    }

    @IBAction func button_metric_pressed(_ sender: UIButton) {
        currentMeasurement = "metric"
        textfield_weight.placeholder = "example: 60 kilograms (number only)"
        textfield_height.placeholder = "example: 178 cm (number only)"
    }
    
    @IBAction func button_imperial_pressed(_ sender: UIButton) {
        currentMeasurement = "imeprial"
        textfield_weight.placeholder = "example: 120 pounds (number only)"
        textfield_height.placeholder = "example:x.x inches (number only)"
    }
    
    @IBAction func button_tracking_pressed(_ sender: UIButton) {
    }
    
    @IBAction func button_submit_pressed(_ sender: UIButton) {
        var BMI:Double! = 0.0
        if textfield_weight.text == "" || textfield_height.text == ""{
            return
        }
        if currentMeasurement == "metric"{
            let age:Double! = Double(textfield_age.text!)
            let weight:Double! = Double(textfield_weight.text!)
            let height:Double! = Double(textfield_height.text!)
            let BMI:Double! = weight/((height/100)*(height/100))
            let message:String = checkCategory(BMI: BMI)
            label_BMIResult.text = String(format:"%.2f",BMI)
            label_BMImessage.text = message
        }else{
            
        }
    }
    
    func checkCategory(BMI:Double)->String{
        if BMI<16{
            return "Severe Thinness"
        }else if BMI >= 16 && BMI < 17{
            return "Moderare Thinness"
        }else if BMI >= 17 && BMI < 18.5{
            return "Mild Thinness"
        }else if BMI >= 18.5 && BMI < 25{
            return "Normal"
        }else if BMI >= 25 && BMI < 30{
            return "Overweight"
        }else if BMI >= 30 && BMI < 35{
            return "Obese Class I"
        }else if BMI >= 35 && BMI < 40{
            return "Obese Class II"
        }else{
            return "Obese Class III"
        }
    }
    
}

