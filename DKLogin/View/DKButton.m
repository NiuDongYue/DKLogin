//
//  DKButton.m
//  DKLogin
//
//  Created by NaCai on 16/8/19.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import "DKButton.h"
@interface DKButton()
@property(nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@end
@implementation DKButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _setup];
    }

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self _setup];
}

- (void)_setup{
    [self addSubview:self.activityIndicatorView];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
}

#pragma mark - Public methods
- (void)startAnimating{
    self.titleLabel.hidden = YES;
    [self.activityIndicatorView startAnimating];
}
- (void)stopAnimating{
    self.titleLabel.hidden = NO;
    [self.activityIndicatorView stopAnimating];
}

#pragma mark - Override super method
- (void)layoutSubviews {
    [super layoutSubviews];
    self.activityIndicatorView.center = CGPointMake(CGRectGetWidth(self.bounds)/2,CGRectGetHeight(self.bounds)/2);
}

#pragma mark - Getter methods
- (UIActivityIndicatorView *)activityIndicatorView {
    if (_activityIndicatorView == nil) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _activityIndicatorView;
}


@end
