//
//  MessageModel.h
//  realmTest
//
//  Created by 云财富 on 2019/5/6.
//  Copyright © 2019 YunCaiFu. All rights reserved.
//

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : RLMObject

@property NSString *userID;
@property NSString *messageContext;
@property NSString *linkUrl;
@property NSString *Time;
@property BOOL isRead;

@end

NS_ASSUME_NONNULL_END
