//
//  BaseTableView.m
//  Base
//
//  Created by 王凯 on 16/3/14.
//  Copyright © 2016年 kai wang. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        [self initViews];
        
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initViews];

}

-(void)initViews
{
    self.dataSource = self;
    self.delegate = self;
    self.isMore = YES;
    self.isRefreshHeader = YES;
    
    __weak typeof(self) weakSelf = self;
    
    self.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        if ([weakSelf.refreshComletedDelegate respondsToSelector:@selector(pullDownCompleted:)] ) {
            [weakSelf.refreshComletedDelegate pullDownCompleted:weakSelf];
        }
    }];
    
    self.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        if ([weakSelf.refreshComletedDelegate respondsToSelector:@selector(pullUpCompleted:)]) {
            [weakSelf.refreshComletedDelegate pullUpCompleted:weakSelf];
        }
    }];
    
}

-(void)setIsMore:(BOOL)isMore
{
    _isMore = isMore;
    if (!_isMore) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.mj_footer resetNoMoreData];
    }
}

-(void)setIsRefreshHeader:(BOOL)isRefreshHeader
{
    _isRefreshHeader  = isRefreshHeader;
    self.mj_header.hidden = !isRefreshHeader;
}

-(void)hiddenRefreshMoreBtn
{
    self.mj_footer.hidden = YES;
}
-(void)doneLoadingTableViewData
{
    [self.mj_header endRefreshing];
}

#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshComletedDelegate respondsToSelector:@selector(baseTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshComletedDelegate baseTableView:self didSelectRowAtIndexPath:indexPath];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
