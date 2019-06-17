
Pod::Spec.new do |s|
  s.name         = "LLCycleScrollView"
  s.version      = "1.6.0"
  s.summary      = "几行代码实现轮播图Swift"
  s.homepage     = "https://github.com/LvJianfeng/LLCycleScrollView"
  s.license      = "MIT"
  s.author       = { "LvJianfeng" => "coderjianfeng@foxmail.com" }

  s.swift_version  = "4.2"
  s.swift_versions = ['4.0', '4.2', '5.0']

  s.ios.deployment_target = "10.0"
  s.tvos.deployment_target = "10.0"
  s.osx.deployment_target = "10.12"
  s.watchos.deployment_target = "3.0"

  s.source         = { :git => "https://github.com/LvJianfeng/LLCycleScrollView.git", :tag => "#{s.version}" }
  s.source_files   = "Lib/LLCycleScrollView/**/*.{swift}"
  s.resource       = "Lib/LLCycleScrollView.bundle"

  s.dependency 'Kingfisher'

  s.requires_arc = true
end
