//
//  DDSliderViewController.h
//  DDSlideViewControllerDemo
//
//  Created by lovelydd on 14/11/7.
//  Copyright (c) 2014年 lovelydd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDSliderViewController : UIViewController


//滑动速度系数-建议在0.5-1之间。默认为0.5
@property (assign,nonatomic) CGFloat slideSpeed;

@property(assign,nonatomic)BOOL canLeftSlider;
@property(assign,nonatomic)BOOL canRightSlider;


- (instancetype)initWithMainViewController:(UIViewController *)mainVC
                        leftViewController:(UIViewController *)leftVC
                       rightViewController:(UIViewController *)rightVC;
@end
