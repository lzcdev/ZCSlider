//
//  ZCHomeSliderViewController.m
//  ZCSlider
//
//  Created by trustway_mac on 16/4/13.
//  Copyright © 2016年 trustway_mac. All rights reserved.
//

#import "ZCHomeSliderViewController.h"
#import "ZCNearViewController.h"
#import "ZCSquareViewController.h"
#import "ZCRecomendViewController.h"
#import "ZCKBViewController.h"
#import "ZCYSViewController.h"
@interface ZCHomeSliderViewController ()<UIScrollViewDelegate>

@property (nonatomic ,strong) ZCNearViewController *nearVC;
@property (nonatomic ,strong) ZCSquareViewController *squareVC;
@property (nonatomic ,strong) ZCRecomendViewController *recommendVC;
@property (nonatomic ,strong) ZCKBViewController *kbVC;
@property (nonatomic ,strong) ZCYSViewController *ysVC;
@property (nonatomic ,strong) UIScrollView *mainScrollView;
@property (nonatomic ,strong) UIButton *slideBtn;
@property (nonatomic ,strong) UILabel *slideLab;
@property (nonatomic,strong) UIScrollView *headerScrollView;
@end

@implementation ZCHomeSliderViewController

/**
 *  懒加载
 *
 *  @return 控制器
 */
- (ZCNearViewController *)nearVC
{
    if (!_nearVC) {
        _nearVC = [[ZCNearViewController alloc]init];
        _nearVC.view.backgroundColor = [UIColor cyanColor];
    }
    return _nearVC;
}
- (ZCSquareViewController *)squareVC
{
    if (!_squareVC) {
        _squareVC = [[ZCSquareViewController alloc]init];
        _squareVC.view.backgroundColor = [UIColor greenColor];

    }
    return _squareVC;
}

- (ZCRecomendViewController *)recommendVC
{
    if (!_recommendVC) {
        _recommendVC = [[ZCRecomendViewController alloc]init];
        _recommendVC.view.backgroundColor = [UIColor purpleColor];

    }
    return _recommendVC;
}
- (ZCKBViewController *)kbVC
{
    if (!_kbVC) {
        _kbVC = [[ZCKBViewController alloc]init];
        _kbVC.view.backgroundColor = [UIColor orangeColor];
    }
    return _kbVC;
}
- (ZCYSViewController *)ysVC
{
    if (!_ysVC) {
        _ysVC = [[ZCYSViewController alloc]init];
        _ysVC.view.backgroundColor = [UIColor blueColor];
    }
    return _ysVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
    [self initMainScrollView];
    
}
/**
 *  初始化导航上的滚动条
 */
- (void)initUI
{
    self.tabBarItem.title = @"首页";
    
    //导航上左边按钮
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClick:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    //导航上滚动条
    _headerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(50, 0,kScreenSizeWidth-50 , 40)];
    _headerScrollView.backgroundColor = [UIColor clearColor];
    _headerScrollView.delegate = self;
    _headerScrollView.showsHorizontalScrollIndicator = NO;
    [self.navigationController.navigationBar addSubview:_headerScrollView];
    
    //滑块
    _slideLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 38, kScreenSizeWidth/4, 2)];
    _slideLab.backgroundColor = [UIColor whiteColor];
    [_headerScrollView addSubview:_slideLab];
    
    //导航上滚动条上按钮
    NSArray *name = @[@"附近",@"广场",@"推荐",@"科比",@"勇士"];
    for (int i = 0; i < name.count; i++) {
        _slideBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _slideBtn.frame = CGRectMake(0+kScreenSizeWidth/4*i, 0, kScreenSizeWidth/4, _headerScrollView.frame.size.height);
        _slideBtn.backgroundColor = [UIColor clearColor];
        [_slideBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _slideBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_slideBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _slideBtn.tag = i + 1;
        [_slideBtn setTitle:name[i] forState:UIControlStateNormal];
        [_headerScrollView addSubview:_slideBtn];
    }
    _headerScrollView.contentSize = CGSizeMake(kScreenSizeWidth/4 * name.count, 0);
}
//并没有用到
- (void)leftBtnClick:(UIBarButtonItem *)bar
{
    NSLog(@"设置");
}
- (void)BtnClick:(UIButton *)sender
{
    [self slideAnimationWithTag:sender.tag];
    //点击button，ScrollView的偏移量
    [UIView animateWithDuration:0.3 animations:^{
        _mainScrollView.contentOffset = CGPointMake(kScreenSizeWidth * (sender.tag - 1), 0);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)slideAnimationWithTag:(NSInteger)tag
{

    UIButton *sender = [self.headerScrollView viewWithTag:tag];
    [UIView animateWithDuration:0.3 animations:^{
        
        _slideLab.frame = CGRectMake(sender.frame.origin.x, _slideLab.frame.origin.y, _slideLab.frame.size.width, _slideLab.frame.size.height);
    
        if (tag >= 4) {
            _headerScrollView.contentOffset = CGPointMake(kScreenSizeWidth/4*(tag-3), 0);
        }if (tag == 1) {
             _headerScrollView.contentOffset = CGPointMake(0, 0);
        }
    } completion:^(BOOL finished) {

    }];
}
/**
 *  大的ScrollView
 */
- (void)initMainScrollView
{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kScreenSizeHeight)];
    _mainScrollView.delegate = self;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.bounces = NO;
    _mainScrollView.tag = 1;
    _mainScrollView.pagingEnabled = YES;
 
    [self.view addSubview:_mainScrollView];
    
    NSArray *views = @[self.nearVC.view,self.squareVC.view,self.recommendVC.view,self.kbVC.view,self.ysVC.view];
    for (int i = 0; i < views.count; i++) {
        UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(kScreenSizeWidth*i, 0, kScreenSizeWidth, kScreenSizeHeight-64)];
        [mainView addSubview:views[i]];
        [_mainScrollView addSubview:mainView];
    }
    _mainScrollView.contentSize = CGSizeMake(kScreenSizeWidth * (views.count), 0);
}
/**
 *  scrollView代理方法
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 1) {
        double index = scrollView.contentOffset.x / kScreenSizeWidth;
        [self slideAnimationWithTag:(int)index+1];
        
    }
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
