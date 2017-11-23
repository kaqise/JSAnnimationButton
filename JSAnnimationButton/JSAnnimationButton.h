//
//  JSAnnimationButton.h
//  Demo_02
//
//  Created by FengDing_Ping on 2017/11/23.
//  Copyright © 2017年 FengDing_Ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSAnnimationButton : UIButton

//加载
- (void)loading;

//结束加载
- (void)endLoadingWithTitle:(NSString *)title;

//失败结束加载
- (void)errorWithTitle:(NSString *)title;


@end
