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

public class ToolBarView: UIView {
    
    typealias CustomClosures = (titleLabel: UILabel, cancleBtn: UIButton, doneBtn: UIButton) -> Void
    public typealias BtnAction = () -> Void
    
    public var title = "请选择" {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var doneAction: BtnAction?
    public var cancelAction: BtnAction?
    // 用来产生上下分割线的效果
    private lazy var contentView: UIView = {
        let content = UIView()
        content.backgroundColor = UIColor.whiteColor()
        return content
    }()
    // 文本框
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Center
        return label
    }()
    
    // 取消按钮
    private lazy var cancleBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("取消", forState: .Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        return btn
    }()
    
    // 完成按钮
    private lazy var doneBtn: UIButton = {
        let donebtn = UIButton()
        donebtn.setTitle("完成", forState: .Normal)
        donebtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        return donebtn
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = UIColor.lightTextColor()
        addSubview(contentView)
        contentView.addSubview(cancleBtn)
        contentView.addSubview(doneBtn)
        contentView.addSubview(titleLabel)
        
        doneBtn.addTarget(self, action: #selector(self.doneBtnOnClick(_:)), forControlEvents: .TouchUpInside)
        cancleBtn.addTarget(self, action: #selector(self.cancelBtnOnClick(_:)), forControlEvents: .TouchUpInside)
    }
    
    func doneBtnOnClick(sender: UIButton) {
        doneAction?()
    }
    func cancelBtnOnClick(sender: UIButton) {
        cancelAction?()
        
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        let margin = 15.0
        let contentHeight = Double(bounds.size.height) - 2.0
        contentView.frame = CGRect(x: 0.0, y: 1.0, width: Double(bounds.size.width), height: contentHeight)
        let btnWidth = contentHeight

        cancleBtn.frame = CGRect(x: margin, y: 0.0, width: btnWidth, height: btnWidth)
        doneBtn.frame = CGRect(x: Double(bounds.size.width) - btnWidth - margin, y: 0.0, width: btnWidth, height: btnWidth)
        let titleX = Double(CGRectGetMaxX(cancleBtn.frame)) + margin
        let titleW = Double(bounds.size.width) - titleX - btnWidth - margin
        
        
        titleLabel.frame = CGRect(x: titleX, y: 0.0, width: titleW, height: btnWidth)
    }
    
    
}
