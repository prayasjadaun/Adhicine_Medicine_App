import 'package:adhicine_project_assignment/screens/add_medicine_screen.dart';
import 'package:adhicine_project_assignment/screens/report_screen.dart';
import 'package:adhicine_project_assignment/screens/setting_screen.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
      // Stay on the home screen
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ReportScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hi Harry!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text('5 Medicines Left',
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              DateSelector(selectedDate: DateTime.now()),
              const SizedBox(height: 20),
              _buildMedicineList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddMedicinesScreen()),
        ),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Report'),
        ],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildMedicineList() {
    final medicines = [
      (
      'Calpol 500mg Tablet',
      'Before Breakfast',
      'Day 01',
      MedicineStatus.taken
      ),
      (
      'Calpol 500mg Tablet',
      'Before Breakfast',
      'Day 27',
      MedicineStatus.missed
      ),
      ('Calpol 500mg Tablet', 'After Food', 'Day 01', MedicineStatus.snoozed),
      ('Calpol 500mg Tablet', 'Before Sleep', 'Day 03', MedicineStatus.left),
    ];

    return Column(
      children: [
        for (var (name, time, day, status) in medicines)
          _buildMedicineItem(name, time, day, status),
      ],
    );
  }

  Widget _buildMedicineItem(
      String name, String time, String day, MedicineStatus status) {
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
      MedicineStatus.left: null,
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: colors[status]!.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colors[status]!.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
                status == MedicineStatus.left
                    ? Icons.medication
                    : Icons.medication_outlined,
                color: colors[status]),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('$time • $day',
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          if (icons[status] != null) Icon(icons[status], color: colors[status]),
        ],
      ),
    );
  }
}

class DateSelector extends StatelessWidget {
  final DateTime selectedDate;

  const DateSelector({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(icon: const Icon(Icons.chevron_left), onPressed: () {}),
        const Text(
          'Saturday, Sep 3',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        IconButton(icon: const Icon(Icons.chevron_right), onPressed: () {}),
      ],
    );
  }
}

enum MedicineStatus { taken, missed, snoozed, left }
