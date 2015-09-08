//
//  DetailViewController.m
//  DemoLoginAnimation
//
//  Created by david  beckz on 9/9/15.
//  Copyright (c) 2015 Appable. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () {
    
    __weak IBOutlet UIImageView *imgBackground;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [imgBackground setAlpha:0.3];
    [imgBackground setTransform:CGAffineTransformMakeScale(2, 2)];
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:.9 initialSpringVelocity:10.0 options:0 animations:^{
        [imgBackground setAlpha:0.9];
        [imgBackground setTransform:CGAffineTransformMakeScale(1, 1)];
    } completion:^(BOOL finished) {
        [imgBackground setAlpha:1.];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
