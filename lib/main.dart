import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';
import 'Services/background_service.dart';
import 'Views/homepage.dart';
import 'Services/notification_service.dart';

// // Function to calculate initial delay to run just after midnight.
// Duration calculateInitialDelay() {
//   final now = DateTime.now();
//   // Calculate the next midnight.
//   final nextMidnight = DateTime(now.year, now.month, now.day).add(const Duration(days: 1, seconds: 5));
//   return nextMidnight.difference(now);
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   // Initialize the notification service.
//   await NotificationService().initialize();
//   NotificationService().restartNotifications();
//   // // Initialize WorkManager for background tasks.
//   // Workmanager().initialize(
//   //   callbackDispatcher, // defined in your background_service.dart
//   //   isInDebugMode: true, // set to false in production
//   // );
//   //
//   // // Schedule a periodic background task to run daily.
//   // Workmanager().registerPeriodicTask(
//   //   "dailyPrayerTask",
//   //   "fetchAndSchedulePrayerTimes",
//   //   frequency: const Duration(hours: 24),
//   //   initialDelay: calculateInitialDelay(),
//   // );
//
//   runApp(MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize awesome_notifications.
  await NotificationService().initialize();

  // Initialize WorkManager with our background callback.
  // Workmanager().initialize(
  //   trialCallbackDispatcher, // our background callback defined above
  //   isInDebugMode: true, // set false in production
  // );
  //
  // // Register a periodic or one-off task as needed.
  // Workmanager().registerPeriodicTask(
  //   "trialTask",
  //   "writeTrialWritingsToDB", // example task name, replace as needed
  //   frequency: const Duration(minutes: 15), // periodic tasks must use the minimum interval
  // );

  NotificationService().resetScheduledNotifications();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Prayer Times App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
