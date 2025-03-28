// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:intl/intl.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:phase_g/firestore_service.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// import 'background_service.dart';
//
//
// class NotificationService {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   Future<void> initialize() async {
//     // Initialize timezone data for scheduling notifications.
//     tz.initializeTimeZones();
//
//     const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
//         // onDidReceiveLocalNotification:
//         //     (int id, String? title, String? body, String? payload) async {
//         //   // Handle iOS foreground notification if needed.
//         // },
//         );
//
//     final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//     );
//
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         // Handle notification tap action.
//       },
//     );
//
//     // Request permissions for notifications.
//     await _requestPermissions();
//   }
//
//   Future<void> _requestPermissions() async {
//     // Resolve the iOS-specific implementation without specifying a type.
//     // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//     final iosImplementation = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
//     // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation();
//     if (iosImplementation != null) {
//       // Cast dynamically to call requestPermissions.
//       await (iosImplementation as dynamic).requestPermissions(alert: true, badge: true, sound: true);
//     }
//
//     // For Android (API level 33+), request notification permission using permission_handler.
//     if (await Permission.notification.isDenied) {
//       await Permission.notification.request();
//     }
//   }
//
//   Future<void> cancelExistingNotifications() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//     print("cancelled all notification");
//     return;
//   }
//
//   Future<void> scheduleNotification({
//     required int id,
//     required String title,
//     required String body,
//     required DateTime scheduledTime,
//   }) async {
//     print('in schedule');
//     // Convert the DateTime to a timezone-aware TZDateTime.
//     // final tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);
//     print(scheduledTime);
//     print(_convertToLocal(scheduledTime));
//     final timeZoneName = await FlutterTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZoneName));
//     // print(tzScheduledTime);
//     // final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
//     // print(formatter.format(tzScheduledTime.toLocal()));
//     tz.TZDateTime convertedTime =  tz.TZDateTime.from(scheduledTime, tz.local);
//
//     const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'prayer_channel_id',
//       'Prayer Notifications',
//       channelDescription: 'Notification channel for prayer times',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails();
//
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );
//
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       convertedTime,
//       platformChannelSpecifics,
//       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       // If you want to match exactly, you can disable time adjustments here.
//     );
//   }
//
//
//   trialNotification()async {
// // Initialize timezone data for scheduling notifications.
//     tz.initializeTimeZones();
//
//     const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
//       // onDidReceiveLocalNotification:
//       //     (int id, String? title, String? body, String? payload) async {
//       //   // Handle iOS foreground notification if needed.
//       // },
//     );
//
//     final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//     );
//
//     await flutterLocalNotificationsPlugin.initialize(
//         initializationSettings,
//         onDidReceiveNotificationResponse: (NotificationResponse response) {
//           // Handle notification tap action.
//         });
//
//     const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'prayer_channel_id',
//       'Prayer Notifications',
//       channelDescription: 'Notification channel for prayer times',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails();
//
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );
//
// //     // await flutterLocalNotificationsPlugin.show(39889, 'title', 'body', NotificationDetails());
// // var r = await flutterLocalNotificationsPlugin.getActiveNotifications();
// // print(r);
// // await flutterLocalNotificationsPlugin..periodicallyShow(909279, 'periodic', 'body',
// //     RepeatInterval.everyMinute, NotificationDetails(),
// //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
//
//     print(DateTime.now());
//     print(_convertToLocal(DateTime.now()));
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       29839,
//       'title',
//       'body',
//       _convertToLocal(
//         DateTime.now().add(Duration(seconds: 5)),
//       ),
//       NotificationDetails(android: androidPlatformChannelSpecifics),
//       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       // If you want to match exactly, you can disable time adjustments here.
//     );
//     // await flutterLocalNotificationsPlugin.show(4534, 'title', "body", NotificationDetails(android: androidPlatformChannelSpecifics));
// }
//
//   void restartNotifications() {
//     flutterLocalNotificationsPlugin.cancelAll();
//     restartNotificationService();
//   }
// }
//
// tz.TZDateTime _convertToLocal(DateTime time) {
// final tz.Location mumbai = tz.getLocation('Asia/Kolkata');
//
// return tz.TZDateTime.from(time, mumbai);
// }

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:phase_g/Models/prayer_time.dart';

import 'firestore_service.dart';

