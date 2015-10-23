//
//  TagViewController.m
//  testtttt
//
//  Created by yangfan on 15/10/20.
//  Copyright © 2015年 Adron. All rights reserved.
//

#import "TagViewController.h"

@interface TagViewController ()

@end

@implementation TagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self refreshData];
}

- (void)refreshData {
    [self loadParameters];
    [self everyOneTags];
    [self loadUI];
    [self calcuteTrueSize];

    if (_tagsAlignment == TagsAlignmentCenter) {
        [self fitRectForCenterBtn];
    }
}

- (void)loadUI {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        [self.view addSubview:_contentView];
    } else {
        for (UIView *view in [_contentView subviews]) {
            [view removeFromSuperview];
        }
    }
    [_contentView setBackgroundColor:_viewBackgroundColor];
    [_contentView setFrame:CGRectMake(0, 0, _maxSize.width, _maxSize.height)];

    for (int i = 0; i < _tagsBtnArray.count; i++) {
        [self returnFitRectForEveryBtn:(UIButton *)[_tagsBtnArray objectAtIndex:i]];
    }

    for (UIButton *btn in _tagsBtnArray) {
        [_contentView addSubview:btn];
    }
}

- (void)calcuteTrueSize {
    if (_tagsBtnArray == nil) {
        return;
    }
    float maxRight = 0;
    float maxBottom = 0;
    for (UIButton *btn in _tagsBtnArray) {
        float btnRight = btn.frame.origin.x + CGRectGetWidth(btn.frame);
        float btnBottom = btn.frame.origin.y + CGRectGetHeight(btn.frame);
        maxRight = btnRight > maxRight ? btnRight : maxRight;
        maxBottom = btnBottom > maxBottom ? btnBottom : maxBottom;
    }
    _trueSize = CGSizeMake(maxRight + _tagsMarginLeftAndRightForSubView, maxBottom + _tagsMarginTopAndBottomForSubView);
    [_contentView setFrame:CGRectMake(0, 0, _trueSize.width, _trueSize.height)];
    CGRect rect = self.view.frame;
    rect.size = _contentView.frame.size;
    self.view.frame = rect;
}

#pragma mark - 这个是重要的部分，用来判断每一个按钮的位置(这个时候是向左对其)
- (void)returnFitRectForEveryBtn:(UIButton *)sender {
    int whichTag = (int)sender.tag;
    CGSize currentBtnSize = sender.frame.size;
    if (whichTag == 0) {
        CGRect rect = CGRectMake(_tagsMarginLeftAndRightForSubView, _tagsMarginTopAndBottomForSubView, currentBtnSize.width, currentBtnSize.height);
        sender.frame = rect;
        return;
    }
    CGRect preBtnRect = [(UIButton *)[_tagsBtnArray objectAtIndex:whichTag - 1] frame]; // 上一个按钮的位置
    {
        // 这里开始计算如果按照上一个按钮的位置继续排列，会不会超出父View
        CGRect wantSenderRect = CGRectMake(preBtnRect.origin.x + preBtnRect.size.width + _tagsMargin, preBtnRect.origin.y, currentBtnSize.width, currentBtnSize.height);

        if ([self isContainSubView:wantSenderRect]) {
            sender.frame = wantSenderRect;
        } else {
            sender.frame = CGRectMake(_tagsMarginLeftAndRightForSubView, preBtnRect.origin.y + preBtnRect.size.height + _tagsMargin, currentBtnSize.width, currentBtnSize.height);
        }
    }
}

#pragma mark - 当要求居中对其的时候，这里需要根据向左对其的基础重新调整Rect值
- (void)fitRectForCenterBtn {
    NSMutableArray *lineArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    float originy = 0;
    int line = 0;
    for (int i = 0; i < _tagsBtnArray.count; i++) {
        UIButton *btn = [_tagsBtnArray objectAtIndex:i];
        if (btn.frame.origin.y - originy > 2) {
            line++;
            lineArray = [[NSMutableArray alloc] init];
            [lineArray addObject:btn];
            originy = btn.frame.origin.y;
        } else {
            [lineArray addObject:btn];
        }
        [dic setObject:lineArray forKey:[NSString stringWithFormat:@"%d", line]];
    }

    for (int i = 1; i < dic.count + 1; i++) {
        NSMutableArray *array = [dic objectForKey:[NSString stringWithFormat:@"%d", i]];
        UIButton *firstButton = [array firstObject];
        UIButton *lastButton = [array lastObject];
        float marginLeftNew = (firstButton.frame.origin.x + _trueSize.width - lastButton.frame.origin.x - CGRectGetWidth(lastButton.frame)) / 2.0;
        float moveFromOriginRectX = firstButton.frame.origin.x - marginLeftNew;

        for (int j = 0; j < array.count; j++) {
            UIButton *btn = [array objectAtIndex:j];
            CGRect rect = btn.frame;
            rect.origin.x = rect.origin.x - moveFromOriginRectX;
            btn.frame = rect;
        }
    }
}

