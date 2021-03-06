//
//  UILabel+YSAdd.h
//  tigerwallet
//
//  Created by andy on 2018/5/23.
//  Copyright © 2018年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YSAdd)

/**
 *  设置字符、行距、字体
 */
- (void)ys_setText:(NSString *)text lineSpacing:(CGFloat)lineSpacing;

/**
 *  设置删除线
 */
- (void)ys_setUnderlineStyleText:(NSString *)text;
/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end
