//
//  ZPContentScrollView.swift
//  NewHomeDemo
//
//  Created by miaolin on 16/5/11.
//  Copyright © 2016年 赵攀. All rights reserved.
//

import UIKit

class ZPContentScrollView: UIScrollView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        backgroundColor = UIColor.lightGrayColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
