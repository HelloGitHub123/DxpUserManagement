# DxpUserManagement

用户管理 SDK，提供登录、登出、设备 Token 上报等能力。

## 集成方式

在 Podfile 中添加：

```ruby
use_frameworks! :linkage => :static

pod 'DxpUserManagement'
```

执行 `pod install` 后，Swift 工程直接 `import DxpUserManagement` 即可，**无需**在宿主工程中配置 Bridging Header 或编写 Objective-C 适配代码。

## Swift 调用示例

### Result 回调

```swift
import DxpUserManagement

DxpUserManagement.login(
    custNbr: "cust001",
    serviceNumber: "13800138000",
    subsId: "subs001"
) { result in
    switch result {
    case .success(let userData):
        print("token: \(userData.token ?? "")")
    case .failure(let error):
        print(error.localizedDescription)
    }
}
```

### async/await（iOS 13+）

```swift
import DxpUserManagement

Task {
    do {
        let userData = try await DxpUserManagement.login(
            custNbr: "cust001",
            serviceNumber: "13800138000",
            subsId: "subs001"
        )
        print("token: \(userData.token ?? "")")
    } catch {
        print(error.localizedDescription)
    }
}
```

### 登出与设备 Token 上报

```swift
DxpUserManagement.logout(pushToken: token, pushServiceVendor: vendor) { result in
    // ...
}

DxpUserManagement.deviceTokenReport(token, pushServiceVendor: vendor) { result in
    // ...
}
```

## Objective-C 调用示例

```objc
#import <DxpUserManagement/DxpUserManagement.h>

[DxpUserManagement login:@"cust001"
           serviceNumber:@"13800138000"
                  subsId:@"subs001"
              completion:^(DxpUserData *model, NSString *message) {
    if (model) {
        NSLog(@"token: %@", model.token);
    } else {
        NSLog(@"%@", message);
    }
}];
```

## 模块说明

SDK 内部已完成 Swift 互操作改造：

- 通过 `DEFINES_MODULE` 导出 Clang Module，Swift 工程可直接 `import`
- Umbrella Header 统一导出公开 API
- Swift 与 Objective-C 使用统一的类名与方法名
- SDK 内置 Swift 扩展，提供 `Result` 与 `async/await` 便捷接口
