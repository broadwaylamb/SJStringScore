#
# Be sure to run `pod lib lint StringScore_Swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SJStringScore"
  s.version          = "1.0.1"
  s.summary          = "Swift string search and fuzzy ranking. Score of 0 for no match; up to 1 for perfect."
  s.description      = "Swift string search and fuzzy ranking. Score of 0 for no match; up to 1 for perfect. StringScore is a Swift library which provides fast fuzzy string matching/scoring. Based on the JavaScript library of the same name, by Joshaven Potter."
  s.homepage         = "https://github.com/broadwaylamb/SJStringScore"
  s.license          = 'MIT'
  s.author           = { "Yichi Zhang" => "zhang-yi-chi@hotmail.com" }
  s.source           = { :git => "https://github.com/broadwaylamb/SJStringScore.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/nsyichi'
  s.source_files = 'Sources/**/*.swift'
  
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
end
