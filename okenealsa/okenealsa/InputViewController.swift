//
//  InputViewController.swift
//  okenealsa
//
//  Created by 松岡　隆斗 on 2019/11/21.
//  Copyright © 2019 松岡　隆斗. All rights reserved.
//

import UIKit
import RealmSwift

class Spending: Object {
    @objc dynamic var category = ""
    @objc dynamic var price = 0
    @objc dynamic var contents = ""
}


class InputViewController: UIViewController {
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var contents: UITextField!
    
    var toolBar:UIToolbar!
    
    var datePicker: UIDatePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.price.keyboardType = UIKeyboardType.numberPad
        }
    
    @IBAction func bottonPress(_ sender: Any) {
        let mySpending = Spending()
        mySpending.category = category.text!
        mySpending.price =  Int(price.text!)!
        mySpending.contents = contents.text!
        
        let realm = try! Realm()
        
        try! realm.write{
            realm.add(mySpending)
        }
        
        let data = realm.objects(Spending.self).filter("price > 0")
        print(data)
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
