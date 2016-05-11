# NewHome
类似网易新闻首页的一个框架(Swift)
##1. 最为简单的用法
在控制器中写一下代码
```objc
  //如果是导航控制器请设置y值为64，否则会挡住
  newHomeView.frame.origin.y = 64
  newHomeView.frame.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 64)
  //添加这个view
  view.addSubview(newHomeView)
  //设置属性
  newHomeView.ZP_Titles = ["头条", "热点", "政治", "经济", "文化", "军事", "国际", "国内"]
  //这个地方你尽量把需要的控制器作为父控制器的子控制器，将子控制器数组给这个控件
  newHomeView.ZP_ContentVCS = childViewControllers
```
##2. 你可以设置一些属性，来控制这个view的显示效果，已到达你的预期
```objc
/// 标题的scrollView的颜色(默认是灰色)
var ZP_TitleScrollViewBGColor: UIColor?
/// 内容的scrollView的颜色(默认是灰色)
var ZP_ContentScrollViewBGColor: UIColor? 
/// 标题的lable的宽度(默认是100)
var ZP_TitleLableWidth: CGFloat = 100
/// 标题lable的背景色(默认是白色)
var ZP_TitleLableBGColor: UIColor?
/// 标题lable字体大小 (默认14)
var ZP_LableFont: CGFloat = 14
/// 放大倍数 (默认是0.3倍, 建议写0~0.5)
var ZP_LableZoomMultiple: CGFloat = 0.3
/// 标题lable没有被放大时候的文字颜色(默认是红色)
var ZP_LableSmallRGB: (R: CGFloat, G: CGFloat, B: CGFloat)?
/// 标题lable被放大时候的文字颜色(默认是黄色)
var ZP_LableBigRGB: (R: CGFloat, G: CGFloat, B: CGFloat)?
```
