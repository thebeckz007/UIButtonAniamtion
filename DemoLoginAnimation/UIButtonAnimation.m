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
    CGRect _pureFrame;
    CGPoint _pureCenter;
    LoginAnimation _animation;
    
    LoadingIndicator *_ldc;
}

static CGFloat duration = 0.8;
static CGFloat delay = 0;
static CGFloat damping = 0.8;
static CGFloat springVelocity = 10;
static CGFloat sizeOfLogin = 50;    // size of button login when zoom out

/*!
 *  @discussion perform animation login
 */
- (void)animationLogin:(LoginAnimation)animation finishBlock:(void (^)(bool finish))block {
    // cache some values
    _animation = animation;
    _pureFrame = self.frame;
    CGRect loginFrame = self.frame;
    loginFrame.origin.x += loginFrame.size.width/ 2.0 - sizeOfLogin/ 2.0;
    loginFrame.size.width = sizeOfLogin;
    loginFrame.size.height = sizeOfLogin;
    
    if (_ldc == nil) {
        // initial loading indicator
        _ldc = [[LoadingIndicator alloc] init];
    }
    
    switch (animation) {
        case LoginAnimationScaleIntoCirle:
        {
            [UIView animateWithDuration:duration - 0.5 delay:delay usingSpringWithDamping:damping initialSpringVelocity:springVelocity options:0 animations:^{
                // scale
                [self setTitle:nil forState:UIControlStateNormal];
                [self setFrame:loginFrame];
            } completion:^(BOOL finished) {
                // show loading indicator
                [_ldc startAnimatingOnBaseView:self];
                
                if (block) {
                    block(YES);
                }
            }];
        }
            break;
            
        case LoginAnimationScaleIntoCirleAndFlyCenter:
        {
            [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:damping - 0.2 initialSpringVelocity:springVelocity options:0 animations:^{
                // scale
                [self setTitle:nil forState:UIControlStateNormal];
                [self setFrame:loginFrame];
                
                // fly to center
                _pureCenter = self.center;
                if (self.superview != nil) {
                    [self setCenter:self.superview.center];
                }
                
            } completion:^(BOOL finished) {
                // show loading indicator
                [_ldc startAnimatingOnBaseView:self];
                
                if (block) {
                    block(YES);
                }
            }];
        }
            break;
            
        case LoginAnimationScaleIntoCirleAndThenFlyCenter:
        {
            [UIView animateWithDuration:duration - 0.5 delay:delay usingSpringWithDamping:damping initialSpringVelocity:springVelocity options:0 animations:^{
                // scale
                [self setTitle:nil forState:UIControlStateNormal];
                [self setFrame:loginFrame];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:damping - 0.2 initialSpringVelocity:springVelocity options:0 animations:^{
                    // fly to center
                    _pureCenter = self.center;
                    if (self.superview != nil) {
                        [self setCenter:self.superview.center];
                    }
                } completion:^(BOOL finished) {
                    // show loading indicator
                    [_ldc startAnimatingOnBaseView:self];
                    
                    if (block) {
                        block(YES);
                    }
                }];
            }];
        }
            break;
            
        default:    // LoginAnimationScaleIntoCirle
        {
            [UIView animateWithDuration:duration - 0.5 delay:delay usingSpringWithDamping:damping initialSpringVelocity:springVelocity options:0 animations:^{
                [self setTitle:nil forState:UIControlStateNormal];
                [self setFrame:loginFrame];
            } completion:^(BOOL finished) {
                // show loading indicator
                [_ldc startAnimatingOnBaseView:self];
                
                if (block) {
                    block(YES);
                }
            }];
        }
            break;
    }
}

/*!
 *  @discussion perform animation move center and blow up
 */
- (void)animationLoginSuccess:(void (^)(bool finish))block {
    if (_ldc == nil) {
        // initial loading indicator
        _ldc = [[LoadingIndicator alloc] init];
    }
    
    [_ldc stopAnimating];
    
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
- (void)animationLoginFailed:(void (^)(bool finish))block {
    if (_ldc == nil) {
        // initial loading indicator
        _ldc = [[LoadingIndicator alloc] init];
    }
    
    [_ldc stopAnimating];
    
    switch (_animation) {
        case LoginAnimationScaleIntoCirle:
        {
            [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:damping - 0.5 initialSpringVelocity:springVelocity options:0 animations:^{
                [self setFrame:_pureFrame];
                [self setTitle:@"Log In" forState:UIControlStateNormal];
            } completion:^(BOOL finished) {
                if (block) {
                    block(YES);
                }
            }];
        }
            break;
            
        case LoginAnimationScaleIntoCirleAndFlyCenter:
        {
            [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:damping - 0.2 initialSpringVelocity:springVelocity + 5.0 options:0 animations:^{
                [self setFrame:_pureFrame];
                [self setTitle:@"Log In" forState:UIControlStateNormal];
            } completion:^(BOOL finished) {
                if (block) {
                    block(YES);
                }
            }];
        }
            break;
            
        case LoginAnimationScaleIntoCirleAndThenFlyCenter:
        {
            [UIView animateWithDuration:duration - 0.5 delay:delay usingSpringWithDamping:damping - 0.2 initialSpringVelocity:springVelocity + 5.0 options:0 animations:^{
                [self setCenter:_pureCenter];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:duration delay:delay + 0.1 usingSpringWithDamping:damping - 0.5 initialSpringVelocity:springVelocity options:0 animations:^{
                    [self setFrame:_pureFrame];
                    [self setTitle:@"Log In" forState:UIControlStateNormal];
                } completion:^(BOOL finished) {
                    if (block) {
                        block(YES);
                    }
                }];
            }];
        }
            break;
            
        default:    // LoginAnimationScaleIntoCirle
        {
            [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:damping - 0.5 initialSpringVelocity:springVelocity options:0 animations:^{
                [self setFrame:_pureFrame];
                [self setTitle:@"Log In" forState:UIControlStateNormal];
            } completion:^(BOOL finished) {
                if (block) {
                    block(YES);
                }
            }];
        }
            break;
    }
}

@end
