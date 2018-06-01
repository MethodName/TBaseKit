//
//  TMMWkWebViewViewController.m
//  TBaseKit
//
//  Created by 唐明明 on 2018/6/1.
//

#import "TMMWkWebViewViewController.h"
#import <WebKit/WebKit.h>

@interface TMMWkWebViewViewController ()<WKNavigationDelegate,WKUIDelegate,CAAnimationDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) WKWebView *webView;

@property(weak,nonatomic)CAShapeLayer *loadline;

@property(nonatomic,assign)CGFloat changeY;

@property(nonatomic,assign)CGFloat oldY;

@property(nonatomic,assign)CGFloat defaultTitleFontSize;
@property(nonatomic,assign)CGFloat defaultTitleY;
@property(nonatomic,assign)CGFloat defaultTitleH;

@end

@implementation TMMWkWebViewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WKWebView* webView = [[WKWebView alloc] init];
    webView.translatesAutoresizingMaskIntoConstraints = YES;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.webView = webView;
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [self.webView.configuration.userContentController addUserScript:wkUScript];
    self.webView.configuration.preferences.minimumFontSize = 12;
    
    //适配iOS11，让scrollView不自动计算内边距
    if (@available(iOS 11.0, *)) {
        //self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
            /**
             iOS11之后导航栏视图结构更改，需要另外获取标题和返回按钮
             */
         for (UIView * item in self.navigationController.navigationBar.subviews) {
            
            if ([NSStringFromClass([item class]) isEqualToString:@"_UINavigationBarContentView"]) {
                for (UIView *subItem in item.subviews) {
                    if ([NSStringFromClass([subItem class]) isEqualToString:@"UILabel"]) {
                        UILabel *titleLB = (UILabel *)subItem;
                        NSLog(@"====>%@",NSStringFromCGRect(titleLB.frame));
                        self.defaultTitleFontSize = titleLB.font.pointSize;
                        self.defaultTitleY = titleLB.frame.origin.y;
                        self.defaultTitleH = titleLB.frame.size.height;
                        break;
                    }
                }
                break;
            }
            
        }
        
        
    } else {
        // Fallback on earlier versions
        //self.automaticallyAdjustsScrollViewInsets = NO;
        
        //获取标题的默认字体和默认Y轴
        for (UIView * item in self.navigationController.navigationBar.subviews) {
            //UINavigationItemView
            if ([NSStringFromClass([item class]) isEqualToString:@"UINavigationItemView"]) {
                self.defaultTitleY = item.frame.origin.y;
                NSLog(@"====>%@",NSStringFromCGRect(item.frame));
                for (UIView *subItem in item.subviews) {
                    //UILabel
                    if ([NSStringFromClass([subItem class]) isEqualToString:@"UILabel"]) {
                        UILabel *titleLB = (UILabel *)subItem;
                        self.defaultTitleFontSize = titleLB.font.pointSize;
                        self.defaultTitleH = titleLB.frame.size.height;
                        self.defaultTitleY = self.defaultTitleY + titleLB.frame.origin.y;
                        break;
                    }
                }
                break;
            }
        }
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    }
    //设置scrollview的内边距和滚动范围的内边距
    
    self.webView.scrollView.scrollIndicatorInsets = self.webView.scrollView.contentInset;
    
    if (self.webUrl) {
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.webUrl]];
        [self.webView loadRequest:request];
    }
    else
    {
        [self showNoDataAtTableViewFormNoDataWithScrollView:self.webView.scrollView];
    }
    
    
    
}


#pragma mark -导航栏返回按钮事件拦截
-(BOOL)navigationShouldPopOnBackButton
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    return NO;
}



#pragma mark -scrollView滑动代理事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;//滑动距离
    
    CGFloat sH = 20.0f;//状态栏高度
    CGFloat zH = -10.0f;//定住y轴位置
    if (IPHONE_X) {
        sH = 44.0f;
        zH = 14.0f;
    }
    CGFloat h = self.navigationController.navigationBar.bounds.size.height+sH;//整个导航栏高度
    CGFloat mY = sH;
    if (y>=self.oldY) {
        mY = y > 0.0 ? (y<=h ? sH : (-y+h+sH) >= zH ? (-y+h+sH) : zH ) : sH;//((y-h)>sH ? (-y+h+sH) : zH)
    }else{
        mY = y > 0.0 ? (y>=h ? zH : ((zH+h-y) >= sH ? sH : (zH+h-y))) : sH;
    }
    
    [self.navigationController.navigationBar setFrame:CGRectMake(0, mY, self.navigationController.navigationBar.bounds.size.width, self.navigationController.navigationBar.bounds.size.height)];
    //NSLog(@"%lf   %lf",scrollView.contentOffset.y,mY);
    [self setNaviBar:(sH-mY)/(sH-zH)];
    
    self.oldY = y;
}


