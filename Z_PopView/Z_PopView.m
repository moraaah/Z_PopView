//
//  Z_PopView.m
//  UGuang
//
//  Created by Lidear on 16/3/23.
//  Copyright © 2016年 LidearOceanus. All rights reserved.
//

#import "Z_PopView.h"

#define ZShowViewWidh 100
#define ZShowViewBtnHeight 30

@implementation Z_PopView

// 根据传入的items初始化
- (instancetype)initWithArray:(NSArray *)array
{
    self = [[Z_PopView alloc] initWithFrame:CGRectMake(0, 0, ZShowViewWidh, ZShowViewBtnHeight*array.count)];
    [self createSubViews:array];
    self.backgroundColor = [UIColor blackColor];
    return self;
}

// 根据items创建视图
- (void)createSubViews:(NSArray *)array
{
    for (int i = 0; i < array.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, ZShowViewBtnHeight*i, ZShowViewWidh, ZShowViewBtnHeight)];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(chooseItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

// 显示
- (void)showInView:(UIView *)view baseView:(UIView *)baseView withPosition:(ZShowPosition)position
{
    CGPoint point = baseView.frame.origin;
    CGSize size = baseView.frame.size;
    CGPoint center = baseView.center;
    switch (position) {
        case ZShowTop:
        {
            self.center = CGPointMake(center.x, center.x - self.frame.size.height / 2.0 - size.height / 2.0);
            [self add_self:view];
        }
            break;
            
        case ZShowLeft:
        {
            self.frame = CGRectMake(point.x - size.width, point.y + size.height / 2.0, self.frame.size.width, self.frame.size.height);
            [self add_self:view];
        }
            
            break;
            
        case ZShowBottom:
        {
            self.center = CGPointMake(center.x, center.y + self.frame.size.height / 2.0 + size.height / 2.0);
            [self add_self:view];
        }
            break;
            
        default:
        {
            self.frame = CGRectMake(point.x + size.width, point.y + size.height / 2.0, self.frame.size.width, self.frame.size.height);;
            [self add_self:view];
        }
            break;
    }
}

// 添加到指定视图上
- (void)add_self:(UIView *)view
{
    [view addSubview:self];
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 1.0;
    }];
}

// 选择item时回调
- (void)chooseItem:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (_chooseBlock) {
        _chooseBlock(btn.titleLabel.text);
        [UIView animateWithDuration:.3 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

@end
