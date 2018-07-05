//
//  Base64KeyBoardView.m
//  ZSCSafeKeyBoard
//
//  Created by jrjc on 17/2/16.
//  Copyright © 2017年 jrjc. All rights reserved.
//

#import "Base64KeyBoardView.h"
#import "UIImage+FitWithImage.h"
#import "UIControl+Category.h"
#import "HZCommanFunc.h"

@interface Base64KeyBoardView ()
/** 控制面板 */
@property (nonatomic, strong) UIView * KeyBoardConsoleView;

/** 数字按钮 */
@property(nonatomic,strong)UIButton * NumberBtn;

/**  字符按钮*/
@property(nonatomic,strong)UIButton * CharacterBtn;

/**中文按钮*/
@property(nonatomic,strong)UIButton * EnglishBtn;


/**数字键盘数据源*/
@property (nonatomic, strong) NSMutableArray * numberArray;
/**  字符加盘数据源*/
@property (nonatomic, strong) NSMutableArray * CharacterArry;
@property (nonatomic, strong) NSMutableArray * SmallCharacterArry;
/** 符号键盘数据源*/
@property (nonatomic, strong) NSMutableArray * EnglishArry;


@end


@implementation Base64KeyBoardView
-(UIView *)KeyBoardConsoleView {
    
    if (!_KeyBoardConsoleView) {
        _KeyBoardConsoleView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT-KeyBoardHeightScale , SCREEN_WIDTH, KeyBoardHeightScale)];
        
        _KeyBoardConsoleView.backgroundColor = [UIColor colorWithRed:210/255.0f green:213/255.0f blue:219/255.0f alpha:1];
    }
    return _KeyBoardConsoleView;
}

/**
 *  数字键盘
 *
 *  @return <#return value description#>
 */
-(NSMutableArray *)numberArray {
    if (!_numberArray) {
        _numberArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"EN",@"0",@"删除"].mutableCopy;
    }
    return _numberArray;
}

-(NSMutableArray *)CharacterArry {
    if (!_CharacterArry) {
        _CharacterArry = @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"小",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"删",@"123",@"空格",@"隐藏"].mutableCopy;
    }
    return _CharacterArry;
}

-(NSMutableArray *)SmallCharacterArry {
    if (!_SmallCharacterArry) {
        _SmallCharacterArry = @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"大",@"z",@"x",@"c",@"v",@"b",@"n",@"m",@"删",@"123",@"空格",@"隐藏"].mutableCopy;
    }
    return _SmallCharacterArry;
}

-(NSMutableArray *)EnglishArry {
    if (!_EnglishArry) {
        _EnglishArry = @[@"!",@"@",@"#",@"$",@"%",@"^",@"&",@"*",@"_",@"-",@"+",@"=",@"|",@"(",@")",@"[",@"]",@"{",@"}",@";",@":",@"?",@"/",@"<",@">",@",",@".",@"~",@"删",@"123",@"英",@"空格",@"return"].mutableCopy;
    }
    return _EnglishArry;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // 清除颜色
        self.backgroundColor = [UIColor clearColor];
        
        self.OtherConnectStr = self.ConnectStr = @"";
        self.OtherJumpStr = self.JumpStr = @"";
        self.OtherselectState = self.selectState = YES;
        self.DeleteDone = NO;
        
        // ******第二项数据
        self.ConnectStrSecond = self.JumpStrSecond = @"";
        self.SecondSelectState = self.selectState = YES;
        self.DeleteDoneSecond = NO;
        
        /**
         *  默认为选项一
         */
        self.TextSelectPostion = TextFiledSecond;
    }
    return self;
}

