//
//  BaseTableView.h
//  Base
//
//  Created by 王凯 on 16/3/14.
//  Copyright © 2016年 kai wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseTableView;

@protocol BaseTableViewProtocol <NSObject>

// 上拉刷新
-(void)pullUpCompleted:(BaseTableView*)tableView;

//下拉加载
-(void)pullDownCompleted:(BaseTableView*)tableView;

//点击事件
-(void)baseTableView:(BaseTableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath;

@end
@interface BaseTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray*data;

@property(nonatomic,assign)id<BaseTableViewProtocol>refreshComletedDelegate;

@property(nonatomic,assign)BOOL isRefreshHeader;//是否需要下拉刷新
@property(nonatomic,assign)BOOL isMore; //是否需要更多

-(void)hiddenRefreshMoreBtn;
-(void)doneLoadingTableViewData; //收回下拉视图


@end
