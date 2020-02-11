//
//  DeleteController.swift
//  okenealsa
//
//  Created by ueda mizuki on 2020/02/11.
//  Copyright © 2020 松岡　隆斗. All rights reserved.
//

import UIKit
import RealmSwift

class DeleteController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var dateToolbar = UIToolbar()
    let pickerView = UIPickerView()
    
    @IBOutlet weak var Text: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.view.addBackground(name: "parpul_mizutama.jpg")

        //realmswiftのデータベースを読み込む
        let realm = try! Realm()
        let results = realm.objects(Spending.self)
        
        var RealmText: [String] = []
        var lastnum = 0
        for i in stride(from: 0, to: results.count, by: 1){
            RealmText.append("\(results[i].date)" + " " +  "\(results[i].category)" + " " + "\(results[i].price)")
            lastnum = i
        }
        
        // UIToolbarを設定
        dateToolbar.sizeToFit()
        
//        Doneボタンを設定(押下時doneClickedが起動)
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneClicked(_:)))
        let DoneButton: UIBarButtonItem = UIBarButtonItem(title: "done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneClicked(_:)))
        
        dateToolbar.setItems([ flexibleItem, DoneButton, flexibleItem], animated: true)
        
        Text.text = RealmText[lastnum]
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([doneButton], animated: true)
        
        Text.inputAccessoryView = toolbar
        Text.inputView = pickerView
        Text.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked(_ sender: UIButton){
        self.view.endEditing(true)
    }
    
    @objc func done() {
        Text.endEditing(true)
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
        //realmswiftのデータベースを読み込む
        let realm = try! Realm()
        let results = realm.objects(Spending.self)
        return results.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let realm = try! Realm()
        var results = realm.objects(Spending.self)
        results = realm.objects(Spending.self).sorted(byKeyPath: "date",ascending: true)
        var Text: [String] = []
       for i in stride(from: 0, to: results.count, by: 1){
        Text.append("\(results[i].date)" + "\(results[i].category)" + "\(results[i].price)")
        }
        return Text[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let realm = try! Realm()
        var results = realm.objects(Spending.self)
        results = realm.objects(Spending.self).sorted(byKeyPath: "date",ascending: true)
        var text: [String] = []
        for i in stride(from: 0, to: results.count, by: 1){
            text.append("\(results[i].date)" + " " + "\(results[i].category)" + " " + "\(results[i].price)")
        }
        Text.text = text[row]
    }
    
    @IBAction func bottonPress(_ sender: Any) {
//        let alert: UIAlertController = UIAlertController(title: "アラート表示", message: "削除してもいいですか？", preferredStyle:  UIAlertController.Style.alert)
//        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
//            // ボタンが押された時の処理を書く（クロージャ実装）
//            (action: UIAlertAction!) -> Void in
//            print("OK")
//        })
//        // キャンセルボタン
//        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
//            // ボタンが押された時の処理を書く（クロージャ実装）
//            (action: UIAlertAction!) -> Void in
//            print("Cancel")
//        })
//        
//        // ③ UIAlertControllerにActionを追加
//        alert.addAction(cancelAction)
//        alert.addAction(defaultAction)
//        
//        // ④ Alertを表示
//        present(alert, animated: true, completion: nil)

        let realm = try! Realm()
        var results = realm.objects(Spending.self)
        results = realm.objects(Spending.self).sorted(byKeyPath: "date",ascending: true)
        
        let labeltext = Text.text
        var moji = labeltext?.components(separatedBy: " ")
        
        for i in stride(from: 0, to: results.count, by:1){
            if(moji?[0] == results[i].date && moji?[1] == results[i].category && moji?[2] == "\(results[i].price)"){
                    try? realm.write {
                        Text.text = "削除されたよ"
                        realm.delete(results[i])
                    }
                }
            }
        }
    
    
    //textfield以外に触れるとキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
