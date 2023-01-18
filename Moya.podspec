Pod::Spec.new do |s|
  s.name         = "Moya"
  s.version      = "15.1.0-onelight"
  s.summary      = "Network abstraction layer written in Swift"
  s.description  = <<-EOS
  Moya abstracts network commands using Swift Generics to provide developers
  with more compile-time confidence.

  ReactiveSwift and RxSwift extensions exist as well. Instructions for installation
  are in [the README](https://github.com/Moya/Moya).
  EOS
  s.homepage     = "https://github.com/OnelightApps/Moya"
  s.license      = { :type => "MIT", :file => "License.md" }
  s.author             = { "Ash Furrow" => "ash@ashfurrow.com" }
  s.social_media_url   = "http://twitter.com/ashfurrow"
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.source       = { :git => "git@github.com:OnelightApps/Moya.git", :tag => s.version }
  s.default_subspec = "Core"
  s.swift_version = '5.3'
  s.cocoapods_version = '>= 1.4.0'

  s.subspec "Core" do |ss|
    ss.source_files  = "Sources/Moya/", "Sources/Moya/Plugins/"
    ss.dependency "Alamofire", "~> 5.0"
    ss.framework  = "Foundation"
  end

  s.subspec "Combine" do |ss|
    ss.source_files  = "Sources/CombineMoya/"
    ss.dependency "Moya/Core"
    ss.framework  = "Combine"
    ss.ios.deployment_target = '13.0'
    ss.osx.deployment_target = '10.15'
  end

  s.subspec "ReactiveSwift" do |ss|
    ss.source_files = "Sources/ReactiveMoya/"
    ss.dependency "Moya/Core"
    ss.dependency "ReactiveSwift", "~> 7.1"
  end

  s.subspec "RxSwift" do |ss|
    ss.source_files = "Sources/RxMoya/"
    ss.dependency "Moya/Core"
    ss.dependency "RxSwift", "~> 6.0"
  end
end
