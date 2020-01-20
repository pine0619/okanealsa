//

//  ViewController.swift
//  okenealsa
//
//  Created by 松岡　隆斗 on 2019/11/07.
//  Copyright © 2019 松岡　隆斗. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class ViewController: UIViewController {
    
    
    @IBOutlet weak var pieChartsView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChartsView.delegate = self as? ChartViewDelegate
        
        //データベースのデータを取得
        let realm = try! Realm()
        let results = realm.objects(Spending.self)
        
        //今月のyyyy年MM月を取得
        let YearMonth:String
        YearMonth = dayGet()
        
        var MonthPrice : Int = 0    //今月の総出費額の初期設定
        
        //カテゴリ別の金額の初期設定
        var FoodPrice : Int = 0
        var ClothPrice : Int = 0
        var PlayPrice : Int = 0
        var FreePrice : Int = 0
        
        /*
         今月分のみの金額をカテゴリ別にまとめる。
         var yearmonthにてYearMonthと一致した年月のみの出費額をカテゴリ別の変数に設定する。
         */
        for i in stride(from: 0, to: results.count, by: 1) {
            var yearmonth : String
            
            yearmonth = results[i].date
            yearmonth = String(yearmonth[yearmonth.index(yearmonth.startIndex,offsetBy: 0)..<yearmonth.index(yearmonth.startIndex,offsetBy: 8)])
            
            if(yearmonth == YearMonth){
                if (results[i].category == "食費") {
                    FoodPrice += results[i].price
                }else if (results[i].category == "交遊費"){
                    ClothPrice += results[i].price
                }else if (results[i].category == "生活費"){
                    PlayPrice += results[i].price
                }else if (results[i].category == "その他"){
                    FreePrice += results[i].price
                }
            }
        }
        
        //今月分の出費額の計算
        MonthPrice += FoodPrice
        MonthPrice += ClothPrice
        MonthPrice += PlayPrice
        MonthPrice += FreePrice
        
        //dataEntriesにて扱う値とラベル設定
        let dataEntries = [
            PieChartDataEntry(value: Double(FoodPrice), label: "食費"),
            PieChartDataEntry(value: Double(ClothPrice), label: "交遊費"),
            PieChartDataEntry(value: Double(PlayPrice), label: "生活費"),
            PieChartDataEntry(value: Double(FreePrice), label: "その他"),
        ]
        
        //円グラフ及び右下の設定
        let dataSet = PieChartDataSet(entries: dataEntries, label: "カテゴリ別")
        
        // 円グラフの中心に表示するタイトル
        self.pieChartsView.centerText = String(MonthPrice)
        
        // グラフの色
        dataSet.colors = ChartColorTemplates.vordiplom()
        // グラフのデータの値の色
        dataSet.valueTextColor = UIColor.black
        // グラフのデータのタイトルの色
        dataSet.entryLabelColor = UIColor.black
        
        self.pieChartsView.data = PieChartData(dataSet: dataSet)
        
        // データを％表示にする
        //        let formatter = NumberFormatter()
        //        formatter.numberStyle = .percent
        //        formatter.maximumFractionDigits = 2
        //        formatter.multiplier = 1.0
        //        self.pieChartsView.data?.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        //        self.pieChartsView.usePercentValuesEnabled = true
        
        view.addSubview(self.pieChartsView)
        
    }
    
    @IBOutlet weak var date_outlet: UIDatePicker!
    
    @IBAction func date_action(_ sender: UIDatePicker) {
    }
    
    func dayGet() -> String {
        //今日の年と月を取得する。
        let dt = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        
        var toDay :String
        var toYearMonth :String
        
        toDay = dateFormatter.string(from: dt)
        toYearMonth = String(toDay[toDay.index(toDay.startIndex,offsetBy: 0)..<toDay.index(toDay.startIndex,offsetBy: 8)])
        
        return toYearMonth
    }
}
