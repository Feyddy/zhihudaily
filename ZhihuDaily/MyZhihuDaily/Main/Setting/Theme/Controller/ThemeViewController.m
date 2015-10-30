//
//  ThemeViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/5.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeTableView.h"
#import "DataService.h"
#import "ThemeModel.h"
@interface ThemeViewController ()
{
    ThemeTableView *_tableView;
    NSArray *_storiesArray;
    NSMutableArray *_storyModelArray;
}
@end

@implementation ThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"日常心理学";
    [self setRootNavItem];
    [self _createTableView];
    [self _loadData];
    self.view.backgroundColor = [UIColor whiteColor];
//    NSLog(@"%@",self.themeId);
}

- (void)_createTableView {
    _tableView = [[ThemeTableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
}

//- (void)setThemeId:(NSString *)themeId {
//    if (themeId != nil) {
//        _themeId = themeId;
//        [self _loadData];
//    }
//    }

- (void)setModel:(ThemeCellModel *)model {
    if (model) {
        _model = model;
        self.title = _model.name;
    }
    [self _loadData];
}


- (void)_loadData {
//    self.themeId = @"13";
//    NSLog(@"%@",self.themeId);
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",Theme,self.model.idStr];
        [DataService requestAFUrl:urlStr httpMethod:@"GET" params:nil data:nil block:^(id result) {
            _storyModelArray = [[NSMutableArray alloc] init];
            _storiesArray = result[@"stories"];
            for (NSDictionary *dic in _storiesArray) {
                ThemeModel *model = [[ThemeModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [_storyModelArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                _tableView.themeModelArray = _storyModelArray;
                [_tableView reloadData];
            });
        }];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
