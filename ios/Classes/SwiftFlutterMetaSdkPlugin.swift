import Flutter
import UIKit
import FBSDKCoreKit

public class SwiftFlutterMetaSdkPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
            let channel = FlutterMethodChannel(name: "solusibejo.com/flutter_meta_sdk", binaryMessenger: registrar.messenger())
            let instance = SwiftFlutterMetaSdkPlugin()

            // Required for FB SDK 9.0, as it does not initialize the SDK automatically any more.
            // See: https://developers.facebook.com/blog/post/2021/01/19/introducing-facebook-platform-sdk-version-9/
            // "Removal of Auto Initialization of SDK" section
            ApplicationDelegate.shared.initializeSDK()

            registrar.addMethodCallDelegate(instance, channel: channel)
            registrar.addApplicationDelegate(instance)
        }
        
        public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
            Settings.shared.isAdvertiserTrackingEnabled = false
            let launchOptionsForFacebook = launchOptions as? [UIApplication.LaunchOptionsKey: Any]
            ApplicationDelegate.shared.application(
                application,
                didFinishLaunchingWithOptions:
                    launchOptionsForFacebook
            )
            return true
        }
        
        public func applicationDidBecomeActive(_ application: UIApplication) {
            FlutterMetaSdkMethods.activateApp()
        }
        
        public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            return ApplicationDelegate.shared.application(application, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        }

        public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
            switch call.method {
            case "activateApp":
                FlutterMetaSdkMethods.activateApp()
                break
            case "clearUserData":
                FlutterMetaSdkMethods.clearUserData(result: result)
                break
            case "setUserData":
                FlutterMetaSdkMethods.setUserData(call, result: result)
                break
            case "clearUserID":
                FlutterMetaSdkMethods.clearUserID(result: result)
                break
            case "flush":
                FlutterMetaSdkMethods.flush(result: result)
                break
            case "getApplicationId":
                FlutterMetaSdkMethods.getApplicationId(result: result)
                break
            case "logEvent":
                FlutterMetaSdkMethods.logEvent(call, result: result)
                break
            case "logPushNotificationOpen":
                FlutterMetaSdkMethods.pushNotificationOpen(call, result: result)
                break
            case "setUserID":
                FlutterMetaSdkMethods.setUserId(call, result: result)
                break
            case "setAutoLogAppEventsEnabled":
                FlutterMetaSdkMethods.setAutoLogAppEventsEnabled(call, result: result)
                break
            case "setDataProcessingOptions":
                FlutterMetaSdkMethods.setDataProcessingOptions(call, result: result)
                break
            case "logPurchase":
                FlutterMetaSdkMethods.purchased(call, result: result)
                break
            case "getAnonymousId":
                FlutterMetaSdkMethods.getAnonymousId(result: result)
                break
            case "setAdvertiserTracking":
                FlutterMetaSdkMethods.setAdvertiserTracking(call, result: result)
                break
            default:
                result(FlutterMethodNotImplemented)
            }
        }
}
