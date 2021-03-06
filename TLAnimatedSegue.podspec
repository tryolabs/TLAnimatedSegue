#
# Be sure to run `pod lib lint TLAnimatedSegue.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TLAnimatedSegue"
  s.version          = "0.0.3"
  s.summary          = "Segue for present controllers with custom animations."
  s.homepage         = "https://github.com/tryolabs/TLAnimatedSegue"
  s.license          = 'MIT'
  s.author           = { "BrunoBerisso" => "bruno@tryolabs.com" }
  s.source           = { :git => "https://github.com/tryolabs/TLAnimatedSegue.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/tryolabs'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
end
