//
//  ZTextAttachment.m
//  Z_PopView
//
//  Created by Lidear on 16/3/24.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import "ZTextAttachment.h"

@implementation ZTextAttachment

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex NS_AVAILABLE_IOS(7_0)
{
    return CGRectMake( 0 , 0 , lineFrag.size.height , lineFrag.size.height );
}

@end
