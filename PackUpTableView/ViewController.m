//
//  ViewController.m
//  PackUpTableView
//
//  Created by 宇玄丶 on 2017/3/6.
//  Copyright © 2017年 北京116工作室. All rights reserved.
//

#import "ViewController.h"
#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height

@interface ViewController () <PackUpTableViewDelegate>
@property(nonatomic,strong)UILabel *promotion_money;
@property(nonatomic,strong)PackUpTableView *packUpTableView;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSArray *titleDetailArray;
@property(nonatomic,strong)NSArray *valueArray;
@property(nonatomic,strong)NSArray *valueDetailArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.packUpTableView = [[PackUpTableView alloc] init];
    self.packUpTableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    self.packUpTableView.Mydelegate = self;
    [self.view addSubview:self.packUpTableView];
    [self loadData];
    
}

- (void)loadData {
    
    self.titleArray = @[@"未确认",@"已确认",@"津贴",@"奖励"];
    self.titleDetailArray = @[@"0元",@"9.9元",@"0元",@"0元",];
    self.valueArray = @[@"已提取",@"已申请",@"可提取"];
    self.valueDetailArray = @[@"0元",@"9.9元",@"0元"];
}

#pragma mark - YUFoldingTableViewDelegate / required
- (PackUpTableViewSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(PackUpTableView *)yuTableView {
    return self.arrowPosition ? :PackUpTableViewSectionHeaderArrowPositionRight;
}
- (NSInteger )numberOfSectionForPackUpTableView:(PackUpTableView *)tableView {
    return 4;
}
- (NSInteger )packUpTableView:(PackUpTableView *)tableView numberOfRowsInSection:(NSInteger )section {
    return 3;
}
- (CGFloat )packUpTableView:(PackUpTableView *)tableView heightForHeaderInSection:(NSInteger )section {
    return 50;
}
- (CGFloat )packUpTableView:(PackUpTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (NSString *)packUpTableView:(PackUpTableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.titleArray[section];
}
- (UITableViewCell *)packUpTableView:(PackUpTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.valueArray[indexPath.row];
    cell.textLabel.textColor = [UIColor redColor];
    cell.detailTextLabel.text = self.valueDetailArray[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor redColor];
    return cell;
}
- (void )packUpTableView:(PackUpTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - YUFoldingTableViewDelegate / optional
- (NSString *)packUpTableView:(PackUpTableView *)tableView descriptionForHeaderInSection:(NSInteger )section {
    return self.titleDetailArray[section];
}

@end
