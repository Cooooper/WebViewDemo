//
//  IDBProgressView.m
//  WebViewDemo
//
//  Created by Han Yahui on 15/12/9.
//  Copyright © 2015年 Han Yahui. All rights reserved.
//

#import "IDBProgressView.h"

@implementation IDBProgressView

- (void)hideWithFadeOut {
  //initialize fade animation
  CATransition *animation = [CATransition animation];
  animation.type = kCATransitionFade;
  animation.duration = 0.5;
  [self.layer addAnimation:animation forKey:nil];
  
  //Do hide progress bar
  self.hidden = YES;
}


-(void)setProgress:(float)progress animated:(BOOL)animated
{
  if ((!animated && progress > self.progress) || animated) {
    self.progress = progress;
  }
  if (self.progress == 1.0) {
    [self performSelector:@selector(hideWithFadeOut) withObject:nil afterDelay:1.0];
  }
}

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.progress = 0;
    self.tintColor = [UIColor blueColor];
    self.backgroundColor = [UIColor clearColor];
  }
  return self;
}

@end
