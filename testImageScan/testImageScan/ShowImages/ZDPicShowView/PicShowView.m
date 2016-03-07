//
//  PicShowView.m
//  ZDPictureShowView
//
//  Created by CHENYI LONG on 15/12/3.
//  Copyright © 2015年 william. All rights reserved.
//
#define COMMENTSIZE      CGSizeMake(100, 30)
#define WINDOWSIZE       [UIScreen mainScreen].bounds.size
#define MARGINLEFT           10
#define MARGINTOP            20
#define MARGINBUTTOM         30
#define OFFSET                5
#define CONTENTHIGHT         70
#define TITTLEWIDTH          (WINDOWSIZE.width -2 *MARGINLEFT)*0.8
#define FONTSIZE              [UIFont systemFontOfSize:16]
#define FONTCOLOR            [UIColor colorWithWhite:1 alpha:.6]

#import "PicShowView.h"
#import "Masonry.h"
#import "UIView+ShotMethod.h"
#import "UIImageView+WebCache.h"
#import "ZDPicDetailView.h"
@implementation ContentScroll
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = YES;
    self.contentSize = WINDOWSIZE;
    self.backgroundColor = [UIColor clearColor];
    self.scrollEnabled = YES;
    UILabel *contentLable = [[UILabel alloc] init];
    contentLable.numberOfLines =0;
    contentLable.lineBreakMode = NSLineBreakByCharWrapping;
    contentLable.textColor = FONTCOLOR;
    contentLable.font = [UIFont systemFontOfSize:13];
    contentLable.textAlignment = NSTextAlignmentLeft;
     [self  addSubview:contentLable];
    self.contentLable = contentLable;
    return self;
}

- (void)setContentLableWithString:(NSString*)string{
    self.contentLable.text = string;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    dic[NSParagraphStyleAttributeName] = paragraphStyle.copy;
    CGRect rect = [self.contentLable.text boundingRectWithSize:CGSizeMake(WINDOWSIZE.width - 2*MARGINLEFT, MAXFLOAT) options:NSStringDrawingUsesDeviceMetrics|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    self.contentLable.frame = rect;
    //[self.contentLable sizeToFit];

  self.contentSize =CGSizeMake(100, self.contentLable.height+5);
}
@end
@interface PicShowView (){
    int currentPage;
    
    CGFloat   scale;
    BOOL      isHiden;
  }
//返回按钮
@property (nonatomic,weak)UIButton *backBtn;
@property (nonatomic,weak)UIButton  *commentBtn;
@property (nonatomic, weak)ContentScroll *contentScr;
@property (nonatomic,weak)UILabel  *tittleLable;
@property (nonatomic,weak)UILabel  *contentLable;
@property (nonatomic,weak)UILabel  *countLable;
@end

@implementation PicShowView
//初始化
- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    //加载视图
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setUI];
    });
    
    self.delegate = self;
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor blackColor];
    currentPage = 0;
    isHiden   = NO;
    return self;
}

#pragma mark----添加视图
- (void)setUI{
    //获取控制器的view
    UIView *ctrView = [[self viewController] view];
    
    //返回按钮
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"button_setting_back"] forState:UIControlStateNormal];
    [ctrView addSubview:backBtn];
    [backBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(MARGINTOP);
        make.left.equalTo(self).with.offset(MARGINLEFT);
        make.size.mas_equalTo(backBtn.currentBackgroundImage.size);
    }];
    [backBtn addTarget:self action:@selector(back_click:) forControlEvents:UIControlEventTouchUpInside];
    self.backBtn = backBtn;
    
    //评论数
    UIButton *cmtBtn = [[UIButton alloc] init];
    [ctrView addSubview:cmtBtn];
    [cmtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-MARGINLEFT);
        make.top.equalTo(backBtn);
        make.size.mas_equalTo(COMMENTSIZE);
    }];
    [cmtBtn setBackgroundColor:[UIColor redColor]];
    cmtBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    cmtBtn.titleLabel.contentMode = UIViewContentModeScaleToFill;
    cmtBtn.titleLabel.font = FONTSIZE;
    cmtBtn.titleLabel.textColor = FONTCOLOR;
    [cmtBtn sizeToFit];
    self.commentBtn = cmtBtn;
    
    //新闻内容
