//
//  UIButton+UIButtonImageWithLabel.m
//  Z_PopView
//
//  Created by Lidear on 16/4/5.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import "UIButton+UIButtonImageWithLabel.h"

@implementation UIButton (UIButtonImageWithLabel)

- (void)setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType
{
    CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:12]];
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-8.0, 0, 0, 0)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
    [self setTitle:title forState:stateType];
}

@end
