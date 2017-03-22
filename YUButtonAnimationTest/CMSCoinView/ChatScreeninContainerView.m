//
//  ChatScreeninContainerView.m
//  YUButtonAnimationTest
//
//  Created by 于博洋 on 2017/3/22.
//  Copyright © 2017年 于博洋. All rights reserved.
//

#import "ChatScreeninContainerView.h"
#import "ChatScreeninButView.h"
#import "ChatScreeninViewModel.h"


@interface ChatScreeninContainerView () <ChatScreeninButViewDelete>


@property (nonatomic,strong) ChatScreeninButView * chatScreeninButView;

@property (nonatomic,strong) ChatScreeninButView * chatScreeninButView2;

@property (nonatomic,strong) ChatScreeninButView * chatScreeninButView3;

@property (nonatomic,strong) ChatScreeninViewModel * chatScreeninViewModel;

@end


@implementation ChatScreeninContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.chatScreeninButView];
        [self addSubview:self.chatScreeninButView2];
        [self addSubview:self.chatScreeninButView3];
        
        self.chatScreeninButView.center = CGPointMake(self.frame.size.width - 44, self.frame.size.height/2);
        
        self.chatScreeninButView2.center = CGPointMake((self.frame.origin.x + self.frame.size.width)/2 + self.chatScreeninButView2.frame.size.width , self.frame.size.height/4 + self.chatScreeninButView2.frame.size.width);
        
        self.chatScreeninButView3.center = CGPointMake((self.frame.origin.x + self.frame.size.width)/2 + self.chatScreeninButView2.frame.size.width , self.frame.size.height/2 + self.chatScreeninButView2.frame.size.width + 40);
        
        
        [self.chatScreeninViewModel.viewList addObject:self.chatScreeninButView];
        [self.chatScreeninViewModel.viewList addObject:self.chatScreeninButView2];
        [self.chatScreeninViewModel.viewList addObject:self.chatScreeninButView3];
    }
    return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchesPoint = [[touches anyObject] locationInView:self];
    
    ChatScreeninButView * clickChatScreeninButView = nil;
    
    //查询我点击的是那个按钮
    for (int i = 0; i < self.chatScreeninViewModel.viewList.count; i++) {
        ChatScreeninButView * tempChatScreeninButView = self.chatScreeninViewModel.viewList[i];
        if (touchesPoint.x >= tempChatScreeninButView.frame.origin.x && touchesPoint.x <= tempChatScreeninButView.frame.origin.x + tempChatScreeninButView.frame.size.width) {
            if (touchesPoint.y >= tempChatScreeninButView.frame.origin.y && touchesPoint.y <= tempChatScreeninButView.frame.origin.y + tempChatScreeninButView.frame.size.height) {
                
                clickChatScreeninButView = tempChatScreeninButView;
                break;
            }
        }
    }
    
    if (clickChatScreeninButView) {
        
        //查找剩下的是否有正在执行动画的
        BOOL isAnimation = NO;
        for (int i = 0; i < self.chatScreeninViewModel.viewList.count; i++) {
            ChatScreeninButView * tempChatScreeninButView = self.chatScreeninViewModel.viewList[i];
            //筛选出 其他按钮
            if (clickChatScreeninButView != tempChatScreeninButView) {
                
                if (tempChatScreeninButView.isAnimation) {
                    isAnimation = YES;
                    break;
                }
                
            }
        }
        
        //如果有执行动画的不执行当前的动画
        if (!isAnimation) {
            [clickChatScreeninButView tapAction];
        }
        
    }
}


#pragma mark - ChatScreeninButViewDelete

- (void)ChatScreeninButViewDidClick:(UIView *)butView currentType:(ChatScreeninButViewType)currentType {
    [self.chatScreeninViewModel changeOtherViewType:(ChatScreeninButView *)butView currentType:currentType];
}


#pragma mark - getter

-(ChatScreeninViewModel *)chatScreeninViewModel {
    if (_chatScreeninViewModel == nil) {
        _chatScreeninViewModel = [[ChatScreeninViewModel alloc] init];
    }
    return _chatScreeninViewModel;
}

- (ChatScreeninButView *)chatScreeninButView {
    if (_chatScreeninButView == nil) {
        _chatScreeninButView = [[ChatScreeninButView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_chatScreeninButView changeTypeWithType:ChatScreeninButViewTypeNone animation:NO];
        _chatScreeninButView.butViewDelete = self;
        _chatScreeninButView.titleStr = @"距离";
    }
    return _chatScreeninButView;
}

- (ChatScreeninButView *)chatScreeninButView2 {
    if (_chatScreeninButView2 == nil) {
        _chatScreeninButView2 = [[ChatScreeninButView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_chatScreeninButView2 changeTypeWithType:ChatScreeninButViewTypeSelect animation:NO];
        _chatScreeninButView2.butViewDelete = self;
        _chatScreeninButView2.titleStr = @"全部";
    }
    return _chatScreeninButView2;
}

- (ChatScreeninButView *)chatScreeninButView3 {
    if (_chatScreeninButView3 == nil) {
        _chatScreeninButView3 = [[ChatScreeninButView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_chatScreeninButView3 changeTypeWithType:ChatScreeninButViewTypeNone animation:NO];
        _chatScreeninButView3.butViewDelete = self;
        _chatScreeninButView3.titleStr = @"目的";
    }
    return _chatScreeninButView3;
}













@end