class NotificationService {
  /// Initializes awesome_notifications, sets up the channel, and requests permissions.
  Future<void> initialize() async {
    // Initialize awesome_notifications with a channel.
    await AwesomeNotifications().initialize(
      // You can specify a drawable resource for your app icon (set to null to use default).
      null,
      [
        NotificationChannel(
          channelKey: 'adhan_channel',
          channelName: 'Adhan Notifications',
          channelDescription: 'Notification channel for prayer times',
          defaultColor: const Color(0xFF9050DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          soundSource: 'resource://raw/adhan',
        ),
        NotificationChannel(
          channelKey: 'iqamah_channel',
          channelName: 'Iqamah Notifications',
          channelDescription: 'Notification channel for prayer times',
          defaultColor: const Color(0xFF9050DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
        )
      ],
      debug: true, // set to false in production
    );

    // Request permission to send notifications.
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      // Optionally, show a dialog to explain why notifications are needed before requesting.
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  /// Schedules a notification using awesome_notifications.
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    bool isIqamah = false,
  }) async {
    // Create a schedule using NotificationCalendar.
    // The schedule takes individual date/time components from the scheduled DateTime.
    final schedule = NotificationCalendar(
      year: scheduledTime.year,
      month: scheduledTime.month,
      day: scheduledTime.day,
      hour: scheduledTime.hour,
      minute: scheduledTime.minute,
      second: scheduledTime.second,
      allowWhileIdle: true,
      preciseAlarm: true,
    );

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: isIqamah?'iqamah_channel':'adhan_channel',
        title: title,
        body: body,
      ),
      schedule: schedule,
    );
  }

  Future<void> cancelExistingNotifications() async {
    await AwesomeNotifications().cancelAll();
    await AwesomeNotifications().cancelAllSchedules();
    return;
  }

  // void trialNotification() async {
  //   await AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: 12344,
  //       channelKey: 'prayer_channel',
  //       title: 'title',
  //       body: 'body',
  //       customSound: 'resource://raw/adhan',
  //     ),
  //   );
  // }



  void resetScheduledNotifications() async {
    await cancelExistingNotifications();
    List<DailyPrayerTimes?>? weekPrayerTimes = [];
    weekPrayerTimes = await FirestoreService().getDailyPrayerTimesForTheWeek();
    if(weekPrayerTimes!=null){
      if(weekPrayerTimes.isNotEmpty){
        for(var day in weekPrayerTimes){
          if (day != null) {
            print("Daily prayer times not empty");
            print('Scheduling noti');
            int id = 0;
            try {
              // Fajr
              await NotificationService().scheduleNotification(
                id: id++,
                title: "Fajr Adhan",
                body: "Time for Fajr prayer",
                scheduledTime: day.fajr.prayerTime,
                // scheduledTime: DateTime.now().add(Duration(seconds: 10))
              );
            } catch (e) {
              print(e);
            }
            try {
              await NotificationService().scheduleNotification(
                id: id++,
                title: "Fajr Iqamah",
                body: "Time for Fajr Iqamah",
                scheduledTime: day.fajr.iqamahTime,
                isIqamah: true
              );
            } catch (e) {
              print(e);
            }
            try {
              // Dhuhr
              await NotificationService().scheduleNotification(
                id: id++,
                title: "Dhuhr Adhan",
                body: "Time for Dhuhr prayer",
                scheduledTime: day.dhuhr.prayerTime,
              );
            } catch (e) {
              print(e);
            }
            try {
              await NotificationService().scheduleNotification(
                id: id++,
                title: "Dhuhr Iqamah",
                body: "Time for Dhuhr Iqamah",
                scheduledTime: day.dhuhr.iqamahTime,
                  isIqamah: true
              );
            } catch (e) {
              print(e);
            }
            try {
              // Asr
              await NotificationService().scheduleNotification(
                id: id++,
                title: "Asr Adhan",
                body: "Time for Asr prayer",
                scheduledTime: day.asr.prayerTime,
              );
            } catch (e) {
              print(e);
            }
            try {
              await NotificationService().scheduleNotification(
                id: id++,
                title: "Asr Iqamah",
                body: "Time for Asr Iqamah",
                scheduledTime: day.asr.iqamahTime,
                  isIqamah: true
              );
            } catch (e) {
              print(e);
            }
            try {
              // Maghrib
              await NotificationService().scheduleNotification(
                id: id++,
                title: "Maghrib Adhan",
                body: "Time for Maghrib prayer",
                scheduledTime: day.maghrib.prayerTime,
              );
            } catch (e) {
              print(e);
            }
            try {
              await NotificationService().scheduleNotification(
                id: id++,
                title: "Maghrib Iqamah",
                body: "Time for Maghrib Iqamah",
                scheduledTime: day.maghrib.iqamahTime,
                  isIqamah: true
              );
            } catch (e) {
              print(e);
            }
            try {
              // Isha
              await NotificationService().scheduleNotification(
                id: id++,
                title: "Isha Adhan",
                body: "Time for Isha prayer",
                scheduledTime: day.isha.prayerTime,
              );
            } catch (e) {
              print(e);
            }
            try {
              await NotificationService().scheduleNotification(
                id: id++,
                title: "Isha Iqamah",
                body: "Time for Isha Iqamah",
                scheduledTime: day.isha.iqamahTime,
                  isIqamah: true
              );
            } catch (e) {
              print(e);
            }
            print('Scheduling noti completed');
          }
        }
      }
    }
  }
}
