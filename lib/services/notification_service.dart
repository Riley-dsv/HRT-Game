import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService
{
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future<void> init() async
  {
    tz.initializeTimeZones();

    const android_settings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOS_settings     = DarwinInitializationSettings();

    await _notification.initialize(
      const InitializationSettings(
        android: android_settings,
        iOS: IOS_settings
      )
    );
  }

  static Future<void> schedule_daily_notifications(int hour, int minute) async
  {
    await _notification.zonedSchedule(
      0,
      "HRT Reminder",
      "Don't forget your medicine today, or you risk to lose your streak D:",
      _nextInstanceOfTime(hour, minute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "daily_hormone_channel",
          "HRT Reminder",
          channelDescription: "Daily reminder for hormone taking",
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails()
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
      //androidAllowWhileIdle: true,
      //uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time
    ); 
  }

  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute)
  {
    final now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if ( scheduled.isBefore(now) )
    {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }
}
