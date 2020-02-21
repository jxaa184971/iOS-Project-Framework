//
//  CommonTool.m
//  IOSProjectFramework
//
//  Created by 黄一川 on 2020/2/21.
//  Copyright © 2020 hyc. All rights reserved.
//

#import "CommonTool.h"

/**
 检查字符串是否为空
 
 @param string 检查的字符串
 @return 字符串是否为空
 */
BOOL isBlankString(NSString *string) {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

/**
 检查字符串是否为整数
 
 @param string 检查的字符串
 @return 字符串是否为整数
 */
BOOL isIntString(NSString *string) {
    if (string == nil || [string length] <= 0)
    {
        return NO;
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if (![string isEqualToString:filtered])
    {
        return NO;
    }
    return YES;
}

/**
 展示toast弹窗
 
 @param text 弹窗的文字内容
 */
//void showToast(NSString *text) {
//    [AppHudTool showCommonTip:text At:[UIApplication sharedApplication].keyWindow];
//}

/**
 获取固定行高的AttributedString

 @param string 文本内容
 @param lineHeight 行高
 @param font 字体
 @param breakModel 换行模式
 @param textAliment 文本对齐模式
 @return 固定行高的AttributedString
 */
NSAttributedString* getAttributedStringWithLineHeight(NSString* string, CGFloat lineHeight, UIFont* font, NSLineBreakMode breakModel, NSTextAlignment textAliment){
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.maximumLineHeight = lineHeight;
    paragraphStyle.minimumLineHeight = lineHeight;
    paragraphStyle.lineBreakMode = breakModel;
    paragraphStyle.alignment = textAliment;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                font, NSFontAttributeName,
                                paragraphStyle,NSParagraphStyleAttributeName,
                                nil];
    NSString *oriString = @"";
    if (!isBlankString(string)) {
        oriString = string;
    }
    NSAttributedString *attributeStr = [[NSAttributedString alloc]initWithString:oriString attributes:attributes];
    return attributeStr;
}

NSAttributedString *getAttributedStringWithOptions(NSString *string, BOOL isBold, BOOL isItalic, BOOL isUnderline, UIFont *font, UIColor *textColor, NSTextAlignment textAlignment) {
    if (isBlankString(string)) {
        return nil;
    }
    
    @try {
        //对齐方式
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = textAlignment;
        
        //设置是否斜体
        UIFont *finalFont;
        if (isItalic) {
            CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(15 * (CGFloat)M_PI / 180), 1, 0, 0); //设置反射。倾斜角度。
            UIFontDescriptor *desc = [ UIFontDescriptor fontDescriptorWithName:font.fontName matrix :matrix];
            finalFont = [UIFont fontWithDescriptor:desc size:font.pointSize];
        }else {
            finalFont = font;
        }
        
        //生成对应字体
        NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    finalFont, NSFontAttributeName,
                                    textColor, NSStrokeColorAttributeName,
                                    textColor, NSForegroundColorAttributeName,
                                    style, NSParagraphStyleAttributeName, nil];
        
        //设置是否加粗
        if (isBold) {
            [attributes setObject:[NSNumber numberWithFloat:-5] forKey:NSStrokeWidthAttributeName];
        }
        
        //设置是否斜体
        if (isUnderline) {
            [attributes setObject:[NSNumber numberWithUnsignedInteger:NSUnderlineStyleSingle] forKey:NSUnderlineStyleAttributeName];
            [attributes setObject:textColor forKey:NSUnderlineColorAttributeName];
        }
        
        NSAttributedString *attriStr = [[NSAttributedString alloc] initWithString:string attributes:attributes];
        return attriStr;
    } @catch (NSException *exception) {
        return nil;
    }
}

/**
 根据AttributeString动态计算在label中显示的文本高度
 
 @param str 文本内容
 @param width label的宽度
 @param font 字体
 @return 计算出来的文本高度
 */
float heightForAttributeStringWithLabel(NSAttributedString *str, CGFloat width,UIFont *font) {
    UILabel *textView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, CGFLOAT_MAX)];
    textView.attributedText = str;
    textView.textAlignment = NSTextAlignmentJustified;
    textView.numberOfLines = 0;
    textView.lineBreakMode = NSLineBreakByWordWrapping;
    CGFloat height = [textView sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)].height;
    textView = nil;
    return height;
}

float heightForAttributeStringWithLabelAndNumberOfLines(NSAttributedString *str, CGFloat width, UIFont *font, int numberOfLines) {
    UILabel *textView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, CGFLOAT_MAX)];
    textView.textAlignment = NSTextAlignmentLeft;
    textView.numberOfLines = numberOfLines;
    textView.lineBreakMode = NSLineBreakByWordWrapping;
    textView.attributedText = str;
    CGFloat height = [textView sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)].height;
    textView = nil;
    return height;
}

float heightForString(NSString *str, UIFont* font, CGFloat width) {
    if (isBlankString(str)) {
        return 0;
    }
    
    if (font.pointSize > 11) {
        NSAttributedString* atrString = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:font}];
        NSRange range = NSMakeRange(0, atrString.length);
        NSDictionary* dic = [atrString attributesAtIndex:0 effectiveRange:&range];
        
        CGRect rect = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                        options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:dic
                                        context:nil];
        
        return rect.size.height;
    }else {
        NSAttributedString* atrString = [[NSAttributedString alloc] initWithString:str];
        NSRange range = NSMakeRange(0, atrString.length);
        NSDictionary* dic = [atrString attributesAtIndex:0 effectiveRange:&range];
        
        CGRect rect = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                        options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:dic
                                        context:nil];
        
        return rect.size.height;
    }
}

float widthForString(NSString *str, UIFont* font) {
    if (isBlankString(str)) {
        return 0;
    }
    
    if (font.pointSize > 11) {
        NSAttributedString* atrString = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:font}];
        NSRange range = NSMakeRange(0, atrString.length);
        NSDictionary* dic = [atrString attributesAtIndex:0 effectiveRange:&range];
        
        CGRect rect = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, font.pointSize)
                                        options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:dic
                                        context:nil];
        
        return rect.size.width;
    }else {
        NSAttributedString* atrString = [[NSAttributedString alloc] initWithString:str];
        NSRange range = NSMakeRange(0, atrString.length);
        NSDictionary* dic = [atrString attributesAtIndex:0 effectiveRange:&range];
        
        CGRect rect = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, font.pointSize)
                                        options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:dic
                                        context:nil];
        
        return rect.size.width;
    }
}

float widthForAttributeStringWithLabel(NSAttributedString *str, CGFloat height, UIFont *font) {
    UILabel *textView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGFLOAT_MAX, height)];
    textView.attributedText = str;
    textView.textAlignment = NSTextAlignmentJustified;
    textView.numberOfLines = 0;
    textView.lineBreakMode = NSLineBreakByWordWrapping;
    CGFloat width = [textView sizeThatFits:CGSizeMake(CGFLOAT_MAX, height)].width;
    textView = nil;
    return width;
}

UIImage *drawImageFromView(UIView *view) {
    /* 将UIView绘制成UIImage */
    // 初始化绘图环境 opaque参数用来表示生成的图片是否不透明
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    // 将对应的UIView的layer渲染在绘图环境中
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    // 将UIView中所有的view hierarchy绘制在环境中
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    // 获取绘制好的图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    // 结束绘图环境
    UIGraphicsEndImageContext();
    return img;
}

NSString *getCurrentTimestampStr() {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f", timeInterval];//转为字符型
    return timeString;
}
