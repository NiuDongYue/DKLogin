//
//  DKLoginViewModel.m
//  DKLogin
//
//  Created by NaCai on 16/8/19.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "DKLoginViewModel.h"
#import "DKHelper.h"
#import "DKProtocols.h"

@interface DKLoginViewModel()
@property(nonatomic, strong) id <DKLoginProtocol> loginModel;
@end

@implementation DKLoginViewModel

- (instancetype)initWithLoginModel:(id <DKLoginProtocol>)model {
    self = [super init];
    if (self) {
        self.loginModel = model;
        [self _setup];
    }
    return self;
}
+ (instancetype)viewModelWithLoginModel:(id <DKLoginProtocol>)model {
    DKLoginViewModel *viewModel = [[DKLoginViewModel alloc] initWithLoginModel:model];
    return viewModel;
}

- (void)_setup{
    @weakify(self);
    RACSignal *requestCodeEnableSignal = [RACObserve(self,phone) map:^id(NSString *value) {
        @strongify(self);
        if ([self.loginModel respondsToSelector:@selector(isValidPhoneNumber:)]) {
            return @([self.loginModel isValidPhoneNumber:value]);
        }
        return @([value isValidPhoneNumber]);
    }];
    self.requestCodeCommand = [[RACCommand alloc] initWithEnabled:requestCodeEnableSignal signalBlock:^RACSignal *(id input) {
        @strongify(self);
        return self.loginModel.codeRequestSignal;
    }];

    RACSignal *loginEnableSignal = [RACSignal combineLatest:@[
            requestCodeEnableSignal,
            [RACObserve(self,code) map:^id(NSString * value) {
                @strongify(self);
                if ([self.loginModel respondsToSelector:@selector(isValidCodeNumber:)]) {
                    return @([self.loginModel isValidCodeNumber:value]);
                }
                return @([value isValidCodeNumber]);
            }]] reduce:^id (NSNumber *first, NSNumber *second){
        return @(first.boolValue && second.boolValue);
    }];
    self.loginCommand = [[RACCommand alloc] initWithEnabled:loginEnableSignal signalBlock:^RACSignal *(id input) {
        @strongify(self);
        return self.loginModel.loginRequestSignal;
    }];
}

- (RACSignal *)timerSignalWithDuration:(NSUInteger)duration {
    __block NSInteger time = duration;
    return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        return [[RACScheduler mainThreadScheduler] after:[NSDate date] repeatingEvery:1 withLeeway:0.0 schedule:^{
            if (time > 0) {
                [subscriber sendNext:@(time).stringValue];
                time --;
            } else{
                [subscriber sendCompleted];
            }
        }];
    }];
}
@end
