#import "FlutterMetaSdkPlugin.h"
#if __has_include(<flutter_meta_sdk/flutter_meta_sdk-Swift.h>)
#import <flutter_meta_sdk/flutter_meta_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_meta_sdk-Swift.h"
#endif

@implementation FlutterMetaSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterMetaSdkPlugin registerWithRegistrar:registrar];
}
@end
