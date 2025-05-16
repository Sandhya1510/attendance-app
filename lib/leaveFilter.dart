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

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
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
//   @override
//   void initState() {
//     super.initState();
//     loadLeaveRequests();
//   }
//
//   Future<void> loadLeaveRequests() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedRequests = prefs.getString('leaveRequests');
//     if (savedRequests != null) {
//       List<dynamic> decodedData = json.decode(savedRequests);
//       setState(() {
//         leaveRequests = decodedData.map((item) => Map<String, dynamic>.from(item)).toList();
//       });
//     }
//   }
//
//   Future<void> saveLeaveRequests() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString('leaveRequests', json.encode(leaveRequests));
//   }
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
//
//       // Save leave requests after submission
//       saveLeaveRequests();
//     }
//   }
//
//   void updateStatus(int index, String status) {
//     setState(() {
//       leaveRequests[index]['status'] = status;
//     });
//     // Save updated requests after status change
//     saveLeaveRequests();
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
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text('From:'),
//                                     SizedBox(width: 20,),
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
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text('To:'),
//                                     SizedBox(width: 35,),
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
//               SizedBox(
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
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(home: LeaveRequestScreen(), debugShowCheckedModeBanner: false),
  );
}

class LeaveRequestScreen extends StatefulWidget {
  @override
  _LeaveRequestScreenState createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  String employeeName = '';
  String searchQuery = '';
  Map<String, Map<String, DateTime?>> selectedLeaveTypes = {};
  List<Map<String, dynamic>> leaveRequests = [];
  bool isFormValid = false;
  bool showLeaveList = false;

  List<String> leaveTypes = [
    'Sick Leave',
    'Vacation Leave',
    'Work From Home',
    'Other Leave',
  ];

