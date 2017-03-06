//
//  PackUpTableViewSectionHeader.h
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/23.
//  Copyright © 2016年 北京116工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PackUpTableViewSectionState) {
    PackUpTableViewSectionStateFlod, // 折叠
    PackUpTableViewSectionStateShow, // 打开
};

// 箭头的位置
typedef NS_ENUM(NSUInteger, PackUpTableViewSectionHeaderArrowPosition) {
    
    PackUpTableViewSectionHeaderArrowPositionLeft,
    PackUpTableViewSectionHeaderArrowPositionRight,
};

@protocol PackUpTableViewSectionHeaderDelegate <NSObject>

- (void)PackUpTableSectionHeaderTappedAtIndex:(NSInteger)index;

@end


@interface PackUpTableViewSectionHeader : UIView
@property(nonatomic,weak)id<PackUpTableViewSectionHeaderDelegate> tapDelegate;
- (instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag;

- (void)setupWithBackgroundColor:(UIColor *)backgroundColor
                    titleString:(NSString *)titleString
                     titleColor:(UIColor *)titleColor
                      titleFont:(UIFont *)titleFont
              descriptionString:(NSString *)descriptionString
               descriptionColor:(UIColor *)descriptionColor
                descriptionFont:(UIFont *)descriptionFont
                     arrowImage:(UIImage *)arrowImage
                  arrowPosition:(PackUpTableViewSectionHeaderArrowPosition)arrowPosition
                   sectionState:(PackUpTableViewSectionState)sectionState;

@end
