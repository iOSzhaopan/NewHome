//
//  ZPNewHomeView.swift
//  NewHomeDemo
//
//  Created by miaolin on 16/5/10.
//  Copyright © 2016年 赵攀. All rights reserved.
//

import UIKit

class ZPNewHomeView: UIView {
    
    //MARK: - 对外的接口
    /// 控制器数组(这个必须传)
    var ZP_ContentVCS: [UIViewController]? {
        didSet {
            
            contentScrollView.contentSize = CGSize(width: UIScreen.mainScreen().bounds.size.width * CGFloat(ZP_ContentVCS!.count), height: 0)
            scrollViewDidEndScrollingAnimation(contentScrollView)
        }
    }
    /// 标题的数组(这个必须传)
    var ZP_Titles: [String]? {
        didSet {
            titleScrollView.ZP_Titles = ZP_Titles
        }
    }
    
    /// 标题的scrollView的颜色(默认是灰色)
    var ZP_TitleScrollViewBGColor: UIColor? {
        didSet {
            titleScrollView.backgroundColor = ZP_TitleScrollViewBGColor
        }
    }
    /// 内容的scrollView的颜色(默认是灰色)
    var ZP_ContentScrollViewBGColor: UIColor? {
        didSet {
            contentScrollView.backgroundColor = ZP_ContentScrollViewBGColor
        }
    }
    
    /// 标题的lable的宽度(默认是100)
    var ZP_TitleLableWidth: CGFloat = 100 {
        didSet {
            titleScrollView.ZP_TitleLableWidth = ZP_TitleLableWidth
        }
    }
    /// 标题lable的背景色(默认是白色)
    var ZP_TitleLableBGColor: UIColor? {
        didSet {
            titleScrollView.ZP_TitleLableBGColor = ZP_TitleLableBGColor!
        }
    }
    /// 标题lable字体大小 (默认14)
    var ZP_LableFont: CGFloat = 14 {
        didSet {
            titleScrollView.ZP_LableFont = ZP_LableFont
        }
    }
    /// 放大倍数 (默认是0.3倍, 建议写0~0.5)
    var ZP_LableZoomMultiple: CGFloat = 0.3 {
        didSet {
            titleScrollView.ZP_LableZoomMultiple = ZP_LableZoomMultiple
        }
    }
    /// 标题lable没有被放大时候的文字颜色(默认是红色)
    var ZP_LableSmallRGB: (R: CGFloat, G: CGFloat, B: CGFloat)? {
        didSet {
            titleScrollView.ZP_LableSmallRGB = ZP_LableSmallRGB
        }
    }
    /// 标题lable被放大时候的文字颜色(默认是黄色)
    var ZP_LableBigRGB: (R: CGFloat, G: CGFloat, B: CGFloat)? {
        didSet {
            titleScrollView.ZP_LableBigRGB = ZP_LableBigRGB
        }
    }
    //MARK: - 内部私有的
    private let ZPScreenWidth = UIScreen.mainScreen().bounds.width
    private let ZPScreenHeight = UIScreen.mainScreen().bounds.height
    private let scrollW = UIScreen.mainScreen().bounds.size.width
    private let tagStart = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleScrollView)
        
        addSubview(contentScrollView)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MAKR: - 懒加载
    /// 顶部的ScrollView
    private lazy var titleScrollView: ZPTitleScrollView = {
        let scrollView = ZPTitleScrollView()
        weak var weakSelf = self
        scrollView.titleCilckIndex = { (index) -> Void in
            let offsetX = UIScreen.mainScreen().bounds.size.width * CGFloat(index)
            weakSelf!.contentScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        }
        return scrollView
    }()
    private lazy var contentScrollView: ZPContentScrollView = {
        let scrollView = ZPContentScrollView()
        scrollView.frame = CGRect(x: 0, y: CGRectGetMaxY(self.titleScrollView.frame), width: self.ZPScreenWidth, height: self.ZPScreenHeight - CGRectGetMaxY(self.titleScrollView.frame))
        scrollView.delegate = self
        scrollView.pagingEnabled = true
        return scrollView
    }()
}

extension ZPNewHomeView: UIScrollViewDelegate {
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        var offset = scrollView.contentOffset
        let scrollH = scrollView.frame.size.height
        let index: Int = Int(offset.x / scrollW)
        let vc = ZP_ContentVCS![index]
        vc.view.frame = CGRect(x: CGFloat(index) * scrollW, y: 0, width: scrollW, height: scrollH)
        contentScrollView.addSubview(vc.view)
        
        
        let subView = titleScrollView.subviews[index]
        offset.x = subView.center.x - scrollW * 0.5
        if offset.x <= 0 {
            offset.x = 0
        }
        if offset.x >= titleScrollView.contentSize.width - scrollW - ZP_TitleLableWidth * 0.5 {
            offset.x = titleScrollView.contentSize.width - scrollW
        }
        titleScrollView.setContentOffset(offset, animated: true)
        
        for lable: ZP_TitleLable in titleScrollView.subviews as! [ZP_TitleLable] {
            if lable != subView {
                lable.scale = 0
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollW)
        let scale = scrollView.contentOffset.x / scrollW - CGFloat(index)
        if scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > scrollView.contentSize.width - scrollView.frame.size.width {
            return
        }
        let leftLable = titleScrollView.viewWithTag(tagStart + index) as! ZP_TitleLable
        leftLable.scale = 1 - scale
        if index >= ZP_ContentVCS!.count - 1 {
            return
        }
        let rightLable = titleScrollView.viewWithTag(tagStart + index + 1) as! ZP_TitleLable
        rightLable.scale = scale
    }
    
}
