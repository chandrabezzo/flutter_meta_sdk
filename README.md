# Flutter Meta SDK
![GitHub code size](https://img.shields.io/github/languages/code-size/chandrabezzo/flutter_meta_sdk)
![GitHub followers](https://img.shields.io/github/followers/chandrabezzo?style=social)
![GitHub contributors](https://img.shields.io/github/contributors/chandrabezzo/flutter_meta_sdk)
[![Linkedin](https://i.stack.imgur.com/gVE0j.png) LinkedIn](https://www.linkedin.com/in/chandra-abdul-fattah/)
[![GitHub](https://i.stack.imgur.com/tskMh.png) GitHub](https://github.com/chandrabezzo/)

`flutter_meta_sdk` allows you to integration Flutter with Native Meta SDK.

This was created using the latest SDK to include support for iOS 14. The plugin currently supports app events and deeps links for iOS and Android. 

## Setting things up
First of all, if you don't have one already, you must first create an app at Facebook developers: https://developers.facebook.com/
1. Get your app id (referred to as `[APP_ID]` below)
2. Get your client token (referred to as `[CLIENT_TOKEN]` below).
   See "[Facebook Doc: Client Tokens](https://developers.facebook.com/docs/facebook-login/guides/access-tokens#clienttokens)" for more information and how to obtain it.

* Don't forget to replace [APP_ID] with your Application ID

# For IOS
For more information you can see full setup from [Facebook SDK Official](https://developers.facebook.com/docs/ios/)
Read through the "[Getting Started with App Events for iOS](https://developers.facebook.com/docs/app-events/getting-started-app-events-ios)" tutuorial and in particular, follow [step 5](https://developers.facebook.com/docs/app-events/getting-started-app-events-ios#step-5--configure-your-project) by opening `info.plist` "As Source Code" and add the following

- If your code does not have `CFBundleURLTypes`, add the following just before the final `</dict>` element:

```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
  <key>CFBundleURLSchemes</key>
  <array>
    <string>fb[APP_ID]</string>
  </array>
  </dict>
</array>
<key>FacebookAppID</key>
<string>[APP_ID]</string>
<key>FacebookClientToken</key>
<string>[CLIENT_TOKEN]</string>
<key>FacebookDisplayName</key>
<string>[APP_NAME]</string>
```

- If your code already contains `CFBundleURLTypes`, insert the following:

```xml
<array>
 <dict>
 <key>CFBundleURLSchemes</key>
 <array>
   <string>fb[APP_ID]</string>
 </array>
 </dict>
</array>
<key>FacebookAppID</key>
<string>[APP_ID]</string>
<key>FacebookClientToken</key>
<string>[CLIENT_TOKEN]</string>
<key>FacebookDisplayName</key>
<string>[APP_NAME]</string>

# For Android 
For more information you can see full setup from [Facebok SDK Official](https://developers.facebook.com/docs/android/)
Read through the "[Getting Started with App Events for Android](https://developers.facebook.com/docs/app-events/getting-started-app-events-android)" tutorial and in particular, follow [step 3](https://developers.facebook.com/docs/app-events/getting-started-app-events-android#step-3--integrate-the-facebook-sdk-in-your-android-app) by adding the following into `/app/res/values/strings.xml` (or into respective `debug` or `release` build flavor)

```xml
<string name="facebook_app_id">[APP_ID]</string>
<string name="facebook_client_token">[CLIENT_TOKEN]</string>
```

After that, add that string resource reference to your main `AndroidManifest.xml` file, directly under the `<application>` tag.

```xml
<application android:label="@string/app_name" ...>
    ...
   	<meta-data android:name="com.facebook.sdk.ApplicationId" android:value="@string/facebook_app_id"/>
   	<meta-data android:name="com.facebook.sdk.ClientToken" android:value="@string/facebook_client_token"/>
    ...
</application>
```

## About Flutter Meta SDK
Please refer to the official SDK documentation for Facebook App Events
[iOS](https://developers.facebook.com/docs/reference/iossdk/current/FBSDKCoreKit/classes/fbsdkappevents.html)
and
[Android](https://developers.facebook.com/docs/reference/androidsdk/current/facebook/com/facebook/appevents/appeventslogger.html) respectively for the correct and expected behavior. Please
[report an issue](https://github.com/chandrabezzo/flutter_meta_sdk/issues)
if you find anything that is not working according to official documentation.

## Getting involved
First of all, thank you for even considering to get involved. You are a real super :star:  and we :heart:  you!

### Reporting bugs and issues
Use the configured [Github issue report template](https://github.com/chandrabezzo/flutter_meta_sdk/issues/new?assignees=&labels=&template=bug_report.md&title=) when reporting an issue. Make sure to state your observations and expectations
as objectively and informative as possible so that we can understand your need and be able to troubleshoot.

### Discussions and ideas
We're happy to discuss and talk about ideas in the
[repository discussions](https://github.com/chandrabezzo/flutter_meta_sdk/discussions) and/or post your
question to [StackOverflow](https://stackoverflow.com/search?q=flutter+meta+sdk).

Feel free to open a thread if you are having any questions on how to use either the Facebook SDK as a reporting tool
itself or even on how to use this plugin. 