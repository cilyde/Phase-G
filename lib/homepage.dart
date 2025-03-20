// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:phase_g/prayer_time.dart';
// import 'PrayerTimeViewModel.dart';
// import 'admin_page.dart';
//
// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   // Create an instance of your ViewModel.
//   final PrayerTimeViewModel _viewModel = PrayerTimeViewModel();
//
//   @override
//   void initState() {
//     super.initState();
//     // Load prayer times when the homepage loads.
//     _viewModel.fetchPrayerTimes();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Prayer Times"),
//         actions: [
//           CupertinoButton(child: Text("Admin"),
//               onPressed: (){
//             Get.to(()=>AdminPage());
//               })
//         ],
//       ),
//       body: AnimatedBuilder(
//         animation: _viewModel,
//         builder: (context, child) {
//           if (_viewModel.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (_viewModel.errorMessage != null) {
//             return Center(child: Text("Error: ${_viewModel.errorMessage}"));
//           } else {
//             final List<PrayerTime> prayerTimes = _viewModel.prayerTimes;
//             if (prayerTimes.isEmpty) {
//               return const Center(child: Text("No prayer times available."));
//             }
//             return ListView.builder(
//               itemCount: prayerTimes.length,
//               itemBuilder: (context, index) {
//                 final prayer = prayerTimes[index];
//                 return ListTile(
//                   title: Text(prayer.name),
//                   subtitle: Text(
//                     "Prayer: ${prayer.prayerTime.toLocal().toString().substring(11, 16)}\nIqamah: ${prayer.iqamahTime.toLocal().toString().substring(11, 16)}",
//                   ),
//                   isThreeLine: true,
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phase_g/firestore_service.dart';
import 'package:phase_g/prayer_time.dart';

import 'PrayerTimeViewModel.dart';
import 'admin_page.dart';
import 'background_service.dart';
import 'notification_service.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PrayerTimeViewModel _viewModel = PrayerTimeViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.fetchDailyPrayerTimes();
    notificationScheduleProcessor();
  }

  // Helper widget to build a tile for a given prayer.
  Widget _buildPrayerTile(String prayerName, DateTime prayerTime, DateTime iqamahTime) {
    return ListTile(
      title: Text(prayerName),
      subtitle: GestureDetector(
        onTap: (){
          print('tapped'); NotificationService().trialNotification();
          // writeInDB();
          },
        child: Text(
          "Prayer: ${prayerTime.toLocal().toString().substring(11, 16)}\nIqamah: ${iqamahTime.toLocal().toString().substring(11, 16)}",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Prayer Times"),
                actions: [
          CupertinoButton(child: Text("Admin"),
              onPressed: (){
            Get.to(()=>AdminPage());
              }),],),
      body: AnimatedBuilder(
        animation: _viewModel,
        builder: (context, child) {
          if (_viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (_viewModel.errorMessage != null) {
            return Center(child: Text("Error: ${_viewModel.errorMessage}"));
          } else if (_viewModel.dailyPrayerTimes == null) {
            return const Center(child: Text("No prayer times available for today."));
          } else {
            DailyPrayerTimes dt = _viewModel.dailyPrayerTimes!;
            return ListView(
              children: [
                _buildPrayerTile("Fajr", dt.fajr.prayerTime, dt.fajr.iqamahTime),
                _buildPrayerTile("Dhuhr", dt.dhuhr.prayerTime, dt.dhuhr.iqamahTime),
                _buildPrayerTile("Asr", dt.asr.prayerTime, dt.asr.iqamahTime),
                _buildPrayerTile("Maghrib", dt.maghrib.prayerTime, dt.maghrib.iqamahTime),
                _buildPrayerTile("Isha", dt.isha.prayerTime, dt.isha.iqamahTime),
              ],
            );
          }
        },
      ),
    );
  }
}
