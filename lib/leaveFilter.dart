// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MaterialApp(
//     home: LeaveRequestScreen(),
//     debugShowCheckedModeBanner: false,
//   ));
// }
//
// class LeaveRequestScreen extends StatefulWidget {
//   @override
//   _LeaveRequestScreenState createState() => _LeaveRequestScreenState();
// }
//
// class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String employeeName = '';
//   String leaveType = '';
//   DateTime? fromDate;
//   DateTime? toDate;
//
//   List<Map<String, dynamic>> leaveRequests = [];
//
//   bool showLeaveList = false;
//
//   void submitRequest() {
//     if (_formKey.currentState!.validate() &&
//         fromDate != null &&
//         toDate != null &&
//         !fromDate!.isAfter(toDate!)) {
//       _formKey.currentState!.save();
//
//       setState(() {
//         leaveRequests.add({
//           'employee': employeeName,
//           'type': leaveType,
//           'fromDate': fromDate!.toString().split(' ')[0],
//           'toDate': toDate!.toString().split(' ')[0],
//           'status': 'Pending',
//         });
//         employeeName = '';
//         leaveType = '';
//         fromDate = null;
//         toDate = null;
//       });
//
//       _formKey.currentState!.reset();
//
//       // Mock email notification here
//       print("Email notification sent for leave request by $employeeName");
//
//       // Show success dialog
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Leave Request'),
//           content: Text('Leave requested successfully!'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   Future<void> pickFromDate() async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: fromDate ?? DateTime.now(),
//       firstDate: DateTime(2024),
//       lastDate: DateTime(2026),
//     );
//     if (picked != null) setState(() => fromDate = picked);
//   }
//
//   Future<void> pickToDate() async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: toDate ?? DateTime.now(),
//       firstDate: DateTime(2024),
//       lastDate: DateTime(2026),
//     );
//     if (picked != null) setState(() => toDate = picked);
//   }
//
//   void updateStatus(int index, String status) {
//     setState(() {
//       leaveRequests[index]['status'] = status;
//     });
//   }
//
//   void showLeaveSummary() {
//     int total = leaveRequests.length;
//     int approved =
//         leaveRequests.where((req) => req['status'] == 'Approved').length;
//     int rejected =
//         leaveRequests.where((req) => req['status'] == 'Rejected').length;
//     int pending =
//         leaveRequests.where((req) => req['status'] == 'Pending').length;
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Leave Summary'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('Total Requests: $total'),
//             Text('Approved: $approved'),
//             Text('Rejected: $rejected'),
//             Text('Pending: $pending'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildLeaveRequestCard(int index) {
//     final request = leaveRequests[index];
//     return Card(
//       child: ListTile(
//         title:
//         Text('${request['employee']} - ${request['type']} Leave'),
//         subtitle: Text(
//             'From: ${request['fromDate']} To: ${request['toDate']}'),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(request['status']),
//             PopupMenuButton<String>(
//               onSelected: (value) => updateStatus(index, value),
//               itemBuilder: (context) => [
//                 PopupMenuItem(value: 'Pending', child: Text('Pending')),
//                 PopupMenuItem(value: 'Approved', child: Text('Approve')),
//                 PopupMenuItem(value: 'Rejected', child: Text('Reject')),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leave Request'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.bar_chart),
//             onPressed: showLeaveSummary,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Leave Requests counter
//             Container(
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade50,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.list_alt, color: Colors.blue),
//                   SizedBox(width: 8),
//                   Text(
//                     'Total Leave Requests: ${leaveRequests.length}',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.blue[900],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//
//             // Leave Request Form
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                   ),
//                 ],
//               ),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       decoration: InputDecoration(labelText: 'Employee Name'),
//                       validator: (value) =>
//                       value == null || value.isEmpty
//                           ? 'Enter name'
//                           : null,
//                       onSaved: (value) => employeeName = value!,
//                     ),
//                     SizedBox(height: 12),
//                     DropdownButtonFormField<String>(
//                       value: leaveType.isEmpty ? null : leaveType,
//                       decoration: InputDecoration(labelText: 'Type of Leave'),
//                       items: [
//                         '',
//                         'Vacation Leave',
//                         'Sick Leave',
//                         'Work From Home',
//                         'Other Leave'
//                       ].map((type) {
//                         return DropdownMenuItem(
//                             value: type, child: Text(type));
//                       }).toList(),
//                       onChanged: (value) => setState(() => leaveType = value!),
//                       validator: (value) =>
//                       value == null || value.isEmpty
//                           ? 'Select leave type'
//                           : null,
//                     ),
//                     SizedBox(height: 12),
//                     Row(
//                       children: [
//                         Text(fromDate == null
//                             ? 'From Date: Select'
//                             : 'From: ${fromDate!.toString().split(' ')[0]}'),
//                         Spacer(),
//                         ElevatedButton(
//                           onPressed: pickFromDate,
//                           child: Text('Pick Date'),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Text(toDate == null
//                             ? 'To Date: Select'
//                             : 'To: ${toDate!.toString().split(' ')[0]}'),
//                         Spacer(),
//                         ElevatedButton(
//                           onPressed: pickToDate,
//                           child: Text('Pick Date'),
//                         ),
//                       ],
//                     ),
//                     if (fromDate != null &&
//                         toDate != null &&
//                         fromDate!.isAfter(toDate!))
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8.0),
//                         child: Text(
//                           'From Date cannot be later than To Date',
//                           style: TextStyle(color: Colors.red, fontSize: 12),
//                         ),
//                       ),
//                     SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: submitRequest,
//                       child: Text('Submit Leave Request'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   showLeaveList = !showLeaveList;
//                 });
//               },
//               child: Text(
//                   showLeaveList ? 'Hide Leave Requests' : 'Show Leave Requests'),
//             ),
//             SizedBox(height: 16),
//
//             if (showLeaveList)
//               Container(
//                 height: 300,
//                 child: leaveRequests.isEmpty
//                     ? Center(child: Text('No leave requests yet.'))
//                     : ListView.builder(
//                   itemCount: leaveRequests.length,
//                   itemBuilder: (context, index) =>
//                       buildLeaveRequestCard(index),
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
// void main() {
//   runApp(MaterialApp(
//     home: LeaveRequestScreen(),
//     debugShowCheckedModeBanner: false,
//   ));
// }
//
// class LeaveRequestScreen extends StatefulWidget {
//   @override
//   _LeaveRequestScreenState createState() => _LeaveRequestScreenState();
// }
//
// class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String employeeName = '';
//   Map<String, Map<String, DateTime?>> selectedLeaveTypes = {};
//   List<Map<String, dynamic>> leaveRequests = [];
//   bool showLeaveList = false;
//
//   List<String> leaveTypes = [
//     'Sick Leave',
//     'Vacation Leave',
//     'Work From Home',
//     'Other Leave'
//   ];
//
//   void submitRequest() {
//     if (_formKey.currentState!.validate()) {
//       if (selectedLeaveTypes.isEmpty) {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('Missing Leave Type'),
//             content: Text('Please select at least one leave type before submitting.'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//         return;
//       }
//
//       // Check that both 'from' and 'to' dates are selected for each leave type
//       for (var entry in selectedLeaveTypes.entries) {
//         if (entry.value['from'] == null || entry.value['to'] == null) {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text('Incomplete Date Selection'),
//               content: Text('Please select both "From" and "To" dates for "${entry.key}".'),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text('OK'),
//                 ),
//               ],
//             ),
//           );
//           return;
//         }
//       }
//
//       _formKey.currentState!.save();
//
//       selectedLeaveTypes.forEach((type, dates) {
//         leaveRequests.add({
//           'employee': employeeName,
//           'type': type,
//           'start_date': DateFormat('yyyy-MM-dd').format(dates['from']!),
//           'end_date': DateFormat('yyyy-MM-dd').format(dates['to']!),
//           'status': 'Pending',
//         });
//       });
//
//       setState(() {
//         selectedLeaveTypes.clear();
//       });
//
//       _formKey.currentState!.reset();
//
//       print("Email notification sent for leave request by $employeeName");
//
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Leave Request'),
//           content: Text('Leave requested successfully!'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   void updateStatus(int index, String status) {
//     setState(() {
//       leaveRequests[index]['status'] = status;
//     });
//   }
//
//   void showLeaveSummary() {
//     int total = leaveRequests.length;
//     int approved = leaveRequests.where((req) => req['status'] == 'Approved').length;
//     int rejected = leaveRequests.where((req) => req['status'] == 'Rejected').length;
//     int pending = leaveRequests.where((req) => req['status'] == 'Pending').length;
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Leave Summary'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('Total Requests: $total'),
//             Text('Approved: $approved'),
//             Text('Rejected: $rejected'),
//             Text('Pending: $pending'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> pickDate(String type, String whichDate) async {
//     DateTime initialDate = DateTime.now();
//     DateTime firstDate = DateTime(2024);
//     DateTime lastDate = DateTime(2026);
//
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: initialDate,
//       firstDate: firstDate,
//       lastDate: lastDate,
//     );
//
//     if (pickedDate != null) {
//       setState(() {
//         selectedLeaveTypes[type]![whichDate] = pickedDate;
//       });
//     }
//   }
//
//   Widget buildLeaveRequestCard(int index) {
//     final request = leaveRequests[index];
//     return Card(
//       child: ListTile(
//         title: Text('${request['employee']} - ${request['type']}'),
//         subtitle: Text('From: ${request['start_date']} To: ${request['end_date']}'),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(request['status']),
//             PopupMenuButton<String>(
//               onSelected: (value) => updateStatus(index, value),
//               itemBuilder: (context) => [
//                 PopupMenuItem(value: 'Pending', child: Text('Pending')),
//                 PopupMenuItem(value: 'Approved', child: Text('Approve')),
//                 PopupMenuItem(value: 'Rejected', child: Text('Reject')),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     bool isMobile = screenWidth < 600;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leave Request'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.bar_chart),
//             onPressed: showLeaveSummary,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade50,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.list_alt, color: Colors.blue),
//                   SizedBox(width: 8),
//                   Text(
//                     'Total Leave Requests: ${leaveRequests.length}',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.blue[900],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey,
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                   ),
//                 ],
//               ),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       decoration: InputDecoration(labelText: 'Employee Name'),
//                       validator: (value) => value == null || value.isEmpty ? 'Enter name' : null,
//                       onSaved: (value) => employeeName = value!,
//                     ),
//                     SizedBox(height: 16),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'Select Leave Types:',
//                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     ...leaveTypes.map((type) {
//                       return Column(
//                         children: [
//                           CheckboxListTile(
//                             title: Text(type),
//                             value: selectedLeaveTypes.containsKey(type),
//                             onChanged: (value) {
//                               setState(() {
//                                 if (value!) {
//                                   selectedLeaveTypes[type] = {'from': null, 'to': null};
//                                 } else {
//                                   selectedLeaveTypes.remove(type);
//                                 }
//                               });
//                             },
//                           ),
//                           if (selectedLeaveTypes.containsKey(type))
//                             Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text('From:'),
//                                     ElevatedButton(
//                                       onPressed: () => pickDate(type, 'from'),
//                                       child: Text(selectedLeaveTypes[type]!['from'] != null
//                                           ? DateFormat('yyyy-MM-dd').format(selectedLeaveTypes[type]!['from']!)
//                                           : 'Select Date'),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 8),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text('To:'),
//                                     ElevatedButton(
//                                       onPressed: () => pickDate(type, 'to'),
//                                       child: Text(selectedLeaveTypes[type]!['to'] != null
//                                           ? DateFormat('yyyy-MM-dd').format(selectedLeaveTypes[type]!['to']!)
//                                           : 'Select Date'),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 10),
//                               ],
//                             ),
//                         ],
//                       );
//                     }).toList(),
//                     SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: submitRequest,
//                       child: Text('Submit Leave Request'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   showLeaveList = !showLeaveList;
//                 });
//               },
//               child: Text(showLeaveList ? 'Hide Leave Requests' : 'Show Leave Requests'),
//             ),
//             SizedBox(height: 16),
//             if (showLeaveList)
//               Container(
//                 height: isMobile ? 300 : 400,
//                 child: leaveRequests.isEmpty
//                     ? Center(child: Text('No leave requests yet.'))
//                     : ListView.builder(
//                   itemCount: leaveRequests.length,
//                   itemBuilder: (context, index) => buildLeaveRequestCard(index),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: LeaveRequestScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class LeaveRequestScreen extends StatefulWidget {
  @override
  _LeaveRequestScreenState createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  String employeeName = '';
  Map<String, Map<String, DateTime?>> selectedLeaveTypes = {};
  List<Map<String, dynamic>> leaveRequests = [];
  bool showLeaveList = false;

  List<String> leaveTypes = [
    'Sick Leave',
    'Vacation Leave',
    'Work From Home',
    'Other Leave'
  ];

  @override
  void initState() {
    super.initState();
    loadLeaveRequests();
  }

  Future<void> loadLeaveRequests() async {
    final prefs = await SharedPreferences.getInstance();
    final savedRequests = prefs.getString('leaveRequests');
    if (savedRequests != null) {
      List<dynamic> decodedData = json.decode(savedRequests);
      setState(() {
        leaveRequests = decodedData.map((item) => Map<String, dynamic>.from(item)).toList();
      });
    }
  }

  Future<void> saveLeaveRequests() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('leaveRequests', json.encode(leaveRequests));
  }

  void submitRequest() {
    if (_formKey.currentState!.validate()) {
      if (selectedLeaveTypes.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Missing Leave Type'),
            content: Text('Please select at least one leave type before submitting.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
        return;
      }

      // Check that both 'from' and 'to' dates are selected for each leave type
      for (var entry in selectedLeaveTypes.entries) {
        if (entry.value['from'] == null || entry.value['to'] == null) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Incomplete Date Selection'),
              content: Text('Please select both "From" and "To" dates for "${entry.key}".'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
          );
          return;
        }
      }

      _formKey.currentState!.save();

      selectedLeaveTypes.forEach((type, dates) {
        leaveRequests.add({
          'employee': employeeName,
          'type': type,
          'start_date': DateFormat('yyyy-MM-dd').format(dates['from']!),
          'end_date': DateFormat('yyyy-MM-dd').format(dates['to']!),
          'status': 'Pending',
        });
      });

      setState(() {
        selectedLeaveTypes.clear();
      });

      _formKey.currentState!.reset();

      print("Email notification sent for leave request by $employeeName");

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Leave Request'),
          content: Text('Leave requested successfully!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );

      // Save leave requests after submission
      saveLeaveRequests();
    }
  }

  void updateStatus(int index, String status) {
    setState(() {
      leaveRequests[index]['status'] = status;
    });
    // Save updated requests after status change
    saveLeaveRequests();
  }

  void showLeaveSummary() {
    int total = leaveRequests.length;
    int approved = leaveRequests.where((req) => req['status'] == 'Approved').length;
    int rejected = leaveRequests.where((req) => req['status'] == 'Rejected').length;
    int pending = leaveRequests.where((req) => req['status'] == 'Pending').length;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Leave Summary'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Total Requests: $total'),
            Text('Approved: $approved'),
            Text('Rejected: $rejected'),
            Text('Pending: $pending'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> pickDate(String type, String whichDate) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2024);
    DateTime lastDate = DateTime(2026);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        selectedLeaveTypes[type]![whichDate] = pickedDate;
      });
    }
  }

  Widget buildLeaveRequestCard(int index) {
    final request = leaveRequests[index];
    return Card(
      child: ListTile(
        title: Text('${request['employee']} - ${request['type']}'),
        subtitle: Text('From: ${request['start_date']} To: ${request['end_date']}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(request['status']),
            PopupMenuButton<String>(
              onSelected: (value) => updateStatus(index, value),
              itemBuilder: (context) => [
                PopupMenuItem(value: 'Pending', child: Text('Pending')),
                PopupMenuItem(value: 'Approved', child: Text('Approve')),
                PopupMenuItem(value: 'Rejected', child: Text('Reject')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Request'),
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: showLeaveSummary,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.list_alt, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'Total Leave Requests: ${leaveRequests.length}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[900],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Employee Name'),
                      validator: (value) => value == null || value.isEmpty ? 'Enter name' : null,
                      onSaved: (value) => employeeName = value!,
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select Leave Types:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...leaveTypes.map((type) {
                      return Column(
                        children: [
                          CheckboxListTile(
                            title: Text(type),
                            value: selectedLeaveTypes.containsKey(type),
                            onChanged: (value) {
                              setState(() {
                                if (value!) {
                                  selectedLeaveTypes[type] = {'from': null, 'to': null};
                                } else {
                                  selectedLeaveTypes.remove(type);
                                }
                              });
                            },
                          ),
                          if (selectedLeaveTypes.containsKey(type))
                            Column(
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('From:'),
                                    SizedBox(width: 20,),
                                    ElevatedButton(
                                      onPressed: () => pickDate(type, 'from'),
                                      child: Text(selectedLeaveTypes[type]!['from'] != null
                                          ? DateFormat('yyyy-MM-dd').format(selectedLeaveTypes[type]!['from']!)
                                          : 'Select Date'),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('To:'),
                                    SizedBox(width: 35,),
                                    ElevatedButton(
                                      onPressed: () => pickDate(type, 'to'),
                                      child: Text(selectedLeaveTypes[type]!['to'] != null
                                          ? DateFormat('yyyy-MM-dd').format(selectedLeaveTypes[type]!['to']!)
                                          : 'Select Date'),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                        ],
                      );
                    }).toList(),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: submitRequest,
                      child: Text('Submit Leave Request'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showLeaveList = !showLeaveList;
                });
              },
              child: Text(showLeaveList ? 'Hide Leave Requests' : 'Show Leave Requests'),
            ),
            SizedBox(height: 16),
            if (showLeaveList)
              SizedBox(
                height: isMobile ? 300 : 400,
                child: leaveRequests.isEmpty
                    ? Center(child: Text('No leave requests yet.'))
                    : ListView.builder(
                  itemCount: leaveRequests.length,
                  itemBuilder: (context, index) => buildLeaveRequestCard(index),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
