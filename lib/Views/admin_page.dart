// // import 'package:flutter/material.dart';
// // import 'package:phase_g/prayer_time.dart';
// //
// // import 'firestore_service.dart';
// // class AdminPage extends StatefulWidget {
// //   const AdminPage({Key? key}) : super(key: key);
// //
// //   @override
// //   _AdminPageState createState() => _AdminPageState();
// // }
// //
// // class _AdminPageState extends State<AdminPage> {
// //   final _formKey = GlobalKey<FormState>();
// //   final TextEditingController _nameController = TextEditingController();
// //   DateTime? _selectedDate;
// //   TimeOfDay? _selectedPrayerTime;
// //   TimeOfDay? _selectedIqamahTime;
// //
// //   Future<void> _pickDate() async {
// //     final DateTime? picked = await showDatePicker(
// //       context: context,
// //       initialDate: DateTime.now(),
// //       firstDate: DateTime(2020),
// //       lastDate: DateTime(2100),
// //     );
// //     if (picked != null) {
// //       setState(() {
// //         _selectedDate = picked;
// //       });
// //     }
// //   }
// //
// //   Future<void> _pickPrayerTime() async {
// //     final TimeOfDay? picked = await showTimePicker(
// //       context: context,
// //       initialTime: TimeOfDay.now(),
// //     );
// //     if (picked != null) {
// //       setState(() {
// //         _selectedPrayerTime = picked;
// //       });
// //     }
// //   }
// //
// //   Future<void> _pickIqamahTime() async {
// //     final TimeOfDay? picked = await showTimePicker(
// //       context: context,
// //       initialTime: TimeOfDay.now(),
// //     );
// //     if (picked != null) {
// //       setState(() {
// //         _selectedIqamahTime = picked;
// //       });
// //     }
// //   }
// //
// //   Future<void> _submit() async {
// //     if (_formKey.currentState!.validate() &&
// //         _selectedDate != null &&
// //         _selectedPrayerTime != null &&
// //         _selectedIqamahTime != null) {
// //       // Combine selected date with the chosen times.
// //       final prayerDateTime = DateTime(
// //         _selectedDate!.year,
// //         _selectedDate!.month,
// //         _selectedDate!.day,
// //         _selectedPrayerTime!.hour,
// //         _selectedPrayerTime!.minute,
// //       );
// //       final iqamahDateTime = DateTime(
// //         _selectedDate!.year,
// //         _selectedDate!.month,
// //         _selectedDate!.day,
// //         _selectedIqamahTime!.hour,
// //         _selectedIqamahTime!.minute,
// //       );
// //
// //       // Create the PrayerTime model.
// //       final prayerTime = PrayerTime(
// //         name: _nameController.text.trim(),
// //         prayerTime: prayerDateTime,
// //         iqamahTime: iqamahDateTime,
// //       );
// //
// //       try {
// //         await FirestoreService().addPrayerTime(prayerTime);
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text("Prayer time added successfully!")),
// //         );
// //         // Clear the form fields.
// //         _nameController.clear();
// //         setState(() {
// //           _selectedDate = null;
// //           _selectedPrayerTime = null;
// //           _selectedIqamahTime = null;
// //         });
// //       } catch (e) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text("Failed to add prayer time: $e")),
// //         );
// //       }
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("Please fill in all fields.")),
// //       );
// //     }
// //   }
// //
// //   @override
// //   void dispose() {
// //     _nameController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Admin: Add Prayer Time"),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: ListView(
// //             children: [
// //               // Prayer name input.
// //               TextFormField(
// //                 controller: _nameController,
// //                 decoration: const InputDecoration(labelText: "Prayer Name"),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return "Please enter the prayer name";
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               const SizedBox(height: 16),
// //               // Date picker.
// //               ListTile(
// //                 title: Text(_selectedDate == null
// //                     ? "Select Date"
// //                     : "Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}"),
// //                 trailing: const Icon(Icons.calendar_today),
// //                 onTap: _pickDate,
// //               ),
// //               const SizedBox(height: 16),
// //               // Prayer time picker.
// //               ListTile(
// //                 title: Text(_selectedPrayerTime == null
// //                     ? "Select Prayer Time"
// //                     : "Prayer Time: ${_selectedPrayerTime!.format(context)}"),
// //                 trailing: const Icon(Icons.access_time),
// //                 onTap: _pickPrayerTime,
// //               ),
// //               const SizedBox(height: 16),
// //               // Iqamah time picker.
// //               ListTile(
// //                 title: Text(_selectedIqamahTime == null
// //                     ? "Select Iqamah Time"
// //                     : "Iqamah Time: ${_selectedIqamahTime!.format(context)}"),
// //                 trailing: const Icon(Icons.access_time),
// //                 onTap: _pickIqamahTime,
// //               ),
// //               const SizedBox(height: 32),
// //               // Submission button.
// //               ElevatedButton(
// //                 onPressed: _submit,
// //                 child: const Text("Add Prayer Time"),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:phase_g/prayer_time.dart';
//
// import 'firestore_service.dart';
//
// class AdminPage extends StatefulWidget {
//   const AdminPage({Key? key}) : super(key: key);
//
//   @override
//   _AdminPageState createState() => _AdminPageState();
// }
//
// class _AdminPageState extends State<AdminPage> {
//   final _formKey = GlobalKey<FormState>();
//
//   DateTime? _selectedDate;
//   // Time fields for each prayer's prayer time and iqamah time.
//   TimeOfDay? _fajrPrayerTime, _fajrIqamahTime;
//   TimeOfDay? _dhuhrPrayerTime, _dhuhrIqamahTime;
//   TimeOfDay? _asrPrayerTime, _asrIqamahTime;
//   TimeOfDay? _maghribPrayerTime, _maghribIqamahTime;
//   TimeOfDay? _ishaPrayerTime, _ishaIqamahTime;
//
//   Future<void> _pickDate() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }
//
//   Future<TimeOfDay?> _pickTime(TimeOfDay? initialTime) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: initialTime ?? TimeOfDay.now(),
//     );
//     return picked;
//   }
//
//   /// Helper widget to build a row for a given prayer.
//   Widget _buildTimePickerRow(
//       String prayerName,
//       TimeOfDay? prayerTime,
//       TimeOfDay? iqamahTime,
//       Function(TimeOfDay?) onPrayerTimePicked,
//       Function(TimeOfDay?) onIqamahTimePicked) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(prayerName,
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//         Row(
//           children: [
//             Expanded(
//               child: ListTile(
//                 title: Text(prayerTime == null
//                     ? "Select Prayer Time"
//                     : "Prayer: ${prayerTime.format(context)}"),
//                 trailing: const Icon(Icons.access_time),
//                 onTap: () async {
//                   final time = await _pickTime(prayerTime);
//                   if (time != null) {
//                     onPrayerTimePicked(time);
//                   }
//                 },
//               ),
//             ),
//             Expanded(
//               child: ListTile(
//                 title: Text(iqamahTime == null
//                     ? "Select Iqamah Time"
//                     : "Iqamah: ${iqamahTime.format(context)}"),
//                 trailing: const Icon(Icons.access_time),
//                 onTap: () async {
//                   final time = await _pickTime(iqamahTime);
//                   if (time != null) {
//                     onIqamahTimePicked(time);
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//         const Divider(),
//       ],
//     );
//   }
//
//   Future<void> _submit() async {
//     if (_formKey.currentState!.validate() &&
//         _selectedDate != null &&
//         _fajrPrayerTime != null && _fajrIqamahTime != null &&
//         _dhuhrPrayerTime != null && _dhuhrIqamahTime != null &&
//         _asrPrayerTime != null && _asrIqamahTime != null &&
//         _maghribPrayerTime != null && _maghribIqamahTime != null &&
//         _ishaPrayerTime != null && _ishaIqamahTime != null) {
//
//       // Combine the selected date and times.
//       DateTime combine(DateTime date, TimeOfDay time) {
//         return DateTime(date.year, date.month, date.day, time.hour, time.minute);
//       }
//
//       final dailyPrayerTimes = DailyPrayerTimes(
//         date: _selectedDate!,
//         fajr: PrayerDetail(
//           prayerTime: combine(_selectedDate!, _fajrPrayerTime!),
//           iqamahTime: combine(_selectedDate!, _fajrIqamahTime!),
//         ),
//         dhuhr: PrayerDetail(
//           prayerTime: combine(_selectedDate!, _dhuhrPrayerTime!),
//           iqamahTime: combine(_selectedDate!, _dhuhrIqamahTime!),
//         ),
//         asr: PrayerDetail(
//           prayerTime: combine(_selectedDate!, _asrPrayerTime!),
//           iqamahTime: combine(_selectedDate!, _asrIqamahTime!),
//         ),
//         maghrib: PrayerDetail(
//           prayerTime: combine(_selectedDate!, _maghribPrayerTime!),
//           iqamahTime: combine(_selectedDate!, _maghribIqamahTime!),
//         ),
//         isha: PrayerDetail(
//           prayerTime: combine(_selectedDate!, _ishaPrayerTime!),
//           iqamahTime: combine(_selectedDate!, _ishaIqamahTime!),
//         ),
//       );
//
//       try {
//         await FirestoreService().addDailyPrayerTimes(dailyPrayerTimes);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Daily prayer times added successfully!")),
//         );
//         // Reset all fields.
//         setState(() {
//           _selectedDate = null;
//           _fajrPrayerTime = null;
//           _fajrIqamahTime = null;
//           _dhuhrPrayerTime = null;
//           _dhuhrIqamahTime = null;
//           _asrPrayerTime = null;
//           _asrIqamahTime = null;
//           _maghribPrayerTime = null;
//           _maghribIqamahTime = null;
//           _ishaPrayerTime = null;
//           _ishaIqamahTime = null;
//         });
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Failed to add daily prayer times: $e")),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please fill in all fields.")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Admin: Add Daily Prayer Times"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               ListTile(
//                 title: Text(_selectedDate == null
//                     ? "Select Date"
//                     : "Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}"),
//                 trailing: const Icon(Icons.calendar_today),
//                 onTap: _pickDate,
//               ),
//               const Divider(),
//               _buildTimePickerRow("Fajr", _fajrPrayerTime, _fajrIqamahTime, (time) {
//                 setState(() {
//                   _fajrPrayerTime = time;
//                 });
//               }, (time) {
//                 setState(() {
//                   _fajrIqamahTime = time;
//                 });
//               }),
//               _buildTimePickerRow("Dhuhr", _dhuhrPrayerTime, _dhuhrIqamahTime, (time) {
//                 setState(() {
//                   _dhuhrPrayerTime = time;
//                 });
//               }, (time) {
//                 setState(() {
//                   _dhuhrIqamahTime = time;
//                 });
//               }),
//               _buildTimePickerRow("Asr", _asrPrayerTime, _asrIqamahTime, (time) {
//                 setState(() {
//                   _asrPrayerTime = time;
//                 });
//               }, (time) {
//                 setState(() {
//                   _asrIqamahTime = time;
//                 });
//               }),
//               _buildTimePickerRow("Maghrib", _maghribPrayerTime, _maghribIqamahTime, (time) {
//                 setState(() {
//                   _maghribPrayerTime = time;
//                 });
//               }, (time) {
//                 setState(() {
//                   _maghribIqamahTime = time;
//                 });
//               }),
//               _buildTimePickerRow("Isha", _ishaPrayerTime, _ishaIqamahTime, (time) {
//                 setState(() {
//                   _ishaPrayerTime = time;
//                 });
//               }, (time) {
//                 setState(() {
//                   _ishaIqamahTime = time;
//                 });
//               }),
//               const SizedBox(height: 32),
//               ElevatedButton(
//                 onPressed: _submit,
//                 child: const Text("Add Daily Prayer Times"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }}

