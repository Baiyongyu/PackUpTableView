//
//  PackUpTableView.m
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/23.
//  Copyright © 2016年 北京116工作室. All rights reserved.
//

#import "PackUpTableView.h"

@interface PackUpTableView () <PackUpTableViewSectionHeaderDelegate>
@property (nonatomic, strong) NSMutableArray *statusArray;
@end

@implementation PackUpTableView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDelegateAndDataSource];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupDelegateAndDataSource];
    }
    return self;
}

#pragma mark - 创建数据源和代理
- (void)setupDelegateAndDataSource {
    self.delegate = self;
    self.dataSource = self;
    if (self.style == UITableViewStylePlain) {
        self.tableFooterView = [[UIView alloc] init];
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.separatorColor = [UIColor blackColor];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChangeStatusBarOrientationNotification:)  name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (NSMutableArray *)statusArray {
    if (!_statusArray) {
        _statusArray = [NSMutableArray array];
    }
    if (_statusArray.count) {
        if (_statusArray.count > self.numberOfSections) {
            [_statusArray removeObjectsInRange:NSMakeRange(self.numberOfSections - 1, _statusArray.count - self.numberOfSections)];
        }else if (_statusArray.count < self.numberOfSections) {
            for (NSInteger i = self.numberOfSections - _statusArray.count; i < self.numberOfSections; i++) {
                [_statusArray addObject:[NSNumber numberWithInteger:PackUpTableViewSectionStateFlod]];
            }
        }
    }else{
        for (NSInteger i = 0; i < self.numberOfSections; i++) {
            [_statusArray addObject:[NSNumber numberWithInteger:PackUpTableViewSectionStateFlod]];
        }
    }
    return _statusArray;
}

- (void)onChangeStatusBarOrientationNotification:(NSNotification *)notification {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

- (PackUpTableViewSectionHeaderArrowPosition )perferedArrowPosition {
    if (self.Mydelegate && [self.Mydelegate respondsToSelector:@selector(perferedArrowPositionForYUFoldingTableView:)]) {
        return [self.Mydelegate perferedArrowPositionForYUFoldingTableView:self];
    }
    return PackUpTableViewSectionHeaderArrowPositionRight;
}
- (UIColor *)backgroundColorForSection:(NSInteger )section {
    if (self.Mydelegate && [self.Mydelegate respondsToSelector:@selector(packUpTableView:backgroundColorForHeaderInSection:)]) {
        return [self.Mydelegate packUpTableView:self backgroundColorForHeaderInSection:section];
    }
    return [UIColor whiteColor];
}
- (NSString *)titleForSection:(NSInteger )section {
    if (self.Mydelegate && [self.Mydelegate respondsToSelector:@selector(packUpTableView:titleForHeaderInSection:)]) {
        return [self.Mydelegate packUpTableView:self titleForHeaderInSection:section];
    }
    return [NSString string];
}
- (UIFont *)titleFontForSection:(NSInteger )section {
    if (self.Mydelegate && [self.Mydelegate respondsToSelector:@selector(packUpTableView:fontForTitleInSection:)]) {
        return [self.Mydelegate packUpTableView:self fontForTitleInSection:section];
    }
    return [UIFont boldSystemFontOfSize:16];
}
- (UIColor *)titleColorForSection:(NSInteger )section {
    if (self.Mydelegate && [self.Mydelegate respondsToSelector:@selector(packUpTableView:textColorForTitleInSection:)]) {
        return [self.Mydelegate packUpTableView:self textColorForTitleInSection:section];
    }
    return [UIColor blackColor];
}
- (NSString *)descriptionForSection:(NSInteger )section {
    if (self.Mydelegate && [self.Mydelegate respondsToSelector:@selector(packUpTableView:descriptionForHeaderInSection:)]) {
        return [self.Mydelegate packUpTableView:self descriptionForHeaderInSection:section];
    }
    return [NSString string];
}
- (UIFont *)descriptionFontForSection:(NSInteger )section {
    if (self.Mydelegate && [self.Mydelegate respondsToSelector:@selector(packUpTableView:fontForDescriptionInSection:)]) {
        return [self.Mydelegate packUpTableView:self fontForDescriptionInSection:section];
    }
    return [UIFont boldSystemFontOfSize:13];
}

-(UIColor *)descriptionColorForSection:(NSInteger )section {
    if (self.Mydelegate && [self.Mydelegate respondsToSelector:@selector(packUpTableView:textColorForDescriptionInSection:)]) {
        return [self.Mydelegate packUpTableView:self textColorForDescriptionInSection:section];
    }
    return [UIColor blackColor];
}

- (UIImage *)arrowImageForSection:(NSInteger )section {
    if (self.Mydelegate && [self.Mydelegate respondsToSelector:@selector(packUpTableView:arrowImageForSection:)]) {
        return [self.Mydelegate packUpTableView:self arrowImageForSection:section];
    }
    return [UIImage imageNamed:@"Arrow.png"];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.Mydelegate && [self.Mydelegate respondsToSelector:@selector(numberOfSectionForPackUpTableView:)]) {
        return [self.Mydelegate numberOfSectionForPackUpTableView:self];
    }else{
        return self.numberOfSections;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (((NSNumber *)self.statusArray[section]).integerValue == PackUpTableViewSectionStateShow) {
        if (self.Mydelegate && [self.Mydelegate respondsToSelector:@selector(packUpTableView:numberOfRowsInSection:)]) {
            return [self.Mydelegate packUpTableView:self numberOfRowsInSection:section];
        }
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.Mydelegate && [self.Mydelegate respondsToSelector:@selector(packUpTableView:heightForHeaderInSection:)]) {
        return [self.Mydelegate packUpTableView:self heightForHeaderInSection:section];
    }else{
        return self.sectionHeaderHeight;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.Mydelegate && [self.Mydelegate respondsToSelector:@selector(packUpTableView:heightForRowAtIndexPath:)]) {
        return [self.Mydelegate packUpTableView:self heightForRowAtIndexPath:indexPath];
    }else{
        return self.rowHeight;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.style == UITableViewStylePlain) {
        return 0;
    }else{
        return 0.001;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PackUpTableViewSectionHeader *sectionHeaderView = [[PackUpTableViewSectionHeader alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [self tableView:self heightForHeaderInSection:section])  withTag:section];
    
    [sectionHeaderView setupWithBackgroundColor:[self backgroundColorForSection:section]
                                    titleString:[self titleForSection:section]
                                     titleColor:[self titleColorForSection:section]
                                      titleFont:[self titleFontForSection:section]
                              descriptionString:[self descriptionForSection:section]
                               descriptionColor:[self descriptionColorForSection:section]
                                descriptionFont:[self descriptionFontForSection:section]
                                     arrowImage:[self arrowImageForSection:section]
                                  arrowPosition:[self perferedArrowPosition]
                                   sectionState:((NSNumber *)self.statusArray[section]).integerValue];
    
    sectionHeaderView.tapDelegate = self;
    
    return sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.Mydelegate && [self.Mydelegate respondsToSelector:@selector(packUpTableView:cellForRowAtIndexPath:)]) {
        return [self.Mydelegate packUpTableView:self cellForRowAtIndexPath:indexPath];
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCellIndentifier"];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.Mydelegate && [self.Mydelegate respondsToSelector:@selector(packUpTableView:didSelectRowAtIndexPath:)]) {
        [self.Mydelegate packUpTableView:self didSelectRowAtIndexPath:indexPath];
    }
}


#pragma mark - YUFoldingSectionHeaderDelegate
- (void)PackUpTableSectionHeaderTappedAtIndex:(NSInteger)index {
    BOOL currentIsOpen = ((NSNumber *)self.statusArray[index]).boolValue;
    [self.statusArray replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:!currentIsOpen]];
    NSInteger numberOfRow = [self.Mydelegate packUpTableView:self numberOfRowsInSection:index];
    NSMutableArray *rowArray = [NSMutableArray array];
    if (numberOfRow) {
        for (NSInteger i = 0; i < numberOfRow; i++) {
            [rowArray addObject:[NSIndexPath indexPathForRow:i inSection:index]];
        }
    }
    if (rowArray.count) {
        if (currentIsOpen) {
            [self deleteRowsAtIndexPaths:[NSArray arrayWithArray:rowArray] withRowAnimation:UITableViewRowAnimationTop];
        }else{
            [self insertRowsAtIndexPaths:[NSArray arrayWithArray:rowArray] withRowAnimation:UITableViewRowAnimationTop];
        }
    }
}

@end
