//
//  PicShowView.h
//  ZDPictureShowView
//
//  Created by CHENYI LONG on 15/12/3.
//  Copyright © 2015年 william. All rights reserved.
//
#import <UIKit/UIKit.h>
 typedef void(^contentStringBlock)(UILabel *lable);
@interface PicShowView : UIScrollView <UIScrollViewDelegate>
@property (nonatomic,strong) NSArray *imageArray ;
@end

//下方的文字内容scroll
@interface ContentScroll : UIScrollView <UIScrollViewDelegate>
@property (nonatomic,strong,readwrite) UILabel *contentLable;
@property (nonatomic,copy) contentStringBlock myBlock;
- (void)setContentLableWithString:(NSString*)string;
@end