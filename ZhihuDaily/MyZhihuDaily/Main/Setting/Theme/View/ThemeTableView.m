//
//  ThemeTableView.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/7.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "ThemeTableView.h"
#import "ThemeTableViewCell.h"
#import "DetailViewController.h"
#import "ThemeViewController.h"
#import "storyModel.h"
@implementation ThemeTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initViews];
    }
    return self;
}

- (void)_initViews {
    self.delegate = self;
    self.dataSource = self;
    [self registerClass:[ThemeTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)setThemeModelArray:(NSArray *)themeModelArray {
    _themeModelArray = themeModelArray;
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.themeModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    ThemeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (cell == nil) {
//        cell = [[ThemeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
    ThemeTableViewCell *cell = [[ThemeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.model = self.themeModelArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ThemeModel *model = self.themeModelArray[indexPath.row];
    NSLog(@"%@",model.idStr);
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.newsId = model.idStr;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (storyModel *model in self.themeModelArray) {
        NSString *newsId = model.idStr;
        [array addObject:newsId];
    }
    vc.newsIdArray = array;
    vc.index = indexPath.row;
    ThemeViewController *themeVc = (ThemeViewController *)self.nextResponder.nextResponder;
    [themeVc presentViewController:vc animated:YES completion:nil];
}

@end
