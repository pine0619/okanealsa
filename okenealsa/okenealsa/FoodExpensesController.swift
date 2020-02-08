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
        
        let newtextView = UITextView()     //TextViewの配置
        newtextView.frame = CGRect(x: 100, y: 500, width: 700, height: 100)       //サイズ
        newtextView.textColor = UIColor.black        //文字の色を設定
        newtextView.backgroundColor = UIColor.clear
        newtextView.font = UIFont.systemFont(ofSize: 50)       //文字のサイズを設定
        newtextView.text = "(知りたい情報はどれかな？？？)"        //文字の入力内容
        newtextView.isEditable = false
        self.view.addSubview(newtextView)
        
    }
    
    @IBAction func tapFood(_ sender: Any) {
        var FoodText = ""
        
        let realm = try! Realm()
        let results = realm.objects(Spending.self)
        
        for i in stride(from: 0, to: results.count, by: 1){
        if(results[i].category == "食費"){
            FoodText.append(results[i].date)
            FoodText.append("   ")
            FoodText.append(results[i].contents)
            FoodText.append("   ¥")
            FoodText.append(String(results[i].price))
            //                FoodText.append(button)
            FoodText.append("\n")
        }
    }
        let FoodtextView = UITextView()     //TextViewの配置
        FoodtextView.frame = CGRect(x: 100, y: 100, width:  700, height: 600)       //サイズ
        FoodtextView.textColor = UIColor.green        //文字の色を設定
        FoodtextView.backgroundColor = UIColor.darkGray
        FoodtextView.font = UIFont.systemFont(ofSize: 30)       //文字のサイズを設定
        FoodtextView.text = "\(FoodText)"        //文字の入力内容
        FoodtextView.isEditable = false
        self.view.addSubview(FoodtextView)
    }
    
    @IBAction func tapCommunion(_ sender: Any) {
        var ClothText = ""
        
        let realm = try! Realm()
        let results = realm.objects(Spending.self)
        
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

        let ClothtextView = UITextView()     //TextViewの配置
        ClothtextView.frame = CGRect(x: 100, y: 100, width: 700, height: 600)       //サイズ
        ClothtextView.textColor = UIColor.init(red: 255, green: 255, blue: 0, alpha: 1)        //文字の色を設定
        ClothtextView.backgroundColor = UIColor.darkGray
        ClothtextView.font = UIFont.systemFont(ofSize: 30)       //文字のサイズを設定
        ClothtextView.text = "\(ClothText)"        //文字の入力内容
        ClothtextView.isEditable = false
        self.view.addSubview(ClothtextView)
    }
    
    @IBAction func tapLife(_ sender: Any) {
        var PlayText = ""
        
        let realm = try! Realm()
        let results = realm.objects(Spending.self)
        
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
        
        let PlaytextView = UITextView()     //TextViewの配置
        PlaytextView.frame = CGRect(x: 100, y: 100, width: 700, height: 600)      //サイズ
        PlaytextView.textColor = UIColor.orange       //文字の色を設定
        PlaytextView.backgroundColor = UIColor.darkGray
        PlaytextView.font = UIFont.systemFont(ofSize: 30)       //文字のサイズを設定
        PlaytextView.text = "\(PlayText)"        //文字の入力内容
        PlaytextView.isEditable = false
        self.view.addSubview(PlaytextView)
    }
    
    @IBAction func tapOther(_ sender: Any) {
        var FreeText = ""
        
        let realm = try! Realm()
        let results = realm.objects(Spending.self)
        
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
        
        let FreetextView = UITextView()     //TextViewの配置
        FreetextView.frame = CGRect(x: 100, y: 100, width: 700, height: 600)       //サイズ
        FreetextView.textColor = UIColor.init(red: 0, green: 255, blue: 255, alpha: 1)        //文字の色を設定
        FreetextView.backgroundColor = UIColor.darkGray
        FreetextView.font = UIFont.systemFont(ofSize: 30)       //文字のサイズを設定
        FreetextView.text = "\(FreeText)"        //文字の入力内容
        FreetextView.isEditable = false
        self.view.addSubview(FreetextView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
