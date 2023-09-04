// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_ios_voip_kit/flutter_ios_voip_kit.dart';
// import 'package:flutter_ios_voip_kit/flutter_ios_voip_kit_platform_interface.dart';
// import 'package:flutter_ios_voip_kit/src/flutter_ios_voip_kit_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockFlutterIosVoipKitPlatform
//     with MockPlatformInterfaceMixin
//     implements FlutterIosVoipKitPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final FlutterIosVoipKitPlatform initialPlatform = FlutterIosVoipKitPlatform.instance;
//
//   test('$MethodChannelFlutterIosVoipKit is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelFlutterIosVoipKit>());
//   });
//
//   test('getPlatformVersion', () async {
//     FlutterIosVoipKit flutterIosVoipKitPlugin = FlutterIosVoipKit();
//     MockFlutterIosVoipKitPlatform fakePlatform = MockFlutterIosVoipKitPlatform();
//     FlutterIosVoipKitPlatform.instance = fakePlatform;
//
//     expect(await flutterIosVoipKitPlugin.getPlatformVersion(), '42');
//   });
// }
