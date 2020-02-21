//
//  CommonTool.h
//  IOSProjectFramework
//
//  Created by 黄一川 on 2020/2/21.
//  Copyright © 2020 hyc. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 宏

//计算颜色
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGB_A(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB_COLOR_HEX(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

//弱引用
#define kWeakSelf __weak __typeof(self) weakSelf = self;

//屏幕宽高
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

//keyWindow
#define KEY_WINDOW [UIApplication sharedApplication].keyWindow

//屏幕适配
#define kAutoScale(num) ((SCREEN_WIDTH/375)*num)
#define AUTO_SCALE SCREEN_WIDTH/375.0

#pragma mark 全局方法
/**
 检查字符串是否为空

 @param string 检查的字符串
 @return 字符串是否为空
 */
extern BOOL isBlankString(NSString *string);


/**
 检查字符串是否为整数

 @param string 检查的字符串
 @return 字符串是否为整数
 */
extern BOOL isIntString(NSString *string);


/**
 展示toast弹窗

 @param text 弹窗的文字内容
 */
//extern void showToast(NSString *text);

/**
 获取固定行高的AttributedString
 
 @param string 文本内容
 @param lineHeight 行高
 @param font 字体
 @param breakModel 换行模式
 @param textAliment 文本对齐模式
 @return 固定行高的AttributedString
 */
extern NSAttributedString* getAttributedStringWithLineHeight(NSString* string, CGFloat lineHeight, UIFont* font, NSLineBreakMode breakModel, NSTextAlignment textAliment);


/**
 获取加粗的AttributedString

 @param string 文本内容
 @param isBold 是否加粗
 @param isUnderline 是否有下划线
 @param font 字体
 @param textColor 字体颜色
 @param textAlignment 字体对齐方式
 @return 加粗过的AttributedString
 */
extern NSAttributedString *getAttributedStringWithOptions(NSString *string, BOOL isBold, BOOL isItalic, BOOL isUnderline, UIFont *font, UIColor *textColor, NSTextAlignment textAlignment);

/**
 根据AttributeString动态计算在label中显示的文本高度

 @param str 文本内容
 @param width label的宽度
 @param font 字体
 @return 计算出来的文本高度
 */
extern float heightForAttributeStringWithLabel(NSAttributedString *str, CGFloat width,UIFont *font);


/**
 根据AttributeString动态计算在固定行高label中显示的文本高度

 @param str 文本内容
 @param width label的宽度
 @param font 字体
 @param numberOfLines 限定的行高
 @return 计算出来的文本高度
 */
extern float heightForAttributeStringWithLabelAndNumberOfLines(NSAttributedString *str, CGFloat width, UIFont *font, int numberOfLines);


/**
 获取一段文字在固定宽度的情况下的，所显示的高度

 @param str 文本内容
 @param font 字体
 @param width 固定显示的宽度
 @return 计算出来的文本高度
 */
extern float heightForString(NSString *str, UIFont* font, CGFloat width);

/**
 获取一段文字在固定宽度的情况下的，所显示的高度
 
 @param str 文本内容
 @param font 字体
 @return 计算出来的文本高度
 */
extern float widthForString(NSString *str, UIFont* font);

/**
 根据AttributeString动态计算在label中显示的文本高度
 
 @param str 文本内容
 @param height label的高度
 @param font 字体
 @return 计算出来的文本高度
 */
extern float widthForAttributeStringWithLabel(NSAttributedString *str, CGFloat height, UIFont *font);

/**
 将UIView截屏生成图片

 @param view 需要生成图片的view
 @return 截屏的图片
 */
extern UIImage *drawImageFromView(UIView *view);


/// 获取当前时间的时间戳字符串
extern NSString *getCurrentTimestampStr();
