// ignore_for_file: prefer_const_constructors

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsService {
  // singleton stuff
  LocalNotificationsService._();
  static final instance = LocalNotificationsService._();
  // singleton stuff end

  static const _chatNotificationChannel = AndroidNotificationDetails(
    'myUIC',
    'myUICApp',
    playSound: true,
    importance: Importance.max,
    priority: Priority.high,
  );
  static const _iosChatNotificationChannel = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );


  static final  _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {

    _notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();

    const androidSettings = AndroidInitializationSettings(
      "@drawable/logo",
    );

    final iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true,
    );

    final initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
      },
    );
  }

  Future selectNotification(String? payload) {
    // ignore: todo
    // TODO: handle this and redirect to the correct page
    throw UnimplementedError();
  }

  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    await _notificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(
        android: _chatNotificationChannel,
        iOS: _iosChatNotificationChannel
      ),
    );
  }


  Future<void> showNotification2({
    required String title,
    required String body,
  }) async {
    await _notificationsPlugin.show(
      888,
      title,
      '$body ${DateTime.now()}',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'my_foreground',
          'MY FOREGROUND SERVICE',
          icon: 'ic_bg_service_small',
          ongoing: true,
        ),
      ),
    );
  }
}