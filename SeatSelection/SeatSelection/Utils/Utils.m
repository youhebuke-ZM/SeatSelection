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


#pragma mark ---动态获取Label的宽度
+(CGFloat)getLabelWidthByLabel:(UILabel *)lab
{
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    lab.numberOfLines = 1;
    NSDictionary *attributes = @{NSFontAttributeName:lab.font};
    CGSize size = [lab.text boundingRectWithSize:CGSizeMake(MAXFLOAT,lab.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size.width;
}
#pragma mark ---动态获取Label的高度

+(CGFloat)getLabelHeightByLabel:(UILabel *)lab
{
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    lab.numberOfLines = 0;
    NSDictionary *attributes = @{NSFontAttributeName:lab.font};
    CGSize size = [lab.text boundingRectWithSize:CGSizeMake(lab.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size.height;
}


@end
