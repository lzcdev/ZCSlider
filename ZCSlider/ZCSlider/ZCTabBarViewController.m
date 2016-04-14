//
//  ZCTabBarViewController.m
//  ZCSlider
//
//  Created by trustway_mac on 16/4/13.
//  Copyright © 2016年 trustway_mac. All rights reserved.
//

#import "ZCTabBarViewController.h"
#import "ZCHomeSliderViewController.h"
#import "ZCMessageViewController.h"
#import "ZCMeViewController.h"
#import "UIColor+FlatUI.h"
@interface ZCTabBarViewController ()

@end

@implementation ZCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initChildController];
}

/**
 *  初始化子控制器
 */
- (void)initChildController
{
    ZCHomeSliderViewController *home = [[ZCHomeSliderViewController alloc]init];
    [self setupChildController:home titile:@"" imageName:@"tabmsg_tab1_n@2x" selectedImageName:@"tabmsg_tab1_hl@2x"];
    
    ZCMessageViewController *message = [[ZCMessageViewController alloc]init];
    [self setupChildController:message titile:@"message" imageName:@"tabmsg_tab2_n@2x" selectedImageName:@"tabmsg_tab2_hl@2x"];
    
    ZCMeViewController *me = [[ZCMeViewController alloc]init];
    [self setupChildController:me titile:@"me" imageName:@"tabmsg_tab3_n@2x" selectedImageName:@"tabmsg_tab3_hl@2x"];
}
/**
 *  子控制器
 *
 *  @param childVc           子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中图标
 */
- (void)setupChildController:(UIViewController *)childVc titile:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    childVc.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childVc];
    nav.navigationBar.barTintColor =[UIColor colorFromHexCode:@"46a6ff"];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
