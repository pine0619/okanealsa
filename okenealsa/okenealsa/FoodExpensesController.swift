//
//  FoodExpensesController.swift
//  okenealsa
//
//  Created by ueda mizuki on 2020/01/30.
//  Copyright © 2020 松岡　隆斗. All rights reserved.
//

import UIKit
import RealmSwift

class FoodExpensesController: UIViewController{
    
    @IBOutlet weak var Food: UIButton!
    @IBOutlet weak var Communion: UIButton!
    @IBOutlet weak var Life: UIButton!
    @IBOutlet weak var Other: UIButton!
    
    @IBOutlet weak var Text: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.view.addBackground(name: "color.jpg")
        
        Food.setTitle("🍚", for: .normal)
        Food.titleLabel?.font = UIFont.systemFont(ofSize: 100)
        Communion.setTitle("👬", for: .normal)
        Communion.titleLabel?.font = UIFont.systemFont(ofSize: 100)
        Life.setTitle("🏠", for: .normal)
        Life.titleLabel?.font = UIFont.systemFont(ofSize: 100)
        Other.setTitle("🐶", for: .normal)
        Other.titleLabel?.font = UIFont.systemFont(ofSize: 100)
        
        Text.textColor = UIColor.red        //文字の色を設定
        Text.backgroundColor = UIColor.darkGray
        Text.font = UIFont.systemFont(ofSize: 50)       //文字のサイズを設定
        Text.text = "(知りたい情報はどれ？)"        //文字の入力内容
        Text.isEditable = false
    }
    
    @IBAction func tapFood(_ sender: Any) {
        var FoodText = ""
        
        let realm = try! Realm()
        var results = realm.objects(Spending.self)
        results = realm.objects(Spending.self).sorted(byKeyPath: "date",ascending: true)

        
        for i in stride(from: 0, to: results.count, by: 1){
        if(results[i].category == "食費"){
            FoodText.append(results[i].date)
            FoodText.append("   ")
            FoodText.append(results[i].contents)
            FoodText.append("   ¥")
            FoodText.append(String(results[i].price))
            FoodText.append("\n")
        }
    }

        Text.textColor = UIColor.green        //文字の色を設定
        Text.backgroundColor = UIColor.darkGray
        Text.font = UIFont.systemFont(ofSize: 30)       //文字のサイズを設定
        Text.text = "\(FoodText)"        //文字の入力内容
        Text.isEditable = false

    }
    
    @IBAction func tapCommunion(_ sender: Any) {
        var ClothText = ""
        
        let realm = try! Realm()
        var results = realm.objects(Spending.self)
        results = realm.objects(Spending.self).sorted(byKeyPath: "date",ascending: true)
        
        for i in stride(from: 0, to: results.count, by: 1){
            if(results[i].category == "交遊費"){
                ClothText.append(results[i].date)
                ClothText.append("   ")
                ClothText.append(results[i].contents)
                ClothText.append("   ¥")
                ClothText.append(String(results[i].price))
                ClothText.append("\n")
            }
        }

        Text.textColor = UIColor.init(red: 255, green: 255, blue: 0, alpha: 1)        //文字の色を設定
        Text.backgroundColor = UIColor.darkGray
        Text.font = UIFont.systemFont(ofSize: 30)       //文字のサイズを設定
        Text.text = "\(ClothText)"        //文字の入力内容
        Text.isEditable = false
    }
    
    @IBAction func tapLife(_ sender: Any) {
        var PlayText = ""
        
        let realm = try! Realm()
        var results = realm.objects(Spending.self)
        results = realm.objects(Spending.self).sorted(byKeyPath: "date",ascending: true)
        
        for i in stride(from: 0, to: results.count, by: 1){
            if(results[i].category == "生活費"){
                PlayText.append(results[i].date)
                PlayText.append("   ")
                PlayText.append(results[i].contents)
                PlayText.append("   ¥")
                PlayText.append(String(results[i].price))
                PlayText.append("\n")
            }
        }
        
        Text.textColor = UIColor.orange       //文字の色を設定
        Text.backgroundColor = UIColor.darkGray
        Text.font = UIFont.systemFont(ofSize: 30)       //文字のサイズを設定
        Text.text = "\(PlayText)"        //文字の入力内容
        Text.isEditable = false
    }
    
    @IBAction func tapOther(_ sender: Any) {
        var FreeText = ""
        
        let realm = try! Realm()
        var results = realm.objects(Spending.self)
        results = realm.objects(Spending.self).sorted(byKeyPath: "date",ascending: true)
        
        for i in stride(from: 0, to: results.count, by: 1){
            if(results[i].category == "その他"){
                FreeText.append(results[i].date)
                FreeText.append("   ")
                FreeText.append(results[i].contents)
                FreeText.append("   ¥")
                FreeText.append(String(results[i].price))
                FreeText.append("\n")
            }
        }
        
        Text.textColor = UIColor.init(red: 0, green: 255, blue: 255, alpha: 1)        //文字の色を設定
        Text.backgroundColor = UIColor.darkGray
        Text.font = UIFont.systemFont(ofSize: 30)       //文字のサイズを設定
        Text.text = "\(FreeText)"        //文字の入力内容
        Text.isEditable = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
