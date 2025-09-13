#
# Be sure to run `pod lib lint XTPageView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XTPageView'
  s.version          = '0.0.1'
  s.summary          = 'summary:仿照腾讯视频VIPTAB实现的页面框架'
  s.description      = 'description:仿照腾讯视频VIPTAB实现的页面框架'
  s.homepage         = 'https://github.com/summer-xia-star/XTPageView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'summerrrxia' => 'summerrrxia@tencent.com' }
  s.source           = { :git => 'https://github.com/summer-xia-star/XTPageView.git', :tag => s.version.to_s }
  s.swift_versions   = ['5.0']
  s.ios.deployment_target = '10.0'
  s.source_files = 'XTPageView/Classes/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
