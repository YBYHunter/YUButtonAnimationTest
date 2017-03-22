//
//  ChatScreeninButView.h
//  YUButtonAnimationTest
//
//  Created by 于博洋 on 2017/3/17.
//  Copyright © 2017年 于博洋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ChatScreeninButViewType) {
    ChatScreeninButViewTypeNone,
    ChatScreeninButViewTypeSelect,
    ChatScreeninButViewTypeLoading,
};

@protocol ChatScreeninButViewDelete <NSObject>

- (void)ChatScreeninButViewDidClick:(UIView *)butView currentType:(ChatScreeninButViewType)currentType;

@end

@interface ChatScreeninButView : UIView


@property (nonatomic,weak) id<ChatScreeninButViewDelete> butViewDelete;
//@property (nonatomic, copy) void (^didClickBlock)(BOOL isCanClick);

@property (nonatomic, copy) NSString * titleStr;

@property (nonatomic,assign) ChatScreeninButViewType currentType;

@property (nonatomic,assign) BOOL isAnimation; //正在执行动画

- (void)changeTypeWithType:(ChatScreeninButViewType)type animation:(BOOL)animation;

- (void)tapAction;
















@end
