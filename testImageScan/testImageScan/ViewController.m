//
//  ViewController.m
//  testImageScan
//
//  Created by william on 15/12/14.
//  Copyright © 2015年 william. All rights reserved.
//
#define URL1 @"http://g.hiphotos.baidu.com/zhidao/pic/item/730e0cf3d7ca7bcb849f434ebd096b63f724a8ef.jpg"
#define URL2 @"http://b.hiphotos.baidu.com/zhidao/pic/item/7c1ed21b0ef41bd58cb96c9552da81cb38db3dec.jpg"
#define URL3 @"http://h.hiphotos.baidu.com/zhidao/wh%3D600%2C800/sign=7e8abb04b019ebc4c02d7e9fb216e3c4/94cad1c8a786c9177885d658ca3d70cf3ac757c8.jpg"
#define URL4  @"http://h.hiphotos.baidu.com/zhidao/wh%3D600%2C800/sign=2563b35978f40ad115b1cfe5671c3de7/962bd40735fae6cd54912f000cb30f2442a70fad.jpg"


#import "ViewController.h"
#import "PicShowView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self addTestView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) addTestView{
    PicShowView *pic = [[PicShowView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    pic.imageArray = [NSArray arrayWithObjects:URL1,URL2,URL3,URL4, nil];
    [self.view addSubview:pic];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self addTestView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
