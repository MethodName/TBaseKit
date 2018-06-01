//
//  HSDBaseViewController.m
//  HaoShiDai
//
//  Created by Methodname on 14/12/22.
//  Copyright (c) 2014年 Methodname. All rights reserved.
//

#import "TMMBaseViewController.h"



@interface TMMBaseViewController ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic,strong)AMPopTip * tipView;

@property(nonatomic,weak)UITableView *weekTableView;

@property(nonatomic,weak)UIScrollView *weekScrollView ;

@end

@implementation TMMBaseViewController

//移动比例
#define VIEW_MOVE_BFB 0.6f

//侧栏移动自动收缩距离
#define BGVIEW_MOVE_LEFT 150.0f

#pragma mark -视图加载后
- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置navigationBar顶住视图的最上面部分
    self.automaticallyAdjustsScrollViewInsets = NO;

    //初始化tipView
    self.tipView = [AMPopTip popTip];
    self.tipView.font = [UIFont fontWithName:@"Avenir-Medium" size:12];
    self.tipView.shouldDismissOnTap = YES;//单击消失
    self.tipView.edgeMargin = 5;//外边距
    self.tipView.offset = 15;//中心点偏移位置
    self.tipView.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);//内边距

    //设置自定义的返回按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc]  initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
}


/**
 显示没有数据在tableView上面（没有数据）
 */
-(void)showNoDataAtTableViewFormNoDataWithTableView:(UITableView *)tableView
{
    if (tableView)
    {
        self.weekTableView = tableView;
        self.noDataTitle = @"没有数据";
        self.noDataDetail = @"对不起，目前没有数据（点击重试）";
        self.noDataType = TMMNoDataTypeNoData;
        tableView.emptyDataSetSource = self;
        tableView.emptyDataSetDelegate = self;
        [tableView reloadEmptyDataSet];
    }
}
/**
 显示没有数据在tableView上面(网络错误)
 */
-(void)showNoDataAtTableViewFormWorkingErrorWithTableView:(UITableView *)tableView
{
    if (tableView)
    {
        self.weekTableView = tableView;
        [tableView.mj_header endRefreshing];
        [tableView.mj_footer endRefreshing];
        self.noDataTitle = @"网络异常";
        self.noDataDetail = @"网络好像出现了一下问题，可能是因为网络环境不佳或服务器繁忙（点击重试）";
        self.noDataType = TMMNoDataTypeWorkingError;
        tableView.emptyDataSetSource = self;
        tableView.emptyDataSetDelegate = self;
        [tableView reloadEmptyDataSet];
    }
}

/**
 显示没有数据在ScrollView上面（没有数据）
 */
-(void)showNoDataAtTableViewFormNoDataWithScrollView:(UIScrollView*)scrollView{
    if (scrollView)
    {
        self.weekScrollView = scrollView;
        self.noDataTitle = @"没有数据";
        self.noDataDetail = @"对不起，链接没有数据！";
        self.noDataType = TMMNoDataTypeNoData;
        scrollView.emptyDataSetSource = self;
        scrollView.emptyDataSetDelegate = self;
        [scrollView reloadEmptyDataSet];
    }
}
/**
 显示没有数据在ScrollView上面(网络错误)
 */
-(void)showNoDataAtTableViewFormWorkingErrorWithScrollView:(UIScrollView *)scrollView{
    if (scrollView)
    {
        self.weekScrollView = scrollView;
        [scrollView.mj_header endRefreshing];
        [scrollView.mj_footer endRefreshing];
        self.noDataTitle = @"网络异常";
        self.noDataDetail = @"网络好像出现了一下问题，可能是因为网络环境不佳或服务器繁忙~";
        self.noDataType = TMMNoDataTypeWorkingError;
        scrollView.emptyDataSetSource = self;
        scrollView.emptyDataSetDelegate = self;
        [scrollView reloadEmptyDataSet];
    }
}


/*
 * noData显示内容标题
 */
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSString *text = self.noDataTitle;
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0];//185,185,185
    UIColor *textColor = [UIColor colorWithRed:185/255 green:185/255 blue:185/255 alpha:1.0f];
    
    if (!text) {
        return nil;
    }
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

/*
 * noData显示内容描述
 */
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    text = self.noDataDetail;
    font = [UIFont systemFontOfSize:16.0];
    textColor = [UIColor colorWithRed:185/255 green:185/255 blue:185/255 alpha:1.0f];
    
    if (!text) {
        return nil;
    }
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    if (paragraph) [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    
    return attributedString;
    
}

/*
 * noData显示内容单击
 */
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if (self.weekTableView)
    {
        [self.weekTableView.mj_header beginRefreshing];
    }
}



