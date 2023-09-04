enum AuthorizationStatus {
  notDetermined(
      '.notDetermined'), // The user has not yet made a choice regarding whether the application may post user notifications.
  denied(
      '.denied'), // The application is not authorized to post user notifications.
  authorized(
      '.authorized'), // The application is authorized to post user notifications.
  provisional(
      '.provisional'), // The application is authorized to post non-interruptive user notifications. (iOS 12.0 and newer)
  ephemeral(
      '.ephemeral'); // The application is temporarily authorized to post notifications. Only available to app clips. (iOS 14.0 and newer)

  const AuthorizationStatus(this.title);

  final String title;
}

enum ShowPreviewsSetting {
  always('.always'), // Notification previews are always shown.
  whenAuthenticated(
      '.whenAuthenticated'), // Notifications previews are only shown when authenticated.
  never('.never'); // Notifications previews are never shown.

  const ShowPreviewsSetting(this.title);

  final String title;
}

enum NotificationSetting {
  notSupported(
      '.notSupported'), // The application does not support this notification type
  disabled('.disabled'), // The notification setting is turned off.
  enabled('.enabled'); // The notification setting is turned on.

  const NotificationSetting(this.title);

  final String title;
}

enum AlertStyle {
  none('.none'),
  banner('.banner'),
  alert('.alert');

  const AlertStyle(this.title);

  final String title;
}

class NotificationSettings {
  final AuthorizationStatus authorizationStatus;

  final NotificationSetting soundSetting;
  final NotificationSetting badgeSetting;
  final NotificationSetting alertSetting;

  final NotificationSetting notificationCenterSetting;
  final NotificationSetting lockScreenSetting;
  final NotificationSetting carPlaySetting;

  final AlertStyle alertStyle;
  final ShowPreviewsSetting showPreviewsSetting; // (iOS 11.0 and newer)
  final NotificationSetting criticalAlertSetting; // (iOS 12.0 and newer)
  final bool providesAppNotificationSettings; // (iOS 12.0 and newer)
  final NotificationSetting announcementSetting; // (iOS 13.0 and newer)

  NotificationSettings(
    this.authorizationStatus,
    this.soundSetting,
    this.badgeSetting,
    this.alertSetting,
    this.notificationCenterSetting,
    this.lockScreenSetting,
    this.carPlaySetting,
    this.alertStyle,
    this.showPreviewsSetting,
    this.criticalAlertSetting,
    this.providesAppNotificationSettings,
    this.announcementSetting,
  );

  @override
  String toString() {
    return '''
      authorizationStatus = ${authorizationStatus.title}
      soundSetting = ${soundSetting.title}
      badgeSetting = ${badgeSetting.title}
      alertSetting = ${alertSetting.title}
      notificationCenterSetting = ${notificationCenterSetting.title}
      lockScreenSetting = ${lockScreenSetting.title}
      carPlaySetting = ${carPlaySetting.title}
      alertStyle = ${alertStyle.title}
      showPreviewsSetting = ${showPreviewsSetting.title}
      providesAppNotificationSettings = $providesAppNotificationSettings
      announcementSetting = ${announcementSetting.title}
    ''';
  }

  static NotificationSettings createFromMap(Map map) {
    return NotificationSettings(
      AuthorizationStatus.values[map['authorizationStatus']],
      NotificationSetting.values[map['soundSetting']],
      NotificationSetting.values[map['badgeSetting']],
      NotificationSetting.values[map['alertSetting']],
      NotificationSetting.values[map['notificationCenterSetting']],
      NotificationSetting.values[map['lockScreenSetting']],
      NotificationSetting.values[map['carPlaySetting']],
      AlertStyle.values[map['alertStyle']],
      map['showPreviewsSetting'] != null
          ? ShowPreviewsSetting.values[map['showPreviewsSetting']]
          : ShowPreviewsSetting.whenAuthenticated,
      map['criticalAlertSetting'] != null
          ? NotificationSetting.values[map['criticalAlertSetting']]
          : NotificationSetting.notSupported,
      map['providesAppNotificationSettings'] != null
          ? (map['providesAppNotificationSettings'] == 1)
          : false,
      map['announcementSetting'] != null
          ? NotificationSetting.values[map['announcementSetting']]
          : NotificationSetting.notSupported,
    );
  }
}
