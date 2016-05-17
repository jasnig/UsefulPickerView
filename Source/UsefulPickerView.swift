//
//  UsefulPickerView.swift
//  UsefulPickerVIew
//
//  Created by jasnig on 16/4/16.
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

public class UsefulPickerView: UIView {

    public typealias BtnAction = () -> Void
    public typealias SingleDoneAction = (selectedIndex: Int, selectedValue: String) -> Void
    public typealias MultipleDoneAction = (selectedIndexs: [Int], selectedValues: [String]) -> Void
    public typealias DateDoneAction = (selectedDate: NSDate) -> Void

    public typealias MultipleAssociatedDataType = [[[String: [String]?]]]
    
    private var pickerView: PickerView!
    //MARK:- 常量
    private let pickerViewHeight:CGFloat = 260.0
    
    private let screenWidth = UIScreen.mainScreen().bounds.size.width
    private let screenHeight = UIScreen.mainScreen().bounds.size.height
    private var hideFrame: CGRect {
        return CGRect(x: 0.0, y: screenHeight, width: screenWidth, height: pickerViewHeight)
    }
    private var showFrame: CGRect {
        return CGRect(x: 0.0, y: screenHeight - pickerViewHeight, width: screenWidth, height: pickerViewHeight)
    }
    
    ///  使用NSArray 可以存任何"东西", 如果使用 [Any], 那么当
    /// let a = ["1", "2"] var b:[Any] = a 会报错
    
    // MARK:- 初始化
    // 单列
    convenience init(frame: CGRect, toolBarTitle: String, singleColData: [String], defaultSelectedIndex: Int?, doneAction: SingleDoneAction?) {

        self.init(frame: frame)
        
        
        
        pickerView = PickerView.singleColPicker(toolBarTitle, singleColData: singleColData, defaultIndex: defaultSelectedIndex, cancelAction: {[unowned self] in
                // 点击取消的时候移除
                self.hidePicker()

            }, doneAction: {[unowned self] (selectedIndex, selectedValue) in
                doneAction?(selectedIndex: selectedIndex, selectedValue: selectedValue)
                self.hidePicker()

        })
        pickerView.frame = hideFrame
        addSubview(pickerView)
        
        // 点击背景移除self
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(_:)))
        addGestureRecognizer(tap)
    
    }
    // 多列不关联
    convenience init(frame: CGRect, toolBarTitle: String, multipleColsData: [[String]], defaultSelectedIndexs: [Int]?, doneAction: MultipleDoneAction?) {
        
        self.init(frame: frame)
        
        pickerView = PickerView.multipleCosPicker(toolBarTitle, multipleColsData: multipleColsData, defaultSelectedIndexs: defaultSelectedIndexs, cancelAction: {[unowned self] in
            // 点击取消的时候移除
                self.hidePicker()
            
            }, doneAction: {[unowned self] (selectedIndexs, selectedValues) in
                doneAction?(selectedIndexs: selectedIndexs, selectedValues: selectedValues)
                self.hidePicker()
        })
        pickerView.frame = hideFrame
        addSubview(pickerView)
        
        // 点击背景移除self
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(_:)))
        addGestureRecognizer(tap)
        
    }
    // 多列关联
    convenience init(frame: CGRect, toolBarTitle: String, multipleAssociatedColsData: MultipleAssociatedDataType, defaultSelectedValues: [String]?, doneAction: MultipleDoneAction?) {
        
        self.init(frame: frame)
        
        pickerView = PickerView.multipleAssociatedCosPicker(toolBarTitle, multipleAssociatedColsData: multipleAssociatedColsData, defaultSelectedValues: defaultSelectedValues, cancelAction: {[unowned self] in
            // 点击取消的时候移除
                self.hidePicker()
            
            }, doneAction: {[unowned self] (selectedIndexs, selectedValues) in
                doneAction?(selectedIndexs: selectedIndexs, selectedValues: selectedValues)
                self.hidePicker()
        })
                                                  
        pickerView.frame = hideFrame
        addSubview(pickerView)
        
        // 点击背景移除self
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(_:)))
        addGestureRecognizer(tap)
        
    }
    // 城市选择器
    convenience init(frame: CGRect, toolBarTitle: String, defaultSelectedValues: [String]?, doneAction: MultipleDoneAction?) {
        
        self.init(frame: frame)
        
        pickerView = PickerView.citiesPicker(toolBarTitle, defaultSelectedValues: defaultSelectedValues,  cancelAction: {[unowned self] in
            // 点击取消的时候移除
                self.hidePicker()
            
            }, doneAction: {[unowned self] (selectedIndexs, selectedValues) in
                doneAction?(selectedIndexs: selectedIndexs, selectedValues: selectedValues)
                self.hidePicker()
        })
        
        pickerView.frame = hideFrame
        addSubview(pickerView)
        
        // 点击背景移除self
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(_:)))
        addGestureRecognizer(tap)
        
    }
    // 日期选择器
    convenience init(frame: CGRect, toolBarTitle: String, datePickerSetting: DatePickerSetting, doneAction: DateDoneAction?) {
        
        self.init(frame: frame)
        
        pickerView = PickerView.datePicker(toolBarTitle, datePickerSetting: datePickerSetting, cancelAction:  {[unowned self] in
            // 点击取消的时候移除
            self.hidePicker()
            
            }, doneAction: {[unowned self] (selectedDate) in
                doneAction?(selectedDate: selectedDate)
                self.hidePicker()
        })
        
        pickerView.frame = hideFrame
        addSubview(pickerView)
        
        // 点击背景移除self
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(_:)))
        addGestureRecognizer(tap)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addOrentationObserver()
    }

    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        print("\(self.debugDescription) --- 销毁")
    }
    

}

