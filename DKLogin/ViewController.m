//
//  ViewController.m
//  DKLogin
//
//  Created by NaCai on 16/8/16.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import "ViewController.h"
#import "DKLoginViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    DKLoginViewController *controller = [[DKLoginViewController alloc] initWithNibName:@"DKLoginViewController" bundle:nil];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
