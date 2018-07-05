//
//  MainViewController.m
//  ZSCSafeKeyBoard
//
//  Created by jrjc on 17/2/16.
//  Copyright © 2017年 jrjc. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"
#import "HZCommanFunc.h"
#import "KeyBoardManager.h"


@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextFile;
@property (weak, nonatomic) IBOutlet UITextField *paseWordTextFile;
- (IBAction)pushClick:(id)sender;

@property (nonatomic,strong)  KeyBoardManager *manager;

@property (nonatomic,strong)  KeyBoardManager *manager2;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"base64安全键盘";

    self.nameTextFile.clearButtonMode = UITextFieldViewModeAlways;
    self.paseWordTextFile.clearButtonMode = UITextFieldViewModeAlways;
    [self initBase64KeyBoardView];
}

- (void)initBase64KeyBoardView{
    KeyBoardManager *manager = [KeyBoardManager Manager];
    [manager Base64KeyBoardWithTextField:self.nameTextFile type:(CharacterKeyBoardShowView)];
    self.manager = manager;
    
    //textField的代理会被拦截 所以有什么类似需要 按钮 是否可用之类的状态可以在这个block中处理
    __weak __typeof(self) weakSelf = self;
    self.manager.inputInfoBlock = ^(NSString *str,UITextField *curretnTF){
        [weakSelf updateBtnStatus];
    };
    
    KeyBoardManager *manager2 = [KeyBoardManager Manager];
    [manager2 Base64KeyBoardWithTextField:self.paseWordTextFile type:(CharacterKeyBoardShowView)];
    self.manager2 = manager2;
}

- (IBAction)pushClick:(id)sender {
    ViewController *vc = [[ViewController alloc]init];
    vc.unLockBase64Str =  [NSString stringWithFormat:@"用户名：%@ \n密码：%@",[self.manager deCodeStr],[self.manager2 deCodeStr]];

   [self.navigationController pushViewController:vc animated:YES];
}

- (void)updateBtnStatus {
    NSLog(@"啊!我又被改变了,来打我呀");
}
@end
