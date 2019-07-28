#
# Be sure to run `pod lib lint PeripheralMenu.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PeripheralMenu'
  s.version          = '0.1.1'
  s.summary          = 'PeripheralMenu is essentially a re-usable side menu with some customizations.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This CocoaPod creates a reusable, customizable side menu for API users. It is essentially a fork of the SideMenuController by TeodorPatras, with extended functionality and will always be maintained and updated to latest Swift language version.
                       DESC

  s.homepage         = 'https://github.com/michaelcordero/PeripheralMenu'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'michaelcordero' => 'michaelpetercordero@gmail.com' }
  s.source           = { :git => 'https://github.com/michaelcordero/PeripheralMenu.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.source_files = 'PeripheralMenu/Classes/**/*'
  # s.resource_bundles = {
  #   'PeripheralMenu' => ['PeripheralMenu/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