import 'package:flutter/material.dart';
import 'package:phase_g/Models/prayer_time.dart';

import '../Services/firestore_service.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  // Time fields for each prayer's prayer time and iqamah time.
  TimeOfDay? _fajrPrayerTime, _fajrIqamahTime;
  TimeOfDay? _dhuhrPrayerTime, _dhuhrIqamahTime;
  TimeOfDay? _asrPrayerTime, _asrIqamahTime;
  TimeOfDay? _maghribPrayerTime, _maghribIqamahTime;
  TimeOfDay? _ishaPrayerTime, _ishaIqamahTime;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<TimeOfDay?> _pickTime(TimeOfDay? initialTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
    return picked;
  }

  /// Helper widget to build a row for a given prayer.
  Widget _buildTimePickerRow(
      String prayerName,
      TimeOfDay? prayerTime,
      TimeOfDay? iqamahTime,
      Function(TimeOfDay?) onPrayerTimePicked,
      Function(TimeOfDay?) onIqamahTimePicked) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(prayerName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text(prayerTime == null
                    ? "Select Prayer Time"
                    : "Prayer: ${prayerTime.format(context)}"),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  final time = await _pickTime(prayerTime);
                  if (time != null) {
                    onPrayerTimePicked(time);
                  }
                },
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(iqamahTime == null
                    ? "Select Iqamah Time"
                    : "Iqamah: ${iqamahTime.format(context)}"),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  final time = await _pickTime(iqamahTime);
                  if (time != null) {
                    onIqamahTimePicked(time);
                  }
                },
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _fajrPrayerTime != null && _fajrIqamahTime != null &&
        _dhuhrPrayerTime != null && _dhuhrIqamahTime != null &&
        _asrPrayerTime != null && _asrIqamahTime != null &&
        _maghribPrayerTime != null && _maghribIqamahTime != null &&
        _ishaPrayerTime != null && _ishaIqamahTime != null) {

      // Combine the selected date and times.
      DateTime combine(DateTime date, TimeOfDay time) {
        return DateTime(date.year, date.month, date.day, time.hour, time.minute);
      }

      final dailyPrayerTimes = DailyPrayerTimes(
        date: _selectedDate!,
        fajr: PrayerDetail(
          prayerTime: combine(_selectedDate!, _fajrPrayerTime!),
          iqamahTime: combine(_selectedDate!, _fajrIqamahTime!),
        ),
        dhuhr: PrayerDetail(
          prayerTime: combine(_selectedDate!, _dhuhrPrayerTime!),
          iqamahTime: combine(_selectedDate!, _dhuhrIqamahTime!),
        ),
        asr: PrayerDetail(
          prayerTime: combine(_selectedDate!, _asrPrayerTime!),
          iqamahTime: combine(_selectedDate!, _asrIqamahTime!),
        ),
        maghrib: PrayerDetail(
          prayerTime: combine(_selectedDate!, _maghribPrayerTime!),
          iqamahTime: combine(_selectedDate!, _maghribIqamahTime!),
        ),
        isha: PrayerDetail(
          prayerTime: combine(_selectedDate!, _ishaPrayerTime!),
          iqamahTime: combine(_selectedDate!, _ishaIqamahTime!),
        ),
      );

      try {
        await FirestoreService().addDailyPrayerTimes(dailyPrayerTimes,_selectedDate);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Daily prayer times added successfully!")),
        );
        // Reset all fields.
        setState(() {
          _selectedDate = null;
          _fajrPrayerTime = null;
          _fajrIqamahTime = null;
          _dhuhrPrayerTime = null;
          _dhuhrIqamahTime = null;
          _asrPrayerTime = null;
          _asrIqamahTime = null;
          _maghribPrayerTime = null;
          _maghribIqamahTime = null;
          _ishaPrayerTime = null;
          _ishaIqamahTime = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add daily prayer times: $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin: Add Daily Prayer Times"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ListTile(
                title: Text(_selectedDate == null
                    ? "Select Date"
                    : "Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}"),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              const Divider(),
              _buildTimePickerRow("Fajr", _fajrPrayerTime, _fajrIqamahTime, (time) {
                setState(() {
                  _fajrPrayerTime = time;
                });
              }, (time) {
                setState(() {
                  _fajrIqamahTime = time;
                });
              }),
              _buildTimePickerRow("Dhuhr", _dhuhrPrayerTime, _dhuhrIqamahTime, (time) {
                setState(() {
                  _dhuhrPrayerTime = time;
                });
              }, (time) {
                setState(() {
                  _dhuhrIqamahTime = time;
                });
              }),
              _buildTimePickerRow("Asr", _asrPrayerTime, _asrIqamahTime, (time) {
                setState(() {
                  _asrPrayerTime = time;
                });
              }, (time) {
                setState(() {
                  _asrIqamahTime = time;
                });
              }),
              _buildTimePickerRow("Maghrib", _maghribPrayerTime, _maghribIqamahTime, (time) {
                setState(() {
                  _maghribPrayerTime = time;
                });
              }, (time) {
                setState(() {
                  _maghribIqamahTime = time;
                });
              }),
              _buildTimePickerRow("Isha", _ishaPrayerTime, _ishaIqamahTime, (time) {
                setState(() {
                  _ishaPrayerTime = time;
                });
              }, (time) {
                setState(() {
                  _ishaIqamahTime = time;
                });
              }),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Add Daily Prayer Times"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
