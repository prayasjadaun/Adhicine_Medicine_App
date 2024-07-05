import 'package:adhicine_project_assignment/screens/home_screen.dart';
import 'package:adhicine_project_assignment/screens/report_screen.dart';
import 'package:flutter/material.dart';

class MedReminderScreen extends StatefulWidget {
  const MedReminderScreen({Key? key}) : super(key: key);

  @override
  _MedReminderScreenState createState() => _MedReminderScreenState();
}

class _MedReminderScreenState extends State<MedReminderScreen> {
  DateTime selectedDate = DateTime.now();

  List<MedicineItem> medicines = [
    MedicineItem(
      name: 'Calpol 500mg Tablet',
      time: 'Before Breakfast',
      day: 'Day 01',
      status: MedicineStatus.taken,
    ),
    MedicineItem(
      name: 'Calpol 500mg Tablet',
      time: 'Before Breakfast',
      day: 'Day 27',
      status: MedicineStatus.missed,
    ),
    MedicineItem(
      name: 'Calpol 500mg Tablet',
      time: 'After Food',
      day: 'Day 01',
      status: MedicineStatus.snoozed,
    ),
    MedicineItem(
      name: 'Calpol 500mg Tablet',
      time: 'Before Sleep',
      day: 'Day 03',
      status: MedicineStatus.left,
    ),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi Harry!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text('5 Medicines Left', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              DateSelector(
                selectedDate: selectedDate,
                onPreviousDate: () {
                  setState(() {
                    selectedDate = selectedDate.subtract(Duration(days: 1));
                  });
                },
                onNextDate: () {
                  setState(() {
                    selectedDate = selectedDate.add(Duration(days: 1));
                  });
                },
              ),
              const SizedBox(height: 20),
              Expanded(child: _buildMedicineList()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addMedicine(context);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: 'Report',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildMedicineList() {
    return ListView.builder(
      itemCount: medicines.length,
      itemBuilder: (context, index) {
        final medicine = medicines[index];
        return _buildMedicineItem(medicine);
      },
    );
  }

  Widget _buildMedicineItem(MedicineItem medicine) {
    final colors = {
      MedicineStatus.taken: Colors.green,
      MedicineStatus.missed: Colors.red,
      MedicineStatus.snoozed: Colors.orange,
      MedicineStatus.left: Colors.grey,
    };

    final icons = {
      MedicineStatus.taken: Icons.check,
      MedicineStatus.missed: Icons.close,
      MedicineStatus.snoozed: Icons.snooze,
      MedicineStatus.left: Icons.medication,
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: colors[medicine.status]!.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colors[medicine.status]!.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icons[medicine.status],
              color: colors[medicine.status],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medicine.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('${medicine.time} • ${medicine.day}',
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          if (medicine.status != MedicineStatus.left)
            Icon(icons[medicine.status], color: colors[medicine.status]),
        ],
      ),
    );
  }

  void _addMedicine(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Medicine'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Medicine Name'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Time'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Day'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add logic to save the medicine
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // You can add navigation logic based on index if needed
    switch (_selectedIndex) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ReportScreen()));
        break;

      default:
        break;
    }
  }
}

class DateSelector extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback? onPreviousDate;
  final VoidCallback? onNextDate;

  const DateSelector({
    Key? key,
    required this.selectedDate,
    this.onPreviousDate,
    this.onNextDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: onPreviousDate,
        ),
        Text(
          '${_getFormattedDate(selectedDate)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: onNextDate,
        ),
      ],
    );
  }

  String _getFormattedDate(DateTime date) {
    return '${_getDayOfWeek(date.weekday)}, ${_getMonth(date.month)} ${date.day}';
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }

  String _getMonth(int month) {
    switch (month) {
      case DateTime.january:
        return 'January';
      case DateTime.february:
        return 'February';
      case DateTime.march:
        return 'March';
      case DateTime.april:
        return 'April';
      case DateTime.may:
        return 'May';
      case DateTime.june:
        return 'June';
      case DateTime.july:
        return 'July';
      case DateTime.august:
        return 'August';
      case DateTime.september:
        return 'September';
      case DateTime.october:
        return 'October';
      case DateTime.november:
        return 'November';
      case DateTime.december:
        return 'December';
      default:
        return '';
    }
  }
}

enum MedicineStatus { taken, missed, snoozed, left }

class MedicineItem {
  final String name;
  final String time;
  final String day;
  final MedicineStatus status;

  MedicineItem({
    required this.name,
    required this.time,
    required this.day,
    required this.status,
  });
}
