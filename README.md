#UsefulPickerView


##使用示例效果


![TextField使用示例.gif](http://upload-images.jianshu.io/upload_images/1271831-4d7f9d232c035146.gif?imageMogr2/auto-orient/strip)

![按钮使用示例.gif](http://upload-images.jianshu.io/upload_images/1271831-1fe46c6326188f7f.gif?imageMogr2/auto-orient/strip)
-----

### 可以简单快速灵活的实现上图中的效果


---

### 书写思路移步[这里](http://www.jianshu.com/p/ffb7d3628fb3)

## Requirements

* iOS 8.0+ 
* Xcode 7.3 or above

## Installation

### CocoaPods
####1.在你的项目Podfile里面添加下面的内容

source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'
use_frameworks!

pod 'UsefulPickerView', '~> 0.1.2'

###2.终端中执行命令 pod install
###3. 使用{Project}.xcworkspace打开项目


---
###或者直接下载,将下载文件的Scource文件夹下的文件拖进您的项目中就可以使用了
---

###Usage
---
###如果是使用cocoapods安装的需要在使用的文件中
###import UsefulPickerView
---

####1. TextField 使用, 可以使用xib或者代码初始化
	        // 代码生成
        let test = SelectionTextField(frame: CGRect(x: 20, y: 340, width: 340, height: 28))
        test.borderStyle = .RoundedRect
        test.placeholder = "代码初始化"
        test.showSingleColPicker("测试代码", data: singleData, defaultSelectedIndex: 0, autoSetSelectedText: true) { (textField, selectedIndex, selectedValue) in
            print(selectedValue)
        }
        view.addSubview(test)
        
        singleTextField.showSingleColPicker("编程语言选择", data: singleData, defaultSelectedIndex: 2, autoSetSelectedText: true) {[unowned self] (textField, selectedIndex, selectedValue) in
            //  可以使用textField 也可以使用 self.singleTextField
            textField.text = "选中了第\(selectedIndex)行----选中的数据为\(selectedValue)"
            self.selectedDataLabel.text = "选中了第\(selectedIndex)行----选中的数据为\(selectedValue)"

        }



####2. 按钮使用.在点击事件的方法里面
	        UsefulPickerView.showSingleColPicker("编程语言选择", data: singleData, defaultSelectedIndex: 2) {[unowned self] (selectedIndex, selectedValue) in
            self.selectedDataLabel.text = "选中了第\(selectedIndex)行----选中的数据为\(selectedValue)"
        }
        UsefulPickerView.showMultipleColsPicker("持续时间选择", data: multipleData, defaultSelectedIndexs: [0,1,1]) {[unowned self] (selectedIndexs, selectedValues) in
            self.selectedDataLabel.text = "选中了第\(selectedIndexs)行----选中的数据为\(selectedValues)"

        }



###如果您在使用过程中遇到问题, 请联系我
####QQ:854136959 邮箱: 854136959@qq.com
####如果对您有帮助,请随手给个star鼓励一下 

## License

UsefulPickerView is released under the MIT license. See LICENSE for details.