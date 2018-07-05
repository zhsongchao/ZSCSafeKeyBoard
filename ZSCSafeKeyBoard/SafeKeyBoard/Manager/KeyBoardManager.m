//
//  KeyBoardManager.m
//  ZSCSafeKeyBoard
//
//  Created by light on 2018/7/3.
//  Copyright © 2018年 jrjc. All rights reserved.
//

#import "KeyBoardManager.h"
#import "HZCommanFunc.h"
#import "Base64KeyBoardView.h"

@interface KeyBoardManager()<KeyBoardShowViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) Base64KeyBoardView *keyBoardView;

@property (nonatomic,weak) UITextField *textField;

@property (nonatomic,copy) NSString *codeStr;

@end


@implementation KeyBoardManager

+ (instancetype)Manager {

    KeyBoardManager *manager = [[self alloc] init];
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initKeyBoardView];
    }
    return self;
}

- (void)initKeyBoardView {
    _keyBoardView = [Base64KeyBoardView KeyBoardMenu];
    _keyBoardView.delegate = self;
    _keyBoardView.BlockChnagkeyBoard = ^(UIView *v){
        NSLog(@"改变键盘格式");
    };
}


- (void)Base64KeyBoardWithTextField:(UITextField *)textField type:(keyBoardType)type {

    switch (type) {
        case NumberKeyBoardShowView:
        {
            textField.inputView = [self.keyBoardView NumberKeyBoardShowView];
        }
            break;
        case CharacterKeyBoardShowView:
        {
            textField.inputView = [self.keyBoardView CharacterKeyBoardShowView];
        }
            break;
        default:
            break;
    }
    textField.delegate = self;
    self.textField = textField;

}


- (void)getKeyBoardViewValueFromButton:(NSString *)ButtonTxt DidSelectButTag:(NSInteger)BtnTag {
//    NSLog(@"----键盘传过来的数据：%@",ButtonTxt);
    NSString *startStr = [Base64KeyBoardView returnByArryCount:ButtonTxt];
    self.textField.text = startStr;
    self.codeStr = ButtonTxt;
    
    if (self.inputInfoBlock) {
        __weak __typeof(self) weakSelf = self;
        self.inputInfoBlock(startStr,weakSelf.textField);
    }
}

- (void)keyBoardAnmitionDown {
    if ([self.textField isFirstResponder]) {
        [self.textField resignFirstResponder];
    }
}

- (NSString *)deCodeStr {
    return [Base64KeyBoardView tranceBaseToString:self.codeStr]; 
}

#pragma mark - UITextFieldDelegate
/**
 清除按钮点击事件
 */
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    [self.keyBoardView base64TextFieldShouldClear];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.inputInfoBlock) {
        self.inputInfoBlock(textField.text,textField);
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (self.inputInfoBlock) {
        self.inputInfoBlock(textField.text,textField);
    }
    return YES;
}

@end
