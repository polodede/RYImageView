//
//  RYViewController.m
//  RYImageView
//
//  Created by Ryan on 12/30/2015.
//  Copyright (c) 2015 Ryan. All rights reserved.
//

#import "RYViewController.h"
#import <RYImageView/RYImageView.h>

@interface RYViewController ()

@end

@implementation RYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *urlStr = @"http://d01.res.meilishuo.net/pic/_o/f6/b6/358f0c02044ae92bf324832a671b_750_548.cj.jpg";
    
    RYImageView *testView = [[RYImageView alloc] initWithActivityIndecator];
    testView.frame = CGRectMake(0, 0, 320, 300);
    testView.backgroundColor = [UIColor clearColor];
    [testView setImageWithURL:[NSURL URLWithString:urlStr] placeholder:nil];
    [self.view addSubview:testView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
