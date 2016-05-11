//
//  ZP_TitleLable.swift
//  NewHomeDemo
//
//  Created by miaolin on 16/5/11.
//  Copyright © 2016年 赵攀. All rights reserved.
//

import UIKit

class ZP_TitleLable: UILabel {
    
    var labaleZoomMultiple: CGFloat = 0.3
    
    var startColor: (R: CGFloat, G: CGFloat, B: CGFloat)? {
        didSet {
            textColor = UIColor(red: startColor!.R, green: startColor!.G, blue: startColor!.B, alpha: 1.0)
        }
    }
    var endColor: (R: CGFloat, G: CGFloat, B: CGFloat)?
    
    var scale: CGFloat = 0 {
        didSet {
            transform = CGAffineTransformMakeScale(1 + labaleZoomMultiple * scale, 1 + labaleZoomMultiple * scale)
            textColor = UIColor(red: startColor!.R + (endColor!.R - startColor!.R) * scale, green: startColor!.G + (endColor!.G - startColor!.G) * scale, blue: startColor!.B + (endColor!.B - startColor!.B) * scale, alpha: 1.0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .Center
        userInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
