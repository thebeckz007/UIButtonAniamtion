//
//  UIButtonAnimation.h
//  DemoLoginAnimation
//
//  Created by david  beckz on 8/18/15.
//  Copyright (c) 2015 Appable. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButtonAnimation : UIButton

- (void)animationLogin:(void (^)(bool finish))block;

- (void)animationLoginFailed:(void (^)(bool finish))block;

- (void)animationLoginSuccess:(void (^)(bool finish))block;

@end
