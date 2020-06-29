//
//  UIColor+NewFuc.h
//  MilesShellFrame
//
//  Created by Miles Wang on 2020/6/29.
//  Copyright © 2020 Chen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (NewFuc)

/**
 * 根据RGB转UIColor
 */
+ (UIColor *)colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;

/**
 *  根据16进制转UIColor
 *
 *  @param color @"#FFFFFF" ,@"OXFFFFFF" ,@"FFFFFF"
 *
 *  @return uicolor
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

@end

NS_ASSUME_NONNULL_END
