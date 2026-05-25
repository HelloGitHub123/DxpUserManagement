import Foundation

/// SDK 内统一的业务错误类型，Swift 工程可直接使用，无需额外桥接。
public enum DxpUserManagementError: Error, LocalizedError, Sendable {
    case requestFailed(message: String)

    public var errorDescription: String? {
        switch self {
        case .requestFailed(let message):
            return message
        }
    }
}

public extension DxpUserManagement {

    /// Result 风格登录接口
    static func login(
        custNbr: String,
        serviceNumber: String,
        subsId: String,
        completion: @escaping (Result<DxpUserData, DxpUserManagementError>) -> Void
    ) {
        DxpUserManagementSwiftBridge.login(
            withCustNbr: custNbr,
            serviceNumber: serviceNumber,
            subsId: subsId
        ) { model, message in
            if let model {
                completion(.success(model))
            } else {
                completion(.failure(.requestFailed(message: message)))
            }
        }
    }

    /// Result 风格登出接口
    static func logout(
        pushToken: String,
        pushServiceVendor: String,
        completion: @escaping (Result<DxpUserIdentityLogoutModel, DxpUserManagementError>) -> Void
    ) {
        DxpUserManagementSwiftBridge.logout(
            withPushToken: pushToken,
            pushServiceVendor: pushServiceVendor
        ) { model, message in
            if let model {
                completion(.success(model))
            } else {
                completion(.failure(.requestFailed(message: message)))
            }
        }
    }

    /// Result 风格设备 Token 上报接口
    static func deviceTokenReport(
        _ pushToken: String,
        pushServiceVendor: String,
        completion: @escaping (Result<DxpDeviceReportModel, DxpUserManagementError>) -> Void
    ) {
        DxpUserManagementSwiftBridge.deviceTokenReport(
            withPushToken: pushToken,
            pushServiceVendor: pushServiceVendor
        ) { model, message in
            if let model {
                completion(.success(model))
            } else {
                completion(.failure(.requestFailed(message: message)))
            }
        }
    }
}

@available(iOS 13.0, *)
public extension DxpUserManagement {

    /// async/await 登录接口
    static func login(
        custNbr: String,
        serviceNumber: String,
        subsId: String
    ) async throws -> DxpUserData {
        try await withCheckedThrowingContinuation { continuation in
            login(
                custNbr: custNbr,
                serviceNumber: serviceNumber,
                subsId: subsId
            ) { (result: Result<DxpUserData, DxpUserManagementError>) in
                continuation.resume(with: result)
            }
        }
    }

    /// async/await 登出接口
    static func logout(
        pushToken: String,
        pushServiceVendor: String
    ) async throws -> DxpUserIdentityLogoutModel {
        try await withCheckedThrowingContinuation { continuation in
            logout(
                pushToken: pushToken,
                pushServiceVendor: pushServiceVendor
            ) { (result: Result<DxpUserIdentityLogoutModel, DxpUserManagementError>) in
                continuation.resume(with: result)
            }
        }
    }

    /// async/await 设备 Token 上报接口
    static func deviceTokenReport(
        _ pushToken: String,
        pushServiceVendor: String
    ) async throws -> DxpDeviceReportModel {
        try await withCheckedThrowingContinuation { continuation in
            deviceTokenReport(
                pushToken,
                pushServiceVendor: pushServiceVendor
            ) { (result: Result<DxpDeviceReportModel, DxpUserManagementError>) in
                continuation.resume(with: result)
            }
        }
    }
}
