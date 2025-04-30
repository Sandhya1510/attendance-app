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
//   void submitRequest() {
//     if (_formKey.currentState!.validate() &&
//         fromDate != null &&
//         toDate != null &&
//         !fromDate!.isAfter(toDate!)) {
//       _formKey.currentState!.save();
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
//       _formKey.currentState!.reset();
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
//           IconButton(
//             icon: Icon(Icons.list),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => LeaveRequestListScreen(
//                     leaveRequests: leaveRequests,
//                     updateStatus: updateStatus,
//                   ),
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // 👇 Total leave requests counter
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
//             // 👇 Leave Request Form
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
//                       value == null || value.isEmpty ? 'Enter name' : null,
//                       onSaved: (value) => employeeName = value!,
//                     ),
//                     SizedBox(height: 12),
//                     DropdownButtonFormField<String>(
//                       value: leaveType.isEmpty ? null : leaveType,
//                       decoration: InputDecoration(labelText: 'Type of Leave'),
//                       items: [
//                         '',
//                         'VacationLeave',
//                         'Sick',
//                         'Work From Home',
//                         'Other Leave'
//                       ].map((type) {
//                         return DropdownMenuItem(
//                             value: type, child: Text(type));
//                       }).toList(),
//                       onChanged: (value) => setState(() => leaveType = value!),
//                       validator: (value) => value == null || value.isEmpty
//                           ? 'Select leave type'
//                           : null,
//                     ),
//                     SizedBox(height: 12),
//                     Row(
//                       children: [
//                         Text(fromDate == null
//                             ? 'From Date: Select the date'
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
//                             ? 'To Date: Select the date'
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
//             // 👇 Leave Requests List
//             Expanded(
//               child: leaveRequests.isEmpty
//                   ? Center(child: Text('No leave requests yet.'))
//                   : ListView.builder(
//                 itemCount: leaveRequests.length,
//                 itemBuilder: (context, index) {
//                   final request = leaveRequests[index];
//                   return Card(
//                     child: ListTile(
//                       title: Text(
//                           '${request['employee']} - ${request['type']} Leave'),
//                       subtitle: Text(
//                           'From: ${request['fromDate']} To: ${request['toDate']}'),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(request['status']),
//                           PopupMenuButton<String>(
//                             onSelected: (value) =>
//                                 updateStatus(index, value),
//                             itemBuilder: (context) => [
//                               PopupMenuItem(
//                                   value: 'Pending',
//                                   child: Text('Pending')),
//                               PopupMenuItem(
//                                   value: 'Approved',
//                                   child: Text('Approve')),
//                               PopupMenuItem(
//                                   value: 'Rejected',
//                                   child: Text('Reject')),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // 👇 View Leave Requests Screen
// class LeaveRequestListScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> leaveRequests;
//   final Function(int, String) updateStatus;
//
//   const LeaveRequestListScreen(
//       {required this.leaveRequests, required this.updateStatus});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leave Requests List'),
//       ),
//       body: ListView.builder(
//         itemCount: leaveRequests.length,
//         itemBuilder: (context, index) {
//           final request = leaveRequests[index];
//           return Card(
//             child: ListTile(
//               title:
//               Text('${request['employee']} - ${request['type']} Leave'),
//               subtitle: Text(
//                   'From: ${request['fromDate']} To: ${request['toDate']}'),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(request['status']),
//                   PopupMenuButton<String>(
//                     onSelected: (value) => updateStatus(index, value),
//                     itemBuilder: (context) => [
//                       PopupMenuItem(value: 'Pending', child: Text('Pending')),
//                       PopupMenuItem(value: 'Approved', child: Text('Approve')),
//                       PopupMenuItem(value: 'Rejected', child: Text('Reject')),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

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
  String leaveType = '';
  DateTime? fromDate;
  DateTime? toDate;

  List<Map<String, dynamic>> leaveRequests = [];

  bool showLeaveList = false; // <-- new variable

  void submitRequest() {
    if (_formKey.currentState!.validate() &&
        fromDate != null &&
        toDate != null &&
        !fromDate!.isAfter(toDate!)) {
      _formKey.currentState!.save();
      setState(() {
        leaveRequests.add({
          'employee': employeeName,
          'type': leaveType,
          'fromDate': fromDate!.toString().split(' ')[0],
          'toDate': toDate!.toString().split(' ')[0],
          'status': 'Pending',
        });
        employeeName = '';
        leaveType = '';
        fromDate = null;
        toDate = null;
      });
      _formKey.currentState!.reset();
    }
  }

  Future<void> pickFromDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fromDate ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );
    if (picked != null) setState(() => fromDate = picked);
  }

  Future<void> pickToDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: toDate ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );
    if (picked != null) setState(() => toDate = picked);
  }

  void updateStatus(int index, String status) {
    setState(() {
      leaveRequests[index]['status'] = status;
    });
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

  @override
  Widget build(BuildContext context) {
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
            // Leave Requests counter
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

            // Leave Request Form
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
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
                      validator: (value) =>
                      value == null || value.isEmpty ? 'Enter name' : null,
                      onSaved: (value) => employeeName = value!,
                    ),
                    SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: leaveType.isEmpty ? null : leaveType,
                      decoration: InputDecoration(labelText: 'Type of Leave'),
                      items: [
                        '',
                        'VacationLeave',
                        'Sick',
                        'Work From Home',
                        'Other Leave'
                      ].map((type) {
                        return DropdownMenuItem(
                            value: type, child: Text(type));
                      }).toList(),
                      onChanged: (value) => setState(() => leaveType = value!),
                      validator: (value) =>
                      value == null || value.isEmpty
                          ? 'Select leave type'
                          : null,
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text(fromDate == null
                            ? 'From Date: Select the date'
                            : 'From: ${fromDate!.toString().split(' ')[0]}'),
                        Spacer(),
                        ElevatedButton(
                          onPressed: pickFromDate,
                          child: Text('Pick Date'),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(toDate == null
                            ? 'To Date: Select the date'
                            : 'To: ${toDate!.toString().split(' ')[0]}'),
                        Spacer(),
                        ElevatedButton(
                          onPressed: pickToDate,
                          child: Text('Pick Date'),
                        ),
                      ],
                    ),
                    if (fromDate != null &&
                        toDate != null &&
                        fromDate!.isAfter(toDate!))
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'From Date cannot be later than To Date',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
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

            // Show/Hide Leave Requests Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showLeaveList = !showLeaveList;
                });
              },
              child: Text(showLeaveList
                  ? 'Hide Leave Requests'
                  : 'Show Leave Requests'),
            ),
            SizedBox(height: 16),

            // Leave Requests List (visible only when showLeaveList is true)
            if (showLeaveList)
              Container(
                height: 300,
                child: leaveRequests.isEmpty
                    ? Center(child: Text('No leave requests yet.'))
                    : ListView.builder(
                  itemCount: leaveRequests.length,
                  itemBuilder: (context, index) {
                    final request = leaveRequests[index];
                    return Card(
                      child: ListTile(
                        title: Text(
                            '${request['employee']} - ${request['type']} Leave'),
                        subtitle: Text(
                            'From: ${request['fromDate']} To: ${request['toDate']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(request['status']),
                            PopupMenuButton<String>(
                              onSelected: (value) =>
                                  updateStatus(index, value),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                    value: 'Pending',
                                    child: Text('Pending')),
                                PopupMenuItem(
                                    value: 'Approved',
                                    child: Text('Approve')),
                                PopupMenuItem(
                                    value: 'Rejected',
                                    child: Text('Reject')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