-(void)setNaviBar:(CGFloat)floaty
{
    //NSLog(@"%0.2lf",floaty);
    for (UIView * item in self.navigationController.navigationBar.subviews) {
        //NSLog(@"-------%@",NSStringFromClass([item class]));
        //UINavigationItemView
        if ([NSStringFromClass([item class]) isEqualToString:@"UINavigationItemView"]) {
            
            [item setCenter:CGPointMake(item.center.x, 13*floaty+self.defaultTitleY+(self.defaultTitleH/2))];
            for (UIView *subItem in item.subviews) {
                //NSLog(@"%@",NSStringFromClass([subItem class]));
                //UILabel
                if ([NSStringFromClass([subItem class]) isEqualToString:@"UILabel"]) {
                    UILabel *titleLB = (UILabel *)subItem;
                    [titleLB setTextAlignment:NSTextAlignmentCenter];
                    [titleLB setFont:[UIFont boldSystemFontOfSize:self.defaultTitleFontSize - (4.0f*floaty)]];
                    break;
                }
            }
            continue;
        }
        //UINavigationItemButtonView
        if ([NSStringFromClass([item class]) isEqualToString:@"UINavigationItemButtonView"]) {
           [item setAlpha:1.0-floaty];
           continue;
        }
        //_UINavigationBarBackIndicatorView
        if ([NSStringFromClass([item class]) isEqualToString:@"_UINavigationBarBackIndicatorView"]) {
            [item setAlpha:1.0-floaty];
            continue;
        }
        
        //UINavigationButton
        if ([NSStringFromClass([item class]) isEqualToString:@"UINavigationButton"]) {
            [item setAlpha:1.0-floaty];
            continue;
        }
        //NSLog(@"---%@",NSStringFromClass([item class]));
        
        
        /**
         iOS11之后导航栏视图结构更改，需要另外获取标题和返回按钮
         */
        if (@available(iOS 11.0, *)) {
            if ([NSStringFromClass([item class]) isEqualToString:@"_UINavigationBarContentView"]) {
                
                for (UIView *subItem in item.subviews) {
                    //NSLog(@"-------%@",NSStringFromClass([subItem class]));
                    
                    if ([NSStringFromClass([subItem class]) isEqualToString:@"_UIButtonBarButton"]) {
                        [subItem setAlpha:1.0-floaty];
                        continue;
                    }
                    if ([NSStringFromClass([subItem class]) isEqualToString:@"UILabel"]) {
                        UILabel *titleLB = (UILabel *)subItem;
                        [titleLB setTextAlignment:NSTextAlignmentCenter];
                        [titleLB setFont:[UIFont boldSystemFontOfSize:self.defaultTitleFontSize - (4.0f*floaty)]];
                        CGFloat moveY = 13*floaty+self.defaultTitleY+(self.defaultTitleH/2);
                        [titleLB setCenter:CGPointMake(titleLB.center.x, moveY)];
                        //[item setNeedsLayout];
                        
                        continue;
                    }
                    
                    //_UIButtonBarStackView
                    if ([NSStringFromClass([subItem class]) isEqualToString:@"_UIButtonBarStackView"]) {
                        for (UIView *sItem in subItem.subviews) {
                            //NSLog(@"%@",NSStringFromClass([sItem class]));
                            //_UIButtonBarButton
                            if ([NSStringFromClass([sItem class]) isEqualToString:@"_UIButtonBarButton"]) {
                                [sItem setAlpha:1.0-floaty];
                                break;
                            }
                        }
                        continue;
                    }
                    
                }
                continue;
            }
        }
    }
}


