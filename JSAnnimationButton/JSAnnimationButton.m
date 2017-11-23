//
//  JSAnnimationButton.m
//  Demo_02
//
//  Created by FengDing_Ping on 2017/11/23.
//  Copyright © 2017年 FengDing_Ping. All rights reserved.
//

#import "JSAnnimationButton.h"

@interface JSAnnimationButton ()

@property (nonatomic, assign)CGFloat width;

@property (nonatomic, strong)CALayer *backLayer;

@end

@implementation JSAnnimationButton

- (void)loading {
    
    [self setTitle:@"" forState:UIControlStateNormal];
    self.enabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect rect = self.bounds;
        _width = rect.size.width;
        rect.size.width = rect.size.height;
        self.bounds = rect;
    } completion:^(BOOL finished) {
        [self addRoundAnnimation];
    }];
}

- (void)endLoadingWithTitle:(NSString *)title {
    
    [self removeRoundAnnimation];
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect rect = self.bounds;
        rect.size.width = _width;
        self.bounds = rect;
    } completion:^(BOOL finished) {
        
        [self setTitle:title forState:UIControlStateNormal];
        self.enabled = YES;
    }];
}

- (void)errorWithTitle:(NSString *)title {
    
    [self removeRoundAnnimation];
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect rect = self.bounds;
        rect.size.width = _width;
        self.bounds = rect;
    } completion:^(BOOL finished) {
        
        [self setTitle:title forState:UIControlStateNormal];
        
        [self shakeAnnimation];
        self.enabled = YES;
    }];
    
}

- (void)addRoundAnnimation {
    
    CGFloat height = self.bounds.size.height;
    _backLayer = [CALayer layer];
    _backLayer.backgroundColor = [UIColor redColor].CGColor; //圆环底色
    _backLayer.frame = CGRectMake(0, 0, height, height);
    //创建一个圆环
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(height / 2, height / 2) radius:height * 0.4 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    //圆环遮罩
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 2;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 0.8;
    shapeLayer.lineCap = @"round";
    shapeLayer.lineDashPhase = 0.8;
    shapeLayer.path = bezierPath.CGPath;
    
    //颜色渐变
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)[UIColor redColor].CGColor,(id)[UIColor whiteColor].CGColor, nil];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.shadowPath = bezierPath.CGPath;
    gradientLayer.frame = CGRectMake(0, 0, height, height);
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 0);
    [gradientLayer setColors:[NSArray arrayWithArray:colors]];
    [_backLayer addSublayer:gradientLayer]; //设置颜色渐变
    [_backLayer setMask:shapeLayer]; //设置圆环遮罩
    [self.layer addSublayer:_backLayer];
    
    //旋转
    CABasicAnimation *rotationAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation2.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation2.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    rotationAnimation2.repeatCount = MAXFLOAT;
    //    rotationAnimation2.beginTime = 0.8; //延时执行，注释掉动画会同时进行
    rotationAnimation2.duration = 2;
    
    [_backLayer addAnimation:rotationAnimation2 forKey:@"groupAnnimation"];
    
}

- (void)removeRoundAnnimation {
    
    [_backLayer removeFromSuperlayer];
    _backLayer = nil;
    
}

- (void)shakeAnnimation{
    
    CABasicAnimation *baseAnnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    baseAnnimation.fromValue = @(-5);
    baseAnnimation.toValue = @5;
    baseAnnimation.duration = 0.1;
    baseAnnimation.autoreverses = YES;
    baseAnnimation.repeatCount = 2;
    baseAnnimation.removedOnCompletion = YES;
    [self.layer addAnimation:baseAnnimation forKey:@"baseAnnimation"];
    
}

@end
