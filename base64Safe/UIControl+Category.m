//
//  ZSCSafeKeyBoard
//
//  Created by jrjc on 17/2/16.
//  Copyright © 2017年 jrjc. All rights reserved.
//

#import "UIControl+Category.h"
#import "objc/runtime.h"

static const void * OrderTagsBy = &OrderTagsBy;

@implementation UIControl (Category)
@dynamic OrderTags;


-(void)setOrderTags:(NSString *)OrderTags {
    objc_setAssociatedObject(self, OrderTagsBy, OrderTags, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)OrderTags {
  return objc_getAssociatedObject(self, OrderTagsBy);
}

@end
