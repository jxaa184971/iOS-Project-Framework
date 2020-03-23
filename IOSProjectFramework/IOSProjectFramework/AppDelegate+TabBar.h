//
//  AppDelegate+TabBar.h
//  IOSProjectFramework
//
//  Created by 黄一川 on 2020/3/18.
//  Copyright © 2020 hyc. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (TabBar) <UITabBarControllerDelegate>

/// 配置TabBarController
- (void)configureTabBarController;

@end

NS_ASSUME_NONNULL_END
