//
//  DxpUserManagement.m
//  DxpUser
//
//  Created by 李标 on 2026/5/23.
//

#import "DxpUserManagement.h"
#import "DxpUserData.h"
#import "DxpUserIdentityLogoutModel.h"
#import "DxpDeviceReportModel.h"
#import <DXPNetWorkingManagerLib/DCNetAPIClient.h>
#import <MJExtension/MJExtension.h>

@implementation DxpUserManagement

+ (BOOL)dxp_isSuccessResultCode:(NSString *)resultCode {
	return [resultCode isEqualToString:@"0"] || [resultCode isEqualToString:@"DXP-0"];
}

+ (void)login:(NSString *)custNbr
serviceNumber:(NSString *)serviceNumber
       subsId:(NSString *)subsId
   completion:(DxpUserManagementLoginCompletion)completion {
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	if (subsId.length > 0) {
		params[@"subsId"] = subsId;
	}
	if (serviceNumber.length > 0) {
		params[@"serviceNumber"] = serviceNumber;
	}
	if (custNbr.length > 0) {
		params[@"custNbr"] = custNbr;
	}

	[[DCNetAPIClient sharedClient] POST:@"/dxp/user-management/legacy/v1/user/identity-initial"
							 paramaters:params
						  CompleteBlock:^(id res, NSError *error) {
		if (!completion) {
			return;
		}

		void (^dispatchResult)(DxpUserData * _Nullable, NSString *) = ^(DxpUserData *model, NSString *message) {
			dispatch_async(dispatch_get_main_queue(), ^{
				completion(model, message ?: @"");
			});
		};

		if (error) {
			NSString *message = error.localizedDescription ?: @"Network request failed";
			if ([res isKindOfClass:[NSDictionary class]]) {
				NSString *resultMsg = [(NSDictionary *)res objectForKey:@"resultMsg"];
				if (resultMsg.length > 0) {
					message = resultMsg;
				}
			}
			dispatchResult(nil, message);
			return;
		}

		if (![res isKindOfClass:[NSDictionary class]]) {
			dispatchResult(nil, @"Response data format error");
			return;
		}

		NSDictionary *dict = (NSDictionary *)res;
		NSString *resultCode = [NSString stringWithFormat:@"%@", dict[@"resultCode"] ?: @""];
		NSString *resultMsg = dict[@"resultMsg"];
		if (![resultCode isKindOfClass:[NSString class]]) {
			resultCode = [dict[@"resultCode"] description];
		}
		if (![resultMsg isKindOfClass:[NSString class]] && dict[@"resultMsg"] != nil) {
			resultMsg = [dict[@"resultMsg"] description];
		}

		if (![self dxp_isSuccessResultCode:resultCode]) {
			NSString *message = resultMsg.length > 0 ? resultMsg : @"登录失败";
			dispatchResult(nil, message);
			return;
		}

		NSDictionary *data = dict[@"data"];
		DxpUserData *model = nil;
		if ([data isKindOfClass:[NSDictionary class]]) {
			model = [DxpUserData mj_objectWithKeyValues:data];
		}
		if (!model) {
			model = [[DxpUserData alloc] init];
		}
		model.resultCode = resultCode;
		model.resultMsg = resultMsg ?: @"";

		if (model.token.length > 0) {
			[DCNetAPIClient sharedClient].token = model.token;
		}

		model.serviceNumber = serviceNumber;
		model.subsId = subsId;
		model.custNbr = custNbr;

		dispatchResult(model, model.resultMsg.length > 0 ? model.resultMsg : @"");
	}];
}

