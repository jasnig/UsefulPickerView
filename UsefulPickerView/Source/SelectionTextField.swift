//
//  SelectionTextField.swift
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

public class SelectionTextField: UITextField {

    public typealias BtnAction = () -> Void
    public typealias SingleDoneAction = (textField: UITextField, selectedIndex: Int, selectedValue: String) -> Void
    public typealias MultipleDoneAction = (textField: UITextField, selectedIndexs: [Int], selectedValues: [String]) -> Void
    public typealias DateDoneAction = (textField: UITextField, selectedDate: NSDate) -> Void
    
    public typealias MultipleAssociatedDataType = [[[String: [String]?]]]
    
    ///  保存pickerView的初始化
    private var setUpPickerClosure:(() -> PickerView)?
    ///  如果设置了autoSetSelectedText为true 将自动设置text的值, 默认以空格分开多列选择, 但你仍然可以在响应完成的closure中修改text的值
    private var autoSetSelectedText = false
    
    //MARK: 初始化
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    // 从xib或storyboard中初始化时候调用
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        print("\(self.debugDescription) --- 销毁")
    }


}

// MARK: - 监听通知
extension SelectionTextField {
    
    private func commonInit() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.didBeginEdit), name: UITextFieldTextDidBeginEditingNotification, object: self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.didEndEdit), name: UITextFieldTextDidEndEditingNotification, object: self)
    }
    // 开始编辑添加pickerView
    func didBeginEdit()  {
        let pickerView = setUpPickerClosure?()
        pickerView?.delegate = self
        inputView = pickerView
    }
    // 编辑完成销毁pickerView
    func didEndEdit() {
        inputView = nil
    }
    
    override public func caretRectForPosition(position: UITextPosition) -> CGRect {
        return CGRectZero
    }
    
}

// MARK: - 使用方法
extension SelectionTextField {
    
    /// 单列选择器                                 ///  @author ZeroJ, 16-04-23 18:04:59
    ///
    ///  - parameter title:                      标题
    ///  - parameter data:                       数据
    ///  - parameter defaultSeletedIndex:        默认选中的行数
    ///  - parameter autoSetSelectedText:        设置为true的时候, 将按默认的格式自动设置textField的值
    ///  - parameter doneAction:                 响应完成的Closure
    ///
    ///  - returns:
    public func showSingleColPicker(toolBarTitle: String, data: [String], defaultSelectedIndex: Int?,autoSetSelectedText: Bool, doneAction: SingleDoneAction?) {
        
        self.autoSetSelectedText = autoSetSelectedText

        // 保存在这个closure中, 在开始编辑的时候在执行, 避免像之前在这里直接初始化pickerView, 每个SelectionTextField在调用这个方法的时候就初始化pickerView,当有多个pickerView的时候就很消耗内存
        setUpPickerClosure = {() -> PickerView in
            
            return PickerView.singleColPicker(toolBarTitle, singleColData: data, defaultIndex: defaultSelectedIndex, cancelAction: {[unowned self] in
                
                    self.endEditing(true)
                
                }, doneAction: {[unowned self] (selectedIndex: Int, selectedValue: String) -> Void in
                    
                    doneAction?(textField:self, selectedIndex: selectedIndex, selectedValue: selectedValue)
                    self.endEditing(true)
                    
                })

            
        }
        
    }
    
    /// 多列不关联选择器                            ///  @author ZeroJ, 16-04-23 18:04:59
    ///
    ///  - parameter title:                      标题
    ///  - parameter data:                       数据
    ///  - parameter defaultSeletedIndexs:       默认选中的每一列的行数
    ///  - parameter autoSetSelectedText:        设置为true的时候, 将俺默认的格式自动设置textField的值
    ///  - parameter doneAction:                 响应完成的Closure
    ///
    ///  - returns:
    public func showMultipleColsPicker(toolBarTitle: String, data: [[String]], defaultSelectedIndexs: [Int]?, autoSetSelectedText: Bool, doneAction: MultipleDoneAction?) {
        self.autoSetSelectedText = autoSetSelectedText

        setUpPickerClosure = {() -> PickerView in

            return PickerView.multipleCosPicker(toolBarTitle, multipleColsData: data, defaultSelectedIndexs: defaultSelectedIndexs, cancelAction: { [unowned self] in
                
                    self.endEditing(true)
                
                }, doneAction:{[unowned self] (selectedIndexs: [Int], selectedValues: [String]) -> Void in
                    
                    doneAction?(textField:self, selectedIndexs: selectedIndexs, selectedValues: selectedValues)
                    self.endEditing(true)
                })
        }
        
    }
    
