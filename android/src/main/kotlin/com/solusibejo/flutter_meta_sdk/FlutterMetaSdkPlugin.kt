package com.solusibejo.flutter_meta_sdk

import android.content.Context
import androidx.annotation.NonNull
import com.facebook.appevents.AppEventsLogger
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterMetaSdkPlugin */
class FlutterMetaSdkPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel
  private lateinit var appEventsLogger: AppEventsLogger
  private lateinit var anonymousId: String
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(
      flutterPluginBinding.binaryMessenger,
      "solusibejo.com/flutter_meta_sdk"
    )
    channel.setMethodCallHandler(this)

    appEventsLogger = AppEventsLogger.newLogger(flutterPluginBinding.applicationContext)
    anonymousId =
      AppEventsLogger.getAnonymousAppDeviceGUID(flutterPluginBinding.applicationContext)

    context = flutterPluginBinding.applicationContext
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "activateApp" -> FlutterMetaSdkMethods.activateApp(appEventsLogger, result)
      "clearUserData" -> FlutterMetaSdkMethods.clearUserData(result)
      "setUserData" -> FlutterMetaSdkMethods.setUserData(call, result)
      "clearUserID" -> FlutterMetaSdkMethods.clearUserId(result)
      "flush" -> FlutterMetaSdkMethods.flush(appEventsLogger, result)
      "getApplicationId" -> FlutterMetaSdkMethods.getApplicationId(appEventsLogger, result)
      "logEvent" -> FlutterMetaSdkMethods.logEvent(appEventsLogger, call, result)
      "logPushNotificationOpen" -> FlutterMetaSdkMethods.pushNotificationOpen(
        appEventsLogger,
        call,
        result
      )
      "setUserID" -> FlutterMetaSdkMethods.setUserId(call, result)
      "setAutoLogAppEventsEnabled" -> FlutterMetaSdkMethods.setAutoLogAppEventsEnabled(
        call,
        result
      )
      "setDataProcessingOptions" -> FlutterMetaSdkMethods.setDataProcessingOptions(call, result)
      "getAnonymousId" -> FlutterMetaSdkMethods.getAnonymousId(
        anonymousId,
        result
      )
      "logPurchase" -> FlutterMetaSdkMethods.purchased(appEventsLogger, call, result)
      "setAdvertiserTracking" -> FlutterMetaSdkMethods.setAdvertiserTracking(result)
      else -> result.notImplemented()
    }
  }
}
