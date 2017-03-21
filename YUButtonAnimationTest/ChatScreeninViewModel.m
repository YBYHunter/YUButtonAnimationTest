//
//  ChatScreeninViewModel.m
//  YUButtonAnimationTest
//
//  Created by 于博洋 on 2017/3/20.
//  Copyright © 2017年 于博洋. All rights reserved.
//

#import "ChatScreeninViewModel.h"

@implementation ChatScreeninViewModel


- (void)changeOtherViewType:(ChatScreeninButView *)selectView currentType:(ChatScreeninButViewType)currentType {
    
    if (currentType == ChatScreeninButViewTypeNone) {
        currentType = ChatScreeninButViewTypeSelect;
    }
    else {
        currentType = ChatScreeninButViewTypeNone;
    }
    
    if (self.viewList.count <= 0) {
        NSLog(@"出错了");
        return;
    }
    else {
        for (int i = 0; i < self.viewList.count; i++) {
            ChatScreeninButView * tempView = self.viewList[i];
            //筛选出 其他按钮
            if (tempView != selectView) {
                //如果状态一样 不需要再执行动画了
                if (currentType != tempView.currentType) {
                    [tempView changeTypeWithType:currentType animation:YES];
                }
                
            }
        }
    }
    
}


-(NSMutableArray *)viewList {
    if (_viewList == nil) {
        _viewList = [[NSMutableArray alloc] init];
    }
    return _viewList;
}


























@end
