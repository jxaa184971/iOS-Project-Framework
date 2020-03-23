//
//  TabBarPlusButton.m
//  IOSProjectFramework
//
//  Created by 王其林 on 2020/3/18.
//  Copyright © 2020 hyc. All rights reserved.
//

#import "TabBarPlusButton.h"

@implementation TabBarPlusButton

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];

    // 控件大小,间距大小
    CGFloat const imageViewEdgeWidth   = self.bounds.size.width * 0.7;
    CGFloat const imageViewEdgeHeight  = imageViewEdgeWidth;

    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMargin  = (self.bounds.size.height - labelLineHeight - imageViewEdgeHeight) * 0.5;

    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdgeHeight * 0.5;
    CGFloat const centerOfTitleLabel = imageViewEdgeHeight  + verticalMargin * 2 + labelLineHeight * 0.5 - 1;

    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);

    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
}

#pragma mark - IBActions

- (void)clickPublish {
    // 如果按钮的作用是触发点击事件，则调用此方法
}

#pragma mark - CYLPlusButtonSubclassing

+ (id)plusButton {
    TabBarPlusButton *button = [TabBarPlusButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalButtonImage = [UIImage imageNamed:@"add"];
    UIImage *hlightButtonImage = [UIImage imageNamed:@"add_selected"];
    [button setImage:normalButtonImage forState:UIControlStateNormal];
    [button setImage:hlightButtonImage forState:UIControlStateHighlighted];
    [button setImage:hlightButtonImage forState:UIControlStateSelected];
    
    // 设置背景图片
//    UIImage *normalButtonBackImage = [UIImage imageNamed:@"tabBar_post_back"];
//    [button setBackgroundImage:normalButtonBackImage forState:UIControlStateNormal];
//    [button setBackgroundImage:normalButtonBackImage forState:UIControlStateSelected];

    
    // 按钮图片距离上边距增加 5，即向下偏移，按钮图片距离下边距减少 5，即向下偏移。
    //button.imageEdgeInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightBold];
    [button sizeToFit]; // or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
    
    //自定义宽度
    button.frame = CGRectMake(0.0, 0.0, 60, 60);
    // button.backgroundColor = [UIColor redColor];
    
    // if you use `+plusChildViewController` , do not addTarget to plusButton.
    // [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

// 用来自定义加号按钮的位置，如果不实现默认居中。
+ (NSUInteger)indexOfPlusButtonInTabBar {
    return 2;
}

// 实现该方法后，能让 PlusButton 的点击效果与跟点击其他 TabBar 按钮效果一样，跳转到该方法指定的 UIViewController
+ (UIViewController *)plusChildViewController {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.navigationItem.title = @"视频";
    CYLBaseNavigationController *videoNav = [[CYLBaseNavigationController alloc] initWithRootViewController:vc];
    [videoNav cyl_setHideNavigationBarSeparator:YES];
    return videoNav;
}

// 该方法是为了调整 PlusButton 中心点Y轴方向的位置，建议在按钮超出了 tabbar 的边界时实现该方法。
// 返回值是自定义按钮中心点 Y 轴方向的坐标除以 tabbar 的高度，小于 0.5 表示 PlusButton 偏上，大于 0.5 则表示偏下。
// PlusButtonCenterY = multiplierOfTabBarHeight * tabBarHeight + constantOfPlusButtonCenterYOffset;
+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.3;
}

// constantOfPlusButtonCenterYOffset 大于 0 会向下偏移，小于 0 会向上偏移。
+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return (CYL_IS_IPHONE_X ? - 6 : 4);
}

@end
