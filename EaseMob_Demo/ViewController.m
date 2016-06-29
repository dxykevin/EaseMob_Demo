//
//  ViewController.m
//  EaseMob_Demo
//
//  Created by HoldCourt on 16/6/29.
//  Copyright © 2016年 HoldCourt. All rights reserved.
//

#import "ViewController.h"
#import "ChatViewController.h"
#import <EMSDK.h>
@interface ViewController () <EMClientDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
}

/** 注册 */
- (IBAction)register:(id)sender {
    
    EMError *error = [[EMClient sharedClient] registerWithUsername:self.userNameTF.text password:self.pwdTF.text];
    if (!error) {
        NSLog(@"注册成功");
        NSLog(@"用户名:%@ 密码:%@",self.userNameTF.text,self.pwdTF.text);
    } else {
        NSLog(@"error == %@",error);
    }
}

/** 登录 */
- (IBAction)login:(id)sender {
    
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
        EMError *error = [[EMClient sharedClient] loginWithUsername:self.userNameTF.text password:self.pwdTF.text];
        if (!error) {
            
            /** 自动登录 */
            [[EMClient sharedClient].options setIsAutoLogin:YES];
            
            NSLog(@"登录成功");
            NSLog(@"用户名:%@ 密码:%@",self.userNameTF.text,self.pwdTF.text);
        } else {
            NSLog(@"error == %@",error);
        }
    }
}

/** 退出登录 */
- (IBAction)logout:(id)sender {
    
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        NSLog(@"退出成功");
    }
}
- (IBAction)pushChatVC:(id)sender {
    
    ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationChatter:@"kevin" conversationType:(EMConversationTypeChat)];
    chatVC.navigationItem.title = @"kevin";
    [self.navigationController pushViewController:chatVC animated:YES];
}

- (void)didAutoLoginWithError:(EMError *)aError {
    
    NSLog(@"自动登录失败返回结果");
}

/** 掉线时 自动重连 */
- (void)didConnectionStateChanged:(EMConnectionState)aConnectionState {
    
    
}

/*!
 *  当前登录账号在其它设备登录时会接收到该回调
 */
- (void)didLoginFromOtherDevice {
    
}

/*!
 *  当前登录账号已经被从服务器端删除时会收到该回调
 */
- (void)didRemovedFromServer {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
