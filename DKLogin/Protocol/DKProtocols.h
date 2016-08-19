//
//  DKProtocols.h
//  DKLogin
//
//  Created by NaCai on 16/8/19.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <objc/NSObject.h>

@class RACSignal;

#ifndef DKProtocols_h
#define DKProtocols_h


#endif /* DKProtocols_h */

@protocol DKLoginProtocol <NSObject>
@required
- (RACSignal *)loginRequestSignal;
- (RACSignal *)codeRequestSignal;
@optional
- (BOOL)isValidPhoneNumber:(NSString *)phone;
- (BOOL)isValidCodeNumber:(NSString *)code;
@end