    /// 多列关联选择器                             ///  @author ZeroJ, 16-04-23 18:04:59
    ///
    ///  - parameter title:                      标题
    ///  - parameter data:                       数据, 数据的格式参照示例
    ///  - parameter defaultSeletedIndexs:       默认选中的每一列的行数
    ///  - parameter autoSetSelectedText:        设置为true的时候, 将按默认的格式自动设置textField的值
    ///  - parameter doneAction:                 响应完成的Closure
    ///
    ///  - returns:
    public func showMultipleAssociatedColsPicker(toolBarTitle: String, data: MultipleAssociatedDataType, defaultSelectedValues: [String]?,autoSetSelectedText: Bool, doneAction: MultipleDoneAction?) {
        self.autoSetSelectedText = autoSetSelectedText

        setUpPickerClosure = {() -> PickerView in
            
           return PickerView.multipleAssociatedCosPicker(toolBarTitle, multipleAssociatedColsData: data, defaultSelectedValues: defaultSelectedValues,cancelAction: { [unowned self] in
                
                    self.endEditing(true)
                
            }, doneAction:{[unowned self] (selectedIndexs: [Int], selectedValues: [String]) -> Void in
                
                doneAction?(textField:self, selectedIndexs: selectedIndexs, selectedValues: selectedValues)
                self.endEditing(true)
            })
        }

    }

    
    /// 城市选择器                                 ///  @author ZeroJ, 16-04-23 18:04:59
    ///
    ///  - parameter title:                      标题
    ///  - parameter defaultSeletedValues:       默认选中的每一列的值, 注意不是行数
    ///  - parameter autoSetSelectedText:        设置为true的时候, 将按默认的格式自动设置textField的值
    ///  - parameter doneAction:                 响应完成的Closure
    ///
    ///  - returns:
    
    public func showCitiesPicker(toolBarTitle: String, defaultSelectedValues: [String]?,autoSetSelectedText: Bool, doneAction: MultipleDoneAction?) {
        self.autoSetSelectedText = autoSetSelectedText

        setUpPickerClosure = {() -> PickerView in
            return PickerView.citiesPicker(toolBarTitle, defaultSelectedValues: defaultSelectedValues, cancelAction: { [unowned self] in
                    self.endEditing(true)
                
                }, doneAction:{[unowned self] (selectedIndexs: [Int], selectedValues: [String]) -> Void in
                    
                    doneAction?(textField:self,selectedIndexs: selectedIndexs, selectedValues: selectedValues)
                    self.endEditing(true)
                })
        }
    
    }
    
    /// 日期选择器                                 ///  @author ZeroJ, 16-04-23 18:04:59
    ///
    ///  - parameter title:                      标题
    ///  - parameter datePickerSetting:          可配置UIDatePicker的样式
    ///  - parameter autoSetSelectedText:        设置为true的时候, 将按默认的格式自动设置textField的值
    ///  - parameter doneAction:                 响应完成的Closure
    ///
    ///  - returns:
    public func showDatePicker(toolBarTitle: String, datePickerSetting: DatePickerSetting = DatePickerSetting(), autoSetSelectedText: Bool, doneAction: DateDoneAction?) {
        self.autoSetSelectedText = autoSetSelectedText

        setUpPickerClosure = {() -> PickerView in
           return PickerView.datePicker(toolBarTitle, datePickerSetting: datePickerSetting, cancelAction: { [unowned self] in
                    self.endEditing(true)
                
                }, doneAction: {[unowned self]  (selectedDate) in
                    doneAction?(textField:self, selectedDate: selectedDate)
                    self.endEditing(true)

            })

        }
    }
    
}


// MARK: - PickerViewDelegate -- 如果设置了autoSetSelectedText为true 这些代理方法中将以默认的格式自动设置textField的值
extension SelectionTextField: PickerViewDelegate {
    public func singleColDidSelecte(selectedIndex: Int, selectedValue: String) {
        if autoSetSelectedText {
            text = " " + selectedValue
        }
    }
    
    public func multipleColsDidSelecte(selectedIndexs: [Int], selectedValues: [String]) {
        
        
        if autoSetSelectedText {
            text = selectedValues.reduce("", combine: { (result, selectedValue) -> String in
                 result + " " + selectedValue
            })
        }
    }
    
    public func dateDidSelecte(selectedDate: NSDate) {
        if autoSetSelectedText {
            
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let string = formatter.stringFromDate(selectedDate)
            text = " " + string
        }
    }
}
