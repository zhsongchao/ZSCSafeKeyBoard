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
#import "Base64KeyBoardView.h"


@interface MainViewController ()<KeyBoardShowViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextFile;
@property (weak, nonatomic) IBOutlet UITextField *paseWordTextFile;
- (IBAction)pushClick:(id)sender;

@property (nonatomic, strong) Base64KeyBoardView * keyBoardView;
@property (nonatomic,strong) NSString *nameStr;
@property (nonatomic,strong) NSString *namePlaseStr;

@property (nonatomic,strong) NSString *passStr;
@property (nonatomic,strong) NSString *passPlaseStr;




@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"base64安全键盘";
    self.nameTextFile.delegate = self;
    self.paseWordTextFile.delegate = self;
    self.nameTextFile.clearButtonMode = UITextFieldViewModeAlways;
    self.paseWordTextFile.clearButtonMode = UITextFieldViewModeAlways;
    [self initBase64KeyBoardView];
}

- (void)initBase64KeyBoardView{
    self.keyBoardView = [Base64KeyBoardView KeyBoardMenu];
    self.keyBoardView.delegate = self;
    self.keyBoardView.BlockChnagkeyBoard = ^(UIView *v){
        NSLog(@"11");
    };
    self.nameTextFile.inputView = [self.keyBoardView NumberKeyBoardShowView];
    self.paseWordTextFile.inputView = [self.keyBoardView NumberKeyBoardShowView];
}



-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.nameTextFile) {
        self.keyBoardView.TextSelectPostion = TextFiledFirst;
    }
    if (textField == self.paseWordTextFile) {
        
        self.keyBoardView.TextSelectPostion = TextFiledSecond;
    }
}
#pragma mark - 清除按钮点击事件
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    [self.keyBoardView base64TextFieldShouldClear];
    return YES;
}

-(void)getKeyBoardViewValueFromButton:(NSString * )ButtonTxt DidSelectButTag:(NSInteger) BtnTag {
    NSLog(@"----键盘传过来的数据：%@",ButtonTxt);
    self.nameStr = [Base64KeyBoardView returnByArryCount:ButtonTxt];
    self.nameTextFile.text = self.nameStr;
    self.namePlaseStr = ButtonTxt;
}

- (void)getSecondKeyBoardViewValueFromButton:(NSString *)ButtonTxt DidSelectButTag:(NSInteger) BtnTag {
    
    self.passStr = [Base64KeyBoardView returnByArryCount:ButtonTxt];
    NSLog(@"----222222输入数据：%@",self.passStr);
    self.paseWordTextFile.text = self.passStr;
    self.passPlaseStr = ButtonTxt;
    
}

- (IBAction)pushClick:(id)sender {
    ViewController *vc = [[ViewController alloc]init];
    vc.unLockBase64Str =  [NSString stringWithFormat:@"加密用户名：%@\n加密密码:%@\n用户名：%@ \n密码：%@",self.namePlaseStr,self.passPlaseStr,[Base64KeyBoardView tranceBaseToString:self.namePlaseStr],[Base64KeyBoardView tranceBaseToString:self.passPlaseStr]];
    NSLog(@"用户名的长度%ld=密码的长度%ld",[Base64KeyBoardView tranceBaseToString:self.namePlaseStr].length,[Base64KeyBoardView tranceBaseToString:self.passPlaseStr].length);
   [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 点击键盘上的隐藏按钮时键盘下移

- (void)keyBoardAnmitionDown{
    
    /**
     本不想用这个方法，但是修改viewController的keyBoard的frame没有效果，暂时没有找到别的办法，求指点
     */
    if ([self.nameTextFile isFirstResponder])
    {
        [self.nameTextFile resignFirstResponder];
    }
    if ([self.paseWordTextFile isFirstResponder])
    {
        [self.paseWordTextFile resignFirstResponder];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.nameTextFile isFirstResponder])
    {
        [self.nameTextFile resignFirstResponder];
    }
    if ([self.paseWordTextFile isFirstResponder])
    {
        [self.paseWordTextFile resignFirstResponder];
    }
}

@end
