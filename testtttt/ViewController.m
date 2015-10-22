//
//  ViewController.m
//  testtttt
//
//  Created by yangfan on 15/9/10.
//  Copyright (c) 2015年 Adron. All rights reserved.
//

#import "ViewController.h"
#import "TagViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.view setBackgroundColor:[UIColor blackColor]];
    // Do any additional setup after loading the view, typically from a nib.

    TagViewController *tagView = [[TagViewController alloc] init];
    tagView.tagsArray = [@[ @"子",
                            @"hahaaaa12",
                            @"我们都是好孩子",
                            @"hah2",
                            @"我",
                            @"我",
                            @"ha12",
                            @"我们都是好孩子",
                            @"我们子",
                            @"都是子" ] mutableCopy];
    tagView.maxSize = CGSizeMake(self.view.frame.size.width, 300);
    [tagView setViewBackgroundColor:[UIColor grayColor]];
    [tagView setTagsWordsColor:[UIColor blackColor]];
    [tagView setTagsBackgroundColor:[UIColor whiteColor]];
    [tagView setTagsBorderColor:[UIColor blackColor]];
    [tagView setTagsBorderCornerRadius:4];
    [tagView setTagsHeight:20];
    [tagView setFontSize:14];
    [tagView setTagsMarginLeftAndRightForSubView:10];
    [tagView setTagsMarginTopAndBottomForSubView:20];
    [tagView setTagsAlignment:TagsAlignmentCenter];
    CGSize size = [tagView returnContentSize];
    [tagView.view setFrame:CGRectMake(0, 100, size.width, size.height)];
    [self.view addSubview:tagView.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
