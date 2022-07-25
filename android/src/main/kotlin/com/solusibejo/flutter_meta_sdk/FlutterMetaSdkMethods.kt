package com.solusibejo.flutter_meta_sdk

import android.os.Bundle
import com.facebook.FacebookSdk
import com.facebook.appevents.AppEventsConstants
import com.facebook.appevents.AppEventsLogger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.*

object FlutterMetaSdkMethods {
    fun activateApp(appEventsLogger: AppEventsLogger, result: MethodChannel.Result) {
        appEventsLogger.logEvent(AppEventsConstants.EVENT_NAME_ACTIVATED_APP)
        result.success(null)
    }

    fun clearUserData(result: MethodChannel.Result) {
        AppEventsLogger.clearUserData()
        result.success(null)
    }

    fun setUserData(call: MethodCall, result: MethodChannel.Result) {
        val parameters = call.argument("parameters") as? Map<String, Any>
        val parameterBundle = createBundleFromMap(parameters)

        AppEventsLogger.setUserData(
            parameterBundle?.getString("email"),
            parameterBundle?.getString("firstName"),
            parameterBundle?.getString("lastName"),
            parameterBundle?.getString("phone"),
            parameterBundle?.getString("dateOfBirth"),
            parameterBundle?.getString("gender"),
            parameterBundle?.getString("city"),
            parameterBundle?.getString("state"),
            parameterBundle?.getString("zip"),
            parameterBundle?.getString("country")
        )

        result.success(null)
    }

    fun clearUserId(result: MethodChannel.Result) {
        AppEventsLogger.clearUserID()
        result.success(null)
    }

    fun flush(appEventsLogger: AppEventsLogger, result: MethodChannel.Result) {
        appEventsLogger.flush()
        result.success(null)
    }

    fun getApplicationId(appEventsLogger: AppEventsLogger, result: MethodChannel.Result) {
        result.success(appEventsLogger.applicationId)
    }

    fun getAnonymousId(anonymousId: String, result: MethodChannel.Result) {
        result.success(anonymousId)
    }

    //not an android implementation as of yet
    fun setAdvertiserTracking(result: MethodChannel.Result) {
        result.success(null)
    }

    fun logEvent(appEventsLogger: AppEventsLogger, call: MethodCall, result: MethodChannel.Result) {
        val eventName = call.argument("name") as? String
        val parameters = call.argument("parameters") as? Map<String, Any>
        val valueToSum = call.argument("_valueToSum") as? Double

        if (valueToSum != null && parameters != null) {
            val parameterBundle = createBundleFromMap(parameters)
            appEventsLogger.logEvent(eventName, valueToSum, parameterBundle)
        } else if (valueToSum != null) {
            appEventsLogger.logEvent(eventName, valueToSum)
        } else if (parameters != null) {
            val parameterBundle = createBundleFromMap(parameters)
            appEventsLogger.logEvent(eventName, parameterBundle)
        } else {
            appEventsLogger.logEvent(eventName)
        }

        result.success(null)
    }

    fun pushNotificationOpen(
        appEventsLogger: AppEventsLogger,
        call: MethodCall,
        result: MethodChannel.Result
    ) {
        val action = call.argument("action") as? String
        val payload = call.argument("payload") as? Map<String, Any>
        val payloadBundle = createBundleFromMap(payload)!!

        if (action != null) {
            appEventsLogger.logPushNotificationOpen(payloadBundle, action)
        } else {
            appEventsLogger.logPushNotificationOpen(payloadBundle)
        }

        result.success(null)
    }

    fun setUserId(call: MethodCall, result: MethodChannel.Result) {
        val id = call.arguments as String
        AppEventsLogger.setUserID(id)
        result.success(null)
    }

    private fun createBundleFromMap(parameterMap: Map<String, Any>?): Bundle? {
        if (parameterMap == null) {
            return null
        }

        val bundle = Bundle()
        for (jsonParam in parameterMap.entries) {
            val value = jsonParam.value
            val key = jsonParam.key
            when (value) {
                is String -> {
                    bundle.putString(key, value)
                }
                is Int -> {
                    bundle.putInt(key, value)
                }
                is Long -> {
                    bundle.putLong(key, value)
                }
                is Double -> {
                    bundle.putDouble(key, value)
                }
                is Boolean -> {
                    bundle.putBoolean(key, value)
                }
                is Map<*, *> -> {
                    val nestedBundle = createBundleFromMap(value as Map<String, Any>)
                    bundle.putBundle(key, nestedBundle as Bundle)
                }
                else -> {
                    throw IllegalArgumentException(
                        "Unsupported value type: " + value.javaClass.kotlin
                    )
                }
            }
        }
        return bundle
    }

    fun setAutoLogAppEventsEnabled(call: MethodCall, result: MethodChannel.Result) {
        val enabled = call.arguments as Boolean
        FacebookSdk.setAutoLogAppEventsEnabled(enabled)
        result.success(null)
    }

    fun setDataProcessingOptions(call: MethodCall, result: MethodChannel.Result) {
        val options = call.argument("options") as? ArrayList<String> ?: arrayListOf()
        val country = call.argument("country") as? Int ?: 0
        val state = call.argument("state") as? Int ?: 0

        FacebookSdk.setDataProcessingOptions(options.toTypedArray(), country, state)
        result.success(null)
    }

    fun purchased(
        appEventsLogger: AppEventsLogger,
        call: MethodCall,
        result: MethodChannel.Result
    ) {
        val amount = (call.argument("amount") as? Double)?.toBigDecimal()
        val currency = Currency.getInstance(call.argument("currency") as? String)
        val parameters = call.argument("parameters") as? Map<String, Any>
        val parameterBundle = createBundleFromMap(parameters) ?: Bundle()

        appEventsLogger.logPurchase(amount, currency, parameterBundle)
        result.success(null)
    }
}