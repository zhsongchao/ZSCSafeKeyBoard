# ZSCSafeKeyBoard
金融行业base64安全键盘
一直想做一个能够推动产品发展的技术人员（深沉~），一直在发掘产品的槽点（老板在我后面），一直觉得安全才是金融行业的命脉（这句话是真的额~）！一直觉得一个金融产品没有一个安全加密的键盘是对客户财产的不尊重！于是有了这篇文章和文章底部的Demo，接入项目还是很方便的额，所以猿媛们没必要重复造轮子，把有限的精力投入到无限的国家IT建设中去！如果你需要拿去不谢~
内存是宝贵的，看一下效果演示再决定要不要下载：
![安全键盘演示.gif](http://upload-images.jianshu.io/upload_images/2189030-3f71ba52560c4d69.gif?imageMogr2/auto-orient/strip)
数字键盘没有做点击高亮是因为防止录屏啊！
有几处核心代码拿出来给大家看一下，方便需要的同学接入项目：
第一步：导入头文件
```
#import "HZCommanFunc.h"//base64的加密解密算法文件
#import "Base64KeyBoardView.h"//你要的键盘

@interface MainViewController ()<KeyBoardShowViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) Base64KeyBoardView * keyBoardView;

```
第二步：初始化键盘
```
- (void)initBase64KeyBoardView{
    self.keyBoardView = [Base64KeyBoardView KeyBoardMenu];
    self.keyBoardView.delegate = self;
//初始化block，改变输入法的时候可以在block里实现功能
    self.keyBoardView.BlockChnagkeyBoard = ^(UIView *v){
        NSLog(@"改变键盘输入法啦！");
    };
    self.nameTextFile.inputView = [self.keyBoardView NumberKeyBoardShowView];
    self.paseWordTextFile.inputView = [self.keyBoardView NumberKeyBoardShowView];
}
```
必须要说一下inputView这个textfile的属性，inputView
inputView就是显示键盘的view,
如果重写这个view则不再弹出键盘，而是弹出自己的view.
如果想实现当某一控件变为第一响应者时不弹出键盘而是弹出我们自定义的界面，那么我们就可以通过修改这个inputView来实现，比如弹出一个日期拾取器,或者自定义表情键盘。inputView不会随着键盘出现而出现，设置了InputView只会当UITextField或者UITextView变为第一相应者时自定义的键盘显示出来，不会显示系统的键盘了。设置了InputAccessoryView，它会随着键盘一起出现并且会显示在键盘的顶端。InutAccessoryView默认为nil。
自定义任何控件一般都是继承与UIView开始，这样的话难免会用到代理和block：
代理：
```
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
```
block:
```
/**block代码块*/
typedef void(^ChangKeyBoard)(UIView *);
@property (nonatomic, assign) id<KeyBoardShowViewDelegate>  delegate;
```
键盘虽然没有什么关键技术但是逻辑还是蛮复杂的，为了方便所以定义了几个结构体：
```
typedef enum  {
    NumberKeyBoard = 1,             // 数字键盘
    CharacterKeyBoard,               // 大写字符键盘
    SmallCharacterKeyBoard,     // 小写字符键盘
    EnglishKeyBoard                    // 英文符号键盘
} KeyBoardType;
typedef enum  {
    TextFiledFirst = 1,             // 首个文本框
    TextFiledSecond = 2,       // 2文本框
    TextFiledOther,                //
} UISelectTextPostion;

@property (nonatomic, copy) ChangKeyBoard  BlockChnagkeyBoard;
@property (nonatomic, assign) UISelectTextPostion  TextSelectPostion;
```
还有两处关键代码分别是base64加密和解密，定义了两个宏方便调用，不过加密解密算法虽然网上很多，但是最好做一些改变的，为了安全嘛：
调取加密算法：
```
__BASE64为加密算法定义的宏
NSString * baseStr = __BASE64([self.SmallCharacterArry objectAtIndex:sender.tag]);
self.JumpStr = [[self.ConnectStr stringByAppendingString:baseStr] stringByAppendingString:@","];
self.ConnectStr = self.JumpStr;
self.JumpStr = [self.JumpStr substringWithRange:NSMakeRange(0, self.JumpStr.length - 1)];
[self runDelegateFromButtonTag:self.JumpStr andButtonTage:[sender.OrderTags integerValue]];
```
调取解密算法：
```
__TEXT为解密算法定义的宏
+ (NSString *)tranceBaseToString :(NSString *)str{
    NSString * resStr = @"";
    for (NSString * item in [str componentsSeparatedByString:@","]) {
        resStr = [resStr stringByAppendingString:__TEXT(item)];
        NSLog(@"resStr解码后的字符串%@",resStr);
    }
    return resStr;
}
```
核心代码就这几处，里面具体的逻辑当然很麻烦，需要的同学可以把Demo下载下载看看，如有Bug欢迎指正共同解决，大神请略过！如果对你有帮助请给我鼓励，点个喜欢，github给个star！
下载Demo请点这里[金融行业base64安全加密键盘](https://github.com/zhsongchao/ZSCSafeKeyBoard)！
