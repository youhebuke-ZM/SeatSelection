//
//  Utils.h
//  LabScan
//
//  Created by apple on 15/3/6.
//  Copyright (c) 2015年 Smallpixel, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

#pragma mark HUD
+(void)showHUDText:(NSString *)HUDText;
+(void)showHUDProgress:(NSString *)HUDText;
+(void)removeHUDProgress;

@end
