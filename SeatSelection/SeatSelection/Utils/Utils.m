//
//  Utils.m
//  LabScan
//
//  Created by apple on 15/3/6.
//  Copyright (c) 2015年 Smallpixel, Inc. All rights reserved.
//



#import "Utils.h"
#import "UIWindow+HUD.h"
#import "AppDelegate.h"

@implementation Utils


#pragma mark  HUD

+(void)showHUDText:(NSString *)HUDText
{
    AppDelegate *appdel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([HUDText isEqual:[NSNull null]]) {
        return;
    }
    [appdel.window showHUDText:HUDText];
}

+(void)showHUDProgress:(NSString *)HUDText
{
    AppDelegate *appdel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdel.window showHUDProgress:HUDText];
}

+(void)removeHUDProgress
{
    AppDelegate *appdel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdel.window removeHUDProgress];
}


@end
