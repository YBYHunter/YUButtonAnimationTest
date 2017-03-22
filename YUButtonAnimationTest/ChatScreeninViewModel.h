//
//  ChatScreeninViewModel.h
//  YUButtonAnimationTest
//
//  Created by 于博洋 on 2017/3/20.
//  Copyright © 2017年 于博洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ChatScreeninButView.h"

@interface ChatScreeninViewModel : NSObject

@property (nonatomic,strong) NSMutableArray * viewList;

@property (nonatomic, copy) void (^didClickBlock)(BOOL isCanClick);

- (void)changeOtherViewType:(ChatScreeninButView *)selectView currentType:(ChatScreeninButViewType)currentType;


@end
