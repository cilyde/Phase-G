// import 'package:flutter/foundation.dart';
// import 'package:phase_g/prayer_time.dart';
// import 'firestore_service.dart';
//
// class PrayerTimeViewModel extends ChangeNotifier {
//   List<PrayerTime> _prayerTimes = [];
//   bool _isLoading = false;
//   String? _errorMessage;
//
//   List<PrayerTime> get prayerTimes => _prayerTimes;
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//
//   // Fetch prayer times from Firestore and update state.
//   Future<void> fetchPrayerTimes() async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();
//
//     try {
//       _prayerTimes = await FirestoreService().getPrayerTimesForToday();
//       print("Prayertimes got");
//       print(_prayerTimes);
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:phase_g/prayer_time.dart';

import 'firestore_service.dart';

class PrayerTimeViewModel extends ChangeNotifier {
  DailyPrayerTimes? _dailyPrayerTimes;
  bool _isLoading = false;
  String? _errorMessage;

  DailyPrayerTimes? get dailyPrayerTimes => _dailyPrayerTimes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchDailyPrayerTimes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _dailyPrayerTimes = await FirestoreService().getDailyPrayerTimesForToday();
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}
