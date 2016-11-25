//
//  LLCycleScrollView.swift
//  LLCycleScrollView
//
//  Created by LvJianfeng on 2016/11/22.
//  Copyright © 2016年 LvJianfeng. All rights reserved.
//

import UIKit
import Kingfisher

typealias LLdidSelectItemAtIndexClosure = (NSInteger) -> Void
@IBDesignable class LLCycleScrollView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    // MARK: 控制参数
    // 是否自动滚动，默认true
    @IBInspectable open var autoScroll: Bool? = true {
        didSet {
            invalidateTimer()
            if autoScroll! {
                setupTimer()
            }
        }
    }
    
    // 无限循环，默认true 此属性修改了就不存在轮播的意义了
    @IBInspectable open var infiniteLoop: Bool? = true {
        didSet {
            if imagePaths.count > 0 {
                let temp = imagePaths
                imagePaths = temp
            }
        }
    }
    
    // 滚动方向，默认horizontal
    open var scrollDirection: UICollectionViewScrollDirection? = .horizontal {
        didSet {
            flowLayout?.scrollDirection = scrollDirection!
            if scrollDirection == .horizontal {
                position = .centeredHorizontally
            }else{
                position = .centeredVertically
            }
        }
    }
    
    // 滚动间隔时间,默认2s
    @IBInspectable open var autoScrollTimeInterval: Double = 2.0 {
        didSet {
            autoScroll = true
        }
    }
    
    // 加载状态图 -- 这个是有数据，等待加载的占位图
    @IBInspectable open var placeHolderImage: UIImage? = nil {
        didSet {
            if placeHolderImage != nil {
                placeHolderViewImage = placeHolderImage
            }
        }
    }
    
    // 空数据页面显示占位图 -- 这个是没有数据，整个轮播器的占位图
    @IBInspectable open var coverImage: UIImage? = nil {
        didSet {
            if coverImage != nil {
                coverViewImage = coverImage
            }
        }
    }
    
    // 背景色
    @IBInspectable var collectionViewBackgroundColor: UIColor! = UIColor.clear
    
    // ImagePaths
    open var imagePaths: Array<String> = [] {
        didSet {
            totalItemsCount = infiniteLoop! ? imagePaths.count * 100 : imagePaths.count
            if imagePaths.count != 1 {
                collectionView.isScrollEnabled = true
                autoScroll = true
            }else{
                collectionView.isScrollEnabled = false
            }
            
            setupPageControl()
            collectionView.reloadData()
        }
    }
    
    // 标题
    open var titles: Array<String> = []
    
    // MARK: Private
    // Identifier
    fileprivate let identifier = "LLCycleScrollViewCell"
    
    // 数量
    fileprivate var totalItemsCount: NSInteger! = 1
    
    // 显示图片(CollectionView)
    fileprivate var collectionView: UICollectionView!
    
    // 方向(swift后没有none，只能指定了)
    fileprivate var position: UICollectionViewScrollPosition! = .centeredHorizontally
    
    // FlowLayout
    lazy fileprivate var flowLayout: UICollectionViewFlowLayout? = {
        let tempFlowLayout = UICollectionViewFlowLayout.init()
        tempFlowLayout.minimumLineSpacing = 0
        tempFlowLayout.scrollDirection = .horizontal
        return tempFlowLayout
    }()
    
    // 计时器
    fileprivate var timer: Timer?
    
    // PageControl
    fileprivate var pageControl: UIPageControl?
    
    // 加载状态图
    fileprivate var placeHolderViewImage: UIImage! = UIImage.init(named: "LLCycleScrollView.bundle/llplaceholder.png")
    
    // 空数据页面显示占位图
    fileprivate var coverViewImage: UIImage! = UIImage.init(named: "LLCycleScrollView.bundle/llplaceholder.png")
    
    // 回调
    var lldidSelectItemAtIndex: LLdidSelectItemAtIndexClosure? = nil
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // setupMainView
        setupMainView()
    }
    
    // Class func
    class func llCycleScrollViewWithFrame(_ frame: CGRect, imageURLPaths: Array<String>? = [], titles:Array<String>? = [], didSelectItemAtIndex: LLdidSelectItemAtIndexClosure? = nil) -> LLCycleScrollView {
        let llcycleScrollView: LLCycleScrollView = LLCycleScrollView.init(frame: frame)
        if (imageURLPaths?.count)! > 0 {
            llcycleScrollView.imagePaths = imageURLPaths!
        }
        if (titles?.count)! > 0 {
            llcycleScrollView.titles = titles!
        }
        if didSelectItemAtIndex != nil {
            llcycleScrollView.lldidSelectItemAtIndex = didSelectItemAtIndex
        }
        return llcycleScrollView
    }
    
    
    // MARK: -
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupMainView()
    }
    
    // MARK: setupMainView
    private func setupMainView() {
        collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: flowLayout!)
        collectionView.register(LLCycleScrollViewCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.backgroundColor = collectionViewBackgroundColor
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        self.addSubview(collectionView)
    }
    
    // MARK: Timer
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: autoScrollTimeInterval as TimeInterval, target: self, selector: #selector(automaticScroll), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    func invalidateTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func setupPageControl() {
        // 重新添加
        if pageControl != nil {
            pageControl?.removeFromSuperview()
        }
        
        // warning: 条件判断待添加
        
        pageControl = UIPageControl.init()
        pageControl?.numberOfPages = self.imagePaths.count
        self.addSubview(pageControl!)
    }
    
    // MARK: layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        // Cell Size
        flowLayout?.itemSize = self.frame.size
        // Page Frame
        pageControl?.frame = CGRect.init(x: 0, y: self.ll_h-20, width: UIScreen.main.bounds.width, height: 20)
        
        if collectionView.contentOffset.x == 0 && totalItemsCount > 0 {
            var targetIndex = 0
            if infiniteLoop! {
                targetIndex = totalItemsCount/2
            }
            collectionView.scrollToItem(at: IndexPath.init(item: targetIndex, section: 0), at: position, animated: false)
        }
    }
    
    // MARK: Actions
    func automaticScroll() {
        if totalItemsCount == 0 {return}
        let targetIndex = currentIndex() + 1
        scollToIndex(targetIndex: targetIndex)
    }
    
    func scollToIndex(targetIndex: Int) {
        if targetIndex >= totalItemsCount {
            if infiniteLoop! {
                collectionView.scrollToItem(at: IndexPath.init(item: Int(totalItemsCount/2), section: 0), at: position, animated: false)
            }
            return
        }
        collectionView.scrollToItem(at: IndexPath.init(item: targetIndex, section: 0), at: position, animated: true)
    }
    
    func currentIndex() -> NSInteger {
        if collectionView.ll_w == 0 || collectionView.ll_h == 0 {
            return 0
        }
        var index = 0
        if flowLayout?.scrollDirection == UICollectionViewScrollDirection.horizontal {
            index = NSInteger(collectionView.contentOffset.x + (flowLayout?.itemSize.width)! * 0.5)/NSInteger((flowLayout?.itemSize.width)!)
        }else {
            index = NSInteger(collectionView.contentOffset.y + (flowLayout?.itemSize.height)! * 0.5)/NSInteger((flowLayout?.itemSize.height)!)
        }
        return index
    }
    
    func pageControlIndexWithCurrentCellIndex(index: NSInteger) -> (Int) {
        return Int(index % imagePaths.count)
    }
    
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalItemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LLCycleScrollViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! LLCycleScrollViewCell
        
        // 0==count 占位图
        if imagePaths.count == 0 {
            cell.imageView.image = coverViewImage
        }else{
            let itemIndex = pageControlIndexWithCurrentCellIndex(index: indexPath.item)
            let imagePath = imagePaths[itemIndex]
            cell.imageView.kf.setImage(with: URL(string: imagePath), placeholder: placeHolderImage)
            // 对冲数据判断
            if itemIndex <= titles.count-1 {
                cell.title = titles[itemIndex]
            }else{
                cell.title = ""
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let didSelectItemAtIndexPath = lldidSelectItemAtIndex {
            didSelectItemAtIndexPath(pageControlIndexWithCurrentCellIndex(index: indexPath.item))
        }
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if imagePaths.count == 0 {return}
        let indexOnPageControl = pageControlIndexWithCurrentCellIndex(index: currentIndex())
        pageControl?.currentPage = indexOnPageControl
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if autoScroll! {
            invalidateTimer()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if autoScroll! {
            setupTimer()
        }
    }
 
}
