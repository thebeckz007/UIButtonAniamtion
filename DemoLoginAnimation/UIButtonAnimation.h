//
//  UIButtonAnimation.h
//  DemoLoginAnimation
//
//  Created by david  beckz on 8/18/15.
//  Copyright (c) 2015 Appable. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LoginAnimationScaleIntoCirle = 0,                   // scale button into circle
    LoginAnimationScaleIntoCirleAndFlyCenter,           // scale button into circle and fly to center of super view
    LoginAnimationScaleIntoCirleAndThenFlyCenter,       // scale button into circle and then fly to center of super view
} LoginAnimation;

@interface UIButtonAnimation : UIButton

- (void)animationLogin:(LoginAnimation)animation finishBlock:(void (^)(bool finish))block;

- (void)animationLoginFailed:(void (^)(bool finish))block;

- (void)animationLoginSuccess:(void (^)(bool finish))block;

@end
