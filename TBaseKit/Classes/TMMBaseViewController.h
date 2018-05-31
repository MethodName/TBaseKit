//
//  HSDBaseViewController.h
//  HaoShiDai
//
//  Created by Methodname on 14/12/22.
//  Copyright (c) 2014年 Methodname. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMPopTip.h"
#import "UIScrollView+EmptyDataSet.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "Masonry.h"
#import "TMMConfig.h"




@interface TMMBaseViewController : UIViewController<UIAlertViewDelegate>


typedef NS_ENUM(NSInteger, TMMNoDataType) {
    TMMNoDataTypeNoData = 0,
    TMMNoDataTypeWorkingError
};

@property(nonatomic,weak)UITableView *weekTableView;

/**
 是否正在加载（noData使用）
 */
@property (nonatomic, getter=isLoading) BOOL loading;
/**
 标题（noData使用）
 */
@property(nonatomic,strong)NSString* noDataTitle;
/**
 描述（noData使用）
 */
@property(nonatomic,strong)NSString* noDataDetail;
/**
 noData类型
 */
@property(nonatomic,assign)TMMNoDataType noDataType;



/**
 显示没有数据在tableView上面（没有数据）
 */
-(void)showNoDataAtTableViewFormNoDataWithTableView:(UITableView *)tableView;
/**
 显示没有数据在tableView上面(网络错误)
 */
-(void)showNoDataAtTableViewFormWorkingErrorWithTableView:(UITableView *)tableView;


/*
 显示警告消息
 */
-(void) showInfoMessage:(NSString*)msg;

/*
 显示成功消息
 */
-(void) showSuccessMessage:(NSString*)msg;

/*
 显示错误消息
 */
-(void) showErrorMessage:(NSString*)msg;


-(UIViewController *)viewControllerWithIdentifier:(NSString*) Identifier SbName:(NSString *)name;

/**
 视图跳转
 
 @param Identifier 视图标识
 @param name sb名字
 */
-(void)pushViewControllerWithIdentifier:(NSString*) Identifier SbName:(NSString *)name;


/**
 AMPopTip上面弹出
 
 @param atView 基于视图
 @param text 显示文本
 @param color 颜色
 */
-(void)upShowAMPopTipAtView:(UIView *)atView Text:(NSString *)text PopoverColor:(UIColor *)color;

/**
  AMPopTip下面弹出

 @param atView 基于的视图
 @param text 显示文本
 @param color 颜色
 */
-(void)downShowAMPopTipAtView:(UIView *)atView Text:(NSString *)text PopoverColor:(UIColor *)color;

/**
   AMPopTip左边弹出

 @param atView 基于的视图
 @param text 显示文本
 @param color 颜色
 */
-(void)leftShowAMPopTipAtView:(UIView *)atView Text:(NSString *)text PopoverColor:(UIColor *)color;
/**
 AMPopTip右边弹出
 
 @param atView 基于的视图
 @param text 显示文本
 @param color 颜色
 */
-(void)rightShowAMPopTipAtView:(UIView *)atView Text:(NSString *)text PopoverColor:(UIColor *)color;




@end
