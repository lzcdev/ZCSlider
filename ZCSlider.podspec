Pod::Spec.new do |s|
  s.name     = 'ZCSlider'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'It is a slider demo'
  s.homepage = 'https://github.com/zcLu'
  s.author   = { 'appdesignvault' => 'appdesignvault' }
  s.source   = { :git => 'https://github.com/zcLu/ZCSlider.git', :tag => s.version }
  s.platform = :ios  
  s.source_files = 'ZCSlider/ZCSlder/*.{h,m}'
  s.framework = 'UIKit'

  s.requires_arc = true  
end
