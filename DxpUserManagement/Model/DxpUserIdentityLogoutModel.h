//
//  DxpUserIdentityLogoutModel.h
//  DxpUserSDK
//
//  Created by 李标 on 2025/11/3.
//

#import <Foundation/Foundation.h>
#import "DxpBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface DxpUserIdentityLogoutModel : DxpBaseObject

@property (nonatomic, copy) NSString *resultCode;
@property (nonatomic, copy) NSString *resultMsg;

@end

NS_ASSUME_NONNULL_END
