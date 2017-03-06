//
//  PackUpTableView.h
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/23.
//  Copyright © 2016年 北京116工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PackUpTableViewSectionHeader.h"

@class PackUpTableView;

@protocol PackUpTableViewDelegate <NSObject>

@required
- (PackUpTableViewSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(PackUpTableView *)yuTableView;

- (NSInteger )numberOfSectionForPackUpTableView:(PackUpTableView *)tableView;

- (NSInteger )packUpTableView:(PackUpTableView *)tableView numberOfRowsInSection:(NSInteger )section;

- (CGFloat )packUpTableView:(PackUpTableView *)tableView heightForHeaderInSection:(NSInteger )section;

- (CGFloat )packUpTableView:(PackUpTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)packUpTableView:(PackUpTableView *)tableView titleForHeaderInSection:(NSInteger )section;

- (UITableViewCell *)packUpTableView:(PackUpTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void )packUpTableView:(PackUpTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@optional


- (UIImage *)packUpTableView:(PackUpTableView *)tableView arrowImageForSection:(NSInteger )section;

- (NSString *)packUpTableView:(PackUpTableView *)tableView descriptionForHeaderInSection:(NSInteger )section;

- (UIColor *)packUpTableView:(PackUpTableView *)tableView backgroundColorForHeaderInSection:(NSInteger )section;

- (UIFont *)packUpTableView:(PackUpTableView *)tableView fontForTitleInSection:(NSInteger )section;

- (UIFont *)packUpTableView:(PackUpTableView *)tableView fontForDescriptionInSection:(NSInteger )section;

- (UIColor *)packUpTableView:(PackUpTableView *)tableView textColorForTitleInSection:(NSInteger )section;

- (UIColor *)packUpTableView:(PackUpTableView *)tableView textColorForDescriptionInSection:(NSInteger )section;

@end

@interface PackUpTableView : UITableView <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) id<PackUpTableViewDelegate> Mydelegate;
@end
