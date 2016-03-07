//
//  ZDPicDetailView.h
//  testImageScan
//
//  Created by william on 16/3/7.
//  Copyright © 2016年 william. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDPicDetailView : UIScrollView<UIScrollViewDelegate>
//初始化
@property (nonatomic,copy)void(^singleTapBlock)();
- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName;
- (instancetype) initWithFrame:(CGRect)frame imageUrl:(NSString*)imageUrl;
//- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)img;
@end
