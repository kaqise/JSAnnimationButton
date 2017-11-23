//
//  ViewController.m
//  JSAnnimationButton
//
//  Created by FengDing_Ping on 2017/11/23.
//  Copyright © 2017年 FengDing_Ping. All rights reserved.
//

#import "ViewController.h"
#import "JSAnnimationButton.h"

@interface ViewController ()

@property (nonatomic, strong)JSAnnimationButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _button = [[JSAnnimationButton alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    _button.center = self.view.center;
    _button.backgroundColor = [UIColor blueColor];
    _button.layer.cornerRadius = 25;
    [_button setTitle:@"开始" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}

- (void)buttonAction{
    
    [_button loading];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_button errorWithTitle:@"请求失败"];
    });
    
}


@end
