// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// void main() {
//   runApp(const AttendanceApp());
// }
//
// class AttendanceApp extends StatelessWidget {
//   const AttendanceApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: DashboardScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});
//
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   List<int> years = [2024, 2025];
//   List<String> months = DateFormat().dateSymbols.MONTHS;
//   List<String> employees = ['Sandhya', 'Ajay', 'Nisha'];
//
//   int? selectedYear;
//   String? selectedMonth;
//
//   Map<String, Map<String, String>> attendance = {};
//
//   List<DateTime> getDatesInMonth(int year, int monthIndex) {
//     final firstDate = DateTime(year, monthIndex + 1, 1);
//     final lastDate = DateTime(year, monthIndex + 2, 0);
//     return List.generate(lastDate.day, (i) => DateTime(year, monthIndex + 1, i + 1));
//   }
//
//   void _showAttendanceDialog(String emp, DateTime date) {
//     String? selectedCode = attendance[emp]?[date.toIso8601String()];
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Mark Attendance for $emp on ${DateFormat('yyyy-MM-dd').format(date)}'),
//           content: DropdownButton<String>(
//             value: selectedCode,
//             hint: const Text('Select Code'),
//             items: ['P', 'A', 'L'].map((code) {
//               return DropdownMenuItem(value: code, child: Text(code));
//             }).toList(),
//             onChanged: (value) {
//               setState(() {
//                 selectedCode = value;
//               });
//               Navigator.pop(context);
//               setState(() {
//                 attendance.putIfAbsent(emp, () => {})[date.toIso8601String()] = selectedCode!;
//               });
//             },
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final monthIndex = months.indexOf(selectedMonth ?? '');
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Attendance Dashboard'),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 DropdownButton<int>(
//                   hint: const Text('Select Year'),
//                   value: selectedYear,
//                   items: years.map((y) => DropdownMenuItem(value: y, child: Text('$y'))).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedYear = value;
//                       selectedMonth = null;
//                     });
//                   },
//                 ),
//                 const SizedBox(width: 16),
//                 if (selectedYear != null)
//                   DropdownButton<String>(
//                     hint: const Text('Select Month'),
//                     value: selectedMonth,
//                     items: months.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedMonth = value;
//                       });
//                     },
//                   ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             if (selectedYear != null && selectedMonth != null)
//               Expanded(
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: DataTable(
//                     headingRowColor: MaterialStateProperty.all(Colors.deepPurple.shade100),
//                     columns: [
//                       const DataColumn(label: Text('Employee')),
//                       ...getDatesInMonth(selectedYear!, monthIndex)
//                           .map((date) => DataColumn(label: Text('${date.day}\n${DateFormat('E').format(date)}')))
//                           .toList(),
//                     ],
//                     rows: employees.map((emp) {
//                       return DataRow(
//                         cells: [
//                           DataCell(Text(emp)),
//                           ...getDatesInMonth(selectedYear!, monthIndex).map(
//                                 (date) {
//                               final code = attendance[emp]?[date.toIso8601String()] ?? '-';
//                               return DataCell(
//                                 GestureDetector(
//                                   onTap: () => _showAttendanceDialog(emp, date),
//                                   child: Text(code),
//                                 ),
//                               );
//                             },
//                           ).toList(),
//                         ],
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// void main() => runApp(AttendanceApp());
//
// class AttendanceApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Attendance Dashboard',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: DashboardScreen(),
//     );
//   }
// }
//
// class DashboardScreen extends StatefulWidget {
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   int selectedYear = DateTime.now().year;
//   int selectedMonth = DateTime.now().month;
//
//   List<String> employees = [
//     'Pavani',
//     'Chandu',
//     'Vijaya',
//     'Aswitha',
//     'Krishna',
//     'Navya',
//     'Employee 7', 'Employee 8', 'Employee 9'
//   ];
//
//   List<DateTime> getMonthDays(int year, int month) {
//     final firstDay = DateTime(year, month, 1);
//     final lastDay = DateTime(year, month + 1, 0);
//     return List.generate(lastDay.day, (index) => DateTime(year, month, index + 1));
//   }
//
//   Map<String, String> attendanceData = {};
//
//   final List<DateTime> holidays = [
//     DateTime(2025, 1, 26),
//     DateTime(2025, 8, 15),
//     DateTime(2025, 10, 2),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final daysInMonth = getMonthDays(selectedYear, selectedMonth);
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Attendance Dashboard')),
//       body: Column(
//         children: [
//           // Year & Month Selectors
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Text('Year:'),
//                 SizedBox(width: 10),
//                 DropdownButton<int>(
//                   value: selectedYear,
//                   items: List.generate(5, (index) => DateTime.now().year - 2 + index)
//                       .map((year) => DropdownMenuItem(value: year, child: Text('$year')))
//                       .toList(),
//                   onChanged: (value) => setState(() => selectedYear = value!),
//                 ),
//                 SizedBox(width: 30),
//                 Text('Month:'),
//                 SizedBox(width: 10),
//                 DropdownButton<int>(
//                   value: selectedMonth,
//                   items: List.generate(12, (index) => DropdownMenuItem(value: index + 1, child: Text(DateFormat('MMMM').format(DateTime(0, index + 1))))).toList(),
//                   onChanged: (value) => setState(() => selectedMonth = value!),
//                 ),
//               ],
//             ),
//           ),
//
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: SingleChildScrollView(
//                 child: DataTable(
//                   columnSpacing: 5, // Smaller space between columns
//                   headingRowHeight: 50, // Make the heading row taller
//                   dataRowHeight: 40, // Row height for data
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black, width: 1), // Border around the table
//                   ),
//                   columns: [
//                     DataColumn(label: Text('Employee')),
//                     ...daysInMonth.map((date) {
//                       bool isWeekend = date.weekday == 6 || date.weekday == 7;
//                       bool isHoliday = holidays.any((h) => h.year == date.year && h.month == date.month && h.day == date.day);
//                       Color bgColor = isWeekend ? Colors.grey.shade300 : isHoliday ? Colors.amber : Colors.white;
//
//                       return DataColumn(
//                         label: Container(
//                           padding: EdgeInsets.all(4),
//                           color: bgColor,
//                           alignment: Alignment.center,
//                           child: Text(
//                             DateFormat('d').format(date),
//                             style: TextStyle(fontSize: 12),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                     DataColumn(label: Text('Total Days')),
//                   ],
//                   rows: employees.map((employee) {
//                     return DataRow(
//                       cells: [
//                         DataCell(Text(employee)),
//                         ...daysInMonth.map((date) {
//                           String key = '${employee}_${DateFormat('yyyy-MM-dd').format(date)}';
//                           bool isSelected = attendanceData[key] != null && attendanceData[key] != '-';
//                           return DataCell(
//                             DropdownButton<String>(
//                               value: attendanceData[key] ,
//                               items: ['-', 'P', 'L', 'S', 'W'].map((value) {
//                                 return DropdownMenuItem(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList(),
//                               onChanged: isSelected ? null : (value) { // Disable dropdown if already selected
//                                 setState(() {
//                                   attendanceData[key] = value!;
//                                 });
//                               },
//                             ),
//                           );
//                         }).toList(),
//                         DataCell(Text(getTotalDaysPresent(employee, daysInMonth).toString())),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   int getTotalDaysPresent(String employee, List<DateTime> daysInMonth) {
//     int presentDays = 0;
//     for (var date in daysInMonth) {
//       String key = '${employee}_${DateFormat('yyyy-MM-dd').format(date)}';
//       if (attendanceData[key] == 'P') {
//         presentDays++;
//       }
//     }
//     return presentDays;
//   }
// }



//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
//
// void main() => runApp(AttendanceApp());
//
// class AttendanceApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Attendance Dashboard',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: DashboardScreen(),
//     );
//   }
// }
//
// class DashboardScreen extends StatefulWidget {
//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   int selectedYear = DateTime.now().year;
//   int selectedMonth = DateTime.now().month;
//
//   List<String> employees = [
//     'Pavani',
//     'Chandu',
//     'Vijaya',
//     'Aswitha',
//     'Krishna',
//     'Navya',
//   ];
//
//   List<DateTime> getMonthDays(int year, int month) {
//     final firstDay = DateTime(year, month, 1);
//     final lastDay = DateTime(year, month + 1, 0);
//     return List.generate(
//         lastDay.day, (index) => DateTime(year, month, index + 1));
//   }
//
//   Map<String, String> attendanceData = {};
//
//   final List<DateTime> holidays = [
//     DateTime(2025, 1, 26),
//     DateTime(2025, 5, 1),
//     DateTime(2025, 8, 15),
//     DateTime(2025, 10, 2),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     loadAttendanceData();
//   }
//
//   // Load saved attendance data from shared preferences
//   void loadAttendanceData() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       String? jsonString = prefs.getString('attendanceData');
//       if (jsonString != null) {
//         attendanceData = Map<String, String>.from(jsonDecode(jsonString));
//       }
//     });
//   }
//
//   // Save attendance data to shared preferences
//   void saveAttendanceData() async {
//     final prefs = await SharedPreferences.getInstance();
//     String jsonString = jsonEncode(attendanceData);
//     prefs.setString('attendanceData', jsonString);
//   }
//
//   // Total working days excluding weekends and holidays
//   int getWorkingDays(List<DateTime> daysInMonth) {
//     int count = 0;
//     for (var date in daysInMonth) {
//       if (date.weekday != DateTime.saturday &&
//           date.weekday != DateTime.sunday &&
//           !holidays.any((h) => h.year == date.year && h.month == date.month && h.day == date.day)) {
//         count++;
//       }
//     }
//     return count;
//   }
//
//   // Get the total count of Leave, Sick Leave, Work from Home
//   Map<String, int> getLeaveSummary(String employee, List<DateTime> daysInMonth) {
//     int leaveDays = 0;
//     int sickLeaveDays = 0;
//     int workFromHomeDays = 0;
//     int otherLeaveDays = 0;
//
//
//
//     for (var date in daysInMonth) {
//       String key = '${employee}_${DateFormat('yyyy-MM-dd').format(date)}';
//       String? status = attendanceData[key];
//
//       if (status == 'V') {
//         leaveDays++;
//       } else if (status == 'S') {
//         sickLeaveDays++;
//       } else if (status == 'W') {
//         workFromHomeDays++;
//       } else if (status == 'O') {
//         otherLeaveDays++;
//       }
//     }
//
//     return {
//       'VacationLeave': leaveDays,
//       'Sick Leave': sickLeaveDays,
//       'Work From Home': workFromHomeDays,
//       'Other Leave Days': otherLeaveDays
//     };
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final daysInMonth = getMonthDays(selectedYear, selectedMonth);
//     final totalWorkingDays = getWorkingDays(daysInMonth);
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Attendance Dashboard')),
//       body: Column(
//         children: [
//           // Year & Month Selectors
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Text('Year:'),
//                 SizedBox(width: 10),
//                 DropdownButton<int?>( // Year dropdown
//                   value: selectedYear,
//                   items: List.generate(5, (index) => DateTime.now().year - 2 + index)
//                       .map((year) => DropdownMenuItem<int?>(value: year, child: Text('$year')))
//                       .toList(),
//                   onChanged: (int? value) {
//                     setState(() {
//                       selectedYear = value!;
//                       if (selectedMonth > 12) selectedMonth = 1;
//                     });
//                   },
//                 ),
//                 SizedBox(width: 30),
//                 Text('Month:'),
//                 SizedBox(width: 10),
//                 DropdownButton<int?>( // Month dropdown
//                   value: selectedMonth,
//                   items: List.generate(12, (index) {
//                     return DropdownMenuItem<int?>(value: index + 1, child: Text(DateFormat('MMMM').format(DateTime(0, index + 1))));
//                   }).toList(),
//                   onChanged: (int? value) {
//                     setState(() => selectedMonth = value!);
//                   },
//                 ),
//               ],
//             ),
//           ),
//
//           // Working Days Info
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('Total Working Days: $totalWorkingDays', style: TextStyle(fontSize: 16)),
//           ),
//
//           // Attendance Table
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: SingleChildScrollView(
//                 child: DataTable(
//                   columnSpacing: 5,
//                   headingRowHeight: 50,
//                   dataRowHeight: 40,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black, width: 1),
//                   ),
//                   columns: [
//                     DataColumn(label: Text('Employee')),
//                     ...daysInMonth.map((date) {
//                       bool isWeekend = date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
//                       bool isHoliday = holidays.any((h) =>
//                       h.year == date.year &&
//                           h.month == date.month &&
//                           h.day == date.day);
//                       Color bgColor = isWeekend
//                           ? Colors.grey.shade300
//                           : isHoliday
//                           ? Colors.amber
//                           : Colors.white;
//
//                       return DataColumn(
//                         label: Container(
//                           width: 35,
//                           padding: EdgeInsets.all(4),
//                           color: bgColor,
//                           alignment: Alignment.center,
//                           child: Text(
//                             DateFormat('d').format(date),
//                             style: TextStyle(fontSize: 12),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                     DataColumn(label: Text('Total Leaves')),
//                   ],
//                   rows: employees.map((employee) {
//                     return DataRow(
//                       cells: [
//                         DataCell(Text(employee)),
//                         ...daysInMonth.map((date) {
//                           String key = '${employee}_${DateFormat('yyyy-MM-dd').format(date)}';
//                           bool isHoliday = holidays.any((h) =>
//                           h.year == date.year &&
//                               h.month == date.month &&
//                               h.day == date.day);
//                           bool isWeekend = date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
//
//                           return DataCell(
//                             SizedBox(
//                               width: 40,
//                               child: Builder(
//                                 builder: (context) {
//                                   return DropdownButton<String?>(
//                                     value: attendanceData[key] ?? '',
//                                     isDense: true,
//                                     items: ['', 'V', 'S', 'W', 'O'].map((value) {
//                                       return DropdownMenuItem<String?>(value: value, child: Text(value));
//                                     }).toList(),
//                                     onChanged: isHoliday || isWeekend ? null : (String? value) {
//                                       setState(() {
//                                         attendanceData[key] = value ?? '';
//                                         saveAttendanceData();
//                                       });
//                                     },
//                                   );
//                                 },
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                         DataCell(Text(getTotalLeaves(employee, daysInMonth).toString())),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ),
//
//           // Total Leave Summary Table
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: DataTable(
//               columns: [
//                 DataColumn(label: Text('Employee')),
//                 DataColumn(label: Text('Vacation Leave')),
//                 DataColumn(label: Text('Sick Leave')),
//                 DataColumn(label: Text('Work From Home')),
//                 DataColumn(label: Text('Other Leave Days')),
//                 DataColumn(label: Text('Total Leaves')),
//
//               ],
//               rows: employees.map((employee) {
//                 final leaveSummary = getLeaveSummary(employee, daysInMonth);
//                 return DataRow(
//                   cells: [
//                     DataCell(Text(employee)),
//                     DataCell(Text(leaveSummary['VacationLeave'].toString())),
//                     DataCell(Text(leaveSummary['Sick Leave'].toString())),
//                     DataCell(Text(leaveSummary['Work From Home'].toString())),
//                     DataCell(Text(leaveSummary['Other Leave Days'].toString())),
//                     DataCell(Text(getTotalLeaves(employee, daysInMonth).toString())),
//                   ],
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Calculate the total leaves for each employee
//   int getTotalLeaves(String employee, List<DateTime> daysInMonth) {
//     int totalLeaves = 0;
//     for (var date in daysInMonth) {
//       String key = '${employee}_${DateFormat('yyyy-MM-dd').format(date)}';
//       if (attendanceData[key] == 'V' || attendanceData[key] == 'S' || attendanceData[key] == 'W' || attendanceData[key] == 'O') {
//         totalLeaves++;
//       }
//     }
//     return totalLeaves;
//   }
  //
  // double getTotalLeaves(String employee, List<DateTime> daysInMonth) {
  //   double totalLeaves = 0;  // Change type to double
  //   for (var date in daysInMonth) {
  //     String key = '${employee}_${DateFormat('yyyy-MM-dd').format(date)}';
  //     var attendance = attendanceData[key];
  //     if (attendance == 'V' || attendance == 'S' || attendance == 'W' || attendance == 'O') {
  //       totalLeaves++;
  //     } else if (attendance == 'S1' || attendance == 'S2' || attendance == 'W1' || attendance == 'W2') {
  //       totalLeaves += 0.5;  // Adding a fractional value is fine with double
  //     }
  //   }
  //   return totalLeaves;
  // }

// }


// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'leaveFilter.dart';
// import 'salarysheet.dart';
//
// void main() => runApp(AttendanceApp());
//
// class AttendanceApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Attendance Dashboard',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: SalarySheetPage(),
//       debugShowCheckedModeBanner: false,
//       routes: {
//         '/dashboard': (context) => DashboardScreen(),
//       },
//     );
//   }
// }
//
// class LandingPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Welcome")),
//       body: Center(
//         child: ElevatedButton(
//           child: Text("Go to Dashboard"),
//           onPressed: () {
//             Navigator.pushNamed(context, '/dashboard');
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class DashboardScreen extends StatefulWidget {
//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   int selectedYear = DateTime.now().year;
//   int selectedMonth = DateTime.now().month;
//
//   List<String> employees = [
//     'Pavani',
//     'Chandu',
//     'Vijaya',
//     'Aswitha',
//     'Krishna',
//     'Navya',
//   ];
//
//   List<DateTime> getMonthDays(int year, int month) {
//     final firstDay = DateTime(year, month, 1);
//     final lastDay = DateTime(year, month + 1, 0);
//     return List.generate(
//         lastDay.day, (index) => DateTime(year, month, index + 1));
//   }
//
//   Map<String, String> attendanceData = {};
//
//   final List<DateTime> holidays = [
//     DateTime(2025, 1, 26),
//     DateTime(2025, 5, 1),
//     DateTime(2025, 8, 15),
//     DateTime(2025, 10, 2),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     loadAttendanceData();
//   }
//
//   void loadAttendanceData() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       String? jsonString = prefs.getString('attendanceData');
//       if (jsonString != null) {
//         attendanceData = Map<String, String>.from(jsonDecode(jsonString));
//       }
//     });
//   }
//
//   void saveAttendanceData() async {
//     final prefs = await SharedPreferences.getInstance();
//     String jsonString = jsonEncode(attendanceData);
//     prefs.setString('attendanceData', jsonString);
//   }
//
//   int getWorkingDays(List<DateTime> daysInMonth) {
//     int count = 0;
//     for (var date in daysInMonth) {
//       if (date.weekday != DateTime.saturday &&
//           date.weekday != DateTime.sunday &&
//           !holidays.any((h) =>
//           h.year == date.year &&
//               h.month == date.month &&
//               h.day == date.day)) {
//         count++;
//       }
//     }
//     return count;
//   }
//
//   Map<String, int> getLeaveSummary(String employee, List<DateTime> daysInMonth) {
//     int leaveDays = 0;
//     int sickLeaveDays = 0;
//     int workFromHomeDays = 0;
//     int otherLeaveDays = 0;
//
//     for (var date in daysInMonth) {
//       String key = '${employee}_${DateFormat('yyyy-MM-dd').format(date)}';
//       String? status = attendanceData[key];
//
//       if (status == 'V') {
//         leaveDays++;
//       } else if (status == 'S') {
//         sickLeaveDays++;
//       } else if (status == 'W') {
//         workFromHomeDays++;
//       } else if (status == 'O') {
//         otherLeaveDays++;
//       }
//     }
//
//     return {
//       'VacationLeave': leaveDays,
//       'Sick Leave': sickLeaveDays,
//       'Work From Home': workFromHomeDays,
//       'Other Leave Days': otherLeaveDays
//     };
//   }
//
//   int getTotalLeaves(String employee, List<DateTime> daysInMonth) {
//     int totalLeaves = 0;
//     for (var date in daysInMonth) {
//       String key = '${employee}_${DateFormat('yyyy-MM-dd').format(date)}';
//       if (attendanceData[key] == 'V' ||
//           attendanceData[key] == 'S' ||
//           attendanceData[key] == 'W' ||
//           attendanceData[key] == 'O') {
//         totalLeaves++;
//       }
//     }
//     return totalLeaves;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final daysInMonth = getMonthDays(selectedYear, selectedMonth);
//     final totalWorkingDays = getWorkingDays(daysInMonth);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Attendance Dashboard'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Text('Year:'),
//                 SizedBox(width: 10),
//                 DropdownButton<int>(
//                   value: selectedYear,
//                   items: List.generate(5, (index) => DateTime.now().year - 2 + index)
//                       .map((year) => DropdownMenuItem(value: year, child: Text('$year')))
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedYear = value!;
//                     });
//                   },
//                 ),
//                 SizedBox(width: 30),
//                 Text('Month:'),
//                 SizedBox(width: 10),
//                 DropdownButton<int>(
//                   value: selectedMonth,
//                   items: List.generate(
//                     12,
//                         (index) => DropdownMenuItem(
//                       value: index + 1,
//                       child: Text(DateFormat('MMMM').format(DateTime(0, index + 1))),
//                     ),
//                   ).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedMonth = value!;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('Total Working Days: $totalWorkingDays',
//                 style: TextStyle(fontSize: 16)),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: SingleChildScrollView(
//                 child: DataTable(
//                   columnSpacing: 5,
//                   headingRowHeight: 50,
//                   dataRowHeight: 40,
//                   columns: [
//                     DataColumn(label: Text('Employee')),
//                     ...daysInMonth.map((date) {
//                       bool isWeekend = date.weekday == DateTime.saturday ||
//                           date.weekday == DateTime.sunday;
//                       bool isHoliday = holidays.any((h) =>
//                       h.year == date.year &&
//                           h.month == date.month &&
//                           h.day == date.day);
//                       Color bgColor = isWeekend
//                           ? Colors.grey.shade300
//                           : isHoliday
//                           ? Colors.amber
//                           : Colors.white;
//                       return DataColumn(
//                         label: Container(
//                           width: 35,
//                           color: bgColor,
//                           alignment: Alignment.center,
//                           child: Text(
//                             DateFormat('d').format(date),
//                             style: TextStyle(fontSize: 12),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                     DataColumn(label: Text('Total Leaves')),
//                   ],
//                   rows: employees.map((employee) {
//                     return DataRow(
//                       cells: [
//                         DataCell(Text(employee)),
//                         ...daysInMonth.map((date) {
//                           String key =
//                               '${employee}_${DateFormat('yyyy-MM-dd').format(date)}';
//                           bool isHoliday = holidays.any((h) =>
//                           h.year == date.year &&
//                               h.month == date.month &&
//                               h.day == date.day);
//                           bool isWeekend = date.weekday == DateTime.saturday ||
//                               date.weekday == DateTime.sunday;
//                           return DataCell(
//                             SizedBox(
//                               width: 40,
//                               child: DropdownButton<String>(
//                                 value: attendanceData[key] ?? '',
//                                 isDense: true,
//                                 items: ['', 'V', 'S', 'W', 'O']
//                                     .map((value) =>
//                                     DropdownMenuItem(value: value, child: Text(value)))
//                                     .toList(),
//                                 onChanged: isHoliday || isWeekend
//                                     ? null
//                                     : (value) {
//                                   setState(() {
//                                     attendanceData[key] = value ?? '';
//                                     saveAttendanceData();
//                                   });
//                                 },
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                         DataCell(Text(getTotalLeaves(employee, daysInMonth).toString())),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ),
//           // Leave Summary Table
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: DataTable(
//               columns: [
//                 DataColumn(label: Text('Employee')),
//                 DataColumn(label: Text('Vacation')),
//                 DataColumn(label: Text('Sick')),
//                 DataColumn(label: Text('WFH')),
//                 DataColumn(label: Text('Other')),
//                 DataColumn(label: Text('Total')),
//               ],
//               rows: employees.map((employee) {
//                 final summary = getLeaveSummary(employee, daysInMonth);
//                 return DataRow(
//                   cells: [
//                     DataCell(Text(employee)),
//                     DataCell(Text('${summary['VacationLeave']}')),
//                     DataCell(Text('${summary['Sick Leave']}')),
//                     DataCell(Text('${summary['Work From Home']}')),
//                     DataCell(Text('${summary['Other Leave Days']}')),
//                     DataCell(Text('${getTotalLeaves(employee, daysInMonth)}')),
//                   ],
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'attendance_sheet.dart';
import 'leaveFilter.dart';
import 'salarysheet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Dashboard'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              DashboardButton(
                text: '📋 Attendance',
                color: Colors.orangeAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AttendanceScreen()),
                  );
                },
              ),
              DashboardButton(
                text: '📝 Leave Request',
                color: Colors.orangeAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LeaveRequestScreen()),
                  );
                },
              ),
              DashboardButton(
                text: '💰 Salary Sheet',
                color: Colors.orangeAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SalarySheetPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const DashboardButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
