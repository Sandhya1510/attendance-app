// import 'package:flutter/material.dart';
//
// class SalarySheetPage extends StatefulWidget {
//   @override
//   _SalarySheetPageState createState() => _SalarySheetPageState();
// }
//
// class _SalarySheetPageState extends State<SalarySheetPage> {
//   final List<String> employees = ['Pavani', 'Chandu', 'Vijaya', 'Aswitha', 'Krishna', 'Navya'];
//   List<TextEditingController> feesControllers = [];
//   List<TextEditingController> allowanceControllers = [];
//   List<TextEditingController> otherDeductionControllers = [];
//
//   List<double> taxOnFees = [];
//   List<double> taxOnAllowance = [];
//   List<double> totalDeductions = [];
//   List<double> netPay = [];
//
//   @override
//   void initState() {
//     super.initState();
//     initializeLists();
//   }
//
//   void initializeLists() {
//     int length = employees.length;
//
//     feesControllers = List.generate(length, (_) => TextEditingController());
//     allowanceControllers = List.generate(length, (_) => TextEditingController());
//     otherDeductionControllers = List.generate(length, (_) => TextEditingController());
//
//     taxOnFees = List.generate(length, (_) => 0.0);
//     taxOnAllowance = List.generate(length, (_) => 0.0);
//     totalDeductions = List.generate(length, (_) => 0.0);
//     netPay = List.generate(length, (_) => 0.0);
//   }
//
//   void calculateValues(int index) {
//     double fees = double.tryParse(feesControllers[index].text) ?? 0.0;
//     double allowance = double.tryParse(allowanceControllers[index].text) ?? 0.0;
//     double otherDeduct = double.tryParse(otherDeductionControllers[index].text) ?? 0.0;
//
//     double taxFee = fees * 0.10;
//     double taxAllow = allowance * 0.10;
//
//     double totalDeduct = taxFee + taxAllow + otherDeduct;
//     double net = (fees + allowance) - totalDeduct;
//
//     setState(() {
//       taxOnFees[index] = taxFee;
//       taxOnAllowance[index] = taxAllow;
//       totalDeductions[index] = totalDeduct;
//       netPay[index] = net;
//     });
//   }
//
//   Widget buildDataCell(TextEditingController controller, int index, String label) {
//     return Container(
//       width: 120,
//       padding: EdgeInsets.all(5),
//       child: TextField(
//         controller: controller,
//         keyboardType: TextInputType.number,
//         onChanged: (_) {
//           calculateValues(index);
//         },
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(),
//           contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (employees.isEmpty) {
//       return Scaffold(
//         body: Center(child: Text('No employees found.')),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Salary Sheet'),
//         backgroundColor: Colors.blue,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: DataTable(
//           headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue.shade200),
//           columns: [
//             DataColumn(label: Text('Employee')),
//             DataColumn(label: Text('Fees')),
//             DataColumn(label: Text('Allowance')),
//             DataColumn(label: Text('Other Deduction')),
//             DataColumn(label: Text('Tax on Fees')),
//             DataColumn(label: Text('Tax on Allowance')),
//             DataColumn(label: Text('Total Deductions')),
//             DataColumn(label: Text('Net Pay')),
//           ],
//           rows: List.generate(employees.length, (index) {
//             return DataRow(cells: [
//               DataCell(Text(employees[index])),
//               DataCell(buildDataCell(feesControllers[index], index, '')),
//               DataCell(buildDataCell(allowanceControllers[index], index, '')),
//               DataCell(buildDataCell(otherDeductionControllers[index], index, '')),
//               DataCell(Text(taxOnFees[index].toStringAsFixed(2))),
//               DataCell(Text(taxOnAllowance[index].toStringAsFixed(2))),
//               DataCell(Text(totalDeductions[index].toStringAsFixed(2))),
//               DataCell(Text(netPay[index].toStringAsFixed(2))),
//             ]);
//           }),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
//
// class SalarySheetPage extends StatefulWidget {
//   @override
//   _SalarySheetPageState createState() => _SalarySheetPageState();
// }
//
// class _SalarySheetPageState extends State<SalarySheetPage> {
//   final List<String> employees = [
//     'Pavani',
//     'Chandu',
//     'Vijaya',
//     'Aswitha',
//     'Krishna',
//     'Navya'
//   ];
//
//   List<TextEditingController> feesControllers = [];
//   List<TextEditingController> allowanceControllers = [];
//   List<TextEditingController> otherDeductionControllers = [];
//
//   List<double> taxOnFees = [];
//   List<double> taxOnAllowance = [];
//   List<double> totalDeductions = [];
//   List<double> netPay = [];
//
//   @override
//   void initState() {
//     super.initState();
//     initializeLists();
//   }
//
//   void initializeLists() {
//     int length = employees.length;
//     feesControllers = List.generate(length, (_) => TextEditingController());
//     allowanceControllers = List.generate(length, (_) => TextEditingController());
//     otherDeductionControllers =
//         List.generate(length, (_) => TextEditingController());
//
//     taxOnFees = List.generate(length, (_) => 0.0);
//     taxOnAllowance = List.generate(length, (_) => 0.0);
//     totalDeductions = List.generate(length, (_) => 0.0);
//     netPay = List.generate(length, (_) => 0.0);
//   }
//
//   void calculateValues(int index) {
//     double fees = double.tryParse(feesControllers[index].text) ?? 0.0;
//     double allowance = double.tryParse(allowanceControllers[index].text) ?? 0.0;
//     double otherDeduct =
//         double.tryParse(otherDeductionControllers[index].text) ?? 0.0;
//
//     double taxFee = fees * 0.10;
//     double taxAllow = allowance * 0.10;
//
//     double totalDeduct = taxFee + taxAllow + otherDeduct;
//     double net = (fees + allowance) - totalDeduct;
//
//     setState(() {
//       taxOnFees[index] = taxFee;
//       taxOnAllowance[index] = taxAllow;
//       totalDeductions[index] = totalDeduct;
//       netPay[index] = net;
//     });
//   }
//
//   Widget buildDataCell(TextEditingController controller, int index, String label) {
//     return Container(
//       width: 120,
//       padding: EdgeInsets.all(5),
//       child: TextField(
//         controller: controller,
//         keyboardType: TextInputType.number,
//         onChanged: (_) {
//           calculateValues(index);
//         },
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(),
//           contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
//         ),
//       ),
//     );
//   }
//
//   Widget buildMobileCard(int index) {
//     return Card(
//       elevation: 4,
//       margin: EdgeInsets.symmetric(vertical: 10),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               employees[index],
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             buildMobileField(feesControllers[index], index, 'Fees'),
//             buildMobileField(allowanceControllers[index], index, 'Allowance'),
//             buildMobileField(otherDeductionControllers[index], index, 'Other Deduction'),
//             SizedBox(height: 10),
//             Text('Tax on Fees: ₹${taxOnFees[index].toStringAsFixed(2)}'),
//             Text('Tax on Allowance: ₹${taxOnAllowance[index].toStringAsFixed(2)}'),
//             Text('Total Deductions: ₹${totalDeductions[index].toStringAsFixed(2)}'),
//             Text('Net Pay: ₹${netPay[index].toStringAsFixed(2)}',
//                 style: TextStyle(fontWeight: FontWeight.w600)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildMobileField(
//       TextEditingController controller, int index, String label) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 5),
//       child: TextField(
//         controller: controller,
//         keyboardType: TextInputType.number,
//         onChanged: (_) {
//           calculateValues(index);
//         },
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(),
//           contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
//         ),
//       ),
//     );
//   }
//
//   Widget buildTableView(bool isTablet) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: DataTable(
//         headingRowColor:
//         MaterialStateProperty.all(Colors.grey.shade300),
//         columns: const [
//           DataColumn(label: Text('Name')),
//           DataColumn(label: Text('Fees')),
//           DataColumn(label: Text('Allowance')),
//           DataColumn(label: Text('Other Deduction')),
//           DataColumn(label: Text('Tax Fees')),
//           DataColumn(label: Text('Tax Allow')),
//           DataColumn(label: Text('Deductions')),
//           DataColumn(label: Text('Net Pay')),
//         ],
//         rows: List.generate(employees.length, (index) {
//           return DataRow(cells: [
//             DataCell(Text(employees[index])),
//             DataCell(SizedBox(
//               width: 100,
//               child: TextField(
//                 controller: feesControllers[index],
//                 keyboardType: TextInputType.number,
//                 onChanged: (_) {
//                   calculateValues(index);
//                 },
//                 decoration: InputDecoration(border: OutlineInputBorder()),
//               ),
//             )),
//             DataCell(SizedBox(
//               width: 100,
//               child: TextField(
//                 controller: allowanceControllers[index],
//                 keyboardType: TextInputType.number,
//                 onChanged: (_) {
//                   calculateValues(index);
//                 },
//                 decoration: InputDecoration(border: OutlineInputBorder()),
//               ),
//             )),
//             DataCell(SizedBox(
//               width: 120,
//               child: TextField(
//                 controller: otherDeductionControllers[index],
//                 keyboardType: TextInputType.number,
//                 onChanged: (_) {
//                   calculateValues(index);
//                 },
//                 decoration: InputDecoration(border: OutlineInputBorder()),
//               ),
//             )),
//             DataCell(Text('₹${taxOnFees[index].toStringAsFixed(2)}')),
//             DataCell(Text('₹${taxOnAllowance[index].toStringAsFixed(2)}')),
//             DataCell(Text('₹${totalDeductions[index].toStringAsFixed(2)}')),
//             DataCell(Text('₹${netPay[index].toStringAsFixed(2)}')),
//           ]);
//         }),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isMobile = screenWidth < 600;
//     final isTabletOrDesktop = screenWidth >= 600;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Salary Sheet'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: isMobile
//               ? ListView.builder(
//             itemCount: employees.length,
//             itemBuilder: (context, index) => buildMobileCard(index),
//           )
//               : buildTableView(isTabletOrDesktop),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SalarySheetPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class SalarySheetPage extends StatefulWidget {
  @override
  _SalarySheetPageState createState() => _SalarySheetPageState();
}