// 登出
+ (void)logout:(NSString *)pushToken
pushServiceVendor:(NSString *)pushServiceVendor
        completion:(DxpUserManagementLogoutCompletion)completion {
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	if (pushToken.length > 0) {
		params[@"pushToken"] = pushToken;
	}
	if (pushServiceVendor.length > 0) {
		params[@"pushServiceVendor"] = pushServiceVendor;
	}

	[[DCNetAPIClient sharedClient] POST:@"/dxp/user-management/legacy/v1/user/identity-logout"
							 paramaters:params
						  CompleteBlock:^(id res, NSError *error) {
		if (!completion) {
			return;
		}

		void (^dispatchResult)(DxpUserIdentityLogoutModel * _Nullable, NSString *) = ^(DxpUserIdentityLogoutModel *model, NSString *message) {
			dispatch_async(dispatch_get_main_queue(), ^{
				completion(model, message ?: @"");
			});
		};

		if (error) {
			[DCNetAPIClient sharedClient].token = @"";
			NSString *message = error.localizedDescription ?: @"Network request failed";
			if ([res isKindOfClass:[NSDictionary class]]) {
				NSString *resultMsg = [(NSDictionary *)res objectForKey:@"resultMsg"];
				if (resultMsg.length > 0) {
					message = resultMsg;
				}
			}
			dispatchResult(nil, message);
			return;
		}

		if (![res isKindOfClass:[NSDictionary class]]) {
			[DCNetAPIClient sharedClient].token = @"";
			dispatchResult(nil, @"Response data format error");
			return;
		}

		NSDictionary *dict = (NSDictionary *)res;
		NSString *resultCode = [NSString stringWithFormat:@"%@", dict[@"resultCode"] ?: @""];
		NSString *resultMsg = dict[@"resultMsg"];
		if (![resultMsg isKindOfClass:[NSString class]] && dict[@"resultMsg"] != nil) {
			resultMsg = [dict[@"resultMsg"] description];
		}

		DxpUserIdentityLogoutModel *model = [DxpUserIdentityLogoutModel mj_objectWithKeyValues:dict];
		if (!model) {
			model = [[DxpUserIdentityLogoutModel alloc] init];
		}
		model.resultCode = resultCode;
		model.resultMsg = resultMsg ?: @"";

		[DCNetAPIClient sharedClient].token = @"";

		if (![self dxp_isSuccessResultCode:resultCode]) {
			NSString *message = resultMsg.length > 0 ? resultMsg : @"Logout failed";
			dispatchResult(nil, message);
			return;
		}

		dispatchResult(model, model.resultMsg.length > 0 ? model.resultMsg : @"");
	}];
}

// 上报接口
+ (void)deviceTokenReport:(NSString *)pushToken
        pushServiceVendor:(NSString *)pushServiceVendor
               completion:(DxpUserManagementDeviceReportCompletion)completion {
	if (pushToken.length == 0) {
		if (completion) {
			dispatch_async(dispatch_get_main_queue(), ^{
				completion(nil, @"pushToken must not be empty");
			});
		}
		return;
	}

	NSDictionary *params = @{
		@"pushToken": pushToken,
		@"pushServiceVendor": pushServiceVendor,
	};

	[[DCNetAPIClient sharedClient] PUT:@"/dxp/user-management/legacy/v1/device/report"
							paramaters:params
						 CompleteBlock:^(id res, NSError *error) {
		if (!completion) {
			return;
		}

		void (^dispatchResult)(DxpDeviceReportModel * _Nullable, NSString *) = ^(DxpDeviceReportModel *model, NSString *message) {
			dispatch_async(dispatch_get_main_queue(), ^{
				completion(model, message ?: @"");
			});
		};

		if (error) {
			NSString *message = error.localizedDescription ?: @"Network request failed";
			if ([res isKindOfClass:[NSDictionary class]]) {
				NSString *resultMsg = [(NSDictionary *)res objectForKey:@"resultMsg"];
				if (resultMsg.length > 0) {
					message = resultMsg;
				}
			}
			dispatchResult(nil, message);
			return;
		}

		if (![res isKindOfClass:[NSDictionary class]]) {
			dispatchResult(nil, @"Response data format error");
			return;
		}

		NSDictionary *dict = (NSDictionary *)res;
		NSString *resultCode = [NSString stringWithFormat:@"%@", dict[@"resultCode"] ?: @""];
		NSString *resultMsg = dict[@"resultMsg"];
		if (![resultMsg isKindOfClass:[NSString class]] && dict[@"resultMsg"] != nil) {
			resultMsg = [dict[@"resultMsg"] description];
		}

		DxpDeviceReportModel *model = [DxpDeviceReportModel mj_objectWithKeyValues:dict];
		if (!model) {
			model = [[DxpDeviceReportModel alloc] init];
		}
		model.resultCode = resultCode;
		model.resultMsg = resultMsg ?: @"";

		if (![self dxp_isSuccessResultCode:resultCode]) {
			NSString *message = resultMsg.length > 0 ? resultMsg : @"Device token upload failed";
			dispatchResult(nil, message);
			return;
		}

		dispatchResult(model, model.resultMsg.length > 0 ? model.resultMsg : @"");
	}];
}

@end
