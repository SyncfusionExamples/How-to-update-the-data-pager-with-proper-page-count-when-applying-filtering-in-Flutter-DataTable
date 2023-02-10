# How-to-update-the-data-pager-with-proper-page-count-when-applying-filtering-in-Flutter-DataTable

The Syncfusion [Flutter DataGrid](https://www.syncfusion.com/flutter-widgets/flutter-datagrid) supports both programmatic and excel-like UI filtering of its rows. You can find more information about the filtering in [this](https://help.syncfusion.com/flutter/datagrid/filtering) UG documentation. 

The DataGrid interactively supports the manipulation of data using [SfDataPager](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataPager-class.html) control. This provides support to load data in segments when dealing with large volumes of data. You can find more information about the paging in [this](https://help.syncfusion.com/flutter/datagrid/paging) UG documentation. 

In this article, we will show you how to update the data pager with proper page count when applying filtering in Flutter DataGrid.

To initialize the [SfDataGrid](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid-class.html) and [SfDataPager](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataPager-class.html) widgets with all necessary properties, declare them and specify their respective properties. The [onFilterChanged](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid/onFilterChanged.html) callback will be triggered each time a filter is applied to the DataGrid. To update the DataPager's page count while filtering the rows, update the pageCount value based on the length of the [DataGridSource.effectiveRows](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridSource/effectiveRows.html) within the onFilterChanged callback function.

```dart
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
        appBar: AppBar(title: const Text('PageNavigation Demo')),
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
}

```
