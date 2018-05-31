//
//  TMMConfig.h
//  HaoShiDai
//
//  Created by 唐明明 on 16/3/4.
//  Copyright © 2016年 360haoshidai. All rights reserved.
//

#ifndef TMMConfig_h
#define TMMConfig_h



//*************************常用常量字符*****************************

#define HSD_TEXT_NET_ERROR_INFO  @"网络错误" //网络请求出错提示

#define HSD_TEXT_NET_OK  @"1" //网络请求出错提示



//列表点击动画延时时间
#define LIST_ITEM_ANIMATION_DALY_TIME 0.15f

//-------------------获取设备大小-------------------------
//NavBar高度
#define NB_H 44

//获取屏幕 宽度、高度
#define DV_W ([UIScreen mainScreen].bounds.size.width)
#define DV_H ([UIScreen mainScreen].bounds.size.height)

//打印当前方法的名称
#define PRINT_METHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)



//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//获取当前软件版本
#define NOW_APP_VERSION [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
//#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
//#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断设备的操做系统是不是ios7
#define IOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0])

//判断设备的操做系统是不是ios8
#define IOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0])

//判断设备的操做系统是不是ios9
#define IOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)

#define IOS10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)

#define IOS11 ([[UIDevice currentDevice].systemVersion doubleValue] >= 11.0)



//系统细体字体
#define LightFT(s) (IOS9 ? FTwithName(@".SFUIText-Light",s) : FTwithName(@".HelveticaNeueInterface-Light",s))

#define FTwithName(n, s) ([UIFont fontWithName:n size:s])

//判断当前设备是不是iPhone4或者4s
#define IPHONE4S    (([[UIScreen mainScreen] bounds].size.height)==480)

//判断当前设备是不是iPhone5
#define IPHONE5    (([[UIScreen mainScreen] bounds].size.height)==568)

//判断当前设备是不是iPhone6
#define IPHONE6    (([[UIScreen mainScreen] bounds].size.height)==667)

//判断当前设备是不是iPhone6Plus
#define IPHONE6_PLUS    (([[UIScreen mainScreen] bounds].size.height) ==736)

//判断当前设备是不是iPhone X
#define IPHONE_X    (([[UIScreen mainScreen] bounds].size.height) == 812)

//获取当前屏幕的高度
#define kMainScreenHeight ([UIScreen mainScreen].applicationFrame.size.height)

//获取当前屏幕的宽度
#define kMainScreenWidth  ([UIScreen mainScreen].applicationFrame.size.width)


#define AppDel  ((AppDelegate *)[UIApplication sharedApplication].delegate)

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


#define SB(name) [UIStoryboard storyboardWithName:name bundle:nil]


//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//主题颜色
//#define THE_THEME_COLORA(a) RGBA(6,187,106,a)//40  210  130

#define THE_THEME_COLORA(a) RGBA(37,215,148,a)
//特殊按钮的颜色
#define THE_THEME_BUTTON_COLORA(a) RGBA(252,187,89,a)

//信【紫色】
#define THE_THEME_BUTTON_BG_COLORA(a) RGBA(95,125,255,a)

//线颜色
#define LINE_COLOR  RGB(240,240,240)


//文本框前面图标大小
#define FIELD_ICON_SIZE CGSizeMake(24, 24)

//文本框字体大小
#define FIELD_FONT [UIFont systemFontOfSize:16.0f]

//错误颜色
#define ErrorColor [UIColor colorWithRed:0.655 green:0.000 blue:0.060 alpha:1.000]

//警告颜色
#define InfoColor [UIColor colorWithRed:1 green:0.517 blue:0 alpha:1.000]

//成功颜色
#define SuccessColor [UIColor colorWithRed:0.078 green:0.596 blue:0.243 alpha:1.000]





//方正黑体简体字体定义
#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//延迟GCD时间
#define DisTime(time)  dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC)
//延迟GCD
#define DisBACK(disTime,block) dispatch_after(disTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){dispatch_async(dispatch_get_main_queue(), block);});

//通知中心
#define HSDNSCENTER ([NSNotificationCenter defaultCenter])

//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)


//打印当前方法的名称
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)


#ifdef DEBUG

#define NSLog(...) NSLog(__VA_ARGS__)

#else

#define NSLog(...)

#endif






#endif /* TMMConfig_h */
