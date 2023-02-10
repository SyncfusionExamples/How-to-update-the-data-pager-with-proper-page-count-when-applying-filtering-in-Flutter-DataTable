import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion DataGrid Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late EmployeeDataSource _employeeDataSource;
  List<Employee> _employees = [];
  int rowsPerPage = 5;
  double pageCount = 0;

  @override
  void initState() {
    super.initState();
    _employees = populateData();
    _employeeDataSource = EmployeeDataSource(_employees);
    _updatePageCount();
  }

  void _updatePageCount() {
    final rowsCount = _employeeDataSource.filterConditions.isNotEmpty
        ? _employeeDataSource.effectiveRows.length
        : _employeeDataSource._employeeData.length;
    pageCount = (rowsCount / rowsPerPage).ceil().toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Syncfusion Flutter DataGrid')),
        body: LayoutBuilder(builder: (context, constraints) {
          return Column(children: [
            SizedBox(
              height: constraints.maxHeight - 60,
              child: SfDataGrid(
                source: _employeeDataSource,
                columns: getColumns,
                allowFiltering: true,
                rowsPerPage: rowsPerPage,
                onFilterChanged: (details) {
                  setState(() {
                    _updatePageCount();
                  });
                },
                columnWidthMode: ColumnWidthMode.fill,
              ),
            ),
            SizedBox(
              height: 60,
              child: SfDataPager(
                  pageCount: pageCount, delegate: _employeeDataSource),
            ),
          ]);
        }));
  }

  List<GridColumn> get getColumns {
    return <GridColumn>[
      GridColumn(
          columnName: 'id',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text('ID'))),
      GridColumn(
          columnName: 'name',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text('Name'))),
      GridColumn(
          columnName: 'designation',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text('Designation'))),
      GridColumn(
          columnName: 'salary',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text('Salary'))),
    ];
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(List<Employee> employees) {
    buildDataGridRows(employees);
  }

  List<DataGridRow> _employeeData = [];
  List<Employee> paginatedDataSource = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  void buildDataGridRows(List<Employee> employees) {
    _employeeData = employees
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'designation', value: e.designation),
              DataGridCell<int>(columnName: 'salary', value: e.salary),
            ]))
        .toList();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);

  final int id;
  final String name;
  final String designation;
  final int salary;
}

List<Employee> populateData() {
  return [
    Employee(10001, 'James', 'Project Lead', 20000),
    Employee(10002, 'Kathryn', 'Manager', 30000),
    Employee(10003, 'Lara', 'Developer', 15000),
    Employee(10004, 'Michael', 'Designer', 15000),
    Employee(10005, 'Martin', 'Developer', 15000),
    Employee(10006, 'newberry', 'Developer', 15000),
    Employee(10007, 'Balnc', 'Project Lead', 25000),
    Employee(10008, 'Perry', 'Developer', 15000),
    Employee(10009, 'Gable', 'Designer', 10000),
    Employee(10010, 'Keefe', 'Project Lead', 25000),
    Employee(10011, 'Doran', 'Developer', 35000),
    Employee(10012, 'Linda', 'Designer', 19000),
    Employee(10013, 'Perry', 'Developer', 15000),
    Employee(10014, 'Gable', 'Designer', 10000),
    Employee(10015, 'Keefe', 'Project Lead', 25000),
    Employee(10016, 'Doran', 'Developer', 35000),
    Employee(10017, 'Linda', 'Designer', 19000),
    Employee(10018, 'Perry', 'Developer', 15000),
    Employee(10019, 'Gable', 'Designer', 10000),
    Employee(10020, 'Jack', 'Project Lead', 25000)
  ];
}
