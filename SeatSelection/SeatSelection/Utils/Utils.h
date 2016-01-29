//
//  Utils.h
//  LabScan
//
//  Created by apple on 15/3/6.
//  Copyright (c) 2015年 Smallpixel, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

#pragma mark HUD
+(void)showHUDText:(NSString *)HUDText;
+(void)showHUDProgress:(NSString *)HUDText;
+(void)removeHUDProgress;

#pragma mark ---动态获取Label的宽度
+(CGFloat)getLabelWidthByLabel:(UILabel *)lab;

#pragma mark ---动态获取Label的高度
+(CGFloat)getLabelHeightByLabel:(UILabel *)lab;

@end
