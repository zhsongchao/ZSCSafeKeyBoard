//
//  Base64KeyBoardView.h
//  ZSCSafeKeyBoard
//
//  Created by jrjc on 17/2/16.
//  Copyright © 2017年 jrjc. All rights reserved.
//


#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))

#import <UIKit/UIKit.h>
#import "Config.h"

typedef enum  {
    NumberKeyBoard = 1,             // 数字键盘
    CharacterKeyBoard,               // 大写字符键盘
    SmallCharacterKeyBoard,     // 小写字符键盘
    EnglishKeyBoard                    // 英文符号键盘
} KeyBoardType;

typedef enum  {
    TextFiledFirst = 1,             // 首个文本框
    TextFiledSecond = 2,             // 2文本框
    TextFiledOther,                //
} UISelectTextPostion;

/**协议*/
@protocol KeyBoardShowViewDelegate <NSObject>
/**
 * 获取从键盘中点击的值（数字）
 */
@required
-(void)getKeyBoardViewValueFromButton:(NSString * )ButtonTxt DidSelectButTag:(NSInteger) BtnTag;
/**获取第二个*/
- (void)getSecondKeyBoardViewValueFromButton:(NSString *)ButtonTxt DidSelectButTag:(NSInteger) BtnTag;
/**键盘下移*/
- (void)keyBoardAnmitionDown;
/**
 *  第二文本框输入数据获取
 */
@optional

- (void)getOtherKeyBoardViewValueFromButton:(NSString *)ButtonTxt DidSelectButTag:(NSInteger) BtnTag;

@end
/**block代码块*/

typedef void(^ChangKeyBoard)(UIView *);

@interface Base64KeyBoardView : UIView

@property (nonatomic, assign) id<KeyBoardShowViewDelegate>  delegate;

@property (nonatomic, copy) ChangKeyBoard  BlockChnagkeyBoard;

@property (nonatomic, assign) UISelectTextPostion  TextSelectPostion;
/**
 *  键盘类型
 */
@property (nonatomic, assign) KeyBoardType  showKeyBoardType;

/**
 *  连接字符串
 */
@property (nonatomic, strong) NSString * ConnectStr;

@property (nonatomic, strong) NSString * JumpStr;

@property (nonatomic, assign) BOOL  selectState;
/**是否全部删除数据*/
@property (nonatomic, assign) BOOL DeleteDone;

@property (nonatomic, strong) NSString * OtherConnectStr;

@property (nonatomic, strong) NSString * OtherJumpStr;

@property (nonatomic, assign) BOOL  OtherselectState;



//*************第二个数据
@property (nonatomic, strong) NSString * ConnectStrSecond;

@property (nonatomic, strong) NSString * JumpStrSecond;
/**是否全部删除数据*/
@property (nonatomic, assign) BOOL DeleteDoneSecond;

@property (nonatomic, assign) BOOL  SecondSelectState;

/**
 *  初始化键盘
 *
 *  @return
 */
+ (instancetype)KeyBoardMenu;


/**
 *  数字键盘弹出界面
 */
-(UIView *)NumberKeyBoardShowView;

/**
 *  字符键盘弹出界面
 */
-(UIView *)CharacterKeyBoardShowView;

/**
 *  英文键盘弹出界面
 */
-(UIView *)EnglishKeyBoardShowView;
/**
 清除按钮
 */
- (void)base64TextFieldShouldClear;
/**
 base64解码
 */
+ (NSString *)tranceBaseToString :(NSString *)str;
/**
 输入框内容变*加密
 */
+ (NSString *)returnByArryCount:(NSString *)text;

@end
