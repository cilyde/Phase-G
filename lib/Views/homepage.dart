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

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phase_g/Models/prayer_time.dart';

import '../ViewModels/PrayerTimeViewModel.dart';
import 'admin_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PrayerTimeViewModel _viewModel = PrayerTimeViewModel();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Fetch prayer times.
    _viewModel.fetchDailyPrayerTimes();
    // Rebuild the widget every second.
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // // Helper function to format Duration into HH:MM:SS.
  // String formatDuration(Duration duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   final hours = twoDigits(duration.inHours);
  //   final minutes = twoDigits(duration.inMinutes.remainder(60));
  //   final seconds = twoDigits(duration.inSeconds.remainder(60));
  //   return "$hours:$minutes:$seconds";
  // }

  // Format a DateTime as HH:mm.
  String formatTime(DateTime time) => DateFormat('HH:mm').format(time);

  Widget _buildPrayerTile(String prayerName, DateTime adhanTime, DateTime iqamahTime, bool isUpcoming) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Card(
        color: isUpcoming ? Colors.deepPurple : Colors.grey[800],
        elevation: 5,
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(prayerName,
                  style: GoogleFonts.montserrat(
                    fontWeight: isUpcoming ? FontWeight.bold : FontWeight.normal,
                    color:  Colors.white ,
                  )),
              Row(
                children: [
                  Text(
                    "Adhan: ${DateFormat('HH:mm').format(adhanTime)}",
                    style: GoogleFonts.montserrat(
                        color:  Colors.white, fontWeight: isUpcoming ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  Icon(CupertinoIcons.chevron_compact_right, color:  Colors.white ),
                  Text(
                    "Iqamah: ${DateFormat('HH:mm').format(iqamahTime)}",
                    style: GoogleFonts.montserrat(
                        color:  Colors.white, fontWeight: isUpcoming ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),

            ],
          ),
          // subtitle: Text(
          //   "Adhan: ${DateFormat('HH:mm').format(adhanTime)} > Iqamah: ${DateFormat('HH:mm').format(iqamahTime)}",
          //   style: TextStyle(
          //     color: isUpcoming ? Colors.white : Colors.black,
          //   ),
          // ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title:  Text("Daily Prayer Times", style:GoogleFonts.montserrat(color: Colors.white),),
        backgroundColor: Colors.black,
        actions: [
          CupertinoButton(
              child: Text("Admin"),
              onPressed: () {
                Get.to(() => AdminPage());
              }),
        ],
      ),
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

            DateTime now = DateTime.now();

            String nextPrayerName = "";
            String eventLabel = "";
            DateTime? nextEventTime;
            DateTime? adhanForNext;
            DateTime? iqamahForNext;

            // Helper function: sets next event if not already chosen.
            void checkPrayer(String name, DateTime adhanTime, DateTime iqamahTime) {
              if (nextEventTime != null) return;
              if (now.isBefore(adhanTime)) {
                nextPrayerName = name;
                nextEventTime = adhanTime;
                adhanForNext = adhanTime;
                iqamahForNext = iqamahTime;
                eventLabel = "TIME LEFT FOR ADHAN";
              } else if (now.isBefore(iqamahTime)) {
                nextPrayerName = name;
                nextEventTime = iqamahTime;
                adhanForNext = adhanTime;
                iqamahForNext = iqamahTime;
                eventLabel = "TIME LEFT FOR IQAMAH";
              }
            }

            // Check each prayer in order.
            checkPrayer("Fajr", dt.fajr.prayerTime, dt.fajr.iqamahTime);
            checkPrayer("Dhuhr", dt.dhuhr.prayerTime, dt.dhuhr.iqamahTime);
            checkPrayer("Asr", dt.asr.prayerTime, dt.asr.iqamahTime);
            checkPrayer("Maghrib", dt.maghrib.prayerTime, dt.maghrib.iqamahTime);
            checkPrayer("Isha", dt.isha.prayerTime, dt.isha.iqamahTime);

            // If all today's events are past, default to tomorrow's Fajr.
            if (nextEventTime == null) {
              nextPrayerName = "Fajr";
              nextEventTime = dt.fajr.prayerTime.add(const Duration(days: 1));
              adhanForNext = dt.fajr.prayerTime.add(const Duration(days: 1));
              iqamahForNext = dt.fajr.iqamahTime.add(const Duration(days: 1));
              eventLabel = "TIME LEFT FOR ADHAN";
            }
            // Calculate countdown.
            Duration countdown = nextEventTime!.difference(now);
            final hours = countdown.inHours;
            final minutes = countdown.inMinutes.remainder(60);
            final seconds = countdown.inSeconds.remainder(60);
            // String formattedCountdown = formatDuration(countdown);

            // Format the Adhan and Iqamah times for display.
            String adhanFormatted = formatTime(adhanForNext!);
            String iqamahFormatted = formatTime(iqamahForNext!);

            return Container(
              child: Column(
                children: [
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(_viewModel.todaysDate,style:GoogleFonts.montserrat(color: Colors.white),), Text(_viewModel.todaysDateInArabicCalendar,style:GoogleFonts.montserrat(color: Colors.white),)],
                    ),
                  ),
                  Divider(),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Next Prayer:',
                        style:GoogleFonts.montserrat(color: Colors.white),
                        ),
                        Text(
                          '$nextPrayerName',
                          style:GoogleFonts.montserrat(color: Colors.deepPurpleAccent, fontSize: 26),
                        ),
                        const SizedBox(height: 5),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  adhanFormatted,
                                  style: GoogleFonts.montserrat(fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  "ADHAN",
                                  style:GoogleFonts.montserrat(color: Colors.grey),
                                )
                              ],
                            ),
                            Icon(CupertinoIcons.chevron_forward, color: Colors.white,),
                            Column(
                              children: [
                                Text(
                                  iqamahFormatted,
                                  style: GoogleFonts.montserrat(fontSize: 18, color: Colors.white),

                                ),
                                Text(
                                  "IQAMAH",
                                  style:GoogleFonts.montserrat(color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Text(eventLabel, style:GoogleFonts.montserrat(color: Colors.white),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [Text("$hours", style:GoogleFonts.montserrat(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),), Text("HOUR", style: GoogleFonts.montserrat(color: Colors.grey, fontWeight: FontWeight.bold)),],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            children: [Text("$minutes", style:GoogleFonts.montserrat(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),), Text("MINUTES", style: GoogleFonts.montserrat(color: Colors.grey, fontWeight: FontWeight.bold)),],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            children: [Text("$seconds", style:GoogleFonts.montserrat(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),), Text("SECONDS", style: GoogleFonts.montserrat(color: Colors.grey, fontWeight: FontWeight.bold)),],
                          ),
                        ],
                      ),
                    ],
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      _buildPrayerTile("Fajr", dt.fajr.prayerTime, dt.fajr.iqamahTime, nextPrayerName == "Fajr"),
                      _buildPrayerTile("Dhuhr", dt.dhuhr.prayerTime, dt.dhuhr.iqamahTime, nextPrayerName == "Dhuhr"),
                      _buildPrayerTile("Asr", dt.asr.prayerTime, dt.asr.iqamahTime, nextPrayerName == "Asr"),
                      _buildPrayerTile("Maghrib", dt.maghrib.prayerTime, dt.maghrib.iqamahTime, nextPrayerName == "Maghrib"),
                      _buildPrayerTile("Isha", dt.isha.prayerTime, dt.isha.iqamahTime, nextPrayerName == "Isha"),
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
