//
//  ToolBarView.swift
//  UsefulPickerVIew
//
//  Created by jasnig on 16/4/18.
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

open class ToolBarView: UIView {
    
    typealias CustomClosures = (_ titleLabel: UILabel, _ cancleBtn: UIButton, _ doneBtn: UIButton) -> Void
    public typealias BtnAction = () -> Void
    
    open var title = "请选择" {
        didSet {
            titleLabel.text = title
        }
    }
    
    open var doneAction: BtnAction?
    open var cancelAction: BtnAction?
    // 用来产生上下分割线的效果
    fileprivate lazy var contentView: UIView = {
        let content = UIView()
        content.backgroundColor = UIColor.white
        return content
    }()
    // 文本框
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    // 取消按钮
    fileprivate lazy var cancleBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("取消", for: UIControlState())
        btn.setTitleColor(UIColor.black, for: UIControlState())
        return btn
    }()
    
    // 完成按钮
    fileprivate lazy var doneBtn: UIButton = {
        let donebtn = UIButton()
        donebtn.setTitle("完成", for: UIControlState())
        donebtn.setTitleColor(UIColor.black, for: UIControlState())
        return donebtn
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func commonInit() {
        backgroundColor = UIColor.lightText
        addSubview(contentView)
        contentView.addSubview(cancleBtn)
        contentView.addSubview(doneBtn)
        contentView.addSubview(titleLabel)
        
        doneBtn.addTarget(self, action: #selector(self.doneBtnOnClick(_:)), for: .touchUpInside)
        cancleBtn.addTarget(self, action: #selector(self.cancelBtnOnClick(_:)), for: .touchUpInside)
    }
    
    func doneBtnOnClick(_ sender: UIButton) {
        doneAction?()
    }
    func cancelBtnOnClick(_ sender: UIButton) {
        cancelAction?()
        
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        let margin = 15.0
        let contentHeight = Double(bounds.size.height) - 2.0
        contentView.frame = CGRect(x: 0.0, y: 1.0, width: Double(bounds.size.width), height: contentHeight)
        let btnWidth = contentHeight

        cancleBtn.frame = CGRect(x: margin, y: 0.0, width: btnWidth, height: btnWidth)
        doneBtn.frame = CGRect(x: Double(bounds.size.width) - btnWidth - margin, y: 0.0, width: btnWidth, height: btnWidth)
        let titleX = Double(cancleBtn.frame.maxX) + margin
        let titleW = Double(bounds.size.width) - titleX - btnWidth - margin
        
        
        titleLabel.frame = CGRect(x: titleX, y: 0.0, width: titleW, height: btnWidth)
    }
    
    
}
