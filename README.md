## 前言

类似QQ的左右侧滑效果。

##效果
![](https://raw.githubusercontent.com/lcddhr/DDSliderViewController/master/Gif/DDSliderView.gif)

##如何使用


```
	
    LeftViewController  *leftVC     = [[LeftViewController alloc] init];
    RightViewController *rightVC    = [[RightViewController alloc] init];
    MainViewController  *mainVC     = [[MainViewController alloc] init];
    
    DDSliderViewController *sliderVC = [[DDSliderViewController alloc] initWithMainViewController:mainVC leftViewController:leftVC rightViewController:rightVC];
    [sliderVC setSlideSpeed:0.5];

```

## 感谢

开源控件 	[WWSideslipViewController](https://github.com/oopww1992/WWSideslipViewController)作者:[@oopww1992](https://github.com/oopww1992)

博客: [http://www.liuchendi.com](http://www.liuchendi.com)


