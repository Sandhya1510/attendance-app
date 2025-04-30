// import 'package:flutter/material.dart';
//
// void main() {
//   // runApp(SalarySheetApp());
//   runApp(MaterialApp(
//     home: SalarySheetApp(),
//     debugShowCheckedModeBanner: false,
//   ));
// }
//
// class SalarySheetApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Salary Sheet',
//       theme: ThemeData(primarySwatch: Colors.amber),
//       home: SalarySheetPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class SalarySheetPage extends StatefulWidget {
//   @override
//   _SalarySheetPageState createState() => _SalarySheetPageState();
// }
//
// class _SalarySheetPageState extends State<SalarySheetPage> {
//   List<String> employees = [
//     'Pavani',
//     'Chandu',
//     'Vijaya',
//     'Aswitha',
//     'Krishna',
//     'Navya',
//   ];
//
//   List<TextEditingController> feesControllers = [];
//   List<TextEditingController> allowanceControllers = [];
//   List<TextEditingController> otherDeductionControllers = [];
//
//   List<double> taxDeduction = [];
//   List<double> totalDeductions = [];
//   List<double> netPay = [];
//
//   @override
//   void initState() {
//     super.initState();
//     for (int i = 0; i < employees.length; i++) {
//       feesControllers.add(TextEditingController());
//       allowanceControllers.add(TextEditingController());
//       otherDeductionControllers.add(TextEditingController());
//       taxDeduction.add(0.0);
//       totalDeductions.add(0.0);
//       netPay.add(0.0);
//     }
//   }
//
//   void calculateValues(int index) {
//     double fees = double.tryParse(feesControllers[index].text) ?? 0.0;
//     double allowance = double.tryParse(allowanceControllers[index].text) ?? 0.0;
//     double otherDeduct = double.tryParse(otherDeductionControllers[index].text) ?? 0.0;
//
//     double tax = fees * 0.10;
//     double totalDeduct = tax + otherDeduct;
//     double net = (fees + allowance) - totalDeduct;
//
//     setState(() {
//       taxDeduction[index] = tax;
//       totalDeductions[index] = totalDeduct;
//       netPay[index] = net;
//     });
//   }
//
//   Widget buildDataCell(TextEditingController controller, int index) {
//     return Container(
//       width: 100,
//       padding: EdgeInsets.all(5),
//       child: TextField(
//         controller: controller,
//         keyboardType: TextInputType.number,
//         onChanged: (_) {
//           calculateValues(index);
//         },
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Salary Sheet'),
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: DataTable(
//           headingRowColor: MaterialStateColor.resolveWith((states) => Colors.amber.shade200),
//           columns: [
//             DataColumn(label: Text('Employee')),
//             DataColumn(label: Text('Professional Fees')),
//             DataColumn(label: Text('In Office Allowance')),
//             DataColumn(label: Text('Other Deduction')),
//             DataColumn(label: Text('Tax Deduction (10%)')),
//             DataColumn(label: Text('Total Deductions')),
//             DataColumn(label: Text('Net Pay')),
//           ],
//           rows: List.generate(employees.length, (index) {
//             return DataRow(cells: [
//               DataCell(Text(employees[index])),
//               DataCell(buildDataCell(feesControllers[index], index)),
//               DataCell(buildDataCell(allowanceControllers[index], index)),
//               DataCell(buildDataCell(otherDeductionControllers[index], index)),
//               DataCell(Text(taxDeduction[index].toStringAsFixed(2))),
//               DataCell(Text(totalDeductions[index].toStringAsFixed(2))),
//               DataCell(Text(netPay[index].toStringAsFixed(2))),
//             ]);
//           }),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: DashboardPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
          ),
          onPressed: () {
            Navigator.push(
              context,
                MaterialPageRoute(builder: (context) => SalarySheetPage())
            );
          },
          child: Text('Go to Salary Sheet'),
        ),
      ),
    );
  }
}

class SalarySheetPage extends StatefulWidget {
  @override
  _SalarySheetPageState createState() => _SalarySheetPageState();
}

class _SalarySheetPageState extends State<SalarySheetPage> {
  List<String> employees = [
    'Pavani',
    'Chandu',
    'Vijaya',
    'Aswitha',
    'Krishna',
    'Navya',
  ];

  List<TextEditingController> feesControllers = [];
  List<TextEditingController> allowanceControllers = [];
  List<TextEditingController> otherDeductionControllers = [];

  List<double> taxDeduction = [];
  List<double> totalDeductions = [];
  List<double> netPay = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < employees.length; i++) {
      feesControllers.add(TextEditingController());
      allowanceControllers.add(TextEditingController());
      otherDeductionControllers.add(TextEditingController());
      taxDeduction.add(0.0);
      totalDeductions.add(0.0);
      netPay.add(0.0);
    }
  }

  void calculateValues(int index) {
    double fees = double.tryParse(feesControllers[index].text) ?? 0.0;
    double allowance = double.tryParse(allowanceControllers[index].text) ?? 0.0;
    double otherDeduct = double.tryParse(otherDeductionControllers[index].text) ?? 0.0;

    double tax = fees * 0.10;
    double totalDeduct = tax + otherDeduct;
    double net = (fees + allowance) - totalDeduct;

    setState(() {
      taxDeduction[index] = tax;
      totalDeductions[index] = totalDeduct;
      netPay[index] = net;
    });
  }

  Widget buildDataCell(TextEditingController controller, int index) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(5),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: (_) {
          calculateValues(index);
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salary Sheet'),
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // This will return to DashboardPage
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor:
          MaterialStateColor.resolveWith((states) => Colors.amber.shade200),
          columns: [
            DataColumn(label: Text('Employee')),
            DataColumn(label: Text('Professional Fees')),
            DataColumn(label: Text('In Office Allowance')),
            DataColumn(label: Text('Other Deduction')),
            DataColumn(label: Text('Tax Deduction (10%)')),
            DataColumn(label: Text('Total Deductions')),
            DataColumn(label: Text('Net Pay')),
          ],
          rows: List.generate(employees.length, (index) {
            return DataRow(cells: [
              DataCell(Text(employees[index])),
              DataCell(buildDataCell(feesControllers[index], index)),
              DataCell(buildDataCell(allowanceControllers[index], index)),
              DataCell(buildDataCell(otherDeductionControllers[index], index)),
              DataCell(Text(taxDeduction[index].toStringAsFixed(2))),
              DataCell(Text(totalDeductions[index].toStringAsFixed(2))),
              DataCell(Text(netPay[index].toStringAsFixed(2))),
            ]);
          }),
        ),
      ),
    );
  }
}

