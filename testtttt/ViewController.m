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

    _tagView = [[TagViewController alloc] init];
    _tagView.tagsArray = [@[ @"子",
                             @"hahaaaa12",
                             @"我们都是好孩子",
                             @"hah2",
                             @"我",
                             @"我",
                             @"ha12",
                             @"我们都是好孩子",
                             @"我们子",
                             @"都是子" ] mutableCopy];
    _tagView.maxSize = CGSizeMake(self.view.frame.size.width, 300);
    [_tagView setViewBackgroundColor:[UIColor grayColor]];
    [_tagView setTagsWordsColor:[UIColor blackColor]];
    [_tagView setTagsBackgroundColor:[UIColor whiteColor]];
    [_tagView setTagsBorderColor:[UIColor blackColor]];
    [_tagView setTagsBorderCornerRadius:4];
    [_tagView setTagsHeight:20];
    [_tagView setFontSize:14];
    [_tagView setTagsMarginLeftAndRightForSubView:10];
    [_tagView setTagsMarginTopAndBottomForSubView:20];
    [_tagView setTagsAlignment:TagsAlignmentCenter];

    [_tagView setClickRowBlock:^(NSInteger clickTagsTag) {
      NSLog(@"****%d", (int)clickTagsTag);
    }];
    [self.view addSubview:_tagView.view];
    CGSize size = _tagView.contentView.frame.size;
    [_tagView.view setFrame:CGRectMake(0, 100, size.width + 10, size.height + 10)];
    [self.view setBackgroundColor:[UIColor yellowColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
