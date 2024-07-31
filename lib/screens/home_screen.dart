import 'dart:async';

import 'package:adhicine_project_assignment/screens/med_reminder_screen.dart';
import 'package:flutter/material.dart';
import 'package:adhicine_project_assignment/screens/add_medicine_screen.dart';
import 'package:adhicine_project_assignment/screens/report_screen.dart';
import 'package:adhicine_project_assignment/screens/setting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:camera/camera.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription<User?>? _authStateListener;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User? _user;
  List<dynamic> _medicines = [];
  bool _isConnected = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _getMedicines();
    _checkConnectivity(); // Check initial connectivity status
  }

  void _getCurrentUser() {
    _authStateListener = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (mounted) {
        setState(() {
          _user = user;
        });
      }
    });
  }

  void _getMedicines() async {
    if (_user != null) {
      final snapshot = await _firestore
          .collection('users')
          .doc(_user!.uid)
          .collection('medicines')
          .get();
      setState(() {
        _medicines = snapshot.docs.map((doc) => doc.data()).toList();
      });
    }
  }

  @override
  void dispose() {
    _authStateListener?.cancel(); // Cancel the listener when the widget is disposed
    super.dispose();
  }

  void _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi ${_user?.displayName ?? ''}!'),
        actions: [
          IconButton(
            icon: Icon(Icons.medical_services_sharp),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MedReminderScreen()),
              );
            },
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  _user?.photoURL ?? 'https://via.placeholder.com/150'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${_medicines.length} Medicines Left'),
                Text(
                  'Saturday, Sep 3',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isConnected
                ? _buildMedicinesList()
                : _buildNoConnectionWidget(),
          ),
        ],
      ),
      floatingActionButton: _isConnected
          ? null // Remove floating action button from here
          : null,
      bottomNavigationBar: Stack(
        alignment: Alignment.topCenter, // Align items to the top center of the stack
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.10,
            child: BottomNavigationBar(

              backgroundColor: Colors.white,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: 'Reports',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blue.shade800,
              onTap: _onItemTapped,
            ),
          ),
          Positioned(
            top: 0, // Adjust this value to position the FAB correctly
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddMedicinesScreen(),
                  ),
                );
              },
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicinesList() {
    return _medicines.isNotEmpty
        ? ListView.builder(
      itemCount: _medicines.length,
      itemBuilder: (context, index) {
        final medicine = _medicines[index];
        return ListTile(
          title: Text(medicine['name']),
          subtitle: Text(medicine['description']),
        );
      },
    )
        : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.medication, size: 100, color: Colors.grey[300]),
          SizedBox(height: 20),
          Text('Nothing Is Here, Add a Medicine'),
        ],
      ),
    );
  }

  Widget _buildNoConnectionWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/no_connection.png', height: 100),
          SizedBox(height: 20),
          Text(
            'Your Device is not connected',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('Connect your device with'),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _handleWiFi,
            icon: Icon(Icons.wifi),
            label: Text('Wi-Fi'),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (_selectedIndex) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ReportScreen(),
          ),
        );
        break;
      default:
      // Navigate to HomeScreen if index 0 is selected
        break;
    }
  }

  void _handleWiFi() async {
    bool isEnabled = await WiFiForIoTPlugin.isEnabled();
    if (isEnabled) {
      // Wi-Fi is enabled
      List<WifiNetwork> wifiList = await WiFiForIoTPlugin.loadWifiList();
      wifiList.forEach((wifi) {
        print("SSID: ${wifi.ssid}, Signal Strength: ${wifi.level}");
      });
    } else {
      // Handle Wi-Fi off scenario
      print("Please turn on Wi-Fi");
    }
  }
}
