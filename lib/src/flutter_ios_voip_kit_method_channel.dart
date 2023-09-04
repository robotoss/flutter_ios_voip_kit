import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_ios_voip_kit_platform_interface.dart';
import 'settings/notifications_settings.dart';
import 'types/call_state_type.dart';

/// An implementation of [FlutterIosVoipKitPlatform] that uses method channels.
class MethodChannelFlutterIosVoipKit extends FlutterIosVoipKitPlatform {
  MethodChannelFlutterIosVoipKit() {
    _eventSubscription = const EventChannel('flutter_ios_voip_kit/event')
        .receiveBroadcastStream()
        .listen(_eventListener, onError: _errorListener);
  }

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_ios_voip_kit');

  late StreamSubscription<dynamic> _eventSubscription;

  @override
  Future<String?> getVoIPToken() async {
    log('🎈 getVoIPToken');

    final token = await methodChannel.invokeMethod<String>('getVoIPToken');
    return token;
  }

  @override
  Future<String?> getIncomingCallerName() async {
    log('🎈 getIncomingCallerName');

    final callerName =
        await methodChannel.invokeMethod<String>('getIncomingCallerName');
    return callerName;
  }

  @override
  Future<void> startCall({
    required String uuid,
    required String targetName,
  }) async {
    log('🎈 startCall');

    await methodChannel.invokeMethod('startCall', {
      'uuid': uuid,
      'targetName': targetName,
    });

    return;
  }

  @override
  Future<void> endCall() async {
    log('🎈 endCall');

    await methodChannel.invokeMethod('endCall');

    return;
  }

  @override
  Future<void> acceptIncomingCall({required CallStateType callerState}) async {
    log('🎈 acceptIncomingCall');

    await methodChannel.invokeMethod('acceptIncomingCall', {
      'callerState': callerState.value,
    });

    return;
  }

  @override
  Future<void> unansweredIncomingCall({
    bool skipLocalNotification = false,
    required String missedCallTitle,
    required String missedCallBody,
  }) async {
    log(
      '🎈 unansweredIncomingCall $skipLocalNotification, $missedCallTitle, $missedCallBody',
    );

    await methodChannel.invokeMethod(
      'unansweredIncomingCall',
      {
        'skipLocalNotification': skipLocalNotification,
        'missedCallTitle': missedCallTitle,
        'missedCallBody': missedCallBody,
      },
    );

    return;
  }

  @override
  Future<void> callConnected() async {
    log('🎈 callConnected');

    await methodChannel.invokeMethod('callConnected');

    return;
  }

  @override
  Future<bool?> requestAuthLocalNotification() async {
    log('🎈 requestAuthLocalNotification');

    final result = await methodChannel.invokeMethod(
      'requestAuthLocalNotification',
    );
    return result['granted'];
  }

  @override
  Future<NotificationSettings?> getLocalNotificationsSettings() async {
    log('🎈 getLocalNotificationsSettings');

    final result = await methodChannel.invokeMethod<Map<dynamic, dynamic>>(
      'getLocalNotificationsSettings',
    );
    return result != null ? NotificationSettings.createFromMap(result) : null;
  }

  @override
  Future<void> testIncomingCall({
    required String uuid,
    required String callerId,
    required String callerName,
  }) async {
    log('🎈 testIncomingCall: $uuid, $callerId, $callerName');

    const isRelease = bool.fromEnvironment('dart.vm.product');
    if (isRelease) {
      return;
    }

    await methodChannel.invokeMethod('testIncomingCall', {
      'uuid': uuid,
      'callerId': callerId,
      'callerName': callerName,
    });

    return;
  }

  void _eventListener(dynamic event) {
    log('🎈 _eventListener');

    final Map<dynamic, dynamic> map = event;
    switch (map['event']) {
      case 'onDidReceiveIncomingPush':
        log('🎈 onDidReceiveIncomingPush($onDidReceiveIncomingPush): $map');

        if (onDidReceiveIncomingPush == null) {
          return;
        }

        onDidReceiveIncomingPush!(
          Map<String, dynamic>.from(map),
        );
        break;
      case 'onDidAcceptIncomingCall':
        log('🎈 onDidAcceptIncomingCall($onDidAcceptIncomingCall): $map');

        if (onDidAcceptIncomingCall == null) {
          return;
        }

        onDidAcceptIncomingCall!(
          map['uuid'],
          map['incoming_caller_id'],
        );
        break;
      case 'onDidRejectIncomingCall':
        log('🎈 onDidRejectIncomingCall($onDidRejectIncomingCall): $map');

        if (onDidRejectIncomingCall == null) {
          return;
        }

        onDidRejectIncomingCall!(
          map['uuid'],
          map['incoming_caller_id'],
        );
        break;

      case 'onDidUpdatePushToken':
        final String token = map['token'];
        log('🎈 onDidUpdatePushToken $token');

        if (onDidUpdatePushToken == null) {
          return;
        }

        onDidUpdatePushToken!(token);
        break;
      case 'onDidActivateAudioSession':
        log('🎈 onDidActivateAudioSession');
        if (onAudioSessionStateChanged != null) {
          onAudioSessionStateChanged!(true);
        }
        break;
      case 'onDidDeactivateAudioSession':
        log('🎈 onDidDeactivateAudioSession');
        if (onAudioSessionStateChanged != null) {
          onAudioSessionStateChanged!(false);
        }
        break;
    }
  }

  void _errorListener(Object obj) {
    log('🎈 onError: $obj');
  }

  @override
  Future<void> dispose() async {
    await _eventSubscription.cancel();
  }
}
