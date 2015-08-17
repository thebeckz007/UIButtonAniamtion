//
//  LoadingIndicator.m
//  demoUIViewAnimation
//
//  Created by david  beckz on 8/16/15.
//  Copyright (c) 2015 Appable VN. All rights reserved.
//

#import "LoadingIndicator.h"

@implementation LoadingIndicator {
    UIImageView *imgLoading;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        imgLoading = [[UIImageView alloc] init];
        [imgLoading setFrame:CGRectMake(0, 0, 35, 35)];
        [imgLoading setImage:[UIImage imageNamed:@"loading2"]];
    }
    
    return self;
}

- (void)startAnimatingOnBaseView:(UIView *)baseView {
    [baseView addSubview:imgLoading];
    [imgLoading setCenter:CGPointMake(baseView.bounds.size.width/ 2.0, baseView.bounds.size.height/ 2.0)];
    
    CABasicAnimation * rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    rotateAnimation.duration = 1.0f;
    rotateAnimation.repeatDuration = HUGE_VALF;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.fillMode = kCAFillModeForwards;
    [imgLoading.layer addAnimation:rotateAnimation forKey:@"rotation"];
}

- (void)stopAnimating {
    [imgLoading.layer removeAllAnimations];
    [imgLoading removeFromSuperview];
}

@end
