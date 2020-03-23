//
//  ViewController.m
//  IOSProjectFramework
//
//  Created by 黄一川 on 2020/1/13.
//  Copyright © 2020 hyc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *token = @"token402591509343645696";
    
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@1003, @"id", nil];
    [PPNetworkHelper POST:kTestURL parameters:param success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}


@end
