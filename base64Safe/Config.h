//
//  ZSCSafeKeyBoard
//
//  Created by jrjc on 17/2/16.
//  Copyright © 2017年 jrjc. All rights reserved.
//

#ifndef Config_h
#define Config_h

#define DEVICE [[UIDevice currentDevice].systemVersion integerValue] < 7.0
#define IS_IOS7 (BOOL)([[[UIDevice currentDevice] systemVersion]floatValue]>=7.0 ? YES : NO)


#define KWidthScale ([UIScreen mainScreen].bounds.size.width / 320.0)
#define KHeightScale ([UIScreen mainScreen].bounds.size.height / 568.0)


#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define KeyBoardHeight (216)
#define KeyBoardHeightScale ((KeyBoardHeight) * (KHeightScale))

#define KeyBoardTitleColor [UIColor blackColor]

#define KeyBoardNumberFont [UIFont systemFontOfSize:20]
#define KeyBoardFont [UIFont systemFontOfSize:15]

/* 数字键盘*/

#define HNumberCount (3)
#define VNumberCount (4)

#define NumberPadding (0.6)
#define NumberPaddingHScale (NumberPadding *  (KHeightScale))
#define NumberPaddingVScale (NumberPadding *  (KWidthScale))

#define NumberButtonWidth (106.3)
#define NumberButtonWidthScale (NumberButtonWidth *  (KWidthScale))

#define NumberButtonHeight (53)
#define NumberButtonHeightScale (NumberButtonHeight *  (KHeightScale))

/* 英文字符键盘 第一行*/
// 距离父试图头部间距
#define PaddingTop (13)
#define PaddingTopScale  ((13) * (KHeightScale))
// 距离左边距
#define MarddingLeft (3)
#define MarddingLeftSclae ((3) * (KWidthScale))
/**
 *  距离右边距
 */
#define PaddingRight (6)
#define PaddingRightScale ((6) * (KWidthScale))

/**
 *  距离下边距
 */
#define PaddingButtom (15)
#define PaddingButtomScale ((15) * (KHeightScale))

/**
 *  按钮宽
 */
#define CharBtnWidth (26)
#define CharBtnWidthScale ((26) * (KWidthScale))

/**
 *  按钮高
 */
#define CharBtnHeight (39)
#define CharBtnHeightScale ((39) * (KHeightScale))

/* 英文字符键盘 第二行*/

/**
 *  第二行距离左边距
 */
#define MarddingSecondLeft (19)
#define MarddingSecondLeftSclae ((19) * (KWidthScale))


/**
 *  大小写切换
 */
#define BigToSmallWidth (36)
#define BigToSmallWidthScale ((BigToSmallWidth) * (KWidthScale))



#define PaddingThirdRight (12)
#define PaddingThirdRightScale ((PaddingThirdRight) * (KWidthScale))


/**
 *  数字切换
 */
#define NumberChnageWidth (34)
#define NumberChnageWidthScale ((NumberChnageWidth) * (KWidthScale))



/**
 *  空格切换
 */
#define SpeaceButtonWidth (190)
#define SpeaceButtonWidthScale ((SpeaceButtonWidth) * (KWidthScale))

/**
 *  换行
 */
#define ReturnButtonWidth (74)
#define ReturnButtonWidthScale ((ReturnButtonWidth) * (KWidthScale))

/**
 *  键盘OrderTages基数
 */
#define CharacterKey 20

#define EnglishKey (30)


#endif /* Config_h */