// MARK:- selector
extension UsefulPickerView {
    
    private func addOrentationObserver() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.statusBarOrientationChange), name: UIApplicationDidChangeStatusBarOrientationNotification, object: nil)
        
    }
    // 屏幕旋转时移除pickerView
    func statusBarOrientationChange() {
        removeFromSuperview()
    }
    func tapAction(tap: UITapGestureRecognizer) {
        let location = tap.locationInView(self)
        // 点击空白背景移除self
        if location.y <= screenHeight - pickerViewHeight {
            self.hidePicker()
        }
    }
}

// MARK:- 弹出和移除self
extension UsefulPickerView {
    
    private func showPicker() {
        // 通过window 弹出view
        let window = UIApplication.sharedApplication().keyWindow
        guard let currentWindow = window else { return }
        currentWindow.addSubview(self)

//        let pickerX = NSLayoutConstraint(item: self, attribute: .Leading, relatedBy: .Equal, toItem: currentWindow, attribute: .Leading, multiplier: 1.0, constant: 0.0)
//        
//        let pickerY = NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: currentWindow, attribute: .Top, multiplier: 1.0, constant: 0.0)
//        let pickerW = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: currentWindow, attribute: .Width, multiplier: 1.0, constant: 0.0)
//        let pickerH = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: currentWindow, attribute: .Height, multiplier: 1.0, constant: 0.0)
//        self.translatesAutoresizingMaskIntoConstraints = false
//        
//        currentWindow.addConstraints([pickerX, pickerY, pickerW, pickerH])
        
        UIView.animateWithDuration(0.25, animations: {[unowned self] in
            self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1)
            self.pickerView.frame = self.showFrame
        }, completion: nil)
        
        
    }
    
    func hidePicker() {
        // 把self从window中移除
        UIView.animateWithDuration(0.25, animations: { [unowned self] in
            self.backgroundColor = UIColor.clearColor()
            self.pickerView.frame = self.hideFrame

        }) {[unowned self] (_) in
            self.removeFromSuperview()
        }
    }
}

// MARK: -  快速使用方法
extension UsefulPickerView {
    
