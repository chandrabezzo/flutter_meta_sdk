// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'flutter_meta_sdk_platform_interface.dart';

/// A web implementation of the FlutterMetaSdkPlatform of the FlutterMetaSdk plugin.
class FlutterMetaSdkWeb extends FlutterMetaSdkPlatform {
  /// Constructs a FlutterMetaSdkWeb
  FlutterMetaSdkWeb();

  static void registerWith(Registrar registrar) {
    FlutterMetaSdkPlatform.instance = FlutterMetaSdkWeb();
  }
}
