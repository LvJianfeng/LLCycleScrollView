# iOS图片轮播 LLCycleScrollView

[![License](https://img.shields.io/cocoapods/l/LLCycleScrollView.svg?style=flat)](http://cocoapods.org/pods/LLCycleScrollView)
[![Platform](https://img.shields.io/cocoapods/p/LLCycleScrollView.svg?style=flat)](http://cocoapods.org/pods/LLCycleScrollView)

<img src="https://github.com/LvJianfeng/LLCycleScrollView/blob/master/2.gif" width="400" align="center">  <img src="https://github.com/LvJianfeng/LLCycleScrollView/blob/master/screen.gif" width="400" align="center">

## 实在抱歉
该仓库目前停更已久，代码老旧，作为iOS开发人员由于进入的某二线，说是新一线的城市，岗位的需求急剧下降，目前被发配开发区块链、开发小程序、开发大前端、开发Java.....咳咳，总之很苦逼了。未来有时间我争取改造或者使用SwiftUI来进行开发，届时会第一时间提交，感谢朋友一路陪伴，学习使用，代码质量不足之处居多，一起加油。

## Issues
如果使用过程中，有什么问题欢迎issues。


## Swift
Swift3 请使用1.3.x版本
Swift4 请使用1.4.x版本
Swift4.2 请使用1.5.1+版本
Swift5 请使用1.6.0版本

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
* 支持StoryBoard
* 支持纯文本
* 支持CustomPageControl位置设置
* 支持协议
* 支持左右箭头点击风格

## Update

版本信息 | 更新描述
----    |  ------
1.6.0   | * 依赖最新的库版本，Target iOS 10
1.5.4   | * 修复异步数据崩溃问题
1.5.3   | * 修复依赖库版本问题
1.5.2   | * 修复PageControl重置问题<br>* 修复Xib初始化不自动轮播
1.5.1   | * 迁移Swift 4.2
1.5.0   | * 支持左右方向箭头点击风格<br>* 优化部分代码结构<br>* 优化定时器引用问题
1.4.9   | * 支持图片发生切换回调协议<br>* 修复图片更新为一张图时滚动行为
1.4.8   | * fixed #37 'delegate' is inaccessible due to 'internal' protection level
1.4.7   | * 修复反向滑动问题<br>* 修改纯文本下高度设置问题；
1.4.6   | * 新增协议回调方法<br>* 新增开启/关闭URL特殊字符处理<br>* 优化数量为0的计算控制
1.4.5   | * 新增协议回调方法<br>* 新增开启/关闭URL特殊字符处理<br>* 优化数量为0的计算控制
1.4.4   | * 修复：数据为空的时候的不能设置图片的显示mode<br>* 自定义PageControl图标<br>* 修复单张图滚动问题<br>* 修复infiniteLoop为false后的还可以滚动的逻辑问题
1.4.3   | * 优化没有数据时候，标题背景的显示问题
1.4.2   | * 增加容错率->titles不使用默认，赋值nil出错问题
1.4.1   | * UPDATE
1.4.0   | * Swift4
1.3.6   | * 区分使用
1.3.5   | * 指定支持Swift4的依赖库版本
1.3.4   | * 增加自定义PageControl的位置控制pageControlPosition
1.3.3   | * 修复titles数据异步加载问题
1.3.2   | * 由于IBDesignable问题，临时取消，后续会检查更新
1.3.1   | * 修复图placeHolder显示问题
1.3.0   | * 修复StoryBoard在部分设备显示问题
1.2.9   | * 增加支持文本Leading约束属性titleLeading<br>* PageControl的Bottom约束属性pageControlBottom
1.2.8   | * 支持纯文本部分属性修改，没有开放Label
1.2.7   | * 支持纯文本
1.2.6   | * 修改自定义PageControl反向滚动时候，pageControl的方向控制问题
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

## Usage
```swift
let bannerDemo = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect.init(x: 0, y: bannerDemo.ll_y + 205, width: w, height: 200))
// 是否自动滚动
bannerDemo.autoScroll = true

// 是否无限循环，此属性修改了就不存在轮播的意义了 😄
bannerDemo.infiniteLoop = true

// 滚动间隔时间(默认为2秒)
bannerDemo.autoScrollTimeInterval = 3.0

// 等待数据状态显示的占位图
bannerDemo.placeHolderImage = #UIImage

// 如果没有数据的时候，使用的封面图
bannerDemo.coverImage = #UIImage

// 设置图片显示方式=UIImageView的ContentMode
bannerDemo.imageViewContentMode = .scaleToFill

// 设置滚动方向（ vertical || horizontal ）
bannerDemo.scrollDirection = .vertical

// 设置当前PageControl的样式 (.none, .system, .fill, .pill, .snake)
bannerDemo.customPageControlStyle = .snake

// 非.system的状态下，设置PageControl的tintColor
bannerDemo.customPageControlInActiveTintColor = UIColor.red

// 设置.system系统的UIPageControl当前显示的颜色
bannerDemo.pageControlCurrentPageColor = UIColor.white

// 非.system的状态下，设置PageControl的间距(默认为8.0)
bannerDemo.customPageControlIndicatorPadding = 8.0

// 设置PageControl的位置 (.left, .right 默认为.center)
bannerDemo.pageControlPosition = .center

// 背景色
bannerDemo.collectionViewBackgroundColor

// 添加到view
self.addSubview(bannerDemo1)

// 模拟网络图片获取
DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
  bannerDemo.imagePaths = imagesURLStrings
}
```


## Example

示例代码见ViewController.swift

## Future

* 优化代码
* 未来将计划创建新版本，从而使用上更简单明了

## Author

LvJianfeng, coderjianfeng@foxmail.com
