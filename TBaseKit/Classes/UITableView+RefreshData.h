//
//  UITableView+RefreshData.h
//  HaoShiDai
//
//
//  TableView刷新数据的中间件
//  1、自动列表数据请求繁琐的缺省逻辑；
//  2、自动数据列表header和footer显示逻辑；
//  3、自动数据列表请求警告和网络错误逻辑；
//  4、复用数据列表请求逻辑代码，专注于数据的获取和展示；
//
//
//  Created by 唐明明 on 2018/4/17.
//  Copyright © 2018年 360haoshidai. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MJRefresh.h"
//#import "HSDAFNRequest.h"
//#import "ZGAFNRequest.h"
//
//
//
////typedef struct
////{
////    int TableViewCompletionRow10;//足够10行
////    int TableViewCompletionRow0;//之后0行
////    int TableViewCompletionInsufficient;//不够10行
////}TableViewCompletion;
//
//typedef NSInteger (^P2PCompletionHandler)(ZGResponse * response);
//
//typedef NSInteger (^HSDCompletionHandler)(HSDResponse * response);
//
//
//
@interface UITableView (RefreshData)
//
//@property(nonatomic,weak)id target;
//
//@property(nonatomic,strong)MJRefreshNormalHeader *tmm_header;
//@property(nonatomic,strong)MJRefreshAutoNormalFooter *tmm_footer;
//
///**
// 注册多个cell
//
// @param identifiers 标识数组
// */
//-(void)registerNibIdentifiers:(NSArray *)identifiers;
//
///**
// 绑定头部和尾部
// 
// @param headerAction 头部
// @param footerAction 尾部
// @param target 处理对象
// */
//-(void)headerRFAction:(SEL)headerAction footerRFAction:(SEL)footerAction Target:(id)target;
//
///**
// 请求数据
// 
// @param url 链接
// @param data 数据
// @param handler 回调
// */
//-(void)reqzg:(NSString *)url Data:(NSDictionary *)data Completion:(P2PCompletionHandler)handler;
//
///**
// 请求数据
// 
// @param url 链接
// @param data 数据
// @param handler 回调
// */
//-(void)reqhsd:(NSString *)url Data:(NSDictionary *)data Completion:(HSDCompletionHandler)handler;

@end
