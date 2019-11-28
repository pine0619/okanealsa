//
//  ViewController.swift
//  okenealsa
//
//  Created by 松岡　隆斗 on 2019/11/07.
//  Copyright © 2019 松岡　隆斗. All rights reserved.
//

import UIKit
import RealmSwift

class Spending: Object {
    @objc dynamic var category = ""
    @objc dynamic var price = 0
    @objc dynamic var contents = ""
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let mySpending = Spending();
        mySpending.category = "食費"
        mySpending.price = 500
        mySpending.contents = "コンビニでおにぎり, パン,　お茶を購入"
        
        let realm = try! Realm()
        
        try! realm.write{
            realm.add(mySpending)
        }
        
        let data = realm.objects(Spending.self).filter("price > 0")
        print(data)
    }


    @IBOutlet weak var date_outlet: UIDatePicker!
    
    
    @IBAction func date_action(_ sender: UIDatePicker) {
    }
    
    @IBOutlet weak var text_date: UITextField!
}
