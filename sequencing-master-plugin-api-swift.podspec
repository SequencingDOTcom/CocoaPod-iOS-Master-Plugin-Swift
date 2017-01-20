#
#  Be sure to run `pod spec lint sequencing-master-plugin-api-objc.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "sequencing-master-plugin-api-swift"
  s.version      = "1.1.0"
  s.summary      = "Master CocoaPod Plugin for adding Sequencing.com's Real-Time Personalization technology to iOS apps coded in Swift"
  s.homepage     = "https://github.com/SequencingDOTcom/CocoaPod-iOS-Master-Plugin-Swift"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Sequencing" => "gittaca@sequencing.com" }
  s.source       = { 
  :git => "https://github.com/SequencingDOTcom/CocoaPod-iOS-Master-Plugin-Swift.git", 
  :tag => "1.1.0" 
  }
  
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  
  s.dependency "sequencing-oauth-api-swift", "~> 2.0.0"
  s.dependency "sequencing-file-selector-api-swift", "~> 1.1.0"
  s.dependency "sequencing-app-chains-api-swift", "~> 2.1.0"


end