    /// 单列选择器                                 ///  @author ZeroJ, 16-04-23 18:04:59
    ///
    ///  - parameter title:                      标题
    ///  - parameter data:                       数据
    ///  - parameter defaultSeletedIndex:        默认选中的行数
    ///  - parameter doneAction:                 响应完成的Closure
    ///
    ///  - returns:
    public class func showSingleColPicker(toolBarTitle: String, data: [String], defaultSelectedIndex: Int?,  doneAction: SingleDoneAction?) {
        let window = UIApplication.sharedApplication().keyWindow
        guard let currentWindow = window else { return }
        
        let testView = UsefulPickerView(frame: currentWindow.bounds, toolBarTitle: toolBarTitle, singleColData: data,defaultSelectedIndex: defaultSelectedIndex ,doneAction: doneAction)
        
        testView.showPicker()
        
    }
    
    /// 多列不关联选择器                            ///  @author ZeroJ, 16-04-23 18:04:59
    ///
    ///  - parameter title:                      标题
    ///  - parameter data:                       数据
    ///  - parameter defaultSeletedIndexs:       默认选中的每一列的行数
    ///  - parameter doneAction:                 响应完成的Closure
    ///
    ///  - returns:
    public class func showMultipleColsPicker(toolBarTitle: String, data: [[String]], defaultSelectedIndexs: [Int]?,doneAction: MultipleDoneAction?) {
        let window = UIApplication.sharedApplication().keyWindow
        guard let currentWindow = window else { return }
        
        let testView = UsefulPickerView(frame: currentWindow.bounds, toolBarTitle: toolBarTitle, multipleColsData: data, defaultSelectedIndexs: defaultSelectedIndexs, doneAction: doneAction)
        
        testView.showPicker()
        
    }
    
    /// 多列关联选择器                             ///  @author ZeroJ, 16-04-23 18:04:59
    ///
    ///  - parameter title:                      标题
    ///  - parameter data:                       数据, 数据的格式参照示例
    ///  - parameter defaultSeletedIndexs:       默认选中的每一列的行数
    ///  - parameter doneAction:                 响应完成的Closure
    ///
    ///  - returns:
    public class func showMultipleAssociatedColsPicker(toolBarTitle: String, data: MultipleAssociatedDataType, defaultSelectedValues: [String]?, doneAction: MultipleDoneAction?) {
        let window = UIApplication.sharedApplication().keyWindow
        guard let currentWindow = window else { return }
        
        let testView = UsefulPickerView(frame: currentWindow.bounds, toolBarTitle: toolBarTitle, multipleAssociatedColsData: data, defaultSelectedValues: defaultSelectedValues, doneAction: doneAction)
        
        testView.showPicker()
        
    }
    
 
    /// 城市选择器                                 ///  @author ZeroJ, 16-04-23 18:04:59
    ///
    ///  - parameter title:                      标题
    ///  - parameter defaultSeletedValues:       默认选中的每一列的值, 注意不是行数
    ///  - parameter doneAction:                 响应完成的Closure
    ///
    ///  - returns:
    public class func showCitiesPicker(toolBarTitle: String, defaultSelectedValues: [String]?, doneAction: MultipleDoneAction?) {
        
        let window = UIApplication.sharedApplication().keyWindow
        guard let currentWindow = window else { return }
        
        let testView = UsefulPickerView(frame: currentWindow.bounds, toolBarTitle: toolBarTitle, defaultSelectedValues: defaultSelectedValues, doneAction: doneAction)
        
        testView.showPicker()
        
    }
    
    /// 日期选择器                                 ///  @author ZeroJ, 16-04-23 18:04:59
    ///
    ///  - parameter title:                      标题
    ///  - parameter datePickerSetting:          可配置UIDatePicker的样式
    ///  - parameter doneAction:                 响应完成的Closure
    ///
    ///  - returns:
    public class func showDatePicker(toolBarTitle: String, datePickerSetting: DatePickerSetting = DatePickerSetting(), doneAction: DateDoneAction?) {
        
        let window = UIApplication.sharedApplication().keyWindow
        guard let currentWindow = window else { return }
        
        let testView = UsefulPickerView(frame: currentWindow.bounds, toolBarTitle: toolBarTitle, datePickerSetting: datePickerSetting, doneAction: doneAction)
        
        testView.showPicker()
        
    }
    
}


