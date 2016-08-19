//
//  DKHelper.h
//  DKLogin
//
//  Created by NaCai on 16/8/19.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKHelper : NSObject

@end

@interface NSString (DKHelper)
- (BOOL)isValidPhoneNumber;
- (BOOL)isValidCodeNumber;
@end