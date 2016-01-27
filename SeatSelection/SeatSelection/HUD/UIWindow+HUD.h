//
//  UIWindow+HUD.h
//  xiakuajie
//
//  Created by zm on 14-8-11.
//  Copyright (c) 2014年 ingplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (HUD)
-(void)showHUDProgress:(NSString *)text;
-(void)removeHUDProgress;
-(void)showHUDText:(NSString *)text;
-(void)showHUDTitle:(NSString *)title;
@end
