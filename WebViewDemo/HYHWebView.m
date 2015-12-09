//
//  HYHWebView.m
//  WebViewDemo
//
//  Created by Han Yahui on 15/12/9.
//  Copyright © 2015年 Han Yahui. All rights reserved.
//

#import "HYHWebView.h"

@interface UIWebView ()

-(id)webView:(id)view identifierForInitialRequest:(id)initialRequest fromDataSource:(id)dataSource;
-(void)webView:(id)view resource:(id)resource didFinishLoadingFromDataSource:(id)dataSource;
-(void)webView:(id)view resource:(id)resource didFailLoadingWithError:(id)error fromDataSource:(id)dataSource;

@end


@interface HYHWebView ()

@property (nonatomic, assign) int resourceCount;
@property (nonatomic, assign) int resourceCompletedCount;

@property (nonatomic,strong) CAShapeLayer *progressLayer;


@end


@implementation HYHWebView

-(id)webView:(id)view identifierForInitialRequest:(id)initialRequest fromDataSource:(id)dataSource
{
  [super webView:view identifierForInitialRequest:initialRequest fromDataSource:dataSource];
  return [NSNumber numberWithInt:self.resourceCount++];
}

- (void)webView:(id)view resource:(id)resource didFailLoadingWithError:(id)error fromDataSource:(id)dataSource {
  [super webView:view resource:resource didFailLoadingWithError:error fromDataSource:dataSource];
  self.resourceCompletedCount++;
  if ([self.progressDelegate respondsToSelector:@selector(webView:didReceiveResourceNumber:totalResources:)]) {
    [self.progressDelegate webView:self didReceiveResourceNumber:self.resourceCompletedCount totalResources:self.resourceCount];
  }
  [self resetCount];
}

-(void)webView:(id)view resource:(id)resource didFinishLoadingFromDataSource:(id)dataSource
{
  [super webView:view resource:resource didFinishLoadingFromDataSource:dataSource];
  self.resourceCompletedCount++;
  if ([self.progressDelegate respondsToSelector:@selector(webView:didReceiveResourceNumber:totalResources:)]) {
    [self.progressDelegate webView:self didReceiveResourceNumber:self.resourceCompletedCount totalResources:self.resourceCount];
  }
  [self resetCount];

}



- (void)resetCount
{
  if (self.resourceCompletedCount == self.resourceCount) {
    self.resourceCount = 0;
    self.resourceCompletedCount = 0;
  }
}


@end