  TextEditingController searchController = TextEditingController();

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
        leaveRequests =
            decodedData.map((item) => Map<String, dynamic>.from(item)).toList();
      });
    }
  }

  Future<void> saveLeaveRequests() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('leaveRequests', json.encode(leaveRequests));
  }

  void validateForm() {
    final nameFilled = employeeName.trim().isNotEmpty;
    final hasLeave = selectedLeaveTypes.isNotEmpty;
    final allDatesSelected = selectedLeaveTypes.values.every(
      (dates) => dates['from'] != null && dates['to'] != null,
    );
    setState(() {
      isFormValid = nameFilled && hasLeave && allDatesSelected;
    });
  }

  void submitRequest() async {
    if (_formKey.currentState!.validate()) {
      if (selectedLeaveTypes.isEmpty) {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text('Missing Leave Type'),
                content: Text(
                  'Please select at least one leave type before submitting.',
                ),
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

      for (var entry in selectedLeaveTypes.entries) {
        if (entry.value['from'] == null || entry.value['to'] == null) {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: Text('Incomplete Date Selection'),
                  content: Text(
                    'Please select both "From" and "To" dates for "${entry.key}".',
                  ),
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

      await saveLeaveRequests();

      setState(() {
        selectedLeaveTypes.clear();
      });

      _formKey.currentState!.reset();

      await sendEmailNotification(employeeName);

      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Leave Request'),
              content: Text('Leave requested successfully! Email sent.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }
  }

  Future<void> sendEmailNotification(String name) async {
    const serviceId = 'your_service_id';
    const templateId = 'your_template_id';
    const userId = 'your_user_id';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {'employee_name': name},
      }),
    );

    print('EmailJS Response: ${response.statusCode}');
  }

  void updateStatus(int index, String status) {
    setState(() {
      leaveRequests[index]['status'] = status;
    });
    saveLeaveRequests();
  }

  Future<void> pickDate(String type, String whichDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );

    if (pickedDate != null) {
      setState(() {
        selectedLeaveTypes[type]![whichDate] = pickedDate;
      });
    }
  }

  void showLeaveSummary() {
    int total = leaveRequests.length;
    int approved =
        leaveRequests.where((req) => req['status'] == 'Approved').length;
    int rejected =
        leaveRequests.where((req) => req['status'] == 'Rejected').length;
    int pending =
        leaveRequests.where((req) => req['status'] == 'Pending').length;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
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

  void editLeaveRequest(int index) async {
    String currentLeaveType = leaveRequests[index]['type'];

    // Show leave type selection dialog
    String? newLeaveType = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String selectedType = currentLeaveType;

        return AlertDialog(
          title: Text('Select Leave Type'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return DropdownButton<String>(
                value: selectedType,
                isExpanded: true,
                items:
                    leaveTypes
                        .map(
                          (type) =>
                              DropdownMenuItem(value: type, child: Text(type)),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedType = value!;
                  });
                },
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, selectedType),
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (newLeaveType == null) return;

    // Pick new start date
    DateTime? newStartDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(leaveRequests[index]['start_date']),
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );

    if (newStartDate == null) return;

    // Pick new end date
    DateTime? newEndDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(leaveRequests[index]['end_date']),
      firstDate: newStartDate,
      lastDate: DateTime(2026),
    );

    if (newEndDate == null) return;

    setState(() {
      leaveRequests[index]['type'] = newLeaveType;
      leaveRequests[index]['start_date'] = DateFormat(
        'yyyy-MM-dd',
      ).format(newStartDate);
      leaveRequests[index]['end_date'] = DateFormat(
        'yyyy-MM-dd',
      ).format(newEndDate);
    });

    await saveLeaveRequests();
  }

  void deleteLeaveRequest(int index) async {
    setState(() {
      leaveRequests.removeAt(index);
    });
    await saveLeaveRequests();
  }

  Widget buildLeaveRequestCard(int index) {
    final request = leaveRequests[index];
    return Card(
      child: ListTile(
        title: Text('${request['employee']} - ${request['type']}'),
        subtitle: Text(
          'From: ${request['start_date']} To: ${request['end_date']}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(request['status']),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'Edit') {
                  editLeaveRequest(index);
                } else if (value == 'Delete') {
                  deleteLeaveRequest(index);
                } else {
                  updateStatus(index, value);
                }
              },
              itemBuilder:
                  (context) => [
                    PopupMenuItem(value: 'Pending', child: Text('Pending')),
                    PopupMenuItem(value: 'Approved', child: Text('Approve')),
                    PopupMenuItem(value: 'Rejected', child: Text('Reject')),
                    PopupMenuDivider(),
                    PopupMenuItem(value: 'Edit', child: Text('Edit')),
                    PopupMenuItem(value: 'Delete', child: Text('Delete')),
                  ],
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final filteredRequests = leaveRequests.where(
  //         (req) =>
  //         req['employee']
  //             .toString()
  //             .toLowerCase()
  //             .contains(searchQuery.toLowerCase()),
  //   ).toList();
  //
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Leave Request'),
  //       actions: [
  //         IconButton(icon: Icon(Icons.bar_chart), onPressed: showLeaveSummary),
  //       ],
  //     ),
  //     body: SingleChildScrollView(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         children: [
  //           Form(
  //             key: _formKey,
  //             child: Column(
  //               children: [
  //                 TextFormField(
  //                   decoration: InputDecoration(labelText: 'Employee Name'),
  //                   validator:
  //                       (value) =>
  //                           value == null || value.isEmpty
  //                               ? 'Enter name'
  //                               : null,
  //                   onSaved: (value) => employeeName = value!,
  //                 ),
  //                 SizedBox(height: 16),
  //                 ...leaveTypes.map((type) {
  //                   return Column(
  //                     children: [
  //                       CheckboxListTile(
  //                         title: Text(type),
  //                         value: selectedLeaveTypes.containsKey(type),
  //                         onChanged: (value) {
  //                           setState(() {
  //                             if (value!) {
  //                               selectedLeaveTypes[type] = {
  //                                 'from': null,
  //                                 'to': null,
  //                               };
  //                             } else {
  //                               selectedLeaveTypes.remove(type);
  //                             }
  //                           });
  //                         },
  //                       ),
  //                       if (selectedLeaveTypes.containsKey(type))
  //                         Column(
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Text('From: '),
  //                                 ElevatedButton(
  //                                   onPressed: () => pickDate(type, 'from'),
  //                                   child: Text(
  //                                     selectedLeaveTypes[type]!['from'] != null
  //                                         ? DateFormat('yyyy-MM-dd').format(
  //                                           selectedLeaveTypes[type]!['from']!,
  //                                         )
  //                                         : 'Select Date',
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             SizedBox(height: 8),
  //                             Row(
  //                               children: [
  //                                 Text('To:     '),
  //                                 ElevatedButton(
  //                                   onPressed: () => pickDate(type, 'to'),
  //                                   child: Text(
  //                                     selectedLeaveTypes[type]!['to'] != null
  //                                         ? DateFormat('yyyy-MM-dd').format(
  //                                           selectedLeaveTypes[type]!['to']!,
  //                                         )
  //                                         : 'Select Date',
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             SizedBox(height: 16),
  //                           ],
  //                         ),
  //                     ],
  //                   );
  //                 }).toList(),
  //                 SizedBox(height: 16),
  //                 ElevatedButton(
  //                   onPressed: submitRequest,
  //                   child: Text('Submit Leave Request'),
  //                 ),
  //                 SizedBox(height: 16),
  //                 ElevatedButton(
  //                   onPressed:
  //                       () => setState(() => showLeaveList = !showLeaveList),
  //                   child: Text(
  //                     showLeaveList
  //                         ? 'Hide Leave Requests'
  //                         : 'Show Leave Requests',
  //                   ),
  //                 ),
  //                 if (showLeaveList) ...[
  //                   SizedBox(height: 16),
  //                   TextFormField(
  //                     controller: searchController,
  //                     decoration: InputDecoration(
  //                       labelText: 'Search by Employee Name',
  //                       suffixIcon: IconButton(
  //                         icon: Icon(Icons.refresh),
  //                         onPressed: () {
  //                           setState(() {
  //                             searchQuery = '';
  //                             searchController.clear();
  //                           });
  //                         },
  //                       ),
  //                     ),
  //                     onChanged: (value) {
  //                       setState(() {
  //                         searchQuery = value;
  //                       });
  //                     },
  //                   ),
  //                   SizedBox(height: 16),
  //
  //                   if (filteredRequests.isEmpty)
  //                     Text('No leave requests found.')
  //                   else
  //                     Column(
  //                       children:
  //                           filteredRequests
  //                               .asMap()
  //                               .entries
  //                               .map(
  //                                 (entry) => buildLeaveRequestCard(entry.key),
  //                               )
  //                               .toList(),
  //                     ),
  //                 ],
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // ✅ Complete build() method continuation here:

  @override
  Widget build(BuildContext context) {
    final filteredRequests =
        leaveRequests
            .where(
              (req) => req['employee'].toString().toLowerCase().contains(
                searchQuery.toLowerCase(),
              ),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Request'),
        actions: [
          IconButton(icon: Icon(Icons.bar_chart), onPressed: showLeaveSummary),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Employee Name'),
                    validator:
                        (value) =>
                            value!.isEmpty ? 'Enter employee name' : null,
                    onChanged: (value) {
                      employeeName = value;
                      validateForm();
                    },
                  ),
                  SizedBox(height: 20),
                  // Leave Type Selectors
                  Column(
                    children:
                        leaveTypes.map((type) {
                          bool isSelected = selectedLeaveTypes.containsKey(
                            type,
                          );
                          return CheckboxListTile(
                            title: Text(type),
                            value: isSelected,
                            onChanged: (selected) {
                              setState(() {
                                if (selected!) {
                                  selectedLeaveTypes[type] = {
                                    'from': null,
                                    'to': null,
                                  };
                                } else {
                                  selectedLeaveTypes.remove(type);
                                }
                                validateForm();
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          );
                        }).toList(),
                  ),
                  SizedBox(height: 10),
                  // Date Pickers for selected leave types
                  Column(
                    children:
                        selectedLeaveTypes.entries.map((entry) {
                          String type = entry.key;
                          Map<String, DateTime?> dates = entry.value;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                type,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () => pickDate(type, 'from'),
                                    child: Text(
                                      dates['from'] == null
                                          ? 'From Date'
                                          : DateFormat(
                                            'yyyy-MM-dd',
                                          ).format(dates['from']!),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  TextButton(
                                    onPressed: () => pickDate(type, 'to'),
                                    child: Text(
                                      dates['to'] == null
                                          ? 'To Date'
                                          : DateFormat(
                                            'yyyy-MM-dd',
                                          ).format(dates['to']!),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        }).toList(),
                  ),
                  SizedBox(height: 20),
                  // ElevatedButton(
                  //   onPressed: isFormValid ? submitRequest : null,
                  //   child: Text('Submit Leave Request'),
                  // ),
                  ElevatedButton(
                    onPressed: submitRequest,
                    child: Text('Submit Leave Request'),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => setState(() => showLeaveList = !showLeaveList),
              child: Text(
                showLeaveList ? 'Hide Leave Requests' : 'Show Leave Requests',
              ),
            ),
            if (showLeaveList) ...[
              SizedBox(height: 16),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search by Employee Name',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      setState(() {
                        searchQuery = '';
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              SizedBox(height: 20),
              // Leave Requests List
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredRequests.length,
                itemBuilder: (context, index) {
                  final actualIndex = leaveRequests.indexOf(
                    filteredRequests[index],
                  );
                  return buildLeaveRequestCard(actualIndex);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
