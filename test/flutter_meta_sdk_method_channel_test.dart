import 'package:flutter/services.dart';
import 'package:flutter_meta_sdk/flutter_meta_sdk.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel(channelName);
  final metaSdk = FlutterMetaSdk();

  MethodCall? methodCall;

  setUp(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall m) async {
      methodCall = m;
      return methodCall;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
    methodCall = null;
  });

  group('Event logging', () {
    test('logEvent log events', () async {
      await metaSdk.logEvent(
        name: 'test-event',
        parameters: <String, dynamic>{'a': 'b'},
      );
      expect(
        methodCall,
        isMethodCall(
          'logEvent',
          arguments: <String, dynamic>{
            'name': 'test-event',
            'parameters': <String, dynamic>{'a': 'b'},
          },
        ),
      );
    });
  });
}
