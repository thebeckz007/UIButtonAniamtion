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
    UIButtonAnimation *btnLogin;
    __weak IBOutlet UITextField *txtCode;
    __weak IBOutlet UILabel *lblStatus;
    __weak IBOutlet UIScrollView *scrView;
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
    btnLogin = [[UIButtonAnimation alloc] initWithFrame:btnFrame];
    [btnLogin.layer setCornerRadius:25];
    [btnLogin setBackgroundColor:[UIColor purpleColor]];
    [btnLogin addTarget:self action:@selector(button_Tapped:) forControlEvents:UIControlEventTouchUpInside];
    [btnLogin setTitle:@"Log In" forState:UIControlStateNormal];
    [self.view addSubview:btnLogin];
    
    [txtCode setHidden:NO];
    [lblStatus setHidden:YES];
    
    // register manage keyboard
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)button_Tapped:(UIButton *)sender {
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
    lblStatus.text = @"Checking......";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([txtCode.text isEqualToString:@"123"]) {
            // success
            [btnLogin animationLoginSuccess:^(bool finish) {
                [txtCode setHidden:YES];
                [lblStatus setText:@"Success"];
            }];
        } else {
            // failed
            [btnLogin animationLoginFailed:^(bool finish) {
                [txtCode setHidden:NO];
                [lblStatus setText:@"Failed"];
            }];
        }
    });
}

#pragma mark - Manage event show and hide Keyboard
- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrView.contentInset = contentInsets;
    scrView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, txtCode.frame.origin) ) {
        [scrView scrollRectToVisible:txtCode.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrView.contentInset = contentInsets;
    scrView.scrollIndicatorInsets = contentInsets;
}
@end