//    ContentScroll *contentScr = [[ContentScroll alloc] initWithFrame:CGRectMake(MARGINLEFT, WINDOWSIZE.height - MARGINBUTTOM -CONTENTHIGHT, WINDOWSIZE.width-2*MARGINLEFT, CONTENTHIGHT)];
    ContentScroll *contentScr = [[ContentScroll alloc] init];
    [ctrView addSubview:contentScr];
    [contentScr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backBtn);
        make.right.equalTo(cmtBtn);
        make.bottom.equalTo(self).offset(-MARGINBUTTOM);
        make.height.mas_equalTo(CONTENTHIGHT);
        
    }];
    self.contentLable = contentScr.contentLable;
    self.contentScr = contentScr;
    
    //标题
    UILabel *tittleLable = [[UILabel alloc] init];
    [ctrView addSubview:tittleLable];
    [tittleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(contentScr.mas_top);
        make.left.equalTo(self).with.offset(MARGINLEFT);
        //make.right.equalTo(self).with.offset(-MARGINLEFT);
        make.width.mas_equalTo(TITTLEWIDTH);
        make.height.mas_equalTo(COMMENTSIZE.height);
    }];
    tittleLable.textAlignment = NSTextAlignmentLeft;
    tittleLable.backgroundColor= [UIColor clearColor];
    tittleLable.font = FONTSIZE;
    tittleLable.textColor = FONTCOLOR;
    self.tittleLable = tittleLable;
    
    //分页标示
    UILabel *countLable = [[UILabel alloc] init];
    [ctrView addSubview:countLable];
    [countLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(contentScr.mas_top);
        make.right.equalTo(self).with.offset(-MARGINLEFT);
        make.left.equalTo(tittleLable.mas_right);
        make.height.equalTo(tittleLable);
    }];
    countLable.backgroundColor = [UIColor clearColor];
    countLable.font = [UIFont systemFontOfSize:15];
    countLable.textColor = [UIColor colorWithWhite:1 alpha:.6];
    countLable.textAlignment = NSTextAlignmentRight;
    [ctrView addSubview:countLable];
    self.countLable = countLable;

    
}


//获取当前控制器
- (UIViewController *)viewController{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}



#pragma mark---返回
- (void)back_click:(UIButton *)sender{
    [self removeViews];
    [self removeFromSuperview];
   
}

//移除添加的视图
- (void)removeViews{
    [self.contentScr removeFromSuperview];
    [self.commentBtn removeFromSuperview];
    [self.tittleLable removeFromSuperview];
    [self.countLable removeFromSuperview];
    [self.backBtn removeFromSuperview];
}
#pragma mark--- 加载数据
- (void)setImageArray:(NSArray *)imageArray{
    
    _imageArray = [imageArray copy];
    
    self.contentSize = CGSizeMake(self.width * imageArray.count, 0);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self LoadContentDataWithArray:_imageArray];
    });
    for(int i = 0 ; i < imageArray.count ; i++){

        ZDPicDetailView *sc = [[ZDPicDetailView alloc] initWithFrame:CGRectMake(self.width * i, 0, self.width, self.height) imageUrl:[imageArray objectAtIndex:i]];
        [sc setSingleTapBlock:^{
            [self hiddenAction];
        }];
        [self addSubview:sc];
    
    }
    
}

//加载内容

