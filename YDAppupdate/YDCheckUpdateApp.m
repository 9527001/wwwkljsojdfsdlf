//
//  YDCheckUpdateApp.m
//  checkupdateApp
//
//  Created by 中企互联 on 16/9/5.
//  Copyright © 2016年 中企互联. All rights reserved.
//

#define kStoreAppId                     @"xxxxxxxxx"  // （appid数字串）
#import "YDCheckUpdateApp.h"

#import <UIKit/UIKit.h>

@interface YDCheckUpdateApp ()<UIAlertViewDelegate>

@end
@implementation YDCheckUpdateApp
+ (void)checkAppUpdate:(NSString *)appID
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appID]];
    NSString * file =  [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    NSRange substr = [file rangeOfString:@"\"version\":\""];
    NSRange range1 = NSMakeRange(substr.location+substr.length,10);
    NSRange substr2 =[file rangeOfString:@"\"" options:nil range:range1];
    NSRange range2 = NSMakeRange(substr.location+substr.length, substr2.location-substr.location-substr.length);
    NSString *newVersion =[file substringWithRange:range2];
    if(![nowVersion isEqualToString:newVersion])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"版本有更新"delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"更新",nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        // 此处加入应用在app store的地址，方便用户去更新，一种实现方式如下：
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", kStoreAppId]];
        [[UIApplication sharedApplication] openURL:url];
    }
}
@end
