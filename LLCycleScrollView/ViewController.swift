//
//  ViewController.swift
//  LLCycleScrollView
//
//  Created by LvJianfeng on 2016/11/22.
//  Copyright © 2016年 LvJianfeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var storyBoardBanner: LLCycleScrollView!
    
    var bannerDemo2: LLCycleScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let w = UIScreen.main.bounds.width
        // 网络图，本地图混合
        let imagesURLStrings = [
            "s3.jpg",
            "http://www.g-photography.net/file_picture/3/3587/4.jpg",
            "http://img2.zjolcdn.com/pic/0/13/66/56/13665652_914292.jpg",
            "http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
            "http://img3.redocn.com/tupian/20150806/weimeisheyingtupian_4779232.jpg",
        ];
        
        // let imagesURLStrings = [
        //     "s3.jpg","s2","s1"
        // ];
        
        // 图片配文字
        let titles = ["感谢您的支持",
                      "如果代码在使用过程中出现问题",
                      "您可以发邮件到coderjianfeng@foxmail.com您可以发邮件到coderjianfeng@foxmail.com"
                      ];
        
        
        // Storyboard Demo
        self.storyBoardBanner.imagePaths = imagesURLStrings
        self.storyBoardBanner.titles = titles
        
        // 新增图片显示控制
        self.storyBoardBanner.imageViewContentMode = .scaleToFill
        self.storyBoardBanner.customPageControlStyle = .image
        self.storyBoardBanner.pageControlPosition = .left
        self.storyBoardBanner.pageControlActiveImage = #imageLiteral(resourceName: "dot")
        self.storyBoardBanner.pageControlInActiveImage = #imageLiteral(resourceName: "dottest")
        
        // 是否对url进行特殊字符处理
        self.storyBoardBanner.isAddingPercentEncodingForURLString = true
        
        // 2018-02-25 新增协议
        self.storyBoardBanner.delegate = self
        
        
        
        // 纯文本demo
        let titleDemo = LLCycleScrollView.llCycleScrollViewWithTitles(frame: CGRect.init(x: 0, y: self.storyBoardBanner.ll_y + 190, width: w, height:70)) { (index) in
            print("当前点击文本的位置为:\(index)")
        }
        
        titleDemo.customPageControlStyle = .none
        titleDemo.scrollDirection = .vertical
        titleDemo.font = UIFont.systemFont(ofSize: 13)
        titleDemo.textColor = UIColor.white
        titleDemo.titleBackgroundColor = UIColor.red
        titleDemo.numberOfLines = 2
        // 文本　Leading约束
        titleDemo.titleLeading = 30
        scrollView.addSubview(titleDemo)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            titleDemo.titles = titles
        }
        
        // Demo--点击回调
        let bannerDemo = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect.init(x: 0, y:titleDemo.ll_y + 80, width: w, height: 200), imageURLPaths: imagesURLStrings, titles:nil, didSelectItemAtIndex: { index in
            print("当前点击图片的位置为:\(index)")
        })
        
        bannerDemo.lldidSelectItemAtIndex = { index in
            
        }
        bannerDemo.customPageControlStyle = .fill
        bannerDemo.customPageControlInActiveTintColor = UIColor.red
        bannerDemo.pageControlPosition = .left
        bannerDemo.pageControlLeadingOrTrialingContact = 28
        
        // 下边约束
        bannerDemo.pageControlBottom = 15
        scrollView.addSubview(bannerDemo)

        
        /*
        // Demo--延时加载数据之滚动方向控制
        let bannerDemo1 = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect.init(x: 0, y: bannerDemo.ll_y + 205, width: w, height: 200))
        // 垂直滚动
        bannerDemo1.scrollDirection = .vertical
        bannerDemo1.customPageControlStyle = .snake
        scrollView.addSubview(bannerDemo1)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            bannerDemo1.imagePaths = imagesURLStrings
        }
         */
        
        // Demo--带左右箭头
        let bannerDemo1 = LLCycleScrollView.llCycleScrollViewWithArrow(CGRect.init(x: 0, y: bannerDemo.ll_y + 205, width: w, height: 200), arrowLRImages: [UIImage.init(named: "ico-two-left-arrow")!, UIImage.init(named: "ico-two-right-arrow")!], imageURLPaths: imagesURLStrings, titles:nil, didSelectItemAtIndex: { index in
            print("当前点击图片的位置为:\(index)")
        })
        
        bannerDemo1.lldidSelectItemAtIndex = { index in
            
        }
        bannerDemo1.customPageControlStyle = .snake
        bannerDemo1.customPageControlInActiveTintColor = UIColor.red
        bannerDemo1.pageControlPosition = .center
        bannerDemo1.pageControlLeadingOrTrialingContact = 28
        
        // 下边约束
        bannerDemo.pageControlBottom = 15
        scrollView.addSubview(bannerDemo1)
        
        
        // Demo--其他属性
        bannerDemo2 = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect.init(x: 0, y: bannerDemo1.ll_y + 205, width: w, height: 200))
        // 滚动间隔时间
        bannerDemo2.autoScrollTimeInterval = 3.0
        // 加载状态图
        bannerDemo2.placeHolderImage = #imageLiteral(resourceName: "s1")
        // 没有数据时候的封面图
        bannerDemo2.coverImage = #imageLiteral(resourceName: "s2")
        bannerDemo2.customPageControlStyle = .none
        scrollView.addSubview(bannerDemo2)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            self.bannerDemo2.imagePaths = imagesURLStrings
            self.bannerDemo2.titles = titles
        }
        scrollView.contentSize = CGSize.init(width: 0, height: bannerDemo2.ll_y+220)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ViewController: LLCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: LLCycleScrollView, didSelectItemIndex index: NSInteger) {
        print("协议：当前点击文本的位置为:\(index)")
    }
}

