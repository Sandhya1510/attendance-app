// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
//
// class AttendanceScreen extends StatefulWidget {
//   @override
//   _AttendanceScreenState createState() => _AttendanceScreenState();
// }
//
// class _AttendanceScreenState extends State<AttendanceScreen> {
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
//       lastDay.day,
//       (index) => DateTime(year, month, index + 1),
//     );
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
//           !holidays.any(
//             (h) =>
//                 h.year == date.year &&
//                 h.month == date.month &&
//                 h.day == date.day,
//           )) {
//         count++;
//       }
//     }
//     return count;
//   }
//
//   static const List<String> statusOptions = [
//     '',
//     'L',
//     'S',
//     'W',
//     'O',
//     'L1',
//     'L2',
//     'S1',
//     'S2',
//     'W1',
//     'W2',
//   ];
//
//   Map<String, double> getLeaveSummary(
//     String employee,
//     List<DateTime> daysInMonth,
//   ) {
//     double leaveDays = 0;
//     double sickLeaveDays = 0;
//     double workFromHomeDays = 0;
//     double otherLeaveDays = 0;
//
//     for (var date in daysInMonth) {
//       String key = '${employee}_${DateFormat('yyyy-MM-dd').format(date)}';
//       String? status = attendanceData[key];
//
//       if (status == 'L') {
//         leaveDays += 1;
//       } else if (status == 'S') {
//         sickLeaveDays += 1;
//       } else if (status == 'W') {
//         workFromHomeDays += 1;
//       } else if (status == 'O') {
//         otherLeaveDays += 1;
//       } else if (status == 'L1' || status == 'L2') {
//         leaveDays += 0.5;
//       } else if (status == 'S1' || status == 'S2') {
//         sickLeaveDays += 0.5;
//       } else if (status == 'W1' || status == 'W2') {
//         workFromHomeDays += 0.5;
//       }
//     }
//
//     return {
//       'VacationLeave': leaveDays,
//       'Sick Leave': sickLeaveDays,
//       'Work From Home': workFromHomeDays,
//       'Other Leave Days': otherLeaveDays,
//     };
//   }
//
//   double getTotalLeaves(String employee, List<DateTime> daysInMonth) {
//     double totalLeaves = 0;
//     for (var date in daysInMonth) {
//       String key = '${employee}_${DateFormat('yyyy-MM-dd').format(date)}';
//       String? status = attendanceData[key];
//       if (status == 'L' || status == 'S' || status == 'W' || status == 'O') {
//         totalLeaves += 1;
//       } else if (status == 'L1' ||
//           status == 'L2' ||
//           status == 'S1' ||
//           status == 'S2' ||
//           status == 'W1' ||
//           status == 'W2') {
//         totalLeaves += 0.5;
//       }
//     }
//     return totalLeaves;
//   }
//
//   String getSafeValue(String? value) {
//     return statusOptions.contains(value) ? value! : '';
//   }
//
//   Widget buildStatusDropdown(String key, bool isDisabled) {
//     return SizedBox(
//       width: 35,
//       child: DropdownButton<String>(
//         value: getSafeValue(attendanceData[key]),
//         isDense: true,
//         isExpanded: true,
//         underline: SizedBox(),
//         items:
//             statusOptions
//                 .map(
//                   (status) =>
//                       DropdownMenuItem(value: status, child: Text(status)),
//                 )
//                 .toList(),
//         onChanged:
//             isDisabled
//                 ? null
//                 : (value) {
//                   setState(() {
//                     attendanceData[key] = value!;
//                     saveAttendanceData();
//                   });
//                 },
//       ),
//     );
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
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: () {
//               setState(() {
//                 attendanceData.clear();
//                 saveAttendanceData();
//               });
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
//                   items:
//                       List.generate(
//                             5,
//                             (index) => DateTime.now().year - 2 + index,
//                           )
//                           .map(
//                             (year) => DropdownMenuItem(
//                               value: year,
//                               child: Text('$year'),
//                             ),
//                           )
//                           .toList(),
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
//                   items:
//                       List.generate(
//                         12,
//                         (index) => DropdownMenuItem(
//                           value: index + 1,
//                           child: Text(
//                             DateFormat('MMMM').format(DateTime(0, index + 1)),
//                           ),
//                         ),
//                       ).toList(),
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
//             child: Text(
//               'Total Working Days: $totalWorkingDays',
//               style: TextStyle(fontSize: 16),
//             ),
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
//                       bool isWeekend =
//                           date.weekday == DateTime.saturday ||
//                           date.weekday == DateTime.sunday;
//                       bool isHoliday = holidays.any(
//                         (h) =>
//                             h.year == date.year &&
//                             h.month == date.month &&
//                             h.day == date.day,
//                       );
//                       Color bgColor =
//                           isWeekend
//                               ? Colors.grey.shade300
//                               : isHoliday
//                               ? Colors.amber
//                               : Colors.white;
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
//                   rows:
//                       employees.map((employee) {
//                         return DataRow(
//                           cells: [
//                             DataCell(Text(employee)),
//                             ...daysInMonth.map((date) {
//                               String key =
//                                   '${employee}_${DateFormat('yyyy-MM-dd').format(date)}';
//                               bool isHoliday = holidays.any(
//                                 (h) =>
//                                     h.year == date.year &&
//                                     h.month == date.month &&
//                                     h.day == date.day,
//                               );
//                               bool isWeekend =
//                                   date.weekday == DateTime.saturday ||
//                                   date.weekday == DateTime.sunday;
//                               return DataCell(
//                                 buildStatusDropdown(
//                                   key,
//                                   isHoliday || isWeekend,
//                                 ),
//                               );
//                             }).toList(),
//                             DataCell(
//                               Text(
//                                 getTotalLeaves(
//                                   employee,
//                                   daysInMonth,
//                                 ).toString(),
//                               ),
//                             ),
//                           ],
//                         );
//                       }).toList(),
//                 ),
//               ),
//             ),
//           ),
//
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
//               rows:
//                   employees.map((employee) {
//                     final summary = getLeaveSummary(employee, daysInMonth);
//                     return DataRow(
//                       cells: [
//                         DataCell(Text(employee)),
//                         DataCell(Text('${summary['VacationLeave']}')),
//                         DataCell(Text('${summary['Sick Leave']}')),
//                         DataCell(Text('${summary['Work From Home']}')),
//                         DataCell(Text('${summary['Other Leave Days']}')),
//                         DataCell(
//                           Text('${getTotalLeaves(employee, daysInMonth)}'),
//                         ),
//                       ],
//                     );
//                   }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(home: AttendanceScreen(), debugShowCheckedModeBanner: false),
  );
}

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  List<String> employees = [
    'Pavani',
    'Chandu',
    'Vijaya',
    'Aswitha',
    'Krishna',
    'Navya',
  ];

  List<DateTime> getMonthDays(int year, int month) {
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0);
    return List.generate(
      lastDay.day,
      (index) => DateTime(year, month, index + 1),
    );
  }

  Map<String, String> attendanceData = {};

  final List<DateTime> holidays = [
    DateTime(2025, 1, 26),
    DateTime(2025, 5, 1),
    DateTime(2025, 8, 15),
    DateTime(2025, 10, 2),
  ];

  bool isMonthlyListVisible = false;

  @override
  void initState() {
    super.initState();
    loadAttendanceData();
  }

  void loadAttendanceData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      String? jsonString = prefs.getString('attendanceData');
      if (jsonString != null) {
        attendanceData = Map<String, String>.from(jsonDecode(jsonString));
      }
    });
  }

  void saveAttendanceData() async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(attendanceData);
    prefs.setString('attendanceData', jsonString);
  }

  int getWorkingDays(List<DateTime> daysInMonth) {
    int count = 0;
    for (var date in daysInMonth) {
      if (date.weekday != DateTime.saturday &&
          date.weekday != DateTime.sunday &&
          !holidays.any(
            (h) =>
                h.year == date.year &&
                h.month == date.month &&
                h.day == date.day,
          )) {
        count++;
      }
    }
    return count;
  }

  static List<String> get statusOptions => ['', 'L', 'S', 'W', 'O', 'L1', 'L2', 'S1', 'S2', 'W1', 'W2',];

  Map<String, double> getLeaveSummary(
    String employee,
    List<DateTime> daysInMonth,
  ) {
    double leaveDays = 0;
    double sickLeaveDays = 0;
    double workFromHomeDays = 0;
    double otherLeaveDays = 0;

    for (var date in daysInMonth) {
      String key = '${employee}_${DateFormat('yyyy-MM-dd').format(date)}';
      String? status = attendanceData[key];

      if (status == 'L') {
        leaveDays += 1;
      } else if (status == 'S') {
        sickLeaveDays += 1;
      } else if (status == 'W') {
        workFromHomeDays += 1;
      } else if (status == 'O') {
        otherLeaveDays += 1;
      } else if (status == 'L1' || status == 'L2') {
        leaveDays += 0.5;
      } else if (status == 'S1' || status == 'S2') {
        sickLeaveDays += 0.5;
      } else if (status == 'W1' || status == 'W2') {
        workFromHomeDays += 0.5;
      }
    }

    return {
      'VacationLeave': leaveDays,
      'Sick Leave': sickLeaveDays,
      'Work From Home': workFromHomeDays,
      'Other Leave Days': otherLeaveDays,
    };
  }

  double getTotalLeaves(String employee, List<DateTime> daysInMonth) {
    double totalLeaves = 0;
    for (var date in daysInMonth) {
      String key = '${employee}_${DateFormat('yyyy-MM-dd').format(date)}';
      String? status = attendanceData[key];
      if (status == 'L' || status == 'S' || status == 'W' || status == 'O') {
        totalLeaves += 1;
      } else if (status == 'L1' ||
          status == 'L2' ||
          status == 'S1' ||
          status == 'S2' ||
          status == 'W1' ||
          status == 'W2') {
        totalLeaves += 0.5;
      }
    }
    return totalLeaves;
  }

  String getSafeValue(String? value) {
    return statusOptions.contains(value) ? value! : '';
  }

  Widget buildStatusDropdown(String key, bool isDisabled) {
    return SizedBox(
      width: 35,
      child: DropdownButton<String>(
        value: getSafeValue(attendanceData[key]),
        isDense: true,
        isExpanded: true,
        underline: SizedBox(),
        items:
            statusOptions
                .map(
                  (status) =>
                      DropdownMenuItem(value: status, child: Text(status)),
                )
                .toList(),
        onChanged:
            isDisabled
                ? null
                : (value) {
                  setState(() {
                    attendanceData[key] = value!;
                    saveAttendanceData();
                  });
                },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = getMonthDays(selectedYear, selectedMonth);
    final totalWorkingDays = getWorkingDays(daysInMonth);

    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                attendanceData.clear();
                saveAttendanceData();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Year:'),
                SizedBox(width: 10),
                DropdownButton<int>(
                  value: selectedYear,
                  items:
                      List.generate(
                            5,
                            (index) => DateTime.now().year - 2 + index,
                          )
                          .map(
                            (year) => DropdownMenuItem(
                              value: year,
                              child: Text('$year'),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value!;
                    });
                  },
                ),
                SizedBox(width: 30),
                Text('Month:'),
                SizedBox(width: 10),
                DropdownButton<int>(
                  value: selectedMonth,
                  items:
                      List.generate(
                        12,
                        (index) => DropdownMenuItem(
                          value: index + 1,
                          child: Text(
                            DateFormat('MMMM').format(DateTime(0, index + 1)),
                          ),
                        ),
                      ).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMonth = value!;
                    });
                  },
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isMonthlyListVisible = !isMonthlyListVisible;
                    });
                  },
                  child: Text(
                    isMonthlyListVisible
                        ? "Hide Monthly List"
                        : "Show Monthly List",
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total Working Days: $totalWorkingDays',
              style: TextStyle(fontSize: 16),
            ),
          ),
          if (isMonthlyListVisible)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Employee')),
                  DataColumn(label: Text('Vacation')),
                  DataColumn(label: Text('Sick')),
                  DataColumn(label: Text('WFH')),
                  DataColumn(label: Text('Other')),
                  DataColumn(label: Text('Total')),
                ],
                rows:
                    employees.map((employee) {
                      final summary = getLeaveSummary(employee, daysInMonth);
                      return DataRow(
                        cells: [
                          DataCell(Text(employee)),
                          DataCell(Text('${summary['VacationLeave']}')),
                          DataCell(Text('${summary['Sick Leave']}')),
                          DataCell(Text('${summary['Work From Home']}')),
                          DataCell(Text('${summary['Other Leave Days']}')),
                          DataCell(
                            Text('${getTotalLeaves(employee, daysInMonth)}'),
                          ),
                        ],
                      );
                    }).toList(),
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  columnSpacing: 5,
                  headingRowHeight: 50,
                  dataRowHeight: 40,
                  columns: [
                    DataColumn(label: Text('Employee')),
                    ...daysInMonth.map((date) {
                      bool isWeekend =
                          date.weekday == DateTime.saturday ||
                          date.weekday == DateTime.sunday;
                      bool isHoliday = holidays.any(
                        (h) =>
                            h.year == date.year &&
                            h.month == date.month &&
                            h.day == date.day,
                      );
                      Color bgColor =
                          isWeekend
                              ? Colors.grey.shade300
                              : isHoliday
                              ? Colors.amber
                              : Colors.white;
                      return DataColumn(
                        label: Container(
                          width: 35,
                          color: bgColor,
                          alignment: Alignment.center,
                          child: Text(
                            DateFormat('d').format(date),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      );
                    }).toList(),
                    DataColumn(label: Text('Total Leaves')), // <-- added this
                  ],
                  rows:
                      employees.map((employee) {
                        return DataRow(
                          cells: [
                            DataCell(Text(employee)),
                            ...daysInMonth.map((date) {
                              String key =
                                  '${employee}_${DateFormat('yyyy-MM-dd').format(date)}';
                              bool isDisabled =
                                  date.weekday == DateTime.saturday ||
                                  date.weekday == DateTime.sunday ||
                                  holidays.any(
                                    (h) =>
                                        h.year == date.year &&
                                        h.month == date.month &&
                                        h.day == date.day,
                                  );
                              return DataCell(
                                buildStatusDropdown(key, isDisabled),
                              );
                            }).toList(),
                            DataCell(
                              Text('${getTotalLeaves(employee, daysInMonth)}'),
                            ), // <-- added this
                          ],
                        );
                      }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
