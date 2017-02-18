# iOS图片轮播 LLCycleScrollView

[![License](https://img.shields.io/cocoapods/l/LLCycleScrollView.svg?style=flat)](http://cocoapods.org/pods/LLCycleScrollView)
[![Platform](https://img.shields.io/cocoapods/p/LLCycleScrollView.svg?style=flat)](http://cocoapods.org/pods/LLCycleScrollView)

<img src="https://github.com/LvJianfeng/LLCycleScrollView/blob/master/2.gif" width="400" align="center">  <img src="https://github.com/LvJianfeng/LLCycleScrollView/blob/master/screen.gif" width="400" align="center">

## Issues
如果使用过程中，有什么问题欢迎issues。

## Support

* 支持纯图片
* 支持文本图片结合
* 支持横向滚动
* 支持纵向滚动
* 支持手势滑动
* 支持点击回调
* 支持图片数据的延时加载
* 支持没有数据，占位图占位(仅设置CoverImage(有默认图)即可)
* 支持本地图片显示及与网络图的混合显示
* 支持系统UIPageControl位置设置

## Update

版本信息 | 更新描述
----    |  ------
1.2.5   | * 修复自定义PageControl快速滚动问题，修复系统UIPageControl位置left&right对换设置问题
1.2.4   | * 支持系统UIPageControl位置设置，其属性pageControlPosition<br>* 公开pageControl及customPageControl两个控件，方便控制及自定义
1.2.3   | * 支持本地图片显示及与网络图的混合显示<br>* 增加图片contentMode的控制
1.2.2   | * 标题显示两行文字
1.2.1   | * 支持不同类型的PageControl<br>* 支持修改PageControl颜色，当前显示颜色等(文件注释)
1.1.1   | * 支持Storyboard

## CocoaPods
* 支持CocoaPods
```ruby
pod 'LLCycleScrollView' 
```
<!--注意：在pod install的时候，比较慢(可能网速问题)，如果在pod update的时候就比较快了，此无解。-->
## Future

* 支持纯文本
* 优化代码

## Example

示例代码见ViewController.swift

## Author

LvJianfeng, coderjianfeng@foxmail.com






