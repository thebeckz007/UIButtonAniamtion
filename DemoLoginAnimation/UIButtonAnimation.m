//
//  UIButtonAnimation.m
//  DemoLoginAnimation
//
//  Created by david  beckz on 8/18/15.
//  Copyright (c) 2015 Appable. All rights reserved.
//

#import "UIButtonAnimation.h"
#import "LoadingIndicator.h"

@implementation UIButtonAnimation {
    CGRect pureFrame;
    LoadingIndicator *ldc;
}

static CGFloat duration = 0.8;
static CGFloat delay = 0;
static CGFloat damping = 0.9;
static CGFloat springVelocity = 10;
static CGFloat sizeOfLogin = 50;    // size of button login when zoom out

/*!
 *  @discussion perform animation login
 */
- (void)animationLogin:(void (^)(bool finish))block {
    pureFrame = self.frame;
    CGRect loginFrame = self.frame;
    loginFrame.origin.x += loginFrame.size.width/ 2.0 - sizeOfLogin/ 2.0;
    loginFrame.size.width = sizeOfLogin;
    loginFrame.size.height = sizeOfLogin;
    
    if (ldc == nil) {
        // initial loading indicator
        ldc = [[LoadingIndicator alloc] init];
    }
    
    [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:damping initialSpringVelocity:springVelocity options:0 animations:^{
        [self setTitle:nil forState:UIControlStateNormal];
        [self setFrame:loginFrame];
    } completion:^(BOOL finished) {
        // show loading indicator
        [ldc startAnimatingOnBaseView:self];
        
        if (block) {
            block(YES);
        }
    }];
}

/*!
 *  @discussion perform animation move center and blow up
 */
- (void)animationBlowUpCenter:(void (^)(bool finish))block {
    if (ldc == nil) {
        // initial loading indicator
        ldc = [[LoadingIndicator alloc] init];
    }
    
    [ldc stopAnimating];
    // aniamtion blow up
    [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:damping initialSpringVelocity:springVelocity + 5 options:0 animations:^{
        //
        if (self.superview != nil) {
            [self setCenter:self.superview.center];
        }
        
        [self setTransform:CGAffineTransformMakeScale(20, 20)];
        [self setAlpha:0.3];
    } completion:^(BOOL finished) {
        [self setHidden:YES];
        [self setTransform:CGAffineTransformMakeScale(1, 1)];
        [self setAlpha:1.0];
        
        if (block) {
            block(YES);
        }
    }];
}

/*!
 *  @discussion roll back animation
 */
- (void)rollbackLoginAnimation:(void (^)(bool finish))block {
    if (ldc == nil) {
        // initial loading indicator
        ldc = [[LoadingIndicator alloc] init];
    }
    
    [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:damping - 0.5 initialSpringVelocity:springVelocity options:0 animations:^{
        [ldc stopAnimating];
        [self setFrame:pureFrame];
        [self setTitle:@"Log In" forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        if (block) {
            block(YES);
        }
    }];
}

@end
