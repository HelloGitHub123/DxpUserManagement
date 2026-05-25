//
//  DxpUserManagementSwiftBridge.h
//  DxpUserManagement
//

#import <Foundation/Foundation.h>

@class DxpUserData;
@class DxpUserIdentityLogoutModel;
@class DxpDeviceReportModel;

NS_ASSUME_NONNULL_BEGIN

typedef void (^DxpUserManagementBridgeLoginCompletion)(DxpUserData * _Nullable model, NSString *message);
typedef void (^DxpUserManagementBridgeLogoutCompletion)(DxpUserIdentityLogoutModel * _Nullable model, NSString *message);
typedef void (^DxpUserManagementBridgeDeviceReportCompletion)(DxpDeviceReportModel * _Nullable model, NSString *message);

/// Swift 扩展层使用的 Objective-C 桥接入口，避免 Swift 侧同名方法遮蔽原始 API。
@interface DxpUserManagementSwiftBridge : NSObject

+ (void)loginWithCustNbr:(NSString *)custNbr
           serviceNumber:(NSString *)serviceNumber
                  subsId:(NSString *)subsId
              completion:(nullable DxpUserManagementBridgeLoginCompletion)completion;

+ (void)logoutWithPushToken:(NSString *)pushToken
          pushServiceVendor:(NSString *)pushServiceVendor
                 completion:(nullable DxpUserManagementBridgeLogoutCompletion)completion;

+ (void)deviceTokenReportWithPushToken:(NSString *)pushToken
                   pushServiceVendor:(NSString *)pushServiceVendor
                          completion:(nullable DxpUserManagementBridgeDeviceReportCompletion)completion;

@end

NS_ASSUME_NONNULL_END
