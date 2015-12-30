//
//  RYImageView.h
//  EnjoyDaPei
//
//  Created by Ryan on 14-7-25.
//  Copyright (c) 2014年 dapei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface RYImageView : UIImageView

@property (nonatomic ,strong) NSInvocation* onImageTap;
@property (nonatomic ,strong) NSInvocation* longImageTap;

@property (nonatomic ,strong) UIActivityIndicatorView* loadingWheel;

- (instancetype)initWithActivityIndecator;
- (void)addTarget:(id)obj action:(SEL)m;
- (void)addTarget:(id)obj longTapAction:(SEL)m;
- (void)setImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholder;
@end