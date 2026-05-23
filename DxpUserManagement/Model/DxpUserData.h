//
//  DxpUserData.h
//  DxpUserSDK
//
//  Created by 李标 on 2025/11/2.
//

#import <Foundation/Foundation.h>
#import "DxpBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface DxpUserData : DxpBaseObject

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, copy) NSString *tokenExpiryDate;

@property (nonatomic, copy) NSString *serviceNumber;
@property (nonatomic, copy) NSString *subsId;
@property (nonatomic, copy) NSString *custNbr;

@property (nonatomic, copy) NSString *resultCode;
@property (nonatomic, copy) NSString *resultMsg;

@end

NS_ASSUME_NONNULL_END
