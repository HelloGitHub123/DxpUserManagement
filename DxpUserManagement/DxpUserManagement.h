//
//  DxpUserManagement.h
//  DxpUser
//
//  Created by 李标 on 2026/5/23.
//

#import <Foundation/Foundation.h>

#import "DxpUserData.h"
#import "DxpUserIdentityLogoutModel.h"
#import "DxpDeviceReportModel.h"
#import "DxpUserDefaults.h"

NS_ASSUME_NONNULL_BEGIN

/// 登录完成回调：成功时 model 有值、message 可为空或 resultMsg；失败时 model 为 nil，message 为错误描述
typedef void (^DxpUserManagementLoginCompletion)(DxpUserData * _Nullable model, NSString *message);

/// 登出完成回调：成功时 model 有值、message 可为空或 resultMsg；失败时 model 为 nil，message 为错误描述
typedef void (^DxpUserManagementLogoutCompletion)(DxpUserIdentityLogoutModel * _Nullable model, NSString *message);

/// 设备 Token 上报完成回调：成功时 model 有值、message 可为空或 resultMsg；失败时 model 为 nil，message 为错误描述
typedef void (^DxpUserManagementDeviceReportCompletion)(DxpDeviceReportModel * _Nullable model, NSString *message);

@interface DxpUserManagement : NSObject

/// 登录接口
+ (void)login:(NSString *)custNbr
serviceNumber:(NSString *)serviceNumber
       subsId:(NSString *)subsId
   completion:(nullable DxpUserManagementLoginCompletion)completion;

/// 登出
+ (void)logout:(NSString *)pushToken
pushServiceVendor:(NSString *)pushServiceVendor
        completion:(nullable DxpUserManagementLogoutCompletion)completion;

/// 上报设备 Token
+ (void)deviceTokenReport:(NSString *)pushToken
        pushServiceVendor:(NSString *)pushServiceVendor
               completion:(nullable DxpUserManagementDeviceReportCompletion)completion;

@end

NS_ASSUME_NONNULL_END
