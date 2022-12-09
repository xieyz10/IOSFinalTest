//
//  TableViewController.swift
//  FinalTest
//
//  Created by Mingyuan Xie on 12/9/22.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableList: UITableView!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableList.delegate = self
        tableList.dataSource = self
        print("iin???s")
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var list = defaults.object(forKey: "arrayList") as? [[String:String]] ?? [[String:String]]()
        print("list.count is:\(list.count)")
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var arrayList = defaults.object(forKey: "arrayList") as? [[String:String]] ?? [[String:String]]()
        let list =  arrayList[indexPath.row]
        let cell =  tableList.dequeueReusableCell(withIdentifier: "cell",for:indexPath) as? TableViewCell
        
        cell!.label_BMI.text = list["BMI"]
        if list["measurement"] == "metric"{
            cell!.label_weight.text = (list["weight"] ?? "") + " Kg"
        }else{
            cell!.label_weight.text = (list["weight"] ?? "") + " Pounds"
        }
        cell!.label_date.text = list["date"]
        cell?.button_edit.tag = indexPath.row
        cell!.button_edit.addTarget(self, action: #selector(updateScreen(sender:)), for: .touchUpInside)
        return cell!
    }
    
    @objc func updateScreen(sender: UIButton){
        print("sender.tag is: \(sender.tag)")
        let vc = storyboard?.instantiateViewController(identifier: "updateScreen") as! UpdateViewController
        let nc = UINavigationController(rootViewController: vc)
        vc.selectedItem = sender.tag
        present(nc, animated: true,completion: nil)
    }
    
}
