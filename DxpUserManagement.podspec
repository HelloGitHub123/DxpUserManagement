Pod::Spec.new do |spec|
  spec.name         = "DxpUserManagement"
  spec.module_name  = "DxpUserManagement"
  spec.version      = "1.0.2"
  spec.summary      = "Dxp User Management"
  spec.description  = "Dxp User Management SDK: User management, including login, logout, and device token reporting. Supports Swift projects via module import without a bridging header."
  spec.homepage     = "https://github.com/HelloGitHub123/DxpUserManagement"
  spec.license      = "MIT"
  spec.author       = { "李标" => "li.biao3@iwhalecloud.com" }

  spec.platform     = :ios, "12.0"
  spec.swift_version = "5.0"
  spec.source       = { :git => "https://github.com/HelloGitHub123/DxpUserManagement.git", :tag => "1.0.2" }

  spec.source_files = "DxpUserManagement/**/*.{h,m,swift}"
  spec.public_header_files = [
    "DxpUserManagement/DxpUserManagement.h",
    "DxpUserManagement/Model/DxpBaseObject.h",
    "DxpUserManagement/Model/DxpDeviceReportModel.h",
    "DxpUserManagement/Model/DxpUserData.h",
    "DxpUserManagement/Model/DxpUserIdentityLogoutModel.h",
    "DxpUserManagement/Utils/DxpUserDefaults.h"
  ]
  spec.private_header_files = [
    "DxpUserManagement/Model/HJRequestProtocolForVM.h"
  ]
  spec.header_mappings_dir = "DxpUserManagement"

  spec.requires_arc = true
  spec.static_framework = true

  spec.pod_target_xcconfig = {
    "DEFINES_MODULE" => "YES",
    "CLANG_ENABLE_MODULES" => "YES",
    "BUILD_LIBRARY_FOR_DISTRIBUTION" => "YES",
    "SWIFT_VERSION" => "5.0",
    "SWIFT_INSTALL_OBJC_HEADER" => "YES"
  }

  spec.user_target_xcconfig = {
    "CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES" => "YES"
  }

  spec.dependency "DXPNetWorkingManagerLib"
  spec.dependency "DXPToolsLib"
end
