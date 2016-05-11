//
//  ViewController.swift
//  NewHomeDemo
//
//  Created by miaolin on 16/5/10.
//  Copyright © 2016年 赵攀. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化子控制器(这里实例用同一个控制器，你可以传不同控制器，传不同控制器时候，请保持和标题个数一致，否则程序会崩溃!!!)
        setupChildVC()
        //创建新闻控件
        setupNewView()
        automaticallyAdjustsScrollViewInsets = false
    }
    
    private func setupChildVC() {
        let newsVC0 = NewsController()
        newsVC0.title = "头条"
        addChildViewController(newsVC0)
        
        let newsVC1 = NewsController()
        newsVC1.title = "热点"
        addChildViewController(newsVC1)
        
        let newsVC2 = NewsController()
        newsVC2.title = "政治"
        addChildViewController(newsVC2)
        
        let newsVC3 = NewsController()
        newsVC3.title = "经济"
        addChildViewController(newsVC3)
        
        let newsVC4 = NewsController()
        newsVC4.title = "文化"
        addChildViewController(newsVC4)
        
        let newsVC5 = NewsController()
        newsVC5.title = "军事"
        addChildViewController(newsVC5)
        
        let newsVC6 = NewsController()
        newsVC6.title = "国际"
        addChildViewController(newsVC6)
        
        let newsVC7 = NewsController()
        newsVC7.title = "国内"
        addChildViewController(newsVC7)
    }
    
    private func setupNewView() {
        let newHomeView = ZPNewHomeView()
        newHomeView.frame.origin.y = 64
        newHomeView.frame.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 64)
        view.addSubview(newHomeView)
        //设置属性
        newHomeView.ZP_Titles = ["头条", "热点", "政治", "经济", "文化", "军事", "国际", "国内"]
        newHomeView.ZP_ContentVCS = childViewControllers
        
    }
    
}

