#
# Be sure to run `pod lib lint MAAnimatedSegmentedControl.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MAAnimatedSegmentedControl"
  
  s.version          = "0.1.0"
  s.summary          = "UIControl subclass based on Segmented with rebound" 
  s.description      = <<-DESC
  							MAAnimatedSegmentedControl is a UIControl based on
							UISegmentedControl with rounded focus and awesome animation.
                       DESC

  s.homepage         = "https://github.com/Minguel/MAAnimatedSegmentedControl"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Miguel Ángel Aragonés Castañeda" => "minguel553@gmail.com" }
  s.source           = { :git => "https://github.com/Minguel/MAAnimatedSegmentedControl.git", :tag => s.version.to_s }
	s.social_media_url = 'https://twitter.com/iminguel'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'MAAnimatedSegmentedControl' => ['Pod/Assets/*.png']
  }
end
