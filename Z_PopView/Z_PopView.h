//
//  Z_PopView.h
//  UGuang
//
//  Created by Lidear on 16/3/23.
//  Copyright © 2016年 LidearOceanus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZShowPosition) {
    ZShowTop       = 0,
    ZShowLeft      = 1,
    ZShowBottom    = 2,
    ZShowRight     = 3,
}; //显示的位置

typedef void(^ChooseBlock)(NSString *choose); //选择item后的block回调

@interface Z_PopView : UIView

@property (nonatomic, copy) ChooseBlock chooseBlock;  //block

// 自定义选择项并初始化
- (instancetype)initWithArray:(NSArray *)array;

// 展示 view是指展示的view  baseView是指哪个控件
- (void)showInView:(UIView *)view baseView:(UIView *)baseView withPosition:(ZShowPosition)position;

@end
