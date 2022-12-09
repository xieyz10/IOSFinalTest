//
//  UpdateViewController.swift
//  FinalTest
//
//  Created by Mingyuan Xie on 12/9/22.
//

import UIKit

class UpdateViewController: UIViewController {
    
    @IBOutlet weak var textfield_name: UITextField!
    @IBOutlet weak var textfield_age: UITextField!
    @IBOutlet weak var textfield_weight: UITextField!
    @IBOutlet weak var textfield_height: UITextField!
    @IBOutlet weak var textfield_gender: UITextField!
    @IBOutlet weak var label_category: UILabel!
    @IBOutlet weak var label_BMI: UILabel!
    var arr = [[String:String]]()
    var selectedItem = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initDetails()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func initDetails(){
        arr =  UserDefaults.standard.object(forKey: "arrayList") as? [[String:String]] ?? [[String:String]]()
        let selectedItem = arr[selectedItem]
        let measurement = selectedItem["measurement"]
        textfield_name.text = selectedItem["name"]
        textfield_age.text = selectedItem["age"]
        textfield_gender.text = selectedItem["gender"]
        label_category.text = selectedItem["category"]
        label_BMI.text = selectedItem["BMI"]
        
        if measurement == "metrix"{
            textfield_weight.text = selectedItem["weight"]! + " Kg"
            textfield_height.text = selectedItem["height"]! + " Centimeters"
        }else{
            textfield_weight.text = selectedItem["weight"]! + " Pounds"
            textfield_height.text = selectedItem["height"]! + " Inches"
        }
    }
    
    @IBAction func button_update_pressed(_ sender: UIButton) {
        if textfield_weight.text == "" || textfield_height.text == ""{
            return
        }
        let item = arr[selectedItem]
        let name = textfield_name.text ?? ""
        let age = textfield_age.text ?? ""
        let weight = textfield_weight.text ?? ""
        let height = textfield_height.text ?? ""
        let gender = textfield_gender.text ?? ""
        var BMI:Double! = Double(label_BMI.text!)
        let measurement = item["measurement"]
        var weight_d:Double! = 0.0
        var height_d:Double! = 0.0
        if weight != item["weight"] || height != item["height"]{
            //recalculate BMI
            weight_d = Double(textfield_weight.text!)
            height_d = Double(textfield_height.text!)
            if measurement == "metrix"{
                BMI = weight_d/((height_d/100)*(height_d/100))
            }else{
                BMI = (weight_d*703)/(height_d*height_d)
            }
        }
        var category:String = checkCategory(BMI: BMI)
        var formatBMI = String(format:"%.2f",BMI)
        
        arr[selectedItem]["name"] = name
        arr[selectedItem]["age"] = age
        arr[selectedItem]["weight"] = weight
        arr[selectedItem]["height"] = height
        arr[selectedItem]["category"] = category
        arr[selectedItem]["BMI"] = formatBMI
        UserDefaults.standard.set(arr,forKey:"arrayList")
        self.dismiss(animated: true, completion: nil)
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
    
    @IBAction func button_delete_pressed(_ sender: UIButton) {
        arr.remove(at: selectedItem)
        UserDefaults.standard.set(arr,forKey:"arrayList")
        let vc = storyboard?.instantiateViewController(identifier: "tableScreen") as! TableViewController
        let nc = UINavigationController(rootViewController: vc)
        present(nc, animated: true,completion: nil)
    }
}