class _SalarySheetPageState extends State<SalarySheetPage> {
  final List<String> employees = ['Pavani', 'Chandu', 'Vijaya', 'Krishna', 'Navya', 'Aswitha'];

  List<TextEditingController> feesControllers = [];
  List<TextEditingController> allowanceControllers = [];
  List<TextEditingController> otherDeductionControllers = [];

  List<double> taxOnFees = [];
  List<double> taxOnAllowance = [];
  List<double> totalDeductions = [];
  List<double> netPay = [];

  @override
  void initState() {
    super.initState();
    initializeLists();
  }

  void initializeLists() {
    int length = employees.length;
    feesControllers = List.generate(length, (_) => TextEditingController());
    allowanceControllers = List.generate(length, (_) => TextEditingController());
    otherDeductionControllers = List.generate(length, (_) => TextEditingController());
    taxOnFees = List.generate(length, (_) => 0.0);
    taxOnAllowance = List.generate(length, (_) => 0.0);
    totalDeductions = List.generate(length, (_) => 0.0);
    netPay = List.generate(length, (_) => 0.0);
  }

  void calculateValues(int index) {
    double fees = double.tryParse(feesControllers[index].text) ?? 0.0;
    double allowance = double.tryParse(allowanceControllers[index].text) ?? 0.0;
    double otherDeduct = double.tryParse(otherDeductionControllers[index].text) ?? 0.0;

    double taxFee = fees * 0.10;
    double taxAllow = allowance * 0.10;
    double totalDeduct = taxFee + taxAllow + otherDeduct;
    double net = (fees + allowance) - totalDeduct;

    setState(() {
      taxOnFees[index] = taxFee;
      taxOnAllowance[index] = taxAllow;
      totalDeductions[index] = totalDeduct;
      netPay[index] = net;
    });
  }

