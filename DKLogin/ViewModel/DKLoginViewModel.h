//
//  DKLoginViewModel.h
//  DKLogin
//
//  Created by NaCai on 16/8/19.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveViewModel/RVMViewModel.h>

@class RACCommand;
@protocol DKLoginProtocol;
@interface DKLoginViewModel : RVMViewModel

@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *code;

@property(nonatomic, strong) RACCommand *loginCommand;

@property(nonatomic, strong) RACCommand *requestCodeCommand;

- (RACSignal *)timerSignalWithDuration:(NSUInteger)duration;

- (instancetype)initWithLoginModel:(id <DKLoginProtocol>)model NS_DESIGNATED_INITIALIZER ;
+ (instancetype)viewModelWithLoginModel:(id <DKLoginProtocol>)model;
@end
