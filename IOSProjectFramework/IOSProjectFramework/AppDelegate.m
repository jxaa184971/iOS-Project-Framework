//
//  AppDelegate.m
//  IOSProjectFramework
//
//  Created by 黄一川 on 2020/1/13.
//  Copyright © 2020 hyc. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+TabBar.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self configureTabBarController];
    
    return YES;
}

@end
