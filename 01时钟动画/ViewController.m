//
//  ViewController.m
//  01时钟动画
//
//  Created by apple on 15-6-12.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) UIView *seconds;

@property (nonatomic, assign) long count;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    // 创建一个表盘的UIView
    UIView *clockView = [[UIView alloc] init];
    clockView.center = CGPointMake(self.view.bounds.size.width * 0.5, 250);
    clockView.layer.bounds = CGRectMake(0, 0, 214, 214);
    clockView.layer.contents = (__bridge id)([UIImage imageNamed:@"clock1"].CGImage);
    clockView.layer.cornerRadius = 107;
    clockView.layer.masksToBounds = YES;
    [self.view addSubview:clockView];
    
    
    // 创建一个秒针的UIView
    UIView *seconds = [[UIView alloc] init];
    seconds.backgroundColor = [UIColor redColor];
    seconds.layer.bounds = CGRectMake(0, 0, 2, 90);
    seconds.center = clockView.center;
    seconds.layer.anchorPoint = CGPointMake(0.5, 1);
    [self.view addSubview:seconds];
    self.seconds = seconds;
    
    
    // 开启一个计时器控件
    //NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(move) userInfo:nil repeats:YES];
    
    // 创建一个对象
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(move)];
    // 启动这个link
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    
}

- (void)move
{
    self.count++;
    if (self.count % 30 == 0) {
        // 执行代码
        NSLog(@"半秒。。");
    }
   // NSLog(@"...........");
    // 1. 计算出每一个秒针格子对应的弧度
    CGFloat angle = M_PI * 2 / 60.0;
    
    
    // 2. 获取当前事件
    NSDate *date = [NSDate date];
    // 2.1 创建一个日历牌对象(NSCalendar), 通过这个对象才能获取到NSDate中的日期时间的每一部分
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 2.2 告诉日历牌对象, 需要获取哪部分的值
    NSInteger secs = [calendar component:NSCalendarUnitSecond fromDate:date];
    
    // 2.3 计算本次旋转应该旋转到的弧度数
    angle = secs * angle;
    
    
    // 2. 让秒针旋转
    //self.seconds.transform = CGAffineTransformRotate(self.seconds.transform, angle);
    self.seconds.transform = CGAffineTransformMakeRotation(angle);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
