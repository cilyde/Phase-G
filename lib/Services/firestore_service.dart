// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:phase_g/prayer_time.dart';
//
// class FirestoreService {
//   final CollectionReference prayerCollection =
//   FirebaseFirestore.instance.collection('prayerTimes');
//
// //   Future<List<PrayerTime>> getPrayerTimesForToday() async {
// //     final today = DateTime.now();
// //     // Format date as YYYY-MM-DD to match stored data.
// //     final formattedDate = "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
// // print("formattedDate");
// // print(formattedDate);
// //     final snapshot = await prayerCollection
// //         .where('date', isEqualTo: formattedDate)
// //         .get();
// //     print("snapshot.docs.first.data()");
// //     print(snapshot.docs.first.data());
// //     print(snapshot.docs.first.exists);
// //
// // print(snapshot);
// // print(snapshot.size);
// // print(snapshot.docs);
// // print(snapshot.docs.first);
// // print(snapshot.docs.first.id);
// // print("snapshot.docs.first.id");
// //     return snapshot.docs.map((doc) => PrayerTime.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
// //   }
//   /// Reads today's prayer times from Firestore using the same formatted date.
//   Future<List<PrayerTime>> getPrayerTimesForToday() async {
//     final today = DateTime.now();
//     final formattedDate = PrayerTime.formatDate(today);
//
//     final snapshot = await prayerCollection
//         .where('date', isEqualTo: formattedDate)
//         .get();
//
//     return snapshot.docs
//         .map((doc) =>
//         PrayerTime.fromFirestore(doc.data() as Map<String, dynamic>))
//         .toList();
//   }
//
//   Future<void> addPrayerTime(PrayerTime prayerTime) async {
//     await prayerCollection.add(prayerTime.toMap());
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phase_g/Models/prayer_time.dart';

class FirestoreService {
  // Store daily prayer times under a dedicated collection.
  final CollectionReference prayerCollection = FirebaseFirestore.instance.collection('daily_prayer_times');

  /// Reads today's daily prayer times from Firestore.
  Future<DailyPrayerTimes?> getDailyPrayerTimesForToday() async {
    final today = DateTime.now();
    final formattedDate = DailyPrayerTimes.formatDate(today);

    final snapshot = await prayerCollection.where('date', isEqualTo: formattedDate).get();
    print("Got prayer times for the day");
    if (snapshot.docs.isNotEmpty) {
      return DailyPrayerTimes.fromMap(snapshot.docs.first.data() as Map<String, dynamic>);
    }
    return null;
  }

 Future<List<DailyPrayerTimes?>> processDailyTimes(List<DailyPrayerTimes?> weekPrayerTimes, String day)async{
   try{
     print('in process');
     print(day);
      var snapshot = await prayerCollection.where('date', isEqualTo: day).get();
      print("Got prayer times for one day");
      if (snapshot.docs.isNotEmpty) {
        // return DailyPrayerTimes.fromMap(snapshot.docs.first.data() as Map<String, dynamic>);
        weekPrayerTimes.add(DailyPrayerTimes.fromMap(snapshot.docs.first.data() as Map<String, dynamic>));
      }
      return weekPrayerTimes;
    }catch(e){
     print(e);
     return weekPrayerTimes;
   }
  }

  /// Reads today's daily prayer times from Firestore.
  Future<List<DailyPrayerTimes?>?> getDailyPrayerTimesForTheWeek() async {
    try{
      List<DailyPrayerTimes?> weekPrayerTimes = [];
      DateTime today = DateTime.now();
      String formattedDate = DailyPrayerTimes.formatDate(today);
      weekPrayerTimes = await processDailyTimes(weekPrayerTimes, formattedDate);
      //
      // var snapshot = await prayerCollection.where('date', isEqualTo: formattedDate).get();
      // print("Got prayer times for the day");
      // if (snapshot.docs.isNotEmpty) {
      //   // return DailyPrayerTimes.fromMap(snapshot.docs.first.data() as Map<String, dynamic>);
      //   weekPrayerTimes.add(DailyPrayerTimes.fromMap(snapshot.docs.first.data() as Map<String, dynamic>));
      // }

      for (int i = 0; i < 6; i++) {
        today = today.add(Duration(hours: 24));
        formattedDate = DailyPrayerTimes.formatDate(today);
        weekPrayerTimes = await processDailyTimes(weekPrayerTimes, formattedDate);
      }

      print('for loop executed');
      print(weekPrayerTimes);
      print(weekPrayerTimes.length);
      for (var item in weekPrayerTimes) {
        print(item);
        print("isha");
        print(item?.isha.prayerTime);
        print(item?.isha.iqamahTime);
      }
      return weekPrayerTimes;
    }catch(e){
      return null;

    }
  }

  /// Adds new daily prayer times to Firestore.
  Future<void> addDailyPrayerTimes(DailyPrayerTimes dailyPrayerTimes, DateTime? selectedDate) async {
    try {
      // final today = DateTime.now();
      final formattedDate = DailyPrayerTimes.formatDate(selectedDate!);
      await prayerCollection.doc(formattedDate).set(dailyPrayerTimes.toMap());
      // await prayerCollection.add(dailyPrayerTimes.toMap());
    } catch (e) {
      print(e);
    }
  }
}
