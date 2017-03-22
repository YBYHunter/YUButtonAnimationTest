//
//  ViewController.m
//  YUButtonAnimationTest
//
//  Created by 于博洋 on 2017/3/17.
//  Copyright © 2017年 于博洋. All rights reserved.
//

#import "ViewController.h"
#import "ChatScreeninContainerView.h"

@interface ViewController ()

@property (nonatomic,strong) UIImageView * leftLinImageView;

@property (nonatomic,strong) ChatScreeninContainerView * chatScreeninContainerView;

@property (nonatomic,assign) BOOL isAnimation; //正在执行动画

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.leftLinImageView];
    [self.view addSubview:self.chatScreeninContainerView];

}

#pragma mark - getter

- (ChatScreeninContainerView *)chatScreeninContainerView {
    if (_chatScreeninContainerView == nil) {
        CGRect rect = CGRectMake(0, 0, self.leftLinImageView.frame.size.width/2, self.leftLinImageView.frame.size.height);
        _chatScreeninContainerView = [[ChatScreeninContainerView alloc] initWithFrame:rect];
    }
    return _chatScreeninContainerView;
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
