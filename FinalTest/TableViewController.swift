//
//  TableViewController.swift
//  FinalTest
//
//  Created by Mingyuan Xie on 12/9/22.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell",for:indexPath) as? TableViewCell
        
        cell!.label_BMI.text = list["BMI"]
        cell!.label_weight.text = list["weight"]
        cell!.label_date.text = list["date"]
       
        return cell!
    }
    
    
}