/**
 webView开始加载
 
 @param webView webView
 @param navigation 导航
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
{
    [self pathLineStart:0.1 End:0.25 Duration:1.5 OldAnimateKey:@"" AnimateKey:@"line1"];
}



/**
 确认提交
 
 @param webView webView
 @param navigation 导航
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    [self pathLineStart:0.25 End:0.4 Duration:5.0 OldAnimateKey:@"line1" AnimateKey:@"line2"];
    
    [self setNaviBar:0];
}


/**
 webView加载完成
 
 @param webView webView
 @param navigation 导航
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    [self pathLineStart:0.25 End:1 Duration:0.35 OldAnimateKey:@"line2" AnimateKey:@"lineEnd"];
    if ([self.webView canGoBack]) {
        UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeClick)];
        self.navigationItem.rightBarButtonItem = closeItem;
    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    NSString * jsStr = @"document.getElementsByTagName('title')[0].innerText";
    __weak TMMWkWebViewViewController *temp = self;
    [webView evaluateJavaScript:jsStr completionHandler:^(id item, NSError * _Nullable error) {
        // 获取web页面标题
        if (!error ) {
            temp.title = [NSString stringWithFormat:@"%@",item];
        }
    }];
    
}

#pragma mark -关闭点击事件
-(void)closeClick
{
    [self.navigationController popViewControllerAnimated:YES];
}




/**
 *  画线
 */
-(void)pathLineStart:(float)p1 End:(float)p2 Duration:(CFTimeInterval)duration OldAnimateKey:(NSString *)oldkey AnimateKey:(NSString *)key
{
    if (self.loadline == nil)
    {
        //创建动画图层
        CAShapeLayer *line1=[CAShapeLayer layer];
        //创建画笔
        UIBezierPath* bezier1Path = UIBezierPath.bezierPath;
        //设置锚点
        [bezier1Path moveToPoint: CGPointMake(0, 44)];
        //添加一个终点
        CGFloat x = self.navigationController.navigationBar.bounds.size.width;
        [bezier1Path addLineToPoint: CGPointMake(x, 44)];
        //设置图层路径为画笔路径
        line1.path=bezier1Path.CGPath;
        //图层线宽
        line1.lineWidth = 2;
        //设置圆角
        
        //设置描边色
        line1.strokeColor=[THE_THEME_BUTTON_COLORA(1.0) CGColor];
        //将图层添加到视图的图层上
        [self.navigationController.navigationBar.layer addSublayer:line1];
        self.loadline = line1;
    }
    
    if (oldkey.length != 0 ) {
        [self.loadline removeAnimationForKey:oldkey];
    }
    
    
    //创建基础动画
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //设置开始时间
    animation1.beginTime = CACurrentMediaTime() + 0;
    //设置动画时间
    animation1.duration = duration;
    //设置保留动画完成时的图层
    animation1.removedOnCompletion = NO;
    //设置不还原动画
    animation1.autoreverses = NO;
    //填充模式
    animation1.fillMode = kCAFillModeBoth;
    //开始值
    animation1.fromValue = @(p1);
    //结束值
    animation1.toValue = @(p2);
    
    
    //设置动画曲线
    if (duration>1)
    {
        animation1.timingFunction = [CAMediaTimingFunction  functionWithControlPoints:0.3 : 0.2 :0.1 :0.9];
    }
    animation1.delegate = self;
    //添加动画到图层【执行】
    [self.loadline addAnimation:animation1 forKey:key];
}


/**
 动画停止代理
 
 @param anim 动画对象
 @param flag 完成标记
 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    BOOL fl = NO;
    if (flag) {
        for (NSString *key in self.loadline.animationKeys) {
            if ([key isEqualToString:@"lineEnd"]) {
                fl = YES;
                break;
            }
        }
    }
    
    if (fl) {
        [self removeLineLayer];
    }
    
}


/**
 删除线
 */
- (void)removeLineLayer
{
    BOOL fl = NO;
    int index = -1;
    NSArray *array = self.navigationController.navigationBar.layer.sublayers;
    for (int i = 0;i<array.count;i++ ) {
        if ([array[i] isKindOfClass:[CAShapeLayer class]])
        {
            fl = YES;
            index = i;
            
        }
    }
    if (fl && index != -1) {
        CAShapeLayer *lineLayer = array[index];
        [lineLayer removeAllAnimations];
        [lineLayer removeFromSuperlayer];
    }
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.webView.scrollView setDelegate:self];
    self.oldY = 0;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setNaviBar:0];
    [self.webView.scrollView setDelegate:nil];
    [self removeLineLayer];
}







- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{    // js 里面的alert实现，如果不实现，网页的alert函数无效
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{}];
    
    //MBLog(@"%@",message);
}



-(void)dealloc
{
    [self.webView stopLoading];
    self.webView.UIDelegate  = nil;
    self.webView.navigationDelegate = nil;
}


@end
