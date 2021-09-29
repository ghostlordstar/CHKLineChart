#
# Be sure to run `pod lib lint CHKLineChartKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CHKLineChartKit'
  s.version          = '2.4.0'
  s.summary          = 'KLine Chart Kit by Swift4.2.| 纯Swift代码编写的K线图表组件.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
        纯Swift代码编写的K线图表组件，支持：MA,EMA,KDJ,MACD等技术指标显示。集成使用简单，二次开发扩展强大
                       DESC

  s.homepage         = 'https://github.com/zhiquan911/CHKLineChart'
   s.screenshots     = 'https://raw.githubusercontent.com/zhiquan911/CHKLineChart/screenshots/s1.png', 'https://raw.githubusercontent.com/zhiquan911/CHKLineChart/master/screenshots/s2.png', 'https://raw.githubusercontent.com/zhiquan911/CHKLineChart/master/screenshots/s3.png', 'https://raw.githubusercontent.com/zhiquan911/CHKLineChart/master/screenshots/s4.png', 'https://raw.githubusercontent.com/zhiquan911/CHKLineChart/master/screenshots/s5.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Chance" => "zhiquan911@qq.com" }
  s.source           = { :git => 'https://github.com/zhiquan911/CHKLineChart.git', :tag => s.version.to_s }
  s.social_media_url = 'https://github.com/zhiquan911/CHKLineChart'
  
  s.platform     = :ios, "9.0"
  s.ios.deployment_target = '9.0'
  s.swift_version = "4.2"
  
  s.source_files = 'CHKLineChart/Classes/**/*'
  s.requires_arc = true
end

# 1. 添加swift支持版本 4.2
