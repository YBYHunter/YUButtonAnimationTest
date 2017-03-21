//
//  ViewController.m
//  YUButtonAnimationTest
//
//  Created by 于博洋 on 2017/3/17.
//  Copyright © 2017年 于博洋. All rights reserved.
//

#import "ViewController.h"
#import "ChatScreeninButView.h"
#import "ChatScreeninViewModel.h"

@interface ViewController ()<ChatScreeninButViewDelete>

@property (nonatomic,strong) UIImageView * leftLinImageView;

@property (nonatomic,strong) ChatScreeninButView * chatScreeninButView;

@property (nonatomic,strong) ChatScreeninButView * chatScreeninButView2;

@property (nonatomic,strong) ChatScreeninButView * chatScreeninButView3;

@property (nonatomic,strong) ChatScreeninViewModel * chatScreeninViewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.leftLinImageView];
    [self.view addSubview:self.chatScreeninButView];
    [self.view addSubview:self.chatScreeninButView2];
    [self.view addSubview:self.chatScreeninButView3];
    
    self.chatScreeninButView.center = CGPointMake(self.leftLinImageView.frame.origin.x + self.leftLinImageView.frame.size.width , self.leftLinImageView.frame.size.height/2);
    
    self.chatScreeninButView2.center = CGPointMake((self.leftLinImageView.frame.origin.x + self.leftLinImageView.frame.size.width)/2 + self.chatScreeninButView2.frame.size.width , self.leftLinImageView.frame.size.height/4 + self.chatScreeninButView2.frame.size.width);
    
    self.chatScreeninButView3.center = CGPointMake((self.leftLinImageView.frame.origin.x + self.leftLinImageView.frame.size.width)/2 + self.chatScreeninButView2.frame.size.width , self.leftLinImageView.frame.size.height/2 + self.chatScreeninButView2.frame.size.width + 40);
    
    
    [self.chatScreeninViewModel.viewList addObject:self.chatScreeninButView];
    [self.chatScreeninViewModel.viewList addObject:self.chatScreeninButView2];
    [self.chatScreeninViewModel.viewList addObject:self.chatScreeninButView3];
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

- (UIImageView *)leftLinImageView {
    if (_leftLinImageView == nil) {
        
        UIImage * img = [UIImage imageNamed:@"list_circulardottedline"];
        _leftLinImageView = [[UIImageView alloc] init];
        _leftLinImageView.image = img;
        _leftLinImageView.frame = CGRectMake(-140, 0, img.size.width +  30, img.size.height + 60);
        
    }
    return _leftLinImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
