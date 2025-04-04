//
//  FlutterMetaSdkMethods.swift
//  flutter_meta_sdk
//
//  Created by Chandra Abdul Fattah on 25/07/22.
//

import Foundation
import FBSDKCoreKit
import FBSDKCoreKit_Basics
import FBAudienceNetwork

class FlutterMetaSdkMethods {
    static func clearUserData(result: @escaping FlutterResult) {
        AppEvents.shared.clearUserData()
        result(nil)
    }

    static func setUserData(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? [String: Any] ?? [String: Any]()

        AppEvents.shared.setUserData(arguments["email"] as? String, forType: FBSDKAppEventUserDataType.email)
        AppEvents.shared.setUserData(arguments["firstName"] as? String, forType: FBSDKAppEventUserDataType.firstName)
        AppEvents.shared.setUserData(arguments["lastName"] as? String, forType: FBSDKAppEventUserDataType.lastName)
        AppEvents.shared.setUserData(arguments["phone"] as? String, forType: FBSDKAppEventUserDataType.phone)
        AppEvents.shared.setUserData(arguments["dateOfBirth"] as? String, forType: FBSDKAppEventUserDataType.dateOfBirth)
        AppEvents.shared.setUserData(arguments["gender"] as? String, forType: FBSDKAppEventUserDataType.gender)
        AppEvents.shared.setUserData(arguments["city"] as? String, forType: FBSDKAppEventUserDataType.city)
        AppEvents.shared.setUserData(arguments["state"] as? String, forType: FBSDKAppEventUserDataType.state)
        AppEvents.shared.setUserData(arguments["zip"] as? String, forType: FBSDKAppEventUserDataType.zip)
        AppEvents.shared.setUserData(arguments["country"] as? String, forType: FBSDKAppEventUserDataType.country)

        result(nil)
    }

    static func clearUserID(result: @escaping FlutterResult) {
        AppEvents.shared.userID = nil
        result(nil)
    }

    static func flush(result: @escaping FlutterResult) {
        AppEvents.shared.flush()
        result(nil)
    }

    /// iOS FBSDKCoreKit doesn't expose a getSdkVersion [like Android does](https://developers.facebook.com/docs/reference/androidsdk/current/facebook/com/facebook/facebooksdk.html/#getsdkversion)
    /// so just return "latest"  as this is what is set in the podspec
    static func getSdkVersion(result: @escaping FlutterResult) {
        result("latest")
    }

    static func getApplicationId(result: @escaping FlutterResult) {
        result(Settings.shared.appID)
    }

    static func getAnonymousId(result: @escaping FlutterResult) {
        result(AppEvents.shared.anonymousID)
    }

    static func logEvent(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? [String: Any] ?? [String: Any]()
        let eventName = arguments["name"] as! String
        let parameters = arguments["parameters"] as? [AppEvents.ParameterName: Any] ?? [AppEvents.ParameterName: Any]()
        if arguments["_valueToSum"] != nil && !(arguments["_valueToSum"] is NSNull) {
            let valueToDouble = arguments["_valueToSum"] as! Double
            AppEvents.shared.logEvent(AppEvents.Name(eventName), valueToSum: valueToDouble, parameters: parameters)
        } else {
            AppEvents.shared.logEvent(AppEvents.Name(eventName), parameters: parameters)
        }

        result(nil)
    }

    static func pushNotificationOpen(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? [String: Any] ?? [String: Any]()
        let payload = arguments["payload"] as? [String: Any]
        if let action = arguments["action"] {
            let actionString = action as! String
            AppEvents.shared.logPushNotificationOpen(payload: payload!, action: actionString)
        } else {
            AppEvents.shared.logPushNotificationOpen(payload: payload!)
        }

        result(nil)
    }

    static func setUserId(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let id = call.arguments as! String
        AppEvents.shared.userID = id
        result(nil)
    }

    static func setAutoLogAppEventsEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enabled = call.arguments as! Bool
        Settings.shared.isAutoLogAppEventsEnabled = enabled
        result(nil)
    }

    static func setDataProcessingOptions(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? [String: Any] ?? [String: Any]()
        let modes = arguments["options"] as? [String] ?? []
        let state = arguments["state"] as? Int32 ?? 0
        let country = arguments["country"] as? Int32 ?? 0

        Settings.shared.setDataProcessingOptions(modes, country: country, state: state)

        result(nil)
    }

    static func purchased(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? [String: Any] ?? [String: Any]()
        let amount = arguments["amount"] as! Double
        let currency = arguments["currency"] as! String
        let parameters = arguments["parameters"] as? [AppEvents.ParameterName: Any] ?? [AppEvents.ParameterName: Any]()
        AppEvents.shared.logPurchase(amount: amount, currency: currency, parameters: parameters)

        result(nil)
    }

    static func setAdvertiserTracking(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? [String: Any] ?? [String: Any]()
        let enabled = arguments["enabled"] as! Bool
        let collectId = arguments["collectId"] as! Bool
        Settings.shared.isAdvertiserTrackingEnabled = enabled
        Settings.shared.isAdvertiserIDCollectionEnabled = collectId
        result(nil)
    }
    
    static func activateApp(){
        AppEvents.shared.activateApp()
    }
}
