//
//  GraphContoroller.swift
//  okenealsa
//
//  Created by ueda mizuki on 2019/12/19.
//  Copyright © 2019 松岡　隆斗. All rights reserved.
//

import UIKit
import RealmSwift
import Charts

class MonthGraphController: UIViewController {
    // ここに棒グラフを描きます
    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.view.addBackground(name: "color3.jpg")
        
        //月ごとの金額を格納するための変数を用意
        var JanPrice : Double = 0
        var FebPrice : Double = 0
        var MarPrice : Double = 0
        var AprPrice : Double = 0
        var MayPrice : Double = 0
        var JunPrice : Double = 0
        var JulPrice : Double = 0
        var AugPrice : Double = 0
        var SepPrice : Double = 0
        var OctPrice : Double = 0
        var NovPrice : Double = 0
        var DecPrice : Double = 0
        
        //realmswiftのデータベースを読み込む
        let realm = try! Realm()
        let results = realm.objects(Spending.self)
        
        for i in stride(from: 0, to: results.count, by:1){
            let data = results[i].date  //dataの値を取得
            let month = data[data.index(data.startIndex,offsetBy: 5)..<data.index(data.startIndex,offsetBy: 7)] //dataから月の部分だけ抜粋して取得
            
            //次ごとに判定し、その月の金額を+していく
            if(month == "01"){
                JanPrice += Double(results[i].price)
            }else if(month == "02"){
                FebPrice += Double(results[i].price)
            }else if(month == "03"){
                MarPrice += Double(results[i].price)
            }else if(month == "04"){
                AprPrice += Double(results[i].price)
            }else if(month == "05"){
                MayPrice += Double(results[i].price)
            }else if(month == "06"){
                JunPrice += Double(results[i].price)
            }else if(month == "07"){
                JulPrice += Double(results[i].price)
            }else if(month == "08"){
                AugPrice += Double(results[i].price)
            }else if(month == "09"){
                SepPrice += Double(results[i].price)
            }else if(month == "10"){
                OctPrice += Double(results[i].price)
            }else if(month == "11"){
                NovPrice += Double(results[i].price)
            }else if(month == "12"){
                DecPrice += Double(results[i].price)
            }
        }
        
        // y軸のプロットデータ
        let MonthPrice = [JanPrice, FebPrice, MarPrice, AprPrice, MayPrice, JunPrice, JulPrice, AugPrice, SepPrice, OctPrice, NovPrice, DecPrice]
        
        print(MonthPrice)
        
        setChart(y: MonthPrice)
    }
    
    func setChart(y: [Double]) {
        // プロットデータ(y軸)を保持する配列
        var dataEntries = [BarChartDataEntry]()
        
        for (i, val) in y.enumerated() {
            let dataEntry = BarChartDataEntry(x: Double(i), y: val) // X軸データは、0,1,2,...
            dataEntries.append(dataEntry)
        }
        // グラフをUIViewにセット
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "月ごとの金額")
        barChartView.data = BarChartData(dataSet: chartDataSet)
        
        // X軸のラベルを設定
        let xaxis = XAxis()
        xaxis.valueFormatter = BarChartFormatter()
        barChartView.xAxis.valueFormatter = xaxis.valueFormatter
        
        // x軸のラベルをボトムに表示
        barChartView.xAxis.labelPosition = .bottom
        // グラフの色
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        // グラフの背景色
        barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        // グラフの棒をニョキッとアニメーションさせる
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        // 横に赤いボーダーラインを描く
        let ll = ChartLimitLine(limit: 10.0, label: "")
        barChartView.rightAxis.addLimitLine(ll)
        // グラフのタイトル
        barChartView.chartDescription?.text = "Year Graph"
    }
    
}

public class BarChartFormatter: NSObject, IAxisValueFormatter{
    // x軸のラベル
    var months: [String]! = ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"]
    
    // デリゲート。TableViewのcellForRowAtで、indexで渡されたセルをレンダリングするのに似てる。
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        // 0 -> Jan, 1 -> Feb...
        return months[Int(value)]
    }
}
