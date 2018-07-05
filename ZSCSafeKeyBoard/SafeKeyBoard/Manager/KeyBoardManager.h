//
//  KeyBoardManager.h
//  ZSCSafeKeyBoard
//
//  Created by light on 2018/7/3.
//  Copyright © 2018年 jrjc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <UIKit/UIKit.h>

typedef void (^inputInfoBlock)(NSString *info,UITextField *currentTF);

typedef NS_ENUM(NSUInteger, keyBoardType) {
    NumberKeyBoardShowView,//数字键盘弹出界面
    CharacterKeyBoardShowView,//字符键盘弹出界面
};

@interface KeyBoardManager : NSObject

+ (instancetype)Manager;

- (void)Base64KeyBoardWithTextField:(UITextField *)textField type:(keyBoardType)type;

- (NSString *)deCodeStr;

/**
 输入改变时的block
 */
@property (nonatomic, copy) inputInfoBlock inputInfoBlock;

@end
