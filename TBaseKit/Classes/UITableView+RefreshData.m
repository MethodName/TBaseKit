//
//  UITableView+RefreshData.m
//  HaoShiDai
//
//  Created by 唐明明 on 2018/4/17.
//  Copyright © 2018年 360haoshidai. All rights reserved.
//

#import "UITableView+RefreshData.h"
//#import "HSDBaseViewController.h"


@implementation UITableView (RefreshData)

//
////一个固定的值代表这个属性的标记
//static NSString *weakControllerKey = @"_weakControllerKey";
//
////getter方法
//-(id)target
//{
//    return objc_getAssociatedObject(self, &weakControllerKey);
//}
////setter方法
//-(void)setTarget:(id)target
//{
//    objc_setAssociatedObject(self, &weakControllerKey, target, OBJC_ASSOCIATION_ASSIGN);
//}
//
//static NSString *tmm_headerKey = @"_tmm_headerKey";
//-(MJRefreshNormalHeader*)tmm_header
//{
//    return objc_getAssociatedObject(self, &tmm_headerKey);
//}
//
//static NSString *tmm_footerKey = @"_tmm_footerKey";
//-(MJRefreshAutoNormalFooter*)tmm_footer
//{
//    return objc_getAssociatedObject(self, &tmm_footerKey);
//}
//
//-(void)setTmm_header:(MJRefreshNormalHeader *)tmm_header
//{
//    objc_setAssociatedObject(self, &tmm_headerKey, tmm_header, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//-(void)setTmm_footer:(MJRefreshAutoNormalFooter *)tmm_footer
//{
//    objc_setAssociatedObject(self, &tmm_footerKey, tmm_footer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//
///**
// 绑定头部和尾部
//
// @param headerAction 头部
// @param footerAction 尾部
// */
//-(void)headerRFAction:(SEL)headerAction footerRFAction:(SEL)footerAction Target:(id)target
//{
//    self.target = target;
//    HSDBaseViewController *weakController = (HSDBaseViewController *)self.target;
//    weakController.weekTableView = self;
//    if (headerAction) {
//        MJRefreshNormalHeader *header= [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:headerAction];
//        // 隐藏时间
//        header.lastUpdatedTimeLabel.hidden = YES;
//        self.mj_header = header;
//        self.tmm_header = header;
//    }
//    if (footerAction) {
//        //上拉加载更多
//        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:footerAction];
//        //self.mj_footer = footer;
//        self.tmm_footer = footer;
//    }
//
//
//}
//
//
///**
// 注册多个cell
//
// @param identifiers 标识数组
// */
//-(void)registerNibIdentifiers:(NSArray *)identifiers
//{
//    for (NSString *item in identifiers) {
//        [self registerNib:[UINib nibWithNibName:item bundle:nil] forCellReuseIdentifier:item];
//    }
//}
//
///**
// 请求数据
//
// @param url 链接
// @param data 数据
// @param handler 回调
// */
//-(void)reqzg:(NSString *)url Data:(NSDictionary *)data Completion:(P2PCompletionHandler)handler
//{
//    __weak HSDBaseViewController * tempTarget = self.target;
//    if (tempTarget) {
//        [tempTarget.view setUserInteractionEnabled:NO];
//    }
//    //页大小
//    static NSInteger pageSize = 10;
//
//    __weak UITableView *temp = self;
//
//
//    //如果UItableView正在刷新请求数据
//
//    if ([self.mj_header isRefreshing]) {
//        self.mj_footer = nil;
//    }
//
//    if ([self.mj_footer isRefreshing]) {
//        self.mj_header = nil;
//    }
//
//
//
//    [[ZGAFNRequest new] request:data ActionName:url Completion:^(ZGResponse *response) {
//
//        if ([response.status isEqualToString:HSD_TEXT_NET_OK]) {
//            NSInteger count = handler(response);//获取数据条数
//            if (count == 0) {//数据为0条
//                if ([self numberOfRowsInSection:0] == 0) {//并且TableView没有显示数据
//                    [tempTarget showNoDataAtTableViewFormNoDataWithTableView:self];//显示没有数据缺省
//                    [temp.mj_header endRefreshing];//停止刷新
//                } else {//TableView有显示数据
//                    //如果footer有值
//                    if (temp.tmm_footer) {
//                        temp.mj_footer = temp.tmm_footer;
//                        [temp.mj_footer endRefreshingWithNoMoreData];//没有更多数据
//                    }
//                    //如果header有值
//                    if (temp.tmm_header) {
//                        temp.mj_header = temp.tmm_header;
//                    }
//                }
//            }else if (count<pageSize) {
//                //如果header有值
//                if (temp.tmm_header) {
//                    temp.mj_header = temp.tmm_header;
//                }
//                //如果是上拉刷新数据
//                if ([temp.mj_header isRefreshing]) {
//                    [temp.mj_header endRefreshing];
//                }
//                //如果footer有值
//                if (temp.tmm_footer) {
//                    temp.mj_footer = temp.tmm_footer;
//                }
//                [temp.mj_footer endRefreshingWithNoMoreData];//获取到数据条数小于页大小显示没有更多数据
//            }
//            else if(count >= pageSize) {//获取到的数据条数大于等于页大小
//                if ([temp.mj_header isRefreshing]) {
//                    [temp.mj_header endRefreshing];
//                }
//                if ([temp.mj_footer isRefreshing]) {
//                    [temp.mj_footer endRefreshing];
//                }
//                //如果footer有值
//                if (temp.tmm_footer) {
//                    temp.mj_footer = temp.tmm_footer;
//                    [temp.mj_footer resetNoMoreData];
//                }
//                //如果header有值
//                if (temp.tmm_header) {
//                    temp.mj_header = temp.tmm_header;
//                }
//            }
//
//        }
//        else
//        {
//            //后台返回状态为0处理
//            if (temp.target) {
//                [tempTarget showInfoMessage:response.message];
//                if ([self.mj_header isRefreshing])
//                {
//                    [temp.mj_header endRefreshing];
//
//                    if (temp.tmm_footer) {
//                        temp.mj_footer = temp.tmm_footer;
//                    }
//                }
//                if ([self.mj_footer isRefreshing])
//                {
//                    [temp.mj_footer endRefreshing];
//
//                    if (temp.tmm_header) {
//                        temp.mj_header = temp.tmm_header;
//                    }
//                }
//            }
//        }
//
//        if (tempTarget) {
//            [tempTarget.view setUserInteractionEnabled:YES];
//        }
//    } Error:^(NSError *error) {
//        if (tempTarget) {
//            //网络错误并且TableView显示数据条数为0
//            if ([self numberOfRowsInSection:0] == 0) {
//                [tempTarget showNoDataAtTableViewFormWorkingErrorWithTableView:self];
//            }
//            else
//            {
//                [tempTarget showInfoMessage:HSD_TEXT_NET_ERROR_INFO];
//            }
//            [temp.mj_header endRefreshing];
//            [temp.mj_footer endRefreshing];
//            [tempTarget.view setUserInteractionEnabled:YES];
//
//        }
//    }];
//}
//
//
///**
//请求数据
//
//@param url 链接
//@param data 数据
//@param handler 回调
//*/
//-(void)reqhsd:(NSString *)url Data:(NSDictionary *)data Completion:(HSDCompletionHandler)handler
//{
//    __weak HSDBaseViewController * tempTarget = self.target;
//    if (tempTarget) {
//        [tempTarget.view setUserInteractionEnabled:NO];
//    }
//    //页大小
//    static NSInteger pageSize = 10;
//    __weak UITableView *temp = self;
//    //如果UItableView正在刷新请求数据隐藏mj_header和mj_footer
//    if ([self.mj_header isRefreshing]) {
//        self.mj_footer = nil;
//    }
//    if ([self.mj_footer isRefreshing]) {
//        self.mj_header = nil;
//    }
//    [[HSDAFNRequest new] request:data ActionName:url Completion:^(HSDResponse *response) {
//        if ([response.status isEqualToString:HSD_TEXT_NET_OK]) {
//            NSInteger count = handler(response);//获取数据条数
//            if (count == 0) {//数据为0条
//                if ([self numberOfRowsInSection:0] == 0) {//并且TableView没有显示数据
//                    [tempTarget showNoDataAtTableViewFormNoDataWithTableView:self];//显示没有数据缺省
//                    [temp.mj_header endRefreshing];//停止刷新
//                } else {//TableView有显示数据
//                    //如果footer有值
//                    if (temp.tmm_footer) {
//                        temp.mj_footer = temp.tmm_footer;
//                        [temp.mj_footer endRefreshingWithNoMoreData];//没有更多数据
//                    }
//                    //如果header有值
//                    if (temp.tmm_header) {
//                        temp.mj_header = temp.tmm_header;
//                    }
//                }
//            }else if (count<pageSize) {
//                //如果header有值
//                if (temp.tmm_header) {
//                    temp.mj_header = temp.tmm_header;
//                }
//                //如果是上拉刷新数据
//                if ([temp.mj_header isRefreshing]) {
//                    [temp.mj_header endRefreshing];
//                }
//                //如果footer有值
//                if (temp.tmm_footer) {
//                    temp.mj_footer = temp.tmm_footer;
//                }
//                [temp.mj_footer endRefreshingWithNoMoreData];//获取到数据条数小于页大小显示没有更多数据
//            }
//            else if(count >= pageSize) {//获取到的数据条数大于等于页大小
//                if ([temp.mj_header isRefreshing]) {
//                    [temp.mj_header endRefreshing];
//                }
//                if ([temp.mj_footer isRefreshing]) {
//                    [temp.mj_footer endRefreshing];
//                }
//                //如果footer有值
//                if (temp.tmm_footer) {
//                    temp.mj_footer = temp.tmm_footer;
//                    [temp.mj_footer resetNoMoreData];
//                }
//                //如果header有值
//                if (temp.tmm_header) {
//                    temp.mj_header = temp.tmm_header;
//                }
//            }
//
//        }
//        else
//        {
//            //后台返回状态为0处理
//            if (temp.target) {
//                [tempTarget showInfoMessage:response.message];
//                if ([self.mj_header isRefreshing])
//                {
//                    [temp.mj_header endRefreshing];
//
//                    if (temp.tmm_footer) {
//                        temp.mj_footer = temp.tmm_footer;
//                    }
//                }
//                if ([self.mj_footer isRefreshing])
//                {
//                    [temp.mj_footer endRefreshing];
//
//                    if (temp.tmm_header) {
//                        temp.mj_header = temp.tmm_header;
//                    }
//                }
//            }
//        }
//
//        if (tempTarget) {
//            [tempTarget.view setUserInteractionEnabled:YES];
//        }
//    } Error:^(NSError *error) {
//        if (tempTarget) {
//            //网络错误并且TableView显示数据条数为0
//            if ([self numberOfRowsInSection:0] == 0) {
//                [tempTarget showNoDataAtTableViewFormWorkingErrorWithTableView:self];
//            }
//            else
//            {
//                [tempTarget showInfoMessage:HSD_TEXT_NET_ERROR_INFO];
//            }
//            [temp.mj_header endRefreshing];
//            [temp.mj_footer endRefreshing];
//            [tempTarget.view setUserInteractionEnabled:YES];
//
//        }
//    }];
//}








@end
