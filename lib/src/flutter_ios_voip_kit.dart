import 'flutter_ios_voip_kit_platform_interface.dart';
import 'settings/notifications_settings.dart';
import 'types/call_state_type.dart';

class FlutterIosVoipKit {
  /// CALLBACKS
  set onDidReceiveIncomingPush(IncomingPush data) =>
      FlutterIosVoipKitPlatform.instance.onDidReceiveIncomingPush = data;

  set onDidAcceptIncomingCall(IncomingAction data) =>
      FlutterIosVoipKitPlatform.instance.onDidAcceptIncomingCall = data;

  set onDidRejectIncomingCall(IncomingAction data) =>
      FlutterIosVoipKitPlatform.instance.onDidRejectIncomingCall = data;

  set onDidUpdatePushToken(OnUpdatePushToken data) =>
      FlutterIosVoipKitPlatform.instance.onDidUpdatePushToken = data;

  set onAudioSessionStateChanged(OnAudioSessionStateChanged data) =>
      FlutterIosVoipKitPlatform.instance.onAudioSessionStateChanged = data;

  /// Channel messages
  Future<String?> getVoIPToken() async {
    return await FlutterIosVoipKitPlatform.instance.getVoIPToken();
  }

  Future<String?> getIncomingCallerName() async {
    return await FlutterIosVoipKitPlatform.instance.getIncomingCallerName();
  }

  Future<void> startCall({
    required String uuid,
    required String targetName,
  }) async {
    await FlutterIosVoipKitPlatform.instance.startCall(
      uuid: uuid,
      targetName: targetName,
    );
  }

  Future<void> endCall() async {
    await FlutterIosVoipKitPlatform.instance.endCall();
  }

  Future<void> acceptIncomingCall({required CallStateType callerState}) async {
    await FlutterIosVoipKitPlatform.instance.acceptIncomingCall(
      callerState: callerState,
    );
  }

  Future<void> unansweredIncomingCall({
    bool skipLocalNotification = false,
    required String missedCallTitle,
    required String missedCallBody,
  }) async {
    await FlutterIosVoipKitPlatform.instance.unansweredIncomingCall(
      skipLocalNotification: skipLocalNotification,
      missedCallTitle: missedCallTitle,
      missedCallBody: missedCallBody,
    );
  }

  Future<void> callConnected() async {
    await FlutterIosVoipKitPlatform.instance.callConnected();
  }

  Future<bool?> requestAuthLocalNotification() async {
    return await FlutterIosVoipKitPlatform.instance
        .requestAuthLocalNotification();
  }

  Future<NotificationSettings?> getLocalNotificationsSettings() async {
    return await FlutterIosVoipKitPlatform.instance
        .getLocalNotificationsSettings();
  }

  Future<void> testIncomingCall({
    required String uuid,
    required String callerId,
    required String callerName,
  }) async {
    await FlutterIosVoipKitPlatform.instance.testIncomingCall(
      uuid: uuid,
      callerId: callerId,
      callerName: callerName,
    );
  }

  Future<void> dispose() async {
    await FlutterIosVoipKitPlatform.instance.dispose();
  }
}
