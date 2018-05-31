//
//  HSDBaseViewController.m
//  HaoShiDai
//
//  Created by Methodname on 14/12/22.
//  Copyright (c) 2014年 Methodname. All rights reserved.
//

#import "TMMBaseViewController.h"



@interface TMMBaseViewController ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>


/**
 *  侧栏缩放百分比
 */
@property(nonatomic,assign)CGFloat bfb;
/**
 *  是否添加了蒙板
 */
@property(atomic,assign)BOOL isAddShadeView;
/**
 *  是否添加了侧栏
 */
@property(nonatomic,assign)BOOL isAddBGView;
/**
 *  加载中动画图片
 */
@property(nonatomic,weak)UIImageView *imageview;
/**
 *  加载中
 */
@property(nonatomic,weak)UILabel *textLabel;

/**
 *  状态栏底部View
 */
@property(nonatomic,strong)UIView *statusView;


@property(nonatomic,strong)AMPopTip * tipView;

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

    self.bgViewDisplay = NO;
    
    //初始化tipView
    self.tipView = [AMPopTip popTip];
    self.tipView.font = [UIFont fontWithName:@"Avenir-Medium" size:12];
    self.tipView.shouldDismissOnTap = YES;//单击消失
    self.tipView.edgeMargin = 5;//外边距
    self.tipView.offset = 15;//中心点偏移位置
    self.tipView.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);//内边距

    
    //遮挡视图
    self.shadeView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.shadeView.backgroundColor =[UIColor lightGrayColor];
    self.shadeView.alpha = 0.1;

   
    
    self.isAddShadeView = YES;
    
    //设置自定义的返回按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc]  initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
}



/**
 显示没有数据在tableView上面（没有数据）
 */
-(void)showNoDataAtTableViewFormNoData
{
    if (self.weekTableView)
    {
        self.noDataTitle = @"没有数据";
        self.noDataDetail = @"对不起，目前没有数据（点击重试）";
        self.noDataType = TMMNoDataTypeNoData;
        self.weekTableView.emptyDataSetSource = self;
        self.weekTableView.emptyDataSetDelegate = self;
        [self.weekTableView reloadEmptyDataSet];
    }
}
/**
 显示没有数据在tableView上面(网络错误)
 */
-(void)showNoDataAtTableViewFormWorkingError
{
    if (self.weekTableView)
    {
        [self.weekTableView.mj_header endRefreshing];
        [self.weekTableView.mj_footer endRefreshing];
        self.noDataTitle = @"网络异常";
        self.noDataDetail = @"网络好像出现了一下问题，可能是因为网络环境不佳或服务器繁忙（点击重试）";
        self.noDataType = TMMNoDataTypeWorkingError;
        self.weekTableView.emptyDataSetSource = self;
        self.weekTableView.emptyDataSetDelegate = self;
        [self.weekTableView reloadEmptyDataSet];
    }
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




#pragma mark -显示警告消息
-(void) showInfoMessage:(NSString*)msg
{
//    NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleInfo message:msg];
//    [alert setTextAlignment:NSTextAlignmentCenter];
//   [alert show];
    [SVProgressHUD showInfoWithStatus:msg];
}

#pragma mark -显示成功消息
-(void) showSuccessMessage:(NSString*)msg
{
//    NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleSuccess message:msg];
//    [alert setTextAlignment:NSTextAlignmentCenter];
//    [alert show];
    [SVProgressHUD showSuccessWithStatus:msg];
}

#pragma mark -显示错误消息
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


#pragma mark -显示加载视图
-(void)ShowLoadingView
{
    
    if (!_imageview)
    {
        UIImageView *imageview = [UIImageView new];
        _imageview = imageview;
        [self.view addSubview:imageview];
        NSMutableArray *imageArray = [NSMutableArray new];
        for (int i =0; i<12; i++)
        {
            UIImage *img =[UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
            [imageArray addObject:img];
        }
    
       // [imageview setClipsToBounds:YES];
        //[imageview.layer setCornerRadius:10.0];
        [imageview.layer setShadowColor:[[UIColor blackColor] CGColor]];
        //imageview.layer.borderWidth = 10;
        [imageview.layer setShadowOffset:CGSizeMake(0, 3)];
        [imageview.layer setShadowRadius:3.0f];
        [imageview.layer setShadowOpacity:0.5];
        
        [imageview setAnimationImages:imageArray];
        [imageview setAnimationRepeatCount:10000];
        [imageview setAnimationDuration:1.7];
        [imageview setFrame:CGRectMake(0, 0, DV_W*0.35, DV_W*0.35)];
        [imageview setCenter:self.view.center];
        UILabel *textLabel = [UILabel new];
        [textLabel setText:@"加载中"];
        [textLabel setTextColor:RGB(144, 144, 144)];
        _textLabel = textLabel;
        [textLabel setTextAlignment:NSTextAlignmentCenter];
        [imageview addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.size.mas_equalTo(CGSizeMake(DV_W*0.3, 20));
            make.top.equalTo(imageview.mas_top).offset(DV_W*0.05);
            make.centerX.equalTo(imageview);
        }];
        //imageview
    
    }
    
    [self.view setUserInteractionEnabled:NO];
    [_imageview setHidden:NO];
    
    //放大动画
    CABasicAnimation *basicAnime=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [basicAnime setFromValue:[NSNumber numberWithFloat:0.1]];
    [basicAnime setToValue:[NSNumber numberWithFloat:1.0]];
    [basicAnime setDuration:0.15];
    [basicAnime setAutoreverses:NO];
    [basicAnime setRepeatCount:1];
    basicAnime.fillMode=kCAFillModeForwards;
    basicAnime.removedOnCompletion = NO;
    [_imageview.layer addAnimation:basicAnime forKey:@"scale"];
     [_textLabel.layer addAnimation:basicAnime forKey:@"scale"];
    [_imageview startAnimating];
   
    
}



#pragma mark -隐藏加载视图
-(void)hideLoadingView
{
    //设置时间为2
    double delayInSeconds = 0.5;
    //创建一个调度时间,相对于默认时钟或修改现有的调度时间。
    dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //推迟两纳秒执行
    dispatch_queue_t concurrentQueue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self->_imageview)
            {
                [self.view setUserInteractionEnabled:YES];
                [self->_imageview stopAnimating];
                [self->_imageview setHidden:YES];
            }
        });
    });
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
