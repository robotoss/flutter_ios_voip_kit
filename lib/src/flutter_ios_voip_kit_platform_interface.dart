import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_ios_voip_kit_method_channel.dart';
import 'settings/notifications_settings.dart';
import 'types/call_state_type.dart';

typedef IncomingPush = void Function(Map<String, dynamic> payload);
typedef IncomingAction = void Function(String uuid, String callerId);
typedef OnUpdatePushToken = void Function(String token);
typedef OnAudioSessionStateChanged = void Function(bool active);

abstract class FlutterIosVoipKitPlatform extends PlatformInterface {
  /// Constructs a FlutterIosVoipKitPlatform.
  FlutterIosVoipKitPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterIosVoipKitPlatform _instance = MethodChannelFlutterIosVoipKit();

  /// The default instance of [FlutterIosVoipKitPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterIosVoipKit].
  static FlutterIosVoipKitPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterIosVoipKitPlatform] when
  /// they register themselves.
  static set instance(FlutterIosVoipKitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// [onDidReceiveIncomingPush] is not called when the app is not running, because app is not yet running when didReceiveIncomingPushWith is called.
  IncomingPush? onDidReceiveIncomingPush;

  /// [onDidAcceptIncomingCall] and [onDidRejectIncomingCall] can be called even if the app is not running.
  /// This is because the app is already running when the incoming call screen is displayed for CallKit.
  /// If not called, make sure the app is calling [onDidAcceptIncomingCall] and [onDidRejectIncomingCall] in the Dart class(ex: main.dart) that is called immediately after the app is launched.
  IncomingAction? onDidAcceptIncomingCall;
  IncomingAction? onDidRejectIncomingCall;
  OnUpdatePushToken? onDidUpdatePushToken;
  OnAudioSessionStateChanged? onAudioSessionStateChanged;

  Future<void> dispose() {
    throw UnimplementedError('dispose() has not been implemented.');
  }

  Future<String?> getVoIPToken() {
    throw UnimplementedError('getVoIPToken() has not been implemented.');
  }

  Future<String?> getIncomingCallerName() {
    throw UnimplementedError(
      'getIncomingCallerName() has not been implemented.',
    );
  }

  Future<void> startCall({
    required String uuid,
    required String targetName,
  }) {
    throw UnimplementedError('startCall() has not been implemented.');
  }

  Future<void> endCall() {
    throw UnimplementedError('endCall() has not been implemented.');
  }

  Future<void> acceptIncomingCall({
    required CallStateType callerState,
  }) {
    throw UnimplementedError('acceptIncomingCall() has not been implemented.');
  }

  Future<void> unansweredIncomingCall({
    bool skipLocalNotification = false,
    required String missedCallTitle,
    required String missedCallBody,
  }) {
    throw UnimplementedError(
      'unansweredIncomingCall() has not been implemented.',
    );
  }

  Future<void> callConnected() {
    throw UnimplementedError('callConnected() has not been implemented.');
  }

  Future<bool?> requestAuthLocalNotification() {
    throw UnimplementedError(
      'requestAuthLocalNotification() has not been implemented.',
    );
  }

  Future<NotificationSettings?> getLocalNotificationsSettings() {
    throw UnimplementedError(
      'getLocalNotificationsSettings() has not been implemented.',
    );
  }

  Future<void> testIncomingCall({
    required String uuid,
    required String callerId,
    required String callerName,
  }) {
    throw UnimplementedError('testIncomingCall() has not been implemented.');
  }
}
