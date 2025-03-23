// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:phase_g/prayer_time.dart';
// import 'package:workmanager/workmanager.dart';
// import 'firestore_service.dart';
// import 'notification_service.dart';
//
//
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     // Initialize Firebase.
//     await Firebase.initializeApp();
//
//     // Check for an active internet connection.
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (!connectivityResult.contains(ConnectivityResult.none)) {
//       await notificationScheduleProcessor();
//     }
//     return Future.value(true);
//   });
// }
//
// Future<void> notificationScheduleProcessor() async {
//   {
//     await NotificationService().cancelExistingNotifications();
//     DailyPrayerTimes? dailyPrayerTimes = await FirestoreService().getDailyPrayerTimesForToday();
//     if (dailyPrayerTimes != null) {
//       print("Daily prayer times not empty");
//       print('Scheduling noti');
//       int id = 0;
//       try {
//         // Fajr
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Fajr Prayer",
//           body: "Time for Fajr prayer",
//           // scheduledTime: dailyPrayerTimes.fajr.prayerTime,
//           scheduledTime: DateTime.now().add(Duration(seconds: 5)),
//         );
//       } catch (e) {
//         print(e);
//       }
//       try {
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Fajr Iqamah",
//           body: "Time for Fajr Iqamah",
//           scheduledTime: dailyPrayerTimes.fajr.iqamahTime,
//         );
//       } catch (e) {
//         print(e);
//       }
//       try {
//         // Dhuhr
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Dhuhr Prayer",
//           body: "Time for Dhuhr prayer",
//           scheduledTime: dailyPrayerTimes.dhuhr.prayerTime,
//         );
//       } catch (e) {
//         print(e);
//       }
//       try {
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Dhuhr Iqamah",
//           body: "Time for Dhuhr Iqamah",
//           scheduledTime: dailyPrayerTimes.dhuhr.iqamahTime,
//         );
//       } catch (e) {
//         print(e);
//       }
//       try {
//         // Asr
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Asr Prayer",
//           body: "Time for Asr prayer",
//           scheduledTime: dailyPrayerTimes.asr.prayerTime,
//         );
//       } catch (e) {
//         print(e);
//       }
//       try {
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Asr Iqamah",
//           body: "Time for Asr Iqamah",
//           scheduledTime: dailyPrayerTimes.asr.iqamahTime,
//         );
//       } catch (e) {
//         print(e);
//       }
//       try {
//         // Maghrib
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Maghrib Prayer",
//           body: "Time for Maghrib prayer",
//           scheduledTime: dailyPrayerTimes.maghrib.prayerTime,
//         );
//       } catch (e) {
//         print(e);
//       }
//       try {
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Maghrib Iqamah",
//           body: "Time for Maghrib Iqamah",
//           scheduledTime: dailyPrayerTimes.maghrib.iqamahTime,
//         );
//       } catch (e) {
//         print(e);
//       }
//       try {
//         // Isha
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Isha Prayer",
//           body: "Time for Isha prayer",
//           scheduledTime: dailyPrayerTimes.isha.prayerTime,
//         );
//       } catch (e) {
//         print(e);
//       }
//       try {
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Isha Iqamah",
//           body: "Time for Isha Iqamah",
//           scheduledTime: dailyPrayerTimes.isha.iqamahTime,
//         );
//       } catch (e) {
//         print(e);
//       }
//       print('Scheduling noti completed');
//     }
//   }
//
//
// }
//
// restartNotificationService()async{
//   List<DailyPrayerTimes?>? weekPrayerTimes = [];
//   weekPrayerTimes = await FirestoreService().getDailyPrayerTimesForTheWeek();
// if(weekPrayerTimes!=null){
//   if(weekPrayerTimes.isNotEmpty){
//     for(var day in weekPrayerTimes){
//       if (day != null) {
//         print("Daily prayer times not empty");
//         print('Scheduling noti');
//         int id = 0;
//         try {
//           // Fajr
//           await NotificationService().scheduleNotification(
//             id: id++,
//             title: "Fajr Prayer",
//             body: "Time for Fajr prayer",
//             scheduledTime: day.fajr.prayerTime,
//             // scheduledTime: DateTime.now().add(Duration(seconds: 10))
//           );
//         } catch (e) {
//           print(e);
//         }
//         try {
//           await NotificationService().scheduleNotification(
//             id: id++,
//             title: "Fajr Iqamah",
//             body: "Time for Fajr Iqamah",
//             scheduledTime: day.fajr.iqamahTime,
//           );
//         } catch (e) {
//           print(e);
//         }
//         try {
//           // Dhuhr
//           await NotificationService().scheduleNotification(
//             id: id++,
//             title: "Dhuhr Prayer",
//             body: "Time for Dhuhr prayer",
//             scheduledTime: day.dhuhr.prayerTime,
//           );
//         } catch (e) {
//           print(e);
//         }
//         try {
//           await NotificationService().scheduleNotification(
//             id: id++,
//             title: "Dhuhr Iqamah",
//             body: "Time for Dhuhr Iqamah",
//             scheduledTime: day.dhuhr.iqamahTime,
//           );
//         } catch (e) {
//           print(e);
//         }
//         try {
//           // Asr
//           await NotificationService().scheduleNotification(
//             id: id++,
//             title: "Asr Prayer",
//             body: "Time for Asr prayer",
//             scheduledTime: day.asr.prayerTime,
//           );
//         } catch (e) {
//           print(e);
//         }
//         try {
//           await NotificationService().scheduleNotification(
//             id: id++,
//             title: "Asr Iqamah",
//             body: "Time for Asr Iqamah",
//             scheduledTime: day.asr.iqamahTime,
//           );
//         } catch (e) {
//           print(e);
//         }
//         try {
//           // Maghrib
//           await NotificationService().scheduleNotification(
//             id: id++,
//             title: "Maghrib Prayer",
//             body: "Time for Maghrib prayer",
//             scheduledTime: day.maghrib.prayerTime,
//           );
//         } catch (e) {
//           print(e);
//         }
//         try {
//           await NotificationService().scheduleNotification(
//             id: id++,
//             title: "Maghrib Iqamah",
//             body: "Time for Maghrib Iqamah",
//             scheduledTime: day.maghrib.iqamahTime,
//           );
//         } catch (e) {
//           print(e);
//         }
//         try {
//           // Isha
//           await NotificationService().scheduleNotification(
//             id: id++,
//             title: "Isha Prayer",
//             body: "Time for Isha prayer",
//             scheduledTime: day.isha.prayerTime,
//           );
//         } catch (e) {
//           print(e);
//         }
//         try {
//           await NotificationService().scheduleNotification(
//             id: id++,
//             title: "Isha Iqamah",
//             body: "Time for Isha Iqamah",
//             scheduledTime: day.isha.iqamahTime,
//           );
//         } catch (e) {
//           print(e);
//         }
//         print('Scheduling noti completed');
//       }
//     }
//   }
// }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phase_g/prayer_time.dart';
import 'package:workmanager/workmanager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'firestore_service.dart';
import 'notification_service.dart';


writeInDB()async {
  await FirebaseFirestore.instance.collection('dbWritings 2').doc('${DateTime.now().hour} ${DateTime.now().minute}').set({'AutomTED':'${DateTime.now().hour} ${DateTime.now().minute}'});
}
// void trialCallbackDispatcher() {
//   print("IN CALLBACKKKKKKKK");
//   Workmanager().executeTask((task, inputData) async {
//     // Initialize Firebase in the background isolate.
//     await Firebase.initializeApp();
//
//     // Check connectivity.
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult != ConnectivityResult.none) {
//       writeInDB();
//       // Initialize the Awesome Notifications service.
//       final notificationService = NotificationService();
//       await notificationService.initialize();
//
//       // Fetch daily prayer times (your model remains the same).
//       DailyPrayerTimes? dailyPrayerTimes = await FirestoreService().getDailyPrayerTimesForToday();
//       if (dailyPrayerTimes != null) {
//         int id = 0;
//         DateTime now = DateTime.now();
//
//         // Helper function to adjust scheduled time if it's in the past (for testing).
//         DateTime adjust(DateTime time) =>
//             time.isBefore(now) ? now.add(const Duration(minutes: 1)) : time;
//
//         // Schedule notifications for each prayer and iqamah.
//             try{
//           await notificationService.scheduleNotification(
//             id: id++,
//             title: "Fajr Adhan",
//             body: "Time for Fajr prayer",
//             scheduledTime: adjust(dailyPrayerTimes.fajr.prayerTime),
//           );
//         }catch(e){
//               print(e);
//             }
//             try{
//         await notificationService.scheduleNotification(
//           id: id++,
//           title: "Fajr Iqamah",
//           body: "Time for Fajr Iqamah",
//           scheduledTime: adjust(dailyPrayerTimes.fajr.iqamahTime),
//         );
//             }catch(e){
//               print(e);
//             }
//         try{
//           await notificationService.scheduleNotification(
//             id: id++,
//             title: "Dhuhr Adhan",
//             body: "Time for Fajr Iqamah",
//             scheduledTime: adjust(dailyPrayerTimes.dhuhr.prayerTime),
//           );
//         }catch(e){
//           print(e);
//         }
//         try{
//           await notificationService.scheduleNotification(
//             id: id++,
//             title: "Dhuhr Iqamah",
//             body: "Time for Fajr Iqamah",
//             scheduledTime: adjust(dailyPrayerTimes.dhuhr.iqamahTime),
//           );
//         }catch(e){
//           print(e);
//         }
//         try{
//           await notificationService.scheduleNotification(
//             id: id++,
//             title: "Asr Adhan",
//             body: "Time for Fajr Iqamah",
//             scheduledTime: adjust(dailyPrayerTimes.asr.prayerTime),
//           );
//         }catch(e){
//           print(e);
//         }
//         try{
//           await notificationService.scheduleNotification(
//             id: id++,
//             title: "Asr Iqamah",
//             body: "Time for Fajr Iqamah",
//             scheduledTime: adjust(dailyPrayerTimes.asr.iqamahTime),
//           );
//         }catch(e){
//           print(e);
//         }
//         try{
//           await notificationService.scheduleNotification(
//             id: id++,
//             title: "Maghrib Adhan",
//             body: "Time for Fajr Iqamah",
//             scheduledTime: adjust(dailyPrayerTimes.maghrib.prayerTime),
//           );
//         }catch(e){
//           print(e);
//         } try{
//           await notificationService.scheduleNotification(
//             id: id++,
//             title: "Maghrib Iqamah",
//             body: "Time for Fajr Iqamah",
//             scheduledTime: adjust(dailyPrayerTimes.maghrib.iqamahTime),
//           );
//         }catch(e){
//           print(e);
//         }
//         try{
//           await notificationService.scheduleNotification(
//             id: id++,
//             title: "Isha Prayer",
//             body: "Time for Fajr Iqamah",
//             scheduledTime: adjust(dailyPrayerTimes.isha.prayerTime),
//           );
//         }catch(e){
//           print(e);
//         }
//         try{
//           await notificationService.scheduleNotification(
//             id: id++,
//             title: "Isha Iqamah",
//             body: "Time for Fajr Iqamah",
//             scheduledTime: adjust(dailyPrayerTimes.isha.iqamahTime),
//           );
//         }catch(e){
//           print(e);
//         }
//       }
//     } else {
//       print('No internet connection in background task.');
//     }
//     return Future.value(true);
//   });
// }

// Future<void> notificationScheduleProcessor() async {
//   {
//     await NotificationService().cancelExistingNotifications();
//     DailyPrayerTimes? dailyPrayerTimes = await FirestoreService().getDailyPrayerTimesForToday();
//     if (dailyPrayerTimes != null) {
//       print("Daily prayer times not empty");
//       print('Scheduling noti');
//       int id = 0;
//       try {
//         // Fajr
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Fajr Prayer",
//           body: "Time for Fajr prayer",
//           scheduledTime: dailyPrayerTimes.fajr.prayerTime,
//           // scheduledTime: DateTime.now().add(Duration(seconds: 5)),
//         );
//       } catch (e) {
//         print(e);
//       }
//       try {
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Fajr Iqamah",
//           body: "Time for Fajr Iqamah",
//           scheduledTime: dailyPrayerTimes.fajr.iqamahTime,
//           isIqamah: true
//         );
//       } catch (e) {
//         print(e);
//       }
//       try {
//         // Dhuhr
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Dhuhr Prayer",
//           body: "Time for Dhuhr prayer",
//           scheduledTime: dailyPrayerTimes.dhuhr.prayerTime,
//         );
//       } catch (e) {
//         print(e);
//       }
//       try {
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Dhuhr Iqamah",
//           body: "Time for Dhuhr Iqamah",
//           scheduledTime: dailyPrayerTimes.dhuhr.iqamahTime,
//             isIqamah: true
//         );
//       } catch (e) {
//         print(e);
//       }
//       try {
//         // Asr
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Asr Prayer",
//           body: "Time for Asr prayer",
//           scheduledTime: dailyPrayerTimes.asr.prayerTime,
//         );
//       } catch (e) {
//         print(e);
//       }
//       try {
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Asr Iqamah",
//           body: "Time for Asr Iqamah",
//           scheduledTime: dailyPrayerTimes.asr.iqamahTime,
//             isIqamah: true
//         );
//       } catch (e) {
//         print(e);
//       }
//       try {
//         // Maghrib
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Maghrib Prayer",
//           body: "Time for Maghrib prayer",
//           scheduledTime: dailyPrayerTimes.maghrib.prayerTime,
//         );
//       } catch (e) {
//         print(e);
//       }
//       try {
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Maghrib Iqamah",
//           body: "Time for Maghrib Iqamah",
//           scheduledTime: dailyPrayerTimes.maghrib.iqamahTime,
//             isIqamah: true
//         );
//       } catch (e) {
//         print(e);
//       }
//       try {
//         // Isha
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Isha Adhan",
//           body: "Time for Isha prayer",
//           scheduledTime: dailyPrayerTimes.isha.prayerTime,
//         );
//       } catch (e) {
//         print(e);
//       }
//       try {
//         await NotificationService().scheduleNotification(
//           id: id++,
//           title: "Isha Iqamah",
//           body: "Time for Isha Iqamah",
//           scheduledTime: dailyPrayerTimes.isha.iqamahTime,
//             isIqamah: true
//         );
//       } catch (e) {
//         print(e);
//       }
//       print('Scheduling noti completed');
//     }
//   }
//
//
// }
