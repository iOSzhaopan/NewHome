//
//  ZPTitleScrollView.swift
//  NewHomeDemo
//
//  Created by miaolin on 16/5/10.
//  Copyright © 2016年 赵攀. All rights reserved.
//

import UIKit

//["scrollViewBGColor" : self.ZP_TitleScrollViewBGColor, "titleLableWidth" : self.ZP_TitleLableWidth, "titles" : self.ZP_Titles, "titleLableBGColor" : self.ZP_TitleLableBGColor, "titleLableCornerRadius" : self.ZP_TitleLableCornerRadius, "lableFont" : self.ZP_LableFont, "lbaleZoomMultiple" : self.ZP_LbaleZoomMultiple]

class ZPTitleScrollView: UIScrollView {
    
    private let ZPScreenWidth = UIScreen.mainScreen().bounds.width
    private let ZPScreenHeight = UIScreen.mainScreen().bounds.height
    private let TagStart = 100
    
    var lableSmallRGB: (R: CGFloat, G: CGFloat, B: CGFloat) = (0, 0, 0)
    var lableBigRGC: (R: CGFloat, G: CGFloat, B: CGFloat) = (1, 1, 0)
    
    var titleCilckIndex: ((index: Int) -> Void)?
    
    /// 标题的数组(这个必须传)
    var ZP_Titles: [String]? {
        didSet {
            setupTitleLable()
        }
    }
    
    /// 标题的lable的宽度(默认是100)
    var ZP_TitleLableWidth: CGFloat = 100 {
        didSet {
            for i in 0..<subviews.count {
                let lable = subviews[i]
                lable.frame = CGRect(x: CGFloat(i) * self.ZP_TitleLableWidth, y: 0, width: self.ZP_TitleLableWidth, height: frame.size.height)
            }
            let lastLable = viewWithTag(100 + subviews.count - 1)
            contentSize = CGSize(width: CGRectGetMaxX(lastLable!.frame), height: 0)
        }
    }
    /// 标题lable的背景色(默认是白色)
    var ZP_TitleLableBGColor: UIColor? {
        didSet {
            for lable in subviews {
                lable.backgroundColor = ZP_TitleLableBGColor
            }
        }
    }
    /// 标题lable字体大小 (默认14)
    var ZP_LableFont: CGFloat = 14 {
        didSet {
            for i in 0..<subviews.count {
                let lable = subviews[i] as! ZP_TitleLable
                lable.font = UIFont.systemFontOfSize(ZP_LableFont)
            }
        }
    }
    /// 放大倍数 (默认是0.3倍)
    var ZP_LableZoomMultiple: CGFloat = 0.3 {
        didSet {
            for i in 0..<subviews.count {
                let lable = subviews[i] as! ZP_TitleLable
                lable.labaleZoomMultiple = ZP_LableZoomMultiple
                if i == 0 {
                    lable.scale = 1
                }
            }
        }
    }
    /// 标题lable没有被放大时候的文字颜色(默认是黑色)
    var ZP_LableSmallRGB: (R: CGFloat, G: CGFloat, B: CGFloat)? {
        didSet {
            for i in 0..<subviews.count {
                let lable = subviews[i] as! ZP_TitleLable
                lable.startColor = ZP_LableSmallRGB
            }
        }
    }
    /// 标题lable被放大时候的文字颜色(默认是黄色)
    var ZP_LableBigRGB: (R: CGFloat, G: CGFloat, B: CGFloat)? {
        didSet {
            for i in 0..<subviews.count {
                let lable = subviews[i] as! ZP_TitleLable
                lable.endColor = ZP_LableBigRGB
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: self.ZPScreenWidth, height: 44)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        backgroundColor = UIColor.lightGrayColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitleLable() {
        
        let titles = ZP_Titles
        let lableW = ZP_TitleLableWidth
        
        for i in 0..<titles!.count {
            let lable = ZP_TitleLable()
            lable.frame = CGRect(x: CGFloat(i) * lableW, y: 0, width: lableW, height: frame.size.height)
            lable.backgroundColor = ZP_TitleLableBGColor
            lable.font = UIFont.systemFontOfSize(ZP_LableFont)
            lable.textColor = UIColor(red: lableSmallRGB.R, green: lableSmallRGB.G, blue: lableSmallRGB.B, alpha: 1.0)
            lable.tag = TagStart + i
            lable.text = titles![i]
            lable.startColor = (1, 0, 0)
            lable.endColor = (0, 1, 0)
            if i == 0 {
                lable.scale = 1
            }
            lable.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "lableClick:"))
            addSubview(lable)
        }
        let lastLable = viewWithTag(100 + subviews.count - 1)
        contentSize = CGSize(width: CGRectGetMaxX(lastLable!.frame), height: 0)
    }
    
    func lableClick(tap: UITapGestureRecognizer) {
        if titleCilckIndex != nil {
            titleCilckIndex!(index: tap.view!.tag - TagStart)
        }
    }
    
}
