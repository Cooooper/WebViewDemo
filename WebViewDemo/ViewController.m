//
//  ViewController.m
//  WebViewDemo
//
//  Created by Han Yahui on 15/12/8.
//  Copyright © 2015年 Han Yahui. All rights reserved.
//

#import "ViewController.h"

#import "HYHWebView.h"
#import "IDBProgressView.h"
@interface ViewController ()<UIWebViewDelegate,HYHWebViewProgressDelegate>

@property (nonatomic,strong) HYHWebView *webView;

//@property (nonatomic,strong) UIProgressView *progressBar;

@property (nonatomic,strong) IDBProgressView *progressBar;

@property (nonatomic,strong) CAShapeLayer *progressLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initWebView];
//  [self loadProgressBar];
  [self initProgressLayer];
}

- (void)initProgressLayer
{
  CGFloat lineHieght = 4;
  _progressLayer = [CAShapeLayer layer];
  _progressLayer.frame = CGRectMake(0, 64, _webView.frame.size.width, lineHieght);
  UIBezierPath *path = [UIBezierPath bezierPath];
  [path moveToPoint:CGPointMake(0, _progressLayer.frame.size.height/2)];
  [path addLineToPoint:CGPointMake(_webView.frame.size.width, _progressLayer.frame.size.height / 2)];
  _progressLayer.lineWidth = lineHieght;
  _progressLayer.path = path.CGPath;
  _progressLayer.strokeColor = [UIColor colorWithRed:0.000 green:0.640 blue:1.000 alpha:0.720].CGColor;
  _progressLayer.lineCap = kCALineCapButt;
  _progressLayer.strokeStart = 0;
  _progressLayer.strokeEnd = 0;
  [_webView.layer addSublayer:_progressLayer];
}

- (void)progressPrepare
{
  [CATransaction begin];
  [CATransaction setDisableActions:YES];
  self.progressLayer.hidden = YES;
  self.progressLayer.strokeEnd = 0;
  [CATransaction commit];
  
}

- (void)progressLoading:(CGFloat)progress
{
  if (self.progressLayer.hidden) {
    self.progressLayer.hidden = NO;
  }
  self.progressLayer.strokeEnd = progress;
  
}

- (void)progressEnding
{
  self.progressLayer.hidden = YES;
  
}

- (void)loadProgressBar
{
  if (self.progressBar) {
    [self.progressBar removeFromSuperview];
  }
    self.progressBar = [[IDBProgressView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 5)];
    self.progressBar.progressViewStyle = UIProgressViewStyleDefault;
    self.progressBar.tintColor = [UIColor colorWithRed:0.0 green:201/255.0 blue:14/255.0 alpha:1];
    [self.view addSubview:self.progressBar];
  
}

- (void)initWebView
{
  
  if (!self.webView) {
   
    self.webView = [[HYHWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.webView.delegate = self;
    self.webView.progressDelegate = self;
    [self.view addSubview:self.webView];
  }
  
  NSURL *url = [NSURL URLWithString:@"https://www.github.com"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [self.webView loadRequest:request];

}

- (void)webView:(HYHWebView*)webView didReceiveResourceNumber:(int)resourceNumber totalResources:(int)totalResources
{
  
  float progress = (float)resourceNumber / (float)totalResources;
//  [self.progressBar setProgress:progress animated:YES];
  [self progressLoading:progress];
  
  NSLog(@"number %d total %d progress %f",resourceNumber,totalResources,progress);
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
  
  [self progressEnding];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
  [self progressPrepare];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  [self progressEnding];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//  [self loadProgressBar];
  return YES;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
