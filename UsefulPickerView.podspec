Pod::Spec.new do |s|
  s.name        = "UsefulPickerView"
  s.version     = "0.1.0"
  s.summary     = "UsefulPickerView is written in Swift and it is useful."
  s.homepage    = "https://github.com/jasnig/UsefulPickerView"
  s.license     = { :type => "MIT" }
  s.authors     = { "ZeroJ" => "854136959@qq.com" }

  s.requires_arc = true
  s.platform     = :ios
  s.platform     = :ios, "8.0"
  s.source   = { :git => "https://github.com/jasnig/UsefulPickerView.git", :tag => s.version }
  s.framework  = "UIKit"
  s.source_files = "Source/*.swift","Source/*.plist"
end