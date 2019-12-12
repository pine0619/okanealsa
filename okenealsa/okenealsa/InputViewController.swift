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
    @objc dynamic var date = ""
    @objc dynamic var category = ""
    @objc dynamic var price = 0
    @objc dynamic var contents = ""
}

class InputViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var contents: UITextField!
    @IBOutlet weak var date: UITextField!
        
    private var datePicker: UIDatePicker?
    let dateFormatter = DateFormatter()
    var dateToolbar = UIToolbar()
    var alert = UIAlertController()
    
    let pickerView = UIPickerView()
    let catogoryList = ["食費", "交遊費", "生活費", "その他"]


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //キーボードを閉じるためのコード
        self.contents.delegate = self
        self.price.delegate = self
        
        dateFormatter.dateFormat = "yyyy年MM月dd日"//日付のフォーマット指定
        date.text = getToday()//今日の日付をデフォルト挿入
        
        //今日以外の日付を選ぶための処理
        datePicker = UIDatePicker()//インスタンス生成
        datePicker?.locale = Locale(identifier: "ja_jp")
        datePicker?.datePickerMode = UIDatePicker.Mode.date  //デフォルトの時間と日付を設定
        datePicker?.addTarget(self, action: #selector(InputViewController.dateChanged(datePicker:)), for: .valueChanged)
        date.inputView = datePicker   //textfieldに値を代入
        
        // UIToolbarを設定
        dateToolbar.sizeToFit()
        
        // Doneボタンを設定(押下時doneClickedが起動)
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneClicked(_:)))
        let DoneButton: UIBarButtonItem = UIBarButtonItem(title: "done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneClicked(_:)))
        let todayButton: UIBarButtonItem = UIBarButtonItem(title: "today", style: UIBarButtonItem.Style.plain, target: self, action: #selector(todayClicked(_:)))
        // アイテムを配置
        dateToolbar.setItems([flexibleItem, todayButton, flexibleItem, DoneButton, flexibleItem], animated: true)
        // FieldにToolbarを追加
        date.inputAccessoryView = dateToolbar
        
        //カテゴリ選択
        category.text = catogoryList[3]
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([doneButton], animated: true)
        
        category.inputAccessoryView = toolbar
        price.inputAccessoryView = toolbar
        contents.inputAccessoryView = toolbar

        category.inputView = pickerView
        category.inputAccessoryView = toolbar
        
    }
    
    func getToday() -> String {
        return dateFormatter.string(from: Date())
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        date.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func doneClicked(_ sender: UIButton){
        self.view.endEditing(true)
    }
    
    @objc func todayClicked(_ sender: UIButton){
        date.text = getToday()
        self.view.endEditing(true)
    }

    
    //入力決定のボタンが押された際にDBにデータを保存する
    @IBAction func bottonPress(_ sender: Any) {
        if(price.text == ""){
            alert(title: "入力ミス", message:"金額を記入してください")
        } else {
            let mySpending = Spending()
            mySpending.date = date.text!
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
    }
    
    //textfield以外に触れるとキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //returnボタンが押された際にキーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return catogoryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return catogoryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        category.text = catogoryList[row]
    }
    
    @objc func done() {
        category.endEditing(true)
    }

    func alert(title:String, message:String) {
        alert = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                                style: .default,
                                                handler: nil))
        present(alert, animated: true)
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
