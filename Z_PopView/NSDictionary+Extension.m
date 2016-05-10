//
//  NSDictionary+Extension.m
//  Z_PopView
//
//  Created by Lidear on 16/4/22.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import "NSDictionary+Extension.h"

#define isNULL(object) (object== NULL||object==nil||[object isEqual:[NSNull null]])

@implementation NSDictionary (Extension)

- (void)setExistValue:(id)value forKey:(NSString *)key
{
    if(!isNULL(value)) {
        [self setValue:value forKey:key];
    }
}

@end
