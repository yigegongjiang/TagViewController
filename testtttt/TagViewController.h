//
//  TagViewController.h
//  testtttt
//
//  Created by yangfan on 15/10/20.
//  Copyright © 2015年 Adron. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreen_Height ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width ([UIScreen mainScreen].bounds.size.width)
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:(a)]

typedef NS_ENUM(NSUInteger, TagsAlignment) {
    TagsAlignmentLeft = 0, // 所有标签左对齐
    TagsAlignmentCenter    // 所有标签居中对齐
};

typedef void (^ClickRowBlock)(NSInteger clickRow);

@interface TagViewController : UIViewController

#pragma mark - 传过来的需要值
@property (nonatomic, assign) TagsAlignment tagsAlignment;              // 对其方式
@property (nonatomic, strong) NSMutableArray *tagsArray;                // 所有的标签
@property (nonatomic) CGSize maxSize;                                   // 标签页面最大的高宽大小
@property (nonatomic, strong) NSMutableArray *tagsBackgroundColorArray; // 每个标签的背景颜色数组，定义了这个参数，则tagsBackgroundColor参数失效
@property (nonatomic, strong) UIColor *viewBackgroundColor;             // 总体的背景色
@property (nonatomic, strong) UIColor *tagsWordsColor;                  // 字体的颜色（目前近支持单种颜色）
@property (nonatomic, strong) UIColor *tagsBorderColor;                 // 每个标签的边框颜色
@property (nonatomic, strong) UIColor *tagsBackgroundColor;             // 每个标签的背景颜色
@property (nonatomic) float tagsBorderWidth;                            // 标签的边框宽度
@property (nonatomic) float tagsBorderCornerRadius;                     // 标签的边框圆角幅度
@property (nonatomic) float tagsMargin;                                 // 标签之间的距离
@property (nonatomic) float tagsMarginLeftAndRightForSubView;           // 相对父View，最左最右的标签相对父View的Margin值
@property (nonatomic) float tagsMarginTopAndBottomForSubView;           // 相对父View，最上最下的标签相对父View的Margin值
@property (nonatomic) float fontSize;                                   // 字体大小咯
@property (nonatomic) float tagsHeight;                                 // 标签的高度

#pragma mark - 自身需要定义的属性
@property (nonatomic, strong) UIView *contentView;          // 所有的标签统一在一个父view上面
@property (nonatomic, strong) UIFont *tagsFont;             // 确定字体的大小
@property (nonatomic, strong) NSMutableArray *tagsBtnArray; //标签按钮数组
@property (nonatomic) CGSize trueSize;                      // 这个就是整个标签页面的实际size大小

@property (nonatomic, strong) ClickRowBlock clickRowBlock;

- (CGSize)returnContentSize; // 返回刚好包围内容区域的大小Size，当一个元素返行的时候，当前行空余的区域不再计算范围

/**
 *  获取字符串宽度和高度
 *
 *  @param str  需要计算长度的字符串
 *  @param font 字符串的大小
 *  @param size 预计字符串的宽度或者高度
 *
 *  @return 返回字符串计算后的宽度和高度
 */
- (CGSize)theWordSize:(NSString *)str andFont:(UIFont *)font andCGSize:(CGSize)size;
@end
