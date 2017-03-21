//
//  CMSCoinView.m
//  FlipViewTest
//
//  Created by Rebekah Claypool on 10/1/13.
//  Copyright (c) 2013 Coffee Bean Studios. All rights reserved.
//

#import "CMSCoinView.h"


@interface CMSCoinView () {
    
    
}
@end

@implementation CMSCoinView

@synthesize primaryView=_primaryView, secondaryView=_secondaryView, spinTime;

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){

        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithPrimaryView:(UIView *)primaryView andSecondaryView:(UIView *)secondaryView inFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.primaryView = primaryView;
        self.secondaryView = secondaryView;
    }
    return self;
}


- (void)setPrimaryView:(UIView *)primaryView {
    _primaryView = primaryView;
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.primaryView setFrame:frame];
    self.primaryView.userInteractionEnabled = NO;
    [self addSubview:self.primaryView];
}

- (void)setSecondaryView:(UIView *)secondaryView {
    _secondaryView = secondaryView;
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.secondaryView setFrame:frame];
    self.secondaryView.userInteractionEnabled = YES;
    [self addSubview:self.secondaryView];
    [self sendSubviewToBack:self.secondaryView];
}


-(void)flipTouched:(BOOL)isOpen animation:(BOOL)isAnimation {
    if (isAnimation) {
        [UIView transitionFromView:(isOpen ? self.primaryView : self.secondaryView)
                            toView:(isOpen ? self.secondaryView : self.primaryView)
                          duration:spinTime
                           options:UIViewAnimationOptionTransitionFlipFromLeft+UIViewAnimationOptionCurveEaseInOut
                        completion:^(BOOL finished) {
                            if (finished) {
                                if ([self.coinViewDelete respondsToSelector:@selector(coinViewDidAnimationEnd:)]) {
                                    [self.coinViewDelete coinViewDidAnimationEnd:isOpen];
                                }
                                
                            }
                        }
         ];
    }
    else {
        [UIView transitionFromView:(isOpen ? self.primaryView : self.secondaryView)
                            toView:(isOpen ? self.secondaryView : self.primaryView)
                          duration:0
                           options:UIViewAnimationOptionTransitionFlipFromLeft+UIViewAnimationOptionCurveEaseInOut
                        completion:^(BOOL finished) {
                            if (finished) {
                                if ([self.coinViewDelete respondsToSelector:@selector(coinViewDidAnimationEnd:)]) {
                                    [self.coinViewDelete coinViewDidAnimationEnd:isOpen];
                                }
                                
                            }
                        }
         ];
    }
    
    
}











@end