+ (instancetype)KeyBoardMenu {
    return [[self alloc] init];
}
#pragma mark - 创建数字键盘View
-(UIView *)NumberKeyBoardShowView {
    
    for (UIView * subView in self.KeyBoardConsoleView.subviews) {
        [subView removeFromSuperview];
    }
    for (int i = 0; i < 3; i ++) {
        for (int j = 0; j < 4; j++) {
            self.NumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.NumberBtn setFrame:CGRectMake(NumberPaddingHScale + (NumberPaddingHScale + NumberButtonWidthScale) * i, NumberPaddingHScale + (NumberPaddingHScale + NumberButtonHeightScale) * j, NumberButtonWidthScale, NumberButtonHeightScale)];
            
            
            [self.NumberBtn setBackgroundColor:[UIColor whiteColor]];
            //self.NumberBtn.layer.borderWidth = 0.5;
            self.NumberBtn.adjustsImageWhenHighlighted = NO;
            [self.NumberBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.NumberBtn.titleLabel.font = KeyBoardNumberFont;
            self.NumberBtn.tag = i +3 *j;
            [self.NumberBtn setTitle:[self.numberArray objectAtIndex:self.NumberBtn.tag] forState:UIControlStateNormal];
            [self.KeyBoardConsoleView addSubview:self.NumberBtn];
            [self.NumberBtn addTarget:self action:@selector(NumberDidSelect:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    
    return self.KeyBoardConsoleView;
}
#pragma mark - 点击数字键盘
-(void)NumberDidSelect:(UIButton *)sender {
    // 删除
    if (sender.tag ==11) {
        
        if (![self.ConnectStr isEqualToString:@""]) {
            
            NSArray * tempArry = [[self.ConnectStr substringWithRange:NSMakeRange(0, self.ConnectStr.length - 1)] componentsSeparatedByString:@","];
            
            /**截取非最后一位*/
            NSString * NotInlastObjc = @"";
            for (NSInteger index = 0; index < tempArry.count - 1; index++) {
                NotInlastObjc = [[NotInlastObjc stringByAppendingString:tempArry[index]] stringByAppendingString:@","];
            }
            
            /**截取完成赋值给connectStr*/
            self.ConnectStr = NotInlastObjc;
            self.JumpStr = self.ConnectStr;
            
            NSString * resShowStr = IsStrEmpty(self.JumpStr)  ? @"~" : [self.JumpStr substringWithRange:NSMakeRange(0, self.JumpStr.length - 1)] ;
            
            /**赋值删除完成标志*/
            self.DeleteDone = IsStrEmpty(self.JumpStr);
            [self runDelegateFromButtonTag:resShowStr andButtonTage:sender.tag];
        }
        
        // 切换
    }else if (sender.tag == 9){

        if (self.delegate && [self.delegate respondsToSelector:@selector(getKeyBoardViewValueFromButton:DidSelectButTag:)]) {
            [self.delegate  getKeyBoardViewValueFromButton:self.JumpStr DidSelectButTag:sender.tag];
            __weak typeof(self) weakSelf = self;
            if (self.BlockChnagkeyBoard) {
                weakSelf.BlockChnagkeyBoard([weakSelf CharacterKeyBoardShowView]);
            }
        }
    }
    // 正常点击
    else{
        
        NSString * baseStr = __BASE64([self.numberArray objectAtIndex:sender.tag]);
        self.JumpStr = [[self.ConnectStr stringByAppendingString:baseStr] stringByAppendingString:@","];
        self.ConnectStr = self.JumpStr;
        self.JumpStr = [self.JumpStr substringWithRange:NSMakeRange(0, self.JumpStr.length - 1)];
        //                if (self.DeleteDone && !IsStrEmpty(self.JumpStr)) {
        //                    self.JumpStr = [NSString stringWithFormat:@",%@",self.JumpStr];
        //                }MQMgMwNA
        NSLog(@"加密后的字符串%@",self.JumpStr);
        [self runDelegateFromButtonTag:self.JumpStr andButtonTage:sender.tag];
    }
}

#pragma mark - 创建英文键盘view
-(UIView *)CharacterKeyBoardShowView {
    /**
     大写字母
     */
    for (UIView * subView in self.KeyBoardConsoleView.subviews) {
        [subView removeFromSuperview];
    }
    
    for (int i =0; i < 10; i++) {
        for (int j = 0; j < 4; j++) {
            self.CharacterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (j == 0 && i < 10) {
                [self.CharacterBtn setFrame:CGRectMake(MarddingLeftSclae + i * (CharBtnWidthScale + PaddingRightScale), PaddingTopScale, CharBtnWidthScale, CharBtnHeightScale)];
                self.CharacterBtn.tag = i ;
                [self.CharacterBtn setOrderTags: [NSString stringWithFormat:@"%d",(int)self.CharacterBtn.tag + CharacterKey]];
                
                
            }else if (j == 1 && i <9 ){
                
                CGFloat secY = PaddingTopScale + (CharBtnHeightScale + PaddingButtomScale) * j;
                
                
                [self.CharacterBtn setFrame:CGRectMake(MarddingSecondLeftSclae + i * (CharBtnWidthScale + PaddingRightScale), secY, CharBtnWidthScale, CharBtnHeightScale)];
                self.CharacterBtn.tag = i +10 *j ;
                
                [self.CharacterBtn setOrderTags: [NSString stringWithFormat:@"%d",(int)self.CharacterBtn.tag + CharacterKey]];
                
            }
            else if (j == 2 && i  <9){
                CGFloat thirdY = PaddingTopScale + (CharBtnHeightScale + PaddingButtomScale) * j;
                if (j== 2 && i == 0) {
                    [self.CharacterBtn setFrame:CGRectMake(MarddingLeftSclae, thirdY , BigToSmallWidthScale , CharBtnHeightScale)];
                    self.CharacterBtn.tag = i +9 *j+1;
                    [self.CharacterBtn setOrderTags: [NSString stringWithFormat:@"%d",(int)self.CharacterBtn.tag + CharacterKey]];
                    
                }else if(j== 2 && i == 8){
                    [self.CharacterBtn setFrame:CGRectMake(SCREEN_WIDTH - PaddingRightScale - BigToSmallWidthScale,thirdY , BigToSmallWidthScale , CharBtnHeightScale)];
                    self.CharacterBtn.tag = i +9 *j+1;
                    [self.CharacterBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.CharacterBtn.tag + CharacterKey]];
                }else {
                    
                    CGFloat padding =   i !=1? PaddingRightScale :0.0;
                    CGFloat leftDistance = MarddingLeftSclae + BigToSmallWidthScale + PaddingThirdRightScale;
                    
                    [self.CharacterBtn setFrame:CGRectMake(leftDistance+ (i - 1)* (CharBtnWidthScale + padding ), thirdY, CharBtnWidthScale , CharBtnHeightScale)];
                    self.CharacterBtn.tag = i +9 *j+1;
                    
                    [self.CharacterBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.CharacterBtn.tag + CharacterKey]];
                }
                
            }
            else if(j ==3 && i < 3){
                CGFloat fourthY = PaddingTopScale + (CharBtnHeightScale + PaddingButtomScale) * j ;
                
                if (j == 3 && i < 1) {
                    
                    [self.CharacterBtn setFrame:CGRectMake(MarddingLeftSclae + i * (NumberChnageWidthScale +PaddingRightScale),fourthY  , NumberChnageWidthScale , CharBtnHeightScale)];
                    self.CharacterBtn.tag = i +9 *j+1;
                    [self.CharacterBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.CharacterBtn.tag + CharacterKey]];
                    
                }else if (j == 3 && i == 1){
                    [self.CharacterBtn setFrame:CGRectMake(MarddingLeftSclae + i * (NumberChnageWidthScale +PaddingRightScale), fourthY, SpeaceButtonWidthScale, CharBtnHeightScale)];
                    self.CharacterBtn.tag = i +9 *j+1;
                    [self.CharacterBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.CharacterBtn.tag + CharacterKey]];
                }else if(j == 3 && i == 2){
                    [self.CharacterBtn setFrame:CGRectMake(SCREEN_WIDTH - MarddingLeftSclae * 2 - ReturnButtonWidthScale, fourthY, ReturnButtonWidthScale ,CharBtnHeightScale)];
                    self.CharacterBtn.tag = i +9 *j+1;
                    [self.CharacterBtn setOrderTags: [NSString stringWithFormat:@"%ld",self.CharacterBtn.tag + CharacterKey]];
                }
                
                
            }
            //按键背景
            UIImage * CharacterBtnImage = [UIImage imageNamed:@"whiteBack"];
            CharacterBtnImage = [CharacterBtnImage stretchableImageWithLeftCapWidth:CharacterBtnImage.size.width * 0.5 topCapHeight:CharacterBtnImage.size.height * 0.5];
            //按键高亮背景
            UIImage * CharacterBtnHightedImage = [UIImage imageNamed:@"congsoleImage"];
            CharacterBtnHightedImage = [CharacterBtnHightedImage stretchableImageWithLeftCapWidth:CharacterBtnHightedImage.size.width * 0.5 topCapHeight:CharacterBtnHightedImage.size.height * 0.5];
            [self.CharacterBtn setBackgroundImage:CharacterBtnImage forState:UIControlStateNormal];
            [self.CharacterBtn setBackgroundImage:CharacterBtnHightedImage forState:UIControlStateHighlighted];
            
            [self.CharacterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.CharacterBtn.titleLabel.font = KeyBoardFont;
            self.CharacterBtn.adjustsImageWhenHighlighted = NO;
            
            if (self.selectState) {
                //小写
                [self.CharacterBtn setTitle: [self.SmallCharacterArry objectAtIndex:self.CharacterBtn.tag]forState:UIControlStateNormal];
                
            }else{
                //大写
                [self.CharacterBtn setTitle: [self.CharacterArry objectAtIndex:self.CharacterBtn.tag]forState:UIControlStateNormal];
                
            }
            [self.KeyBoardConsoleView addSubview:self.CharacterBtn];
            [self.CharacterBtn addTarget:self action:@selector(CharacterDidSelect:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    return self.KeyBoardConsoleView;
}
#pragma mark - 英文键盘被点击
-(void)CharacterDidSelect:(UIButton *)sender {
    if (sender.tag == 19) {
        if (self.selectState) {
            //            [sender setTitle:@"小" forState:UIControlStateNormal];
            //            self.CharacterArry[sender.tag] = @"小";
            self.OtherselectState = self.SecondSelectState = self.selectState = NO;
            
        }else {
            //            [sender setTitle:@"大" forState:UIControlStateNormal];
            //            self.CharacterArry[sender.tag] = @"大";
            self.OtherselectState = self.SecondSelectState = self.selectState = YES;
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(getKeyBoardViewValueFromButton:DidSelectButTag:)]) {
            [self.delegate  getKeyBoardViewValueFromButton:self.JumpStr DidSelectButTag:[sender.OrderTags integerValue]];
            __weak typeof(self) weakSelf = self;
            if (self.BlockChnagkeyBoard) {
                weakSelf.BlockChnagkeyBoard([weakSelf CharacterKeyBoardShowView]);
            }
            
        }
        
        //删除
    }else if (sender.tag == 27){

                if (![self.ConnectStr isEqualToString:@""]) {
                    //                    self.JumpStr = [self.ConnectStr substringToIndex:[self.ConnectStr length]-1];
                    //                    self.ConnectStr = self.JumpStr;
                    //                    [self runDelegateFromButtonTag:self.JumpStr andButtonTage:[sender.OrderTags integerValue]];
                    
                    NSArray * tempArry = [[self.ConnectStr substringWithRange:NSMakeRange(0, self.ConnectStr.length - 1)] componentsSeparatedByString:@","];
                    
                    /**截取非最后一位*/
                    NSString * NotInlastObjc = @"";
                    for (NSInteger index = 0; index < tempArry.count - 1; index++) {
                        NotInlastObjc = [[NotInlastObjc stringByAppendingString:tempArry[index]] stringByAppendingString:@","];
                    }
                    
                    /**截取完成赋值给connectStr*/
                    self.ConnectStr = NotInlastObjc;
                    self.JumpStr = self.ConnectStr;
                    
                    NSString * resShowStr = IsStrEmpty(self.JumpStr)  ? @"~" : [self.JumpStr substringWithRange:NSMakeRange(0, self.JumpStr.length - 1)] ;
                    
                    /**赋值删除完成标志*/
                    self.DeleteDone = IsStrEmpty(self.JumpStr);
                    [self runDelegateFromButtonTag:resShowStr andButtonTage:sender.tag];
                }
    // 数字
    }else if (sender.tag == 28){

        if (self.delegate && [self.delegate respondsToSelector:@selector(getKeyBoardViewValueFromButton:DidSelectButTag:)]) {
            [self.delegate  getKeyBoardViewValueFromButton:self.JumpStr DidSelectButTag:[sender.OrderTags integerValue]];
            __weak typeof(self) weakSelf = self;
            if (self.BlockChnagkeyBoard) {
                weakSelf.BlockChnagkeyBoard([weakSelf NumberKeyBoardShowView]);
            }
        }
    }
    else if (sender.tag == 29){
//                self.JumpStr = [self.ConnectStr stringByAppendingString:nil];
//                self.JumpStr = self.ConnectStr;
//                self.ConnectStr = self.JumpStr;
//                [self runDelegateFromButtonTag:self.JumpStr andButtonTage:[sender.OrderTags integerValue]];


    }else if (sender.tag == 30){
        if (self.delegate && [self.delegate respondsToSelector:@selector(keyBoardAnmitionDown)]) {
            [self.delegate  keyBoardAnmitionDown];
        }
//        [self keyBoardDownAnmation];
    }else{    // 正常点击

        if (self.selectState) {
            NSString * baseStr = __BASE64([self.SmallCharacterArry objectAtIndex:sender.tag]);
            self.JumpStr = [[self.ConnectStr stringByAppendingString:baseStr] stringByAppendingString:@","];
            self.ConnectStr = self.JumpStr;
            self.JumpStr = [self.JumpStr substringWithRange:NSMakeRange(0, self.JumpStr.length - 1)];
            [self runDelegateFromButtonTag:self.JumpStr andButtonTage:[sender.OrderTags integerValue]];
        }else{
            NSString * baseStr = __BASE64([self.CharacterArry objectAtIndex:sender.tag]);
            self.JumpStr = [[self.ConnectStr stringByAppendingString:baseStr] stringByAppendingString:@","];
            self.ConnectStr = self.JumpStr;
            self.JumpStr = [self.JumpStr substringWithRange:NSMakeRange(0, self.JumpStr.length - 1)];
            [self runDelegateFromButtonTag:self.JumpStr andButtonTage:[sender.OrderTags integerValue]];
         }
    }
}

#pragma mark - 获取第一个文本框内容
-(void)runDelegateFromButtonTag:(NSString *)ButtonText andButtonTage:(NSInteger)TageValue {
    if (self.delegate && [self.delegate respondsToSelector:@selector(getKeyBoardViewValueFromButton:DidSelectButTag:)]) {
        NSLog(@"ButtonText.length %ld",ButtonText.length);
        [self.delegate  getKeyBoardViewValueFromButton:ButtonText DidSelectButTag:TageValue];
    }
}


#pragma mark - 清除按钮点击事件
- (void)base64TextFieldShouldClear{
    
    if (![self.ConnectStr isEqualToString:@""]) {
        
        /**截取非最后一位*/
        NSString * NotInlastObjc = @"";
        
        /**截取完成赋值给connectStr*/
        self.ConnectStr = NotInlastObjc;
        self.JumpStr = self.ConnectStr;
        
        NSString * resShowStr = IsStrEmpty(self.JumpStr)  ? @"~" : [self.JumpStr substringWithRange:NSMakeRange(0, self.JumpStr.length - 1)] ;
        
        /**赋值删除完成标志*/
        self.DeleteDone = IsStrEmpty(self.JumpStr);
        [self runDelegateFromButtonTag:resShowStr andButtonTage:11];
    }
}

#pragma mark- 解码
 + (NSString *)tranceBaseToString :(NSString *)str{
    NSString * resStr = @"";
//    NSLog(@"self.phoneTextPleace===%@",str);
    for (NSString * item in [str componentsSeparatedByString:@","]) {
        resStr = [resStr stringByAppendingString:__TEXT(item)];
//        NSLog(@"resStr解码后的字符串%@",resStr);
    }
    return resStr;
}

#pragma mark - *加密
+ (NSString *)returnByArryCount:(NSString *)text {
    NSString * strRetun = @"";
    if ([text isEqualToString:@"~"]) {
        strRetun = @"";
    }else {
        if ([text isEqualToString:@""]) {
            strRetun = @"";
        }else{
            NSArray * tempArry = [text componentsSeparatedByString:@","];
            for (NSInteger index = 0; index < tempArry.count; index++) {
                strRetun = [strRetun stringByAppendingString:@"*"];
            }
        }
    }
    return strRetun;
}


@end
