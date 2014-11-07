//
//  DDSliderViewController.m
//  DDSlideViewControllerDemo
//
//  Created by lovelydd on 14/11/7.
//  Copyright (c) 2014年 lovelydd. All rights reserved.
//

#import "DDSliderViewController.h"
static NSTimeInterval const kAnimationTimeInterval = 0.2f;
static CGFloat const kCriticalityValue = 90.0f;  //设定滑动的最大临界值

@interface DDSliderViewController ()
{
    UIViewController *mainViewController;
    UIViewController *leftViewController;
    UIViewController *rightViewController;
    
    CGFloat scalef;
}

@end

@implementation DDSliderViewController
@synthesize slideSpeed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithMainViewController:(UIViewController *)mainVC
                        leftViewController:(UIViewController *)leftVC
                       rightViewController:(UIViewController *)rightVC
{
    
    self = [super init];
    if (self) {
        
        mainViewController  = mainVC;
        leftViewController  = leftVC;
        rightViewController = rightVC;
        
        //添加点击的手势
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [mainVC.view addGestureRecognizer:tapGes];
        
        //添加滑动的手势
        UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [mainVC.view addGestureRecognizer:panGes];
        
        leftVC.view.hidden = YES;
        rightVC.view.hidden = YES;
        
        [self.view addSubview:  leftVC.view];
        [self.view addSubview: rightVC.view];
        [self.view addSubview:  mainVC.view];
    }
    
    return self;
}


#pragma mark - 手势handle
- (void)handleTap:(UITapGestureRecognizer *)tapGes
{
    
    if (tapGes.state == UIGestureRecognizerStateEnded) {
     
        [self showMainViewAnimation];
        [self resetScalef];
    }
    
}


- (void)handlePan:(UIPanGestureRecognizer *)panGes
{
    //获取滑动的坐标
    CGPoint point = [panGes translationInView:self.view];
    
    scalef = ( point.x * slideSpeed + scalef );
    
    NSLog(@"scalef :%f,%f",scalef,kCriticalityValue * slideSpeed);
    
    //向右滑动
    if (panGes.view.frame.origin.x >= 0 ) {
       
        panGes.view.center = CGPointMake(panGes.view.center.x + point.x * slideSpeed, panGes.view.center.y);
        panGes.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1 - scalef / 1000, 1 - scalef / 1000);
        //重新设置在父视图上的坐标系，以免手势划出范围后不受控制
        [panGes setTranslation:CGPointMake(0, 0) inView:self.view];
        
        leftViewController.view.hidden = NO;
        rightViewController.view.hidden = YES;
    }
    else {
    
        panGes.view.center = CGPointMake(panGes.view.center.x + point.x * slideSpeed, panGes.view.center.y);
        panGes.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1 + scalef /1000, 1 + scalef / 1000);
        [panGes setTranslation:CGPointMake(0, 0) inView:self.view];
        
        leftViewController.view.hidden = YES;
        rightViewController.view.hidden = NO;
        
    }
    
    
    //修正坐标的位置
    if (panGes.state == UIGestureRecognizerStateEnded) {
        
        if ([self showLeftView]) {
            
            [self showLeftViewAnimation];
            
        }
        else if([self showRightView])
        {
            
            [self showRightViewAnimation];
        }
        else
        {
            [self showMainViewAnimation];
            
             [self resetScalef];
        }
        
    }
    
    
}

- (void)resetScalef
{
    scalef = 0;
}

- (BOOL)showLeftView
{
    
    return scalef > kCriticalityValue * slideSpeed ? YES : NO;
}

- (BOOL)showRightView
{
    return fabsf(scalef) > kCriticalityValue * slideSpeed ? YES : NO;
}

- (void)showLeftViewAnimation
{
    
    [UIView animateWithDuration:kAnimationTimeInterval animations:^{
        
        mainViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
        mainViewController.view.center = CGPointMake(340,[UIScreen mainScreen].bounds.size.height / 2 );
    }];
}


- (void)showRightViewAnimation
{
    
        [UIView animateWithDuration:kAnimationTimeInterval animations:^{
            
            mainViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
            mainViewController.view.center = CGPointMake(-60,[UIScreen mainScreen].bounds.size.height / 2 );
        
        }];
    
}

- (void)showMainViewAnimation
{
   
    [UIView animateWithDuration:kAnimationTimeInterval animations:^{
        
        mainViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        mainViewController.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2,[UIScreen mainScreen].bounds.size.height / 2 );
    }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
