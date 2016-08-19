//
//  DKHelper.m
//  DKLogin
//
//  Created by NaCai on 16/8/19.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import "DKHelper.h"

@implementation DKHelper

@end

@implementation NSString (DKHelper)

- (BOOL)isValidPhoneNumber {
    return self.length == 11;
}
- (BOOL)isValidCodeNumber {
    return self.length == 4;
}
@end