
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


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
        lastDay.day, (index) => DateTime(year, month, index + 1));
  }

  Map<String, String> attendanceData = {};

  final List<DateTime> holidays = [
    DateTime(2025, 1, 26),
    DateTime(2025, 5, 1),
    DateTime(2025, 8, 15),
    DateTime(2025, 10, 2),
  ];

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
          !holidays.any((h) =>
          h.year == date.year &&
              h.month == date.month &&
              h.day == date.day)) {
        count++;
      }
    }
    return count;
  }

  Map<String, int> getLeaveSummary(String employee, List<DateTime> daysInMonth) {
    int leaveDays = 0;
    int sickLeaveDays = 0;
    int workFromHomeDays = 0;
    int otherLeaveDays = 0;

    for (var date in daysInMonth) {
      String key = '${employee}_${DateFormat('yyyy-MM-dd').format(date)}';
      String? status = attendanceData[key];

      if (status == 'V') {
        leaveDays++;
      } else if (status == 'S') {
        sickLeaveDays++;
      } else if (status == 'W') {
        workFromHomeDays++;
      } else if (status == 'O') {
        otherLeaveDays++;
      }
    }

    return {
      'VacationLeave': leaveDays,
      'Sick Leave': sickLeaveDays,
      'Work From Home': workFromHomeDays,
      'Other Leave Days': otherLeaveDays
    };
  }

  int getTotalLeaves(String employee, List<DateTime> daysInMonth) {
    int totalLeaves = 0;
    for (var date in daysInMonth) {
      String key = '${employee}_${DateFormat('yyyy-MM-dd').format(date)}';
      if (attendanceData[key] == 'V' ||
          attendanceData[key] == 'S' ||
          attendanceData[key] == 'W' ||
          attendanceData[key] == 'O') {
        totalLeaves++;
      }
    }
    return totalLeaves;
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
                  items: List.generate(5, (index) => DateTime.now().year - 2 + index)
                      .map((year) => DropdownMenuItem(value: year, child: Text('$year')))
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
                  items: List.generate(
                    12,
                        (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text(DateFormat('MMMM').format(DateTime(0, index + 1))),
                    ),
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMonth = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Total Working Days: $totalWorkingDays',
                style: TextStyle(fontSize: 16)),
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
                      bool isWeekend = date.weekday == DateTime.saturday ||
                          date.weekday == DateTime.sunday;
                      bool isHoliday = holidays.any((h) =>
                      h.year == date.year &&
                          h.month == date.month &&
                          h.day == date.day);
                      Color bgColor = isWeekend
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
                    DataColumn(label: Text('Total Leaves')),
                  ],
                  rows: employees.map((employee) {
                    return DataRow(
                      cells: [
                        DataCell(Text(employee)),
                        ...daysInMonth.map((date) {
                          String key =
                              '${employee}_${DateFormat('yyyy-MM-dd').format(date)}';
                          bool isHoliday = holidays.any((h) =>
                          h.year == date.year &&
                              h.month == date.month &&
                              h.day == date.day);
                          bool isWeekend = date.weekday == DateTime.saturday ||
                              date.weekday == DateTime.sunday;
                          return DataCell(
                            SizedBox(
                              width: 40,
                              child: DropdownButton<String>(
                                value: attendanceData[key] ?? '',
                                isDense: true,
                                items: ['', 'V', 'S', 'W', 'O']
                                    .map((value) =>
                                    DropdownMenuItem(value: value, child: Text(value)))
                                    .toList(),
                                onChanged: isHoliday || isWeekend
                                    ? null
                                    : (value) {
                                  setState(() {
                                    attendanceData[key] = value ?? '';
                                    saveAttendanceData();
                                  });
                                },
                              ),
                            ),
                          );
                        }).toList(),
                        DataCell(Text(getTotalLeaves(employee, daysInMonth).toString())),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          // Leave Summary Table
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
              rows: employees.map((employee) {
                final summary = getLeaveSummary(employee, daysInMonth);
                return DataRow(
                  cells: [
                    DataCell(Text(employee)),
                    DataCell(Text('${summary['VacationLeave']}')),
                    DataCell(Text('${summary['Sick Leave']}')),
                    DataCell(Text('${summary['Work From Home']}')),
                    DataCell(Text('${summary['Other Leave Days']}')),
                    DataCell(Text('${getTotalLeaves(employee, daysInMonth)}')),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
