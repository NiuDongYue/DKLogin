//
//  DKLoginViewController.m
//  DKLogin
//
//  Created by NaCai on 16/8/19.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import "DKLoginViewController.h"
#import "DKLoginViewModel.h"
#import "DKLogin.h"
#import "DKButton.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface DKLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtCode;
@property (weak, nonatomic) IBOutlet DKButton *btnCode;
@property (weak, nonatomic) IBOutlet DKButton *btnLogin;

@property(nonatomic, strong) DKLoginViewModel *loginViewModel;

@end

@implementation DKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self bindViewAndViewModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)bindViewAndViewModel{
    RAC(self.loginViewModel,phone) = self.txtPhone.rac_textSignal;
    RAC(self.loginViewModel,code) = self.txtCode.rac_textSignal;

    self.btnCode.rac_command = self.loginViewModel.requestCodeCommand;
    self.btnLogin.rac_command = self.loginViewModel.loginCommand;

    @weakify(self);

    void (^disableUIForCode)(BOOL) = ^(BOOL disable){
        @strongify(self);
        self.txtPhone.enabled = !disable;
    };
    self.txtCode.enabled = NO;
    [[self.loginViewModel.requestCodeCommand.executing skip:1] subscribeNext:^(NSNumber *value) {
        @strongify(self);
        if (value.boolValue) {
            disableUIForCode(YES);
            [self.btnCode startAnimating];
        } else {
            self.txtCode.enabled = YES;
            [self.btnCode stopAnimating];
        }
    }];
//    [[[self.loginViewModel.requestCodeCommand.executionSignals switchToLatest] doCompleted:^{
//        @strongify(self);
//        [self.btnCode stopAnimating];
//    }] subscribeNext:^(id x) {
//
//    } completed:^{
//        @strongify(self);
//        [[self.loginViewModel timerSignal] subscribeNext:^(id x) {
//            [self.btnLogin setTitle:x forState:UIControlStateNormal];
//        }];
//    }];
    [self.loginViewModel.requestCodeCommand.executionSignals subscribeNext:^(RACSignal *signal) {
        [signal subscribeCompleted:^{
            @strongify(self);
            [[[[self.loginViewModel timerSignalWithDuration:10] doNext:^(id x) {
                @strongify(self);
                self.btnCode.userInteractionEnabled = NO;
            }] doCompleted:^{
                @strongify(self);
                disableUIForCode(NO);
                self.btnCode.userInteractionEnabled = YES;
                [self.btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
            }] subscribeNext:^(id x) {
                [self.btnCode setTitle:x forState:UIControlStateNormal];
            }];
        }];
    }];

    void (^disableUI) (BOOL) = ^(BOOL disable){
        @strongify(self);
        self.txtPhone.enabled = disable;
        self.txtCode.enabled = disable;
        self.btnCode.enabled = disable;
    };

    [[self.loginViewModel.loginCommand.executing skip:1] subscribeNext:^(NSNumber *value) {
        @strongify(self);
        if (value.boolValue) {
            [self.btnLogin startAnimating];
        } else {
            [self.btnLogin stopAnimating];
        }
        disableUI(!value.boolValue);
    }];

    [self.loginViewModel.loginCommand.executionSignals subscribeNext:^(RACSignal *signal) {
        [signal subscribeNext:^(id x) {
            NSLog(@"x = %@", x);
        } error:^(NSError *error) {
            NSLog(@"error = %@", error);
        } completed:^{
            NSLog(@"completed");
        }];
    }];
}

#pragma mark - Getter methods
- (DKLoginViewModel *)loginViewModel {
    if (_loginViewModel == nil) {
        DKLogin *loginModel = [DKLogin new];
        _loginViewModel = [[DKLoginViewModel alloc] initWithLoginModel:loginModel];
    }
    return _loginViewModel;
}
@end
