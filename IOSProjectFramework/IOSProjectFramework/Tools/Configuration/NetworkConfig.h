//
//  NetworkConfig.h
//  IOSProjectFramework
//
//  Created by 黄一川 on 2020/2/19.
//  Copyright © 2020 hyc. All rights reserved.
//

#ifndef NetworkConfig_h
#define NetworkConfig_h

#ifdef TestEnvironment
    static NSString * const kBaseURL = @"http://rap2api.taobao.org/app/mock/245148/"; //测试环境地址
#else
    static NSString * const kBaseURL = @"http://rap2api.taobao.org/app/mock/245148/"; //正式环境地址
#endif

static NSString *const kTestURL = @"demo/userOrders";

#endif /* NetworkConfig_h */
