#
# Be sure to run `pod lib lint TBaseKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TBaseKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of TBaseKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/methodname@qq.com/TBaseKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'methodname@qq.com' => 'methodname@qq.com' }
  s.source           = { :git => 'https://github.com/methodname@qq.com/TBaseKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'TBaseKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'TBaseKit' => ['TBaseKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AMPopTip', '~> 1.5.3'
  s.dependency 'DZNEmptyDataSet', '~> 1.8.1'
  s.dependency 'MJRefresh', '~> 3.1.15.3'
  s.dependency 'SVProgressHUD', '~> 2.2.5'
  s.dependency 'Masonry', '~> 1.1.0'
end