- (BOOL)isContainSubView:(CGRect)wantSenderRect {
    if (wantSenderRect.origin.x > _maxSize.width - _tagsMarginLeftAndRightForSubView || wantSenderRect.origin.x < _tagsMarginLeftAndRightForSubView) {
        return NO;
    }
    if (wantSenderRect.origin.y > _maxSize.height - _tagsMarginTopAndBottomForSubView || wantSenderRect.origin.y < _tagsMarginTopAndBottomForSubView) {
        return NO;
    }
    if (wantSenderRect.origin.x + wantSenderRect.size.width > _maxSize.width - _tagsMarginLeftAndRightForSubView || wantSenderRect.origin.x + wantSenderRect.size.width < _tagsMarginLeftAndRightForSubView) {
        return NO;
    }
    if (wantSenderRect.origin.y + wantSenderRect.size.height > _maxSize.height - _tagsMarginTopAndBottomForSubView || wantSenderRect.origin.y + wantSenderRect.size.height < _tagsMarginTopAndBottomForSubView) {
        return NO;
    }
    return YES;
}

#pragma mark - 标签按钮数组
- (void)everyOneTags {
    UIButton *button;
    if (_tagsBtnArray == nil) {
        _tagsBtnArray = [[NSMutableArray alloc] init];
    } else {
        [_tagsBtnArray removeAllObjects];
    }
    for (int i = 0; i < self.tagsArray.count; i++) {
        NSString *str = [self.tagsArray objectAtIndex:i];
        button = [[UIButton alloc] init];
        [button setTag:i];
        CGSize strSize = [self theWordSize:str andFont:_tagsFont andCGSize:CGSizeMake(kScreen_Width, kScreen_Height)];
        [button.titleLabel setFont:_tagsFont];
        [button setTitle:str forState:UIControlStateNormal];
        if (_tagsBackgroundColorArray == nil) {
            [button setBackgroundColor:_tagsBackgroundColor];
        } else {
            int colorNumber = (int)_tagsBackgroundColorArray.count;
            [button setBackgroundColor:[_tagsBackgroundColorArray objectAtIndex:i % colorNumber]];
        }
        button.layer.borderColor = _tagsBorderColor.CGColor;
        button.layer.borderWidth = _tagsBorderWidth;
        button.layer.cornerRadius = _tagsBorderCornerRadius;
        button.layer.masksToBounds = YES;
        [button setTitleColor:_tagsWordsColor forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button setFrame:CGRectMake(0, 0, strSize.width + 10, _tagsHeight)];
        [button addTarget:self action:@selector(clickTags:) forControlEvents:UIControlEventTouchUpInside];
        [_tagsBtnArray addObject:button];
    }
}

// 返回刚好包围内容区域的大小Size，当一个元素返行的时候，当前行空余的区域不再计算范围
- (CGSize)returnContentSize {
    return _trueSize;
}

// 初始化各个自定义的参数
- (void)loadParameters {
    if ([@(_maxSize.width) isEqualToNumber:@0.00] || [@(_maxSize.height) isEqualToNumber:@0.00]) {
        _maxSize = CGSizeMake(kScreen_Width, kScreen_Height);
    }
    if (_viewBackgroundColor == nil) {
        _viewBackgroundColor = HexRGB(0xffffff);
    }
    if (_tagsWordsColor == nil) {
        _tagsWordsColor = HexRGB(0x000000);
    }
    if (_tagsBackgroundColor == nil) {
        _tagsBackgroundColor = HexRGB(0xffffff);
    }
    if (_tagsBorderColor == nil) {
        _tagsBorderColor = HexRGB(0xd3d3d3);
    }
    if ([@(_tagsBorderWidth) isEqualToNumber:@0.00]) {
        _tagsBorderWidth = 1;
    }
    if ([@(_tagsBorderCornerRadius) isEqualToNumber:@0.00]) {
        _tagsBorderCornerRadius = 4;
    }
    if ([@(_tagsMargin) isEqualToNumber:@0.00]) {
        _tagsMargin = 5;
    }
    if ([@(_tagsMarginLeftAndRightForSubView) isEqualToNumber:@0.00]) {
        _tagsMarginLeftAndRightForSubView = 10;
    }
    if ([@(_tagsMarginTopAndBottomForSubView) isEqualToNumber:@0.00]) {
        _tagsMarginTopAndBottomForSubView = 10;
    }
    if ([@(_fontSize) isEqualToNumber:@0.00]) {
        _fontSize = 12;
    }
    _tagsFont = [UIFont systemFontOfSize:_fontSize];
    if ([@(_tagsHeight) isEqualToNumber:@0.00]) {
        _tagsHeight = 20;
    }
}

- (void)clickTags:(UIButton *)sender {
    if (_clickRowBlock != nil) {
        _clickRowBlock(sender.tag);
    }
}

- (void)setTagsArray:(NSMutableArray *)array {
    _tagsArray = array;
    if (_contentView != nil) {
        [self refreshData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGSize)theWordSize:(NSString *)str andFont:(UIFont *)font andCGSize:(CGSize)sizeT {
    CGSize size;
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    size = [str boundingRectWithSize:sizeT options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    return size;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
