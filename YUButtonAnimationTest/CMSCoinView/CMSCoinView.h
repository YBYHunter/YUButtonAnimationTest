//
//  CMSCoinView.h
//  FlipViewTest
//
//  Created by Rebekah Claypool on 10/1/13.
//  Copyright (c) 2013 Coffee Bean Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMSCoinViewDelete <NSObject>

- (void)coinViewDidAnimationEnd:(BOOL)isOpen;

@end

@interface CMSCoinView : UIView

- (id)initWithPrimaryView:(UIView *)view1 andSecondaryView:(UIView *)view2 inFrame:(CGRect)frame;

@property (nonatomic, weak) id<CMSCoinViewDelete> coinViewDelete;

@property (nonatomic, strong) UIView *primaryView;
@property (nonatomic, strong) UIView *secondaryView;
@property (nonatomic, assign) CGFloat spinTime;

-(void)flipTouched:(BOOL)isOpen animation:(BOOL)isAnimation;

@end
