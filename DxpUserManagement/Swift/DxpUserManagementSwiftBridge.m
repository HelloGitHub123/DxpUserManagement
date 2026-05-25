//
//  DxpUserManagementSwiftBridge.m
//  DxpUserManagement
//

#import "DxpUserManagementSwiftBridge.h"
#import "DxpUserManagement.h"

@implementation DxpUserManagementSwiftBridge

+ (void)loginWithCustNbr:(NSString *)custNbr
           serviceNumber:(NSString *)serviceNumber
                  subsId:(NSString *)subsId
              completion:(DxpUserManagementBridgeLoginCompletion)completion {
	[DxpUserManagement login:custNbr
			   serviceNumber:serviceNumber
					  subsId:subsId
				  completion:completion];
}

+ (void)logoutWithPushToken:(NSString *)pushToken
          pushServiceVendor:(NSString *)pushServiceVendor
                 completion:(DxpUserManagementBridgeLogoutCompletion)completion {
	[DxpUserManagement logout:pushToken
			pushServiceVendor:pushServiceVendor
				   completion:completion];
}

+ (void)deviceTokenReportWithPushToken:(NSString *)pushToken
                   pushServiceVendor:(NSString *)pushServiceVendor
                          completion:(DxpUserManagementBridgeDeviceReportCompletion)completion {
	[DxpUserManagement deviceTokenReport:pushToken
					   pushServiceVendor:pushServiceVendor
							  completion:completion];
}

@end
