//
//  CommentTableView.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/11.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "CommentTableView.h"
#import "CommentTableViewCell.h"
@implementation CommentTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"cell"];

    }
    return self;
}
- (void)setCommentDicArray:(NSMutableArray *)commentDicArray {
    _commentDicArray = commentDicArray;
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = [self.commentDicArray[section] objectForKey:@"array"];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *array = [self.commentDicArray[indexPath.section] objectForKey:@"array"];
    cell.model = array[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 80;
    CommentModel *model = [self.commentDicArray[indexPath.section] objectForKey:@"array"][indexPath.row];
    
//    CGFloat macLabelWidth = KWidth-140;
//    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
//    CGFloat textHeight = [model.content boundingRectWithSize:CGSizeMake(macLabelWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
//    return textHeight +100;
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGSize size = [model.content boundingRectWithSize:CGSizeMake(KWidth-80, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
//#warning 高度要根据 content的高度来计算
    return size.height + 120;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    NSLog(@"%d",self.commentDicArray.count);
    return self.commentDicArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KWidth, 30)];
    [commentView addSubview:label];
    NSString *count = [self.commentDicArray[section] objectForKey:@"count"];
    if (section == 0) {
        if (count == 0) {
            return nil;
        }else {
            label.text = [NSString stringWithFormat:@"  %@条长评",count];
            return commentView;
        }
    }else {
        label.text = [NSString stringWithFormat:@"  %@条短评",count];
        return commentView;
    }
    
    
//    commentView.backgroundColor = [UIColor blueColor];
//    return commentView;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"1  %f",scrollView.contentInset.top);
//    NSLog(@"2  %f",scrollView.contentOffset.y);
//    if (scrollView == self) {
////        CGFloat sectionHeaderHeight = 30;
//        if (scrollView.contentOffset.y <= 40 && scrollView.contentOffset.y >= 0) {
////            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//            self.tableHeaderView.hidden = YES;
//        }else if (scrollView.contentOffset.y >= 40) {
////            scrollView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
//        }
////        if (scrollView.contentOffset.y == 0) {
////            scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
////        }
//    }
//}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f",scrollView.contentOffset.y);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

@end
