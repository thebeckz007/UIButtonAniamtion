//
//  ViewController.m
//  DemoLoginAnimation
//
//  Created by david  beckz on 8/16/15.
//  Copyright (c) 2015 Appable. All rights reserved.
//

#import "ViewController.h"

#import <QuartzCore/QuartzCore.h>
#import "LoadingIndicator.h"
#import "UIButtonAnimation.h"

@interface ViewController () {
    UIButtonAnimation *btn;
    __weak IBOutlet UITextField *txtCode;
    __weak IBOutlet UILabel *lblStatus;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // initial button login
    CGRect mainFrame = self.view.bounds;
    CGRect btnFrame = CGRectMake(0, 0, 300, 50);
    btnFrame.origin.x = (mainFrame.size.width - btnFrame.size.width)/ 2.0;
    btnFrame.origin.y = mainFrame.size.height - btnFrame.size.height - 20;
    btn = [[UIButtonAnimation alloc] initWithFrame:btnFrame];
    [btn.layer setCornerRadius:25];
    [btn setBackgroundColor:[UIColor purpleColor]];
    [btn addTarget:self action:@selector(button_Tapped:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:0];
    [btn setTitle:@"Log In" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [txtCode setHidden:NO];
    [lblStatus setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)button_Tapped:(UIButton *)sender {
    UIButtonAnimation *btnLogin = (UIButtonAnimation *)sender;
    __weak ViewController *weakSelf = self;
    [btnLogin animationLogin:^(bool finish) {
        if (weakSelf) {
            [weakSelf login];
        }
    }];
}

- (void)login {
    [txtCode setHidden:YES];
    [lblStatus setHidden:NO];
    lblStatus.text = @"Checking ........";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([txtCode.text isEqualToString:@"123"]) {
            // success
            [btn animationBlowUpCenter:^(bool finish) {
                [txtCode setHidden:YES];
                [lblStatus setText:@"Success"];
            }];
        } else {
            // failed
            [btn rollbackLoginAnimation:^(bool finish) {
                [txtCode setHidden:NO];
                [lblStatus setText:@"Failed"];
            }];
        }
    });
}
@end
