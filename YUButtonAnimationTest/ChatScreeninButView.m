//
//  ChatScreeninButView.m
//  YUButtonAnimationTest
//
//  Created by 于博洋 on 2017/3/17.
//  Copyright © 2017年 于博洋. All rights reserved.
//

#import "ChatScreeninButView.h"
#import "CMSCoinView.h"
#import "UIView+addition.h"
#import "UIImageView+CornerRadius.h"


static CGFloat const kDuration = 0.1f; //动画持续时间(秒)
static CGFloat const flipDuration = 0.2f; //翻转持续时间(秒)
static CGFloat const sideBorderWidth = 5;

#define RGBONLYCOLOR(x) [UIColor colorWithRed:(x)/255.0 green:(x)/255.0 blue:(x)/255.0 alpha:1]
#define RGBAONLYCOLOR(x,a) [UIColor colorWithRed:(x)/255.0 green:(x)/255.0 blue:(x)/255.0 alpha:(a)]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface ChatScreeninButView ()<CMSCoinViewDelete>

@property (nonatomic,strong) UIView * hobbyView;    //最小圆
@property (nonatomic,strong) UIView * midView;      //中间圆
@property (nonatomic,strong) UIView * bottomView;   //最大圆

@property (nonatomic,strong) CMSCoinView * flipView;//需要同hobbyView颜色一样

@property (nonatomic,strong) UILabel * titleLab1;   //添加在翻转动画上(为了实现-文字能在动画中翻转)
@property (nonatomic,strong) UILabel * titleLab2;   //添加在翻转动画上
@property (nonatomic,strong) UIActivityIndicatorView * activityIndicator;

@end



@implementation ChatScreeninButView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.bottomView];
        [self addSubview:self.midView];
        [self addSubview:self.hobbyView];
        
        [self addSubview:self.flipView];
        
        [self addSubview:self.activityIndicator];
        
        _isAnimation = NO;
        
    }
    return self;
}

- (void)tapAction {

    _isAnimation = YES;
    if (self.currentType == ChatScreeninButViewTypeNone) {
        [self changeTypeWithType:ChatScreeninButViewTypeLoading animation:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self changeTypeWithType:ChatScreeninButViewTypeSelect animation:YES];
        });
    }
    else if(self.currentType == ChatScreeninButViewTypeSelect){

    }
    
    
    if ([self.butViewDelete respondsToSelector:@selector(ChatScreeninButViewDidClick:currentType:)]) {
        [self.butViewDelete ChatScreeninButViewDidClick:self currentType:self.currentType];
    }
    
    
}

- (void)changeTypeWithType:(ChatScreeninButViewType)type animation:(BOOL)animation {
    self.currentType = type;
    self.titleLab1.hidden = NO;
    self.titleLab2.hidden = NO;
    
    if (animation) {
        if (type == ChatScreeninButViewTypeNone) {
            
            [self.activityIndicator stopAnimating];
            [self animationWithClose];
            
        }
        else if (type == ChatScreeninButViewTypeSelect) {
            
            [self.activityIndicator stopAnimating];
            
            [self.flipView flipTouched:YES animation:YES];
        }
    }
    else {
        if (type == ChatScreeninButViewTypeNone) {
            
            [self.activityIndicator stopAnimating];
            
            self.hobbyView.hidden = YES;
            self.midView.hidden = YES;
            self.bottomView.hidden = YES;
            
            _isAnimation = NO;
            
        }
        else if (type == ChatScreeninButViewTypeSelect) {
            
            [self.activityIndicator stopAnimating];
            [self animationWithOpen];
            [self.flipView flipTouched:YES animation:NO];
            
            _isAnimation = NO;
            
        }
    }
    
    if (type == ChatScreeninButViewTypeLoading) {
        
        [self.activityIndicator startAnimating];
        self.titleLab1.hidden = YES;
        self.titleLab2.hidden = YES;
        
    }

}


#pragma mark - CMSCoinViewDelete

- (void)coinViewDidAnimationEnd:(BOOL)isOpen {
    
    if (isOpen) {
        [self animationWithOpen];
    }
    else {
        _isAnimation = NO;
    }
    
}


//关闭呼吸动画
- (void)animationWithClose {
    
    [self.hobbyView.layer removeAllAnimations];
    [self.midView.layer removeAllAnimations];
    [self.bottomView.layer removeAllAnimations];
    
    CGFloat hobbyViewWidth = self.frame.size.width - (sideBorderWidth * 2);
    CGFloat midViewWidth = self.frame.size.width - (sideBorderWidth * 1);
    CGFloat proportion = hobbyViewWidth/midViewWidth;
    
    CGFloat bottomViewWidth = self.bottomView.frame.size.width;
    CGFloat proportion2 = hobbyViewWidth/bottomViewWidth;
    
    self.hobbyView.transform = CGAffineTransformMakeScale(1, 1);
    self.midView.transform = CGAffineTransformMakeScale(1, 1);
    self.bottomView.transform = CGAffineTransformMakeScale(1, 1);
    
    [UIView animateWithDuration:kDuration animations:^{
        self.hobbyView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.bottomView.transform = CGAffineTransformMakeScale(proportion2, proportion2);
    } completion:^(BOOL finished) {
        if (finished) {
            
            self.bottomView.hidden = YES;
            
            [UIView animateWithDuration:kDuration animations:^{
                self.midView.transform = CGAffineTransformMakeScale(proportion, proportion);
            } completion:^(BOOL finished) {
                if (finished) {
                    self.midView.hidden = YES;
                    self.hobbyView.hidden = YES;
                    [self.flipView flipTouched:NO animation:YES];
                }
            }];
        }
    }];
}

