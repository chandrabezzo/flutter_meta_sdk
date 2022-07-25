import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_meta_sdk_platform_interface.dart';

/// An implementation of [FlutterMetaSdkPlatform] that uses method channels.
class MethodChannelFlutterMetaSdk extends FlutterMetaSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_meta_sdk');
}
