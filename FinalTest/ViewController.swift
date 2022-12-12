//
//  ViewController.swift
//  FinalTest
//
//  Created by Mingyuan Xie on 12/8/22.
//  version 1.0 first commit 12/09/2022
//  version 1.1 add functionalities 12/10/2022
//  version 1.2 fix layout issue 12/11/2022
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textfield_name: UITextField!
    @IBOutlet weak var textfield_age: UITextField!
    @IBOutlet weak var textfield_weight: UITextField!
    @IBOutlet weak var textfield_height: UITextField!
    @IBOutlet weak var textfield_gender: UITextField!
    @IBOutlet weak var label_BMImessage: UILabel!
    @IBOutlet weak var label_BMIResult: UILabel!
    @IBOutlet weak var button_metric: UIButton!
    @IBOutlet weak var button_imperial: UIButton!
    
    let defaults = UserDefaults.standard
    var arr = [[String:String]]()
    var currentMeasurement:String = "metric"
    let examineArray:[Character] = ["1","2","3","4","5","6","7","8","9","0","."]
    override func viewDidLoad() {
        super.viewDidLoad()
        currentMeasurement = "metric"
        textfield_weight.placeholder = "example: 60 kilograms (number only)"
        textfield_height.placeholder = "example: 178 centimeters (number only)"
        button_metric.backgroundColor = UIColor.blue
        button_metric.tintColor = UIColor.white
        if(UserDefaults.standard.object(forKey: "arrayList") == nil){
            defaults.set(arr,forKey:"arrayList")
        }
    }

    //metric button click function
    @IBAction func button_metric_pressed(_ sender: UIButton) {
        currentMeasurement = "metric"
        textfield_weight.placeholder = "example: 60 kilograms (number only)"
        textfield_height.placeholder = "example: 178 cm (number only)"
        button_metric.backgroundColor = UIColor.blue
        button_imperial.backgroundColor = UIColor.white
        
        button_metric.tintColor = UIColor.white
        button_imperial.tintColor = UIColor.blue
    }
    
    //imperial button click function
    @IBAction func button_imperial_pressed(_ sender: UIButton) {
        currentMeasurement = "imeprial"
        textfield_weight.placeholder = "example: 120 pounds (number only)"
        textfield_height.placeholder = "example:x.x inches (number only)"
        button_metric.backgroundColor = UIColor.white
        button_imperial.backgroundColor = UIColor.blue
        
        button_metric.tintColor = UIColor.blue
        button_imperial.tintColor = UIColor.white
    }
    
    //submit button click function
    @IBAction func button_submit_pressed(_ sender: UIButton) {
        var alert_empty = UIAlertController(title: "Wong Input Format", message: "Weight and height cannot be empty", preferredStyle: UIAlertController.Style.alert)
        alert_empty.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        var alert_numberOnly = UIAlertController(title: "Wong Input Format", message: "Number Only!", preferredStyle: UIAlertController.Style.alert)
        alert_numberOnly.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        if textfield_weight.text == "" || textfield_height.text == ""{
            self.present(alert_empty, animated: true, completion: nil)
            return
        }
        if !checkStr(str:textfield_weight.text!) || !checkStr(str:textfield_height.text!){
            self.present(alert_numberOnly, animated: true, completion: nil)
            return
        }
        var weight:Double! = 0.0
        var height:Double! = 0.0
        var BMI:Double! = 0.0
        var message:String = ""
        weight = Double(textfield_weight.text!)
        height = Double(textfield_height.text!)
        if currentMeasurement == "metric"{
            BMI = weight/((height/100)*(height/100))
        }else{
            BMI = (weight*703)/(height*height)
        }
        message = checkCategory(BMI: BMI)
        let formatBMI = String(format:"%.2f",BMI)
        label_BMIResult.text = formatBMI
        label_BMImessage.text = message

        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: now)
        
        let weight_str:String = String(weight)
        let height_str:String = String(height)
        let BMI_str = String(BMI)
        
        arr = defaults.object(forKey: "arrayList") as? [[String:String]] ?? [[String:String]]()
        var dict = [String:String]()
        dict["height"] = height_str
        dict["weight"] = weight_str
        dict["date"] = dateString
        dict["BMI"] = formatBMI
        if textfield_name.text != ""{
            dict["name"] = textfield_name.text
        }else{
            dict["name"] = ""
        }
        if textfield_age.text != ""{
            dict["age"] = textfield_age.text
        }else{
            dict["age"] = ""
        }
        if textfield_gender.text != ""{
            dict["gender"] = textfield_gender.text
        }else{
            dict["gender"] = ""
        }
        if currentMeasurement == "metric"{
            dict["measurement"] = "metric"
        }else{
            dict["measurement"] = "imperial"
        }
        dict["category"] = label_BMImessage.text
        arr.append(dict)
        print("arr.count is: \(arr.count)")
        defaults.set(arr,forKey:"arrayList")
    }
    
    //check if input content includes characters other than 0-9 and .
    func checkStr(str:String)->Bool{
        for char in str {
            if !examineArray.contains(char){
                return false
            }
        }
        return true
    }
    
    //check caregary of BMI
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
    
    //history button clicked
    @IBAction func button_history_pressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "tableScreen") as! TableViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }
    
    
    @IBAction func button_update_pressed(_ sender: UIButton) {
        textfield_name.text = ""
        textfield_age.text = ""
        textfield_gender.text = ""
        textfield_height.text = ""
        textfield_weight.text = ""
        label_BMImessage.text = "Currently No Category"
        label_BMIResult.text = "0.0"
    }
    
}

