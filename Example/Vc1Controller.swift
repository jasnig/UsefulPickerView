//
//  Vc1Controller.swift
//  UsefulPickerVIew
//
//  Created by jasnig on 16/4/24.
//  Copyright © 2016年 ZeroJ. All rights reserved.
// github: https://github.com/jasnig
// 简书: http://www.jianshu.com/users/fb31a3d1ec30/latest_articles

//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

//

import UIKit

let singleData = ["swift", "ObjecTive-C", "C", "C++", "java", "php", "python", "ruby", "js"]
// 每一列为数组
let multipleData = [["1天", "2天", "3天", "4天", "5天", "6天", "7天"],["1小时", "2小时", "3小时", "4小时", "5小时"],  ["1分钟","2分钟","3分钟","4分钟","5分钟","6分钟","7分钟","8分钟","9分钟","10分钟"]]

// 注意这个数据的格式!!!!!!
let multipleAssociatedData: [[[String: [String]?]]] = [// 数组
    
    [   ["交通工具": ["陆地", "空中", "水上"]],//字典
        ["食品": ["健康食品", "垃圾食品"]],
        ["游戏": ["益智游戏", "角色游戏"]]
        
    ],// 数组
    
    [   ["陆地": ["公交车", "小轿车", "自行车"]],
        ["空中": ["飞机"]],
        ["水上": ["轮船"]],
        ["健康食品": ["蔬菜", "水果"]],
        ["垃圾食品": ["辣条", "不健康小吃"]],
        ["益智游戏": ["消消乐", "消灭星星"]],
        ["角色游戏": ["lol", "cf"]]
        
    ]    
]

class Vc1Controller: UIViewController {

    
    @IBOutlet weak var selectedDataLabel: UILabel!
    
    
    @IBAction func singleBtnOnClick(sender: UIButton) {
        
        UsefulPickerView.showSingleColPicker("编程语言选择", data: singleData, defaultSelectedIndex: 2) {[unowned self] (selectedIndex, selectedValue) in
            self.selectedDataLabel.text = "选中了第\(selectedIndex)行----选中的数据为\(selectedValue)"
        }
        
    }
    @IBAction func multipleBtnOnClick(sender: UIButton) {
        
        
        UsefulPickerView.showMultipleColsPicker("持续时间选择", data: multipleData, defaultSelectedIndexs: [0,1,1]) {[unowned self] (selectedIndexs, selectedValues) in
            self.selectedDataLabel.text = "选中了第\(selectedIndexs)行----选中的数据为\(selectedValues)"

        }
        
    }
    @IBAction func multipleAssociatedBtnOnClick(sender: UIButton) {
        
        // 注意这里设置的是默认的选中值, 而不是选中的下标,省得去数关联数组里的下标
        UsefulPickerView.showMultipleAssociatedColsPicker("多列关联数据", data: multipleAssociatedData, defaultSelectedValues: ["交通工具","陆地","自行车"]) {[unowned self] (selectedIndexs, selectedValues) in
            self.selectedDataLabel.text = "选中了第\(selectedIndexs)行----选中的数据为\(selectedValues)"
            
        }
        
    }
    @IBAction func citiesBtnOnClick(sender: UIButton) {
        
        UsefulPickerView.showCitiesPicker("省市区选择", defaultSelectedValues: ["四川", "成都", "郫县"]) {[unowned self] (selectedIndexs, selectedValues) in
            // 处理数据
            let combinedString = selectedValues.reduce("", combine: { (result, value) -> String in
                result + " " + value
            })
            
            self.selectedDataLabel.text = "选中了第\(selectedIndexs)行----选中的数据为\(combinedString)"
            
        }
    }
    @IBAction func dateBtnOnClick(sender: UIButton) {
        
        
        UsefulPickerView.showDatePicker("日期选择") {[unowned self] ( selectedDate) in
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let string = formatter.stringFromDate(selectedDate)
            self.selectedDataLabel.text = "选中了的日期是\(string)"
        }
        

    }
    
    @IBAction func timeBtnOnClick(sender: UIButton) {
        var dateStyle = DatePickerSetting()
        dateStyle.dateMode = .Time
        
        ///          ///  @author ZeroJ, 16-04-25 17:04:28
        /// 注意使用这种方式的时候, 请设置 autoSetSelectedText = false, 否则显示的格式可能不是您需要的
        UsefulPickerView.showDatePicker("时间选择", datePickerSetting: dateStyle) { (selectedDate) in
            let formatter = NSDateFormatter()
            // H -> 24小时制
            formatter.dateFormat = "HH: mm"
            let string = formatter.stringFromDate(selectedDate)
            self.selectedDataLabel.text = "选中了的日期是\(string)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