- (void)LoadContentDataWithArray:(NSArray *)array{
   
        self.countLable.text = [NSString stringWithFormat:@"%d/%zd",currentPage + 1 ,_imageArray.count];
        [self.commentBtn setTitle:[NSString stringWithFormat:@"100%zd跟帖",currentPage+1] forState:UIControlStateNormal];
        self.tittleLable.text =  [NSString stringWithFormat:@"第%zd个标题",currentPage+1];
    NSString *string =[NSString stringWithFormat:@"详情%zd任何平台都有自己的公开规则，我们打开任何一个平台的使用说明里都会有相关规则，比如不能诱导分享、不得滥用服务平台等。纯自由形态下的互联网平台，智慧沦为互联网垃圾的滋生池，而不会有任何有价值的内容突出，规则是必然的。微信公众平台亦如此官方的微信公众平台会实时推出相关规则，让更多用户能够在规则下受益。企业做微信公众号首先应该避免的是，触碰到平台的规则红线。当然，可能会有人怀疑，会不会像Uber，遭遇不明不白的利益冲突式封杀呢？假如有一天自己企业的微信公众号被因为和腾讯出现利益问题，会不会也遭到封杀呢.如果用这种心态，想要在别的平台下生存，那互联网就没有纯净之地了。2014年11月25日，微博开启了对微信的清理之路，新浪市场营销官方微博发出信息：“明天中午（11月26日）12点前如果账号没有清除掉公众账号的推广（包括背景图、粉丝服务后台、微博正文引导等）将面临禁言和封号的可能。”2015年1月，豌豆荚发公开信称奇遭到百度手机助手封杀， 当时豌豆荚还很可笑的宣称“豌豆荚不会“以暴制暴”，屏蔽百度手机助手，我们相信在这个依然开放的世界，沟通最终可以解决问题。”，而实际上到了2015年10月份，豌豆荚对百度多款APP均进行了封杀行为。我们打开任何一个平台的使用说明里都会有相关规则，比如不能诱导分享、不得滥用服务平台等。纯自由形态下的互联网平台，智慧沦为互联网垃圾的滋生池，而不会有任何有价值的内容突出，规则是必然的。微信公众平台亦如此官方的微信公众平台会实时推出相关规则，让更多用户能够在规则下受益。企业做微信公众号首先应该避免的是，触碰到平台的规则红线。当然，可能会有人怀疑，会不会像Uber，遭遇不明不白的利益冲突式封杀呢?平台的使用说明里都会有相关规则，比如不能诱导分享、不得滥用服务平台等。纯自由形态下的互联网平台，智慧沦为互联网垃圾的滋生池，而不会有任何有价值的内容突出，规则是必然的。微信公众平台亦如此官方的微信公众平台会实时推出相关规则，让更多用户能够在规则下受益。企业做微信公众号首先应该避免的是，触碰到平台的规则红线。当然，可能会有人怀疑，会不会像Uber，遭遇不明不白的利益冲突式封杀呢？假如有一天自己企业的微信公众号被因为和腾讯出现利益问题，会不会也遭到封杀呢.如果用这种心态，想要在别的平台下生存，那互联网就没有纯净之地了。2014年11月25日，微博开启了对微信的清理之路，新浪市场营销官方微博发出信息：“明天中午（11月26日）12点前如果账号没有清除掉公众账号的推广（包括背景图、粉丝服务后台、微博正文引导等）将面临禁言和封号的可能。”2015年1月，豌豆荚发公开信称奇遭到百度手机助手封杀， 当时豌豆荚还很可笑的宣称“豌豆荚不会“以暴制暴”，屏蔽百度手机助手，我们相信在这个依然开放的世界，沟通最终可以解决问题。”，而实际上到了2015年10月份，豌豆荚对百度多款APP均进行了封杀行为。我们打开任何一个平台的使用说明里都会有相关规则，比如不能诱导分享、不得滥用服务平台等。纯",currentPage+1];
    [self.contentScr setContentLableWithString:string];
    }

//单击隐藏/显示
- (void)hiddenAction{
    isHiden = !isHiden;
    
    [UIView animateWithDuration:.5 animations:^{
        self.commentBtn.hidden = isHiden;
        self.tittleLable.hidden = isHiden;
        self.countLable.hidden = isHiden;
        self.contentScr.hidden =isHiden;
    }];
    
}
#pragma mark---- 代理方法
// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int page = round(scrollView.contentOffset.x / scrollView.width);
    if(page == currentPage)
        return;
    currentPage = page;
    scale = 0;
    if (currentPage<_imageArray.count) {
        [self LoadContentDataWithArray:_imageArray];
    }
    
    NSLog(@"scrollViewDidEndDecelerating");
    
}

//拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if(scrollView ==self){
        for(UIScrollView * sc in scrollView.subviews){
            if(sc.zoomScale != 1){
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [sc setZoomScale:1 animated:NO];
                    
                });
            }
        }
    }
}


// 当滚动视图动画完成后，调用该方法，如果没有动画，那么该方法将不被调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSLog(@"scrollViewDidEndScrollingAnimation");
    
    if(scrollView == self){
        for(UIScrollView * sc in scrollView.subviews){
            if(sc.zoomScale != 1){
                [sc setZoomScale:1 animated:YES];
            }
        }
    }
}

@end
