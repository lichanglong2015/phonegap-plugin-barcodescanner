//
//  Constant.h
//  TGou
//
//  Created by Franklin Zhang on 15/10/23.
//  Copyright © 2015年 macrame. All rights reserved.
//

#ifndef Constant_h
#define Constant_h
//#define HTTP_DOMAIN @"http://120.25.62.86:8088"
//#define IMAGE_DOMAIN @"http://114.119.6.145:8081/imgService"
//#define HTTP_RELATIVE_URL @"/tgo-ec"
#define HTTP_DOMAIN @"http://125.62.14.157"
#define IMAGE_DOMAIN @"http://125.62.14.157/imgService"
#define HTTP_RELATIVE_URL @""
#define kDateFormat @"yyyyMMdd"
typedef enum {
    DefaulFailed = -1,
    ConnectFailed,
    RequestFailed,
    ResponseFailed,
    ResultFailed
} HttpServiceError;


#define HTTP_SERVICE_RESULT @"code"
#define HTTP_SERVICE_DESCRIPTION @"msg"
#define HTTP_SERVICE_DATA @"callback"
#define HTTP_SERVICE_RESULT_SUCCESS @"1010"
#define kDateFormat @"yyyyMMdd"
#define kSimpleDateFormat @"yyyy-MM-dd"
#define kLongDateFormat @"yyyy-MM-dd HH:mm:ss"
#define SMS_COUNTDOWN_SECONDS 60


#define kScreenSize           [[UIScreen mainScreen] bounds].size                 //(e.g. 320,480)
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width           //(e.g. 320)
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height          //包含状态bar的高度(e.g. 480)
#define kIOSVerison [[[UIDevice currentDevice] systemVersion] floatValue]

#define KEYBOARD_HEIGHT 216

#define kOrangeColor           [UIColor colorWithRed:255.0/255 green:143.0/255 blue:138.0/255 alpha:1]


#define INTERNAL_NOTIFICATION_SIGNIN @"INTERNAL_NOTIFICATION_SIGNIN"
#define INTERNAL_NOTIFICATION_CANCEL_SIGNIN @"INTERNAL_NOTIFICATION_CANCEL_SIGNIN"
#define INTERNAL_NOTIFICATION_SIGNOUT @"INTERNAL_NOTIFICATION_SIGNOUT"
#define INTERNAL_NOTIFICATION_USER_PHOTO_CHANGED @"INTERNAL_NOTIFICATION_USER_PHOTO_CHANGED"
#define INTERNAL_NOTIFICATION_INFORMATION_CHANGED @"INTERNAL_NOTIFICATION_INFORMATION_CHANGED"
#define INTERNAL_NOTIFICATION_SHOPPING_READY @"INTERNAL_NOTIFICATION_SHOPPING_READY" //用户选择商品时选择好商品属性和数量
#define INTERNAL_NOTIFICATION_CART_CHANGE @"INTERNAL_NOTIFICATION_CART_CHANGE" //购物车数量变化
#endif /* Constant_h */
