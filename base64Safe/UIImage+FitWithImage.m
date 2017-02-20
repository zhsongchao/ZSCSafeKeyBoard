//
//  ZSCSafeKeyBoard
//
//  Created by jrjc on 17/2/16.
//  Copyright © 2017年 jrjc. All rights reserved.
//

#import "UIImage+FitWithImage.h"

@implementation UIImage (FitWithImage)
+ (UIImage *)FitWithBackBgroudImage {
    UIImage * SizeWithImage = [UIImage imageNamed:@"whiteBack"];
    SizeWithImage = [SizeWithImage stretchableImageWithLeftCapWidth:SizeWithImage.size.width * 0.5 topCapHeight:SizeWithImage.size.height * 0.5];
    return SizeWithImage;
}

+ (UIImage *)FitWithBackConsoleViewImage {
    UIImage * SizeWithImage = [UIImage imageNamed:@"congsoleView"];
    SizeWithImage = [SizeWithImage stretchableImageWithLeftCapWidth:SizeWithImage.size.width * 0.5 topCapHeight:SizeWithImage.size.height * 0.5];
    return SizeWithImage;
}





@end
