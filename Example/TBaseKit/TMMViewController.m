//
//  TMMViewController.m
//  TBaseKit
//
//  Created by methodname@qq.com on 05/31/2018.
//  Copyright (c) 2018 methodname@qq.com. All rights reserved.
//

#import "TMMViewController.h"
#import "TMMWkWebViewViewController.h"

@interface TMMViewController ()

@end

@implementation TMMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (IBAction)click:(id)sender {
    TMMWkWebViewViewController *webView = [TMMWkWebViewViewController new];
    webView.webUrl = @"https://blog.methodname.com";
    [self.navigationController pushViewController:webView animated:YES];
    
}

@end
