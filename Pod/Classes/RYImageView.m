 //
//  RYImageView.m
//  EnjoyDaPei
//
//  Created by Ryan on 14-7-25.
//  Copyright (c) 2014年 dapei. All rights reserved.
//

#import "RYImageView.h"

#define LoadingWheelTag 191919

@implementation RYImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (instancetype)initWithActivityIndecator
{
    self = [super init];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
        
        _loadingWheel = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _loadingWheel.tag = LoadingWheelTag;
        _loadingWheel.hidesWhenStopped=YES;
        [self addSubview:_loadingWheel];
    }
    return self;
}

- (void)setImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholder
{
    _loadingWheel.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    [_loadingWheel startAnimating];
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        ;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [_loadingWheel stopAnimating];
    }];
}

- (void)addTarget:(id)obj action:(SEL)m {
    id imageView = self;
    
	self.onImageTap = [NSInvocation invocationWithMethodSignature:[obj methodSignatureForSelector:m]];
	[_onImageTap setTarget:obj];
	[_onImageTap setSelector:m];
	[_onImageTap setArgument:&imageView atIndex:2];

	self.userInteractionEnabled=YES; //because it's NO in the initializer, but if we want to get a callback on tap,
    //then need to get touch events.
    
    // 单击的 Recognizer
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [self addGestureRecognizer:singleRecognizer];//给self添加一个手势监测；
    
    // 双击的手势 Recognizer
    UITapGestureRecognizer* doubleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleRecognizer.numberOfTapsRequired = 2; // 双击
    [self addGestureRecognizer:doubleRecognizer];
    
    // 双击手势确定监测失败才会触发单击手势的相应操作
    [singleRecognizer requireGestureRecognizerToFail:doubleRecognizer];
    
}

- (void)addTarget:(id)obj longTapAction:(SEL)m{
    id imageView = self;
    
    self.longImageTap = [NSInvocation invocationWithMethodSignature:[obj methodSignatureForSelector:m]];
    [_longImageTap setTarget:obj];
    [_longImageTap setSelector:m];
    [_longImageTap setArgument:&imageView atIndex:2];
    
    self.userInteractionEnabled=YES; //because it's NO in the initializer, but if we want to get a callback on tap,
    //then need to get touch events.
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTap:)];
    longPressGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:longPressGesture];

}

- (void)singleTap:(UIGestureRecognizer *)recogniser {
    if (_onImageTap) {
		[_onImageTap invoke];
	}
}

- (void)doubleTap:(UIGestureRecognizer *)recogniser {
    if (_onImageTap) {
		[_onImageTap invoke];
	}
}

- (void)longTap:(UIGestureRecognizer *)recogniser {
    if (_longImageTap) {
        [_longImageTap invoke];
    }
}

-(void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    [super touchesEnded:touches withEvent:event];
}

@end