//翻转后为呼吸动画
- (void)animationWithOpen {
    
    [self.hobbyView.layer removeAllAnimations];
    [self.midView.layer removeAllAnimations];
    [self.bottomView.layer removeAllAnimations];
    
    CGFloat hobbyViewWidth = self.frame.size.width - (sideBorderWidth * 2);
    CGFloat midViewWidth = self.frame.size.width - (sideBorderWidth * 1);
    CGFloat proportion = hobbyViewWidth/midViewWidth;
    
    self.hobbyView.transform = CGAffineTransformMakeScale(1, 1);
    self.midView.transform = CGAffineTransformMakeScale(proportion, proportion);
    self.bottomView.transform = CGAffineTransformMakeScale(proportion, proportion);
    
    
    self.hobbyView.hidden = NO;
    self.midView.hidden = NO;
    
    [UIView animateWithDuration:kDuration animations:^{
        self.hobbyView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.midView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        if (finished) {
            
            self.bottomView.hidden = NO;
            [UIView animateWithDuration:kDuration animations:^{
                
                self.bottomView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:^(BOOL finished) {
                if (finished) {
                    [self startHobbiesAnimation];
                    _isAnimation = NO;
                }
            }];
        }
    }];
}

- (void)startHobbiesAnimation {
    
    [self.hobbyView.layer addAnimation:[self scale:[NSNumber numberWithFloat:1.0f] orgin:[NSNumber numberWithFloat:1.17f] durTimes:0.7f Rep:MAXFLOAT] forKey:nil];
    [self.midView.layer addAnimation:[self scale:[NSNumber numberWithFloat:1.0f] orgin:[NSNumber numberWithFloat:1.13f] durTimes:0.7f Rep:MAXFLOAT] forKey:nil];
    [self.bottomView.layer addAnimation:[self scale:[NSNumber numberWithFloat:1.0f] orgin:[NSNumber numberWithFloat:1.1f] durTimes:0.7f Rep:MAXFLOAT] forKey:nil];
    
}


-(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repertTimes {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = Multiple;
    animation.toValue = orginMultiple;
    animation.autoreverses = YES;
    animation.repeatCount = repertTimes;
    animation.duration = time;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return  animation;
}



- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLab2.text = titleStr;
    self.titleLab1.text = titleStr;
}



#pragma mark - getter

- (UILabel *)titleLab1 {
    if (_titleLab1 == nil) {
        _titleLab1 = [[UILabel alloc] init];
        _titleLab1.textAlignment = NSTextAlignmentCenter;
        _titleLab1.font = [UIFont systemFontOfSize:11];
        _titleLab1.textColor = [UIColor whiteColor];
    }
    return _titleLab1;
}

- (UILabel *)titleLab2 {
    if (_titleLab2 == nil) {
        _titleLab2 = [[UILabel alloc] init];
        _titleLab2.textAlignment = NSTextAlignmentCenter;
        _titleLab2.font = [UIFont systemFontOfSize:11];
        _titleLab2.textColor = RGBCOLOR(157, 54, 0);
    }
    return _titleLab2;
}

- (CMSCoinView *)flipView {
    if (_flipView == nil) {
        _flipView = [[CMSCoinView alloc] init];
        _flipView.coinViewDelete = self;
        _flipView.frame = CGRectMake(0, 0, (int)(self.width - sideBorderWidth * 2), (int)(self.height - sideBorderWidth * 2));
        _flipView.center = self.center;
        
        UIImageView * primaryImageView = [[UIImageView alloc] init];
        primaryImageView.frame = _flipView.bounds;
        primaryImageView.image = [UIImage imageNamed:@"yuan"];
        self.titleLab1.frame = primaryImageView.bounds;
        [primaryImageView addSubview:self.titleLab1];
        
        UIView * secondaryView = [[UIView alloc] init];
        secondaryView.frame = _flipView.bounds;
        secondaryView.backgroundColor = RGBCOLOR(255, 213, 45);
        secondaryView.layer.cornerRadius = _flipView.height/2;
        secondaryView.layer.masksToBounds = YES;
        self.titleLab2.frame = secondaryView.bounds;
        [secondaryView addSubview:self.titleLab2];
        
        _flipView.primaryView = primaryImageView;
        _flipView.secondaryView = secondaryView;
        _flipView.spinTime = flipDuration;
    }
    return _flipView;
}


- (UIView *)hobbyView {
    if (_hobbyView == nil) {
        _hobbyView = [[UIView alloc] init];
        _hobbyView.width = self.midView.width - sideBorderWidth;
        _hobbyView.height = self.midView.width - sideBorderWidth;
        _hobbyView.center = CGPointMake(self.width/2, self.width/2);
        _hobbyView.backgroundColor = RGBCOLOR(255, 213, 45);
        _hobbyView.layer.cornerRadius = _hobbyView.width/2;
    }
    return _hobbyView;
}

- (UIView *)midView {
    if (_midView == nil) {
        _midView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width - sideBorderWidth, self.width - sideBorderWidth)];
        _midView.center = CGPointMake(self.width/2, self.height/2);
        _midView.layer.cornerRadius = _midView.width/2;
        _midView.backgroundColor = RGBCOLOR(255, 142, 0);
        _midView.alpha = 1;
        
    }
    return _midView;
}

- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width)];
        _bottomView.center = CGPointMake(self.width/2, self.height/2);
        _bottomView.layer.cornerRadius = _bottomView.width/2;
        _bottomView.backgroundColor = RGBCOLOR(139, 78, 0);
    }
    return _bottomView;
}





-(UIActivityIndicatorView *)activityIndicator {
    if (_activityIndicator == nil) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_activityIndicator startAnimating]; // 开始旋转
        [_activityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
        [_activityIndicator stopAnimating];
        _activityIndicator.center = self.center;
    }
    return _activityIndicator;
}







@end
