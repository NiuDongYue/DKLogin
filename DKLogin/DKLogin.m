//
//  DKLogin.m
//  DKLogin
//
//  Created by NaCai on 16/8/19.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <ReactiveCocoa/RACSignal.h>
#import <ReactiveCocoa/RACScheduler.h>
#import <ReactiveCocoa/RACSubscriber.h>
#import "DKLogin.h"

@implementation DKLogin

- (RACSignal *)loginRequestSignal {
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        [subscriber sendNext:@"1"];
        [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}
- (RACSignal *)codeRequestSignal {
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        [subscriber sendNext:@"1"];
        [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}
- (BOOL)isValidCodeNumber:(NSString *)code {
    return code.length == 4;
}
- (BOOL)isValidPhoneNumber:(NSString *)phone {
    return phone.length == 11;
}
@end
