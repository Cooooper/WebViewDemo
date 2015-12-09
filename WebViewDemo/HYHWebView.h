//
//  HYHWebView.h
//  WebViewDemo
//
//  Created by Han Yahui on 15/12/9.
//  Copyright © 2015年 Han Yahui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYHWebView;

@protocol HYHWebViewProgressDelegate <NSObject>

@optional
- (void) webView:(HYHWebView *)webView didReceiveResourceNumber:(int)resourceNumber totalResources:(int)totalResources;


@end

@interface HYHWebView : UIWebView


@property (nonatomic, weak) id<HYHWebViewProgressDelegate> progressDelegate;


@end
