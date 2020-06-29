//
//  TabBarViewController.m
//  MilesShellFrame
//
//  Created by Miles Wang on 2020/6/29.
//  Copyright © 2020 Chen Wang. All rights reserved.
//

#import "TabBarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

#define BTNTAG 10000
#define BTN_HEIGHT 50

@interface TabBarViewController (){
    UIButton *_button;
    UIButton *_butTitle;
    UIView *_lineView;
}

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initControllers];
    [self creatTabbar];
    //去除顶部的分割线 -- 根据需求 自定注释
    //    [[UITabBar appearance] setShadowImage:[UIImage new]];
    //    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
}

#pragma mark - 如果想添加控制器到tabbar里面在这里面实例化就行
- (void)initControllers
{
#pragma mark ————————————————第一个页
    FirstViewController *homeVC  = [[FirstViewController alloc]init];
    UINavigationController *navVC1 = [[UINavigationController alloc]initWithRootViewController:homeVC];
    [navVC1 setNavigationBarHidden:YES];
    
#pragma mark ————————————————第二个页
    SecondViewController *repaVC = [[SecondViewController alloc]init];
    UINavigationController *navVC2 = [[UINavigationController alloc]initWithRootViewController:repaVC];
    [navVC2 setNavigationBarHidden:YES];
    
#pragma mark ————————————————第三个页
    ThirdViewController *searVC = [[ThirdViewController alloc]init];
    UINavigationController *navVC3 = [[UINavigationController alloc] initWithRootViewController:searVC];
    [navVC3 setNavigationBarHidden:YES];
    
    
    NSArray *ctrlArr = [NSArray arrayWithObjects:navVC1,navVC2,navVC3,nil];
    self.viewControllers=ctrlArr;
    //照着上面添加控制球就行了
}

- (void)creatTabbar{
#pragma mark 修改名称
    NSArray *titleArrs = @[@"页面一",@"页面二",@"页面三"];
#pragma mark 修改图片名字
    NSArray * normImage = @[@"ningmneg",@"huluobo",@"congsuan"];
#pragma mark 修改选中图片的名字
    NSArray * selectImage = @[@"caidao",@"guochan",@"daoju"];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, self.tabBar.frame.size.height)];
    bgView.backgroundColor = COLOR_BG;
    bgView.userInteractionEnabled = YES;
    
    float btn_X = 0;
    float btn_width = SCREEN_W/self.viewControllers.count;
    if ([self getIsIpad]) {
        btn_X = 100;
        btn_width = (SCREEN_W-btn_X*2)/self.viewControllers.count;
    }
    
    for(int i = 0;i<self.viewControllers.count;i++){
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btn_X+btn_width*i, 0, btn_width, 34);
        [btn setImage:[UIImage imageNamed:normImage[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:selectImage[i]] forState:UIControlStateSelected];
        [bgView addSubview:btn];
        
        
        UIButton *titleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        titleBtn.frame = CGRectMake(btn_X+btn_width*i, 26, btn_width, 20);
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [titleBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        [titleBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
        [titleBtn setTitle:titleArrs[i] forState:(UIControlStateNormal)];
        [bgView addSubview:titleBtn];
        
        UIButton *chooseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        chooseBtn.frame = CGRectMake(btn_X+btn_width*i, 0, btn_width, 54);
        [chooseBtn addTarget:self action:@selector(btnSelect:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:chooseBtn];
        
        if (i == 0) {
            _button = btn;
            _butTitle = titleBtn;
            titleBtn.selected = btn.selected = YES;
        }
        chooseBtn.tag = BTNTAG+i;
        btn.tag = BTNTAG+i+10;
        titleBtn.tag = BTNTAG+i+20;
        
    }
    
    //设置横线的宽度
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 54-26, SCREEN_W/self.viewControllers.count/1.5,26)];
    _lineView.backgroundColor = [UIColor clearColor];
    _lineView.layer.cornerRadius = 13.0f;
    _lineView.layer.borderWidth = 0.2;
    _lineView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [_lineView.layer setMasksToBounds:YES];
    _lineView.center = CGPointMake(_button.center.x, _button.center.y);
    [bgView addSubview:_lineView];
    
    [self.tabBar addSubview:bgView];
    
}

#pragma mark --- 震动动画
- (void)btnSelect:(UIButton *)sender{
    
    NSLog(@"------ %ld",sender.tag);
    
    _butTitle.selected = _button.selected = NO;
    
    UIButton *tmpImgBtn = [self.view viewWithTag:sender.tag+10];
    UIButton *tmpTitleBtn = [self.view viewWithTag:sender.tag+20];
    
    tmpTitleBtn.selected = tmpImgBtn.selected = YES;
    _butTitle = tmpTitleBtn;
    _button = tmpImgBtn;
    self.selectedIndex = sender.tag-BTNTAG;
    
    [UIView animateWithDuration:.233 animations:^{
        self->_lineView.center = CGPointMake(_button.center.x, _button.center.y);
    }];
    
}

//如果想要判断设备是ipad，要用如下方法
- (BOOL)getIsIpad{
    
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPhone"]) {
        //iPhone
        return NO;
    }
    else if([deviceType isEqualToString:@"iPod touch"]) {
        //iPod Touch
        return NO;
    }
    else if([deviceType isEqualToString:@"iPad"]) {
        //iPad
        return YES;
    }
    return NO;
    
    //这两个防范判断不准，不要用
    //#define is_iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    //
    //#define is_iPad (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)
}

@end