/*
 * noData显示图片
 */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.noDataType == TMMNoDataTypeNoData)
    {
        return [UIImage imageNamed:@"DZNEmptyImage"];
    }
    else if (self.noDataType == TMMNoDataTypeWorkingError)
    {
        NSString *imageName = @"DZNEmptyImageWorkingError";
        return [UIImage imageNamed:imageName];
    }
    else
    {
        return [UIImage imageNamed:@"DZNEmptyImage"];
    }
}




/**
 显示警告消息
 
 @param msg 消息
 */
-(void) showInfoMessage:(NSString*)msg
{
//    NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleInfo message:msg];
//    [alert setTextAlignment:NSTextAlignmentCenter];
//   [alert show];
    [SVProgressHUD showInfoWithStatus:msg];
}

/**
 显示成功消息
 
 @param msg 消息
 */
-(void) showSuccessMessage:(NSString*)msg
{
//    NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleSuccess message:msg];
//    [alert setTextAlignment:NSTextAlignmentCenter];
//    [alert show];
    [SVProgressHUD showSuccessWithStatus:msg];
}


/**
 显示错误消息

 @param msg 消息
 */
-(void) showErrorMessage:(NSString*)msg
{
//    NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleError message:msg];
//    [alert setTextAlignment:NSTextAlignmentCenter];
//    [alert show];
    [SVProgressHUD showErrorWithStatus:msg];
}




-(UIViewController *)viewControllerWithIdentifier:(NSString*) Identifier SbName:(NSString *)name
{
    NSAssert(Identifier != nil, @"Identifier不能为空！");
    NSAssert(name != nil, @"name不能为空！");
    UIStoryboard *sb = [UIStoryboard storyboardWithName:name bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:Identifier];
    return vc;
}


/**
 视图跳转

 @param Identifier 视图标识
 @param name sb名字
 */
-(void) pushViewControllerWithIdentifier:(NSString*) Identifier SbName:(NSString *)name
{
    NSAssert(Identifier != nil, @"Identifier不能为空！");
    NSAssert(name != nil, @"name不能为空！");
    UIStoryboard *sb = [UIStoryboard storyboardWithName:name bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:Identifier];
    if (![vc isKindOfClass:[UINavigationController class]])
    {
        [self.navigationController pushViewController:vc animated:YES];
    }
}


/*!
 *  @author methodname, 16-08-10 11:08:31
 *
 *  在View上边显示tip提醒
 *
 *  @param atView 基于的View
 *  @param text   内容
 *  @param color  显示颜色
 */
-(void)upShowAMPopTipAtView:(UIView *)atView Text:(NSString *)text PopoverColor:(UIColor *)color
{
    
    self.tipView.popoverColor = color;
    
    [self.tipView showText:text direction:AMPopTipDirectionUp maxWidth:atView.superview.mj_w inView:atView.superview fromFrame:atView.frame duration:2.0f];
}

/*!
 *  @author methodname, 16-08-10 11:08:31
 *
 *  在View下边显示tip提醒
 *
 *  @param atView 基于的View
 *  @param text   内容
 *  @param color  显示颜色
 */
-(void)downShowAMPopTipAtView:(UIView *)atView Text:(NSString *)text PopoverColor:(UIColor *)color
{
    self.tipView.popoverColor = color;
    [self.tipView showText:text direction:AMPopTipDirectionDown maxWidth:atView.superview.mj_w inView:atView.superview fromFrame:atView.frame duration:2.0f];
}

/*!
 *  @author methodname, 16-08-10 11:08:31
 *
 *  在View坐边显示tip提醒
 *
 *  @param atView 基于的View
 *  @param text   内容
 *  @param color  显示颜色
 */
-(void)leftShowAMPopTipAtView:(UIView *)atView Text:(NSString *)text PopoverColor:(UIColor *)color
{
    self.tipView.popoverColor = color;
    [self.tipView showText:text direction:AMPopTipDirectionLeft maxWidth:atView.superview.mj_w inView:atView.superview fromFrame:atView.frame duration:2.0f];
}

/*!
 *  @author methodname, 16-08-10 11:08:31
 *
 *  在View右边显示tip提醒
 *
 *  @param atView 基于的View
 *  @param text   内容
 *  @param color  显示颜色
 */
-(void)rightShowAMPopTipAtView:(UIView *)atView Text:(NSString *)text PopoverColor:(UIColor *)color
{
    self.tipView.popoverColor = color;
    [self.tipView showText:text direction:AMPopTipDirectionRight maxWidth:atView.superview.mj_w inView:atView.superview fromFrame:atView.frame duration:2.0f];
}





@end
