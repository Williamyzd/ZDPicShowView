//
//  UIView+ShotMethod.h
//  DaShan
//
//  Created by Zhi-Kuiyu on 14-8-24.
//  Copyright (c) 2014年 dashan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ShotMethod)

@property(nonatomic) CGFloat            left;
@property(nonatomic) CGFloat            top;
@property(nonatomic, readonly) CGFloat  right;
@property(nonatomic, readonly) CGFloat  bottom;
@property(nonatomic) CGFloat            width;
@property(nonatomic) CGFloat            height;
@end
