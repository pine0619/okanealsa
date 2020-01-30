//
//  LifeController.swift
//  okenealsa
//
//  Created by ueda mizuki on 2020/01/30.
//  Copyright © 2020 松岡　隆斗. All rights reserved.
//

import UIKit
import RealmSwift

class LifeController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var FoodText = ""
        var ClothText = ""
        var PlayText = ""
        var FreeText = ""
        
        //今月のyyyy年MM月を取得
        //        let YearMonth:String
        //        YearMonth = dayGet()
        
        let realm = try! Realm()
        let results = realm.objects(Spending.self)
        
        
        for i in stride(from: 0, to: results.count, by: 1){
            //            var yearmonth : String
            //
            //            yearmonth = results[i].date
            //            yearmonth = String(yearmonth[yearmonth.index(yearmonth.startIndex,offsetBy: 0)..<yearmonth.index(yearmonth.startIndex,offsetBy: 8)])
            
            if(results[i].category == "食費"){
                FoodText.append(results[i].date)
                FoodText.append("   ")
                FoodText.append(results[i].contents)
                FoodText.append("   ¥")
                FoodText.append(String(results[i].price))
                FoodText.append("\n")
            }else if(results[i].category == "交遊費"){
                ClothText.append(results[i].date)
                ClothText.append("   ")
                ClothText.append(results[i].contents)
                ClothText.append("   ¥")
                ClothText.append(String(results[i].price))
                ClothText.append("\n")
            }else if(results[i].category == "生活費"){
                PlayText.append(results[i].date)
                PlayText.append("   ")
                PlayText.append(results[i].contents)
                PlayText.append("   ¥")
                PlayText.append(String(results[i].price))
                PlayText.append("\n")
            }else if(results[i].category == "その他"){
                FreeText.append(results[i].date)
                FreeText.append("   ")
                FreeText.append(results[i].contents)
                FreeText.append("   ¥")
                FreeText.append(String(results[i].price))
                FreeText.append("\n")
            }
        }
        
//        let FoodtextView = UITextView()     //TextViewの配置
//        FoodtextView.frame = CGRect(x: 100, y: 100, width: 1000, height: 1000)       //サイズ
//        FoodtextView.textColor = UIColor.green        //文字の色を設定
//        FoodtextView.font = UIFont.systemFont(ofSize: 30)       //文字のサイズを設定
//        FoodtextView.text = "\(FoodText)"        //文字の入力内容
//        FoodtextView.isEditable = false
//        self.view.addSubview(FoodtextView)
        
        //        let ClothtextView = UITextView()     //TextViewの配置
        //        ClothtextView.frame = CGRect(x: 100, y: 310, width: 600, height: 250)       //サイズ
        //        ClothtextView.textColor = UIColor.yellow        //文字の色を設定
        //        ClothtextView.font = UIFont.systemFont(ofSize: 30)       //文字のサイズを設定
        //        ClothtextView.text = "\(ClothText)"        //文字の入力内容
        //        ClothtextView.isEditable = false
        //        self.view.addSubview(ClothtextView)
        //
                let PlaytextView = UITextView()     //TextViewの配置
                PlaytextView.frame = CGRect(x: 100, y: 100, width: 1000, height: 1000)       //サイズ
                PlaytextView.textColor = UIColor.orange        //文字の色を設定
                PlaytextView.font = UIFont.systemFont(ofSize: 30)       //文字のサイズを設定
                PlaytextView.text = "\(PlayText)"        //文字の入力内容
                PlaytextView.isEditable = false
                self.view.addSubview(PlaytextView)
        //
        //        let FreetextView = UITextView()     //TextViewの配置
        //        FreetextView.frame = CGRect(x: 100, y: 870, width: 600, height: 250)       //サイズ
        //        FreetextView.textColor = UIColor.blue        //文字の色を設定
        //        FreetextView.font = UIFont.systemFont(ofSize: 30)       //文字のサイズを設定
        //        FreetextView.text = "\(FreeText)"        //文字の入力内容
        //        FreetextView.isEditable = false
        //        self.view.addSubview(FreetextView)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //    func dayGet() -> String {
    //        //今日の年と月を取得する。
    //        let dt = Date()
    //        let dateFormatter = DateFormatter()
    //
    //        dateFormatter.locale = Locale(identifier: "ja_JP")
    //        dateFormatter.dateFormat = "yyyy年MM月dd日"
    //
    //        var toDay :String
    //        var toYearMonth :String
    //
    //        toDay = dateFormatter.string(from: dt)
    //        toYearMonth = String(toDay[toDay.index(toDay.startIndex,offsetBy: 0)..<toDay.index(toDay.startIndex,offsetBy: 8)])
    //
    //        return toYearMonth
    //    }
}
