Pod::Spec.new do |s|
  s.name        = "UsefulPickerView"
  s.version     = "0.0.2"
  s.summary     = "UsefulPickerView is written in Swift and it is useful."
  s.homepage    = "https://github.com/jasnig/UsefulPickerView"
  s.license     = { :type => "MIT" }
  s.author     = { "ZeroJ" => "854136959@qq.com" }

  s.requires_arc = true
  s.ios.deployment_target = "8.0"
  s.source   = { :git => "https://github.com/jasnig/UsefulPickerView.git", :tag => "v#{s.version}", :submodules => true }
  s.source_files = "UsefulPickerView/UsefulPickerView/*.swift","UsefulPickerView/UsefulPickerView/*.plist"
end