  Widget buildMobileCard(int index) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(employees[index], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            buildMobileField(feesControllers[index], index, 'Fees'),
            buildMobileField(allowanceControllers[index], index, 'Allowance'),
            buildMobileField(otherDeductionControllers[index], index, 'Other Deduction'),
            SizedBox(height: 10),
            Text('Tax on Fees: ₹${taxOnFees[index].toStringAsFixed(2)}'),
            Text('Tax on Allowance: ₹${taxOnAllowance[index].toStringAsFixed(2)}'),
            Text('Total Deductions: ₹${totalDeductions[index].toStringAsFixed(2)}'),
            Text('Net Pay: ₹${netPay[index].toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget buildMobileField(TextEditingController controller, int index, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: (_) => calculateValues(index),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        ),
      ),
    );
  }

  Widget buildTableView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.grey.shade300),
        columns: const [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Fees')),
          DataColumn(label: Text('Allowance')),
          DataColumn(label: Text('Other Deduction')),
          DataColumn(label: Text('Tax Fees')),
          DataColumn(label: Text('Tax Allowance')),
          DataColumn(label: Text('Deductions')),
          DataColumn(label: Text('Net Pay')),
        ],
        rows: List.generate(employees.length, (index) {
          return DataRow(cells: [
            DataCell(Text(employees[index])),
            DataCell(buildTableTextField(feesControllers[index], index)),
            DataCell(buildTableTextField(allowanceControllers[index], index)),
            DataCell(buildTableTextField(otherDeductionControllers[index], index)),
            DataCell(Text('₹${taxOnFees[index].toStringAsFixed(2)}')),
            DataCell(Text('₹${taxOnAllowance[index].toStringAsFixed(2)}')),
            DataCell(Text('₹${totalDeductions[index].toStringAsFixed(2)}')),
            DataCell(Text('₹${netPay[index].toStringAsFixed(2)}')),
          ]);
        }),
      ),
    );
  }

  Widget buildTableTextField(TextEditingController controller, int index) {
    return SizedBox(
      width: 100,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: (_) => calculateValues(index),
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Salary Sheet'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: isMobile
              ? ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) => buildMobileCard(index),
          )
              : buildTableView(),
        ),
      ),
    );
  }
}
