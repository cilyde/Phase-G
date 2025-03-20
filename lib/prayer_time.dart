// class PrayerTime {
//   final String name;
//   final DateTime prayerTime;
//   final DateTime iqamahTime;
//
//   PrayerTime({
//     required this.name,
//     required this.prayerTime,
//     required this.iqamahTime,
//   });
//
//   /// Formats the date as YYYY-MM-DD for consistency.
//   static String formatDate(DateTime date) {
//     return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
//   }
//
//   /// Creates a PrayerTime instance from Firestore data.
//   factory PrayerTime.fromFirestore(Map<String, dynamic> data) {
//     return PrayerTime(
//       name: data['name'] ?? "",
//       prayerTime: DateTime.parse(data['prayerTime']),
//       iqamahTime: DateTime.parse(data['iqamahTime']),
//     );
//   }
//
//   /// Converts the PrayerTime instance into a map for Firestore.
//   /// Notice the consistent use of [formatDate] based on [prayerTime].
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'prayerTime': prayerTime.toIso8601String(),
//       'iqamahTime': iqamahTime.toIso8601String(),
//       'date': formatDate(prayerTime),
//     };
//   }
// }
class DailyPrayerTimes {
  final DateTime date;
  final PrayerDetail fajr;
  final PrayerDetail dhuhr;
  final PrayerDetail asr;
  final PrayerDetail maghrib;
  final PrayerDetail isha;

  DailyPrayerTimes({
    required this.date,
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  /// Formats the date as YYYY-MM-DD.
  static String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  /// Converts this object to a Map for Firestore.
  Map<String, dynamic> toMap() {
    return {
      'date': formatDate(date),
      'fajr': {
        'prayerTime': fajr.prayerTime.toIso8601String(),
        'iqamahTime': fajr.iqamahTime.toIso8601String(),
      },
      'dhuhr': {
        'prayerTime': dhuhr.prayerTime.toIso8601String(),
        'iqamahTime': dhuhr.iqamahTime.toIso8601String(),
      },
      'asr': {
        'prayerTime': asr.prayerTime.toIso8601String(),
        'iqamahTime': asr.iqamahTime.toIso8601String(),
      },
      'maghrib': {
        'prayerTime': maghrib.prayerTime.toIso8601String(),
        'iqamahTime': maghrib.iqamahTime.toIso8601String(),
      },
      'isha': {
        'prayerTime': isha.prayerTime.toIso8601String(),
        'iqamahTime': isha.iqamahTime.toIso8601String(),
      },
    };
  }

  /// Creates a DailyPrayerTimes instance from Firestore data.
  factory DailyPrayerTimes.fromMap(Map<String, dynamic> data) {
    return DailyPrayerTimes(
      date: DateTime.parse(data['date']),
      fajr: PrayerDetail(
        prayerTime: DateTime.parse(data['fajr']['prayerTime']),
        iqamahTime: DateTime.parse(data['fajr']['iqamahTime']),
      ),
      dhuhr: PrayerDetail(
        prayerTime: DateTime.parse(data['dhuhr']['prayerTime']),
        iqamahTime: DateTime.parse(data['dhuhr']['iqamahTime']),
      ),
      asr: PrayerDetail(
        prayerTime: DateTime.parse(data['asr']['prayerTime']),
        iqamahTime: DateTime.parse(data['asr']['iqamahTime']),
      ),
      maghrib: PrayerDetail(
        prayerTime: DateTime.parse(data['maghrib']['prayerTime']),
        iqamahTime: DateTime.parse(data['maghrib']['iqamahTime']),
      ),
      isha: PrayerDetail(
        prayerTime: DateTime.parse(data['isha']['prayerTime']),
        iqamahTime: DateTime.parse(data['isha']['iqamahTime']),
      ),
    );
  }
}

class PrayerDetail {
  final DateTime prayerTime;
  final DateTime iqamahTime;

  PrayerDetail({required this.prayerTime, required this.iqamahTime});
}
