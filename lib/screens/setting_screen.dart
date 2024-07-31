import 'package:adhicine_project_assignment/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/lady.jpeg'),
                radius: 30,
              ),
              title: Text('Take Care!', style: TextStyle(fontSize: 18)),
              subtitle: Text(
                'Richa Bose',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            _buildSettingTile(
              Icons.notifications,
              'Notification',
              'Check your medicine notification',
            ),
            _buildSettingTile(
              Icons.volume_up,
              'Sound',
              'Ring, Silent, Vibrate',
            ),
            _buildSettingTile(
              Icons.person,
              'Manage Your Account',
              'Password, Email ID, Phone Number',
            ),
            _buildSettingTile(
              Icons.notifications,
              'Notification',
              'Check your medicine notification',
            ),
            _buildSettingTile(
              Icons.notifications,
              'Notification',
              'Check your medicine notification',
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Device',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            _buildSettingTile(
              Icons.bluetooth,
              'Connect',
              'Bluetooth, Wi-Fi',
            ),
            _buildSettingTile(
              Icons.volume_up,
              'Sound Option',
              'Ring, Silent, Vibrate',
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Caretakers: 03',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCaretakerAvatar('Dipa Luna'),
                _buildCaretakerAvatar('Rou Sod...'),
                _buildCaretakerAvatar('Sunny Tu...'),
                _buildAddCaretakerButton(),
              ],
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Doctor',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 10),
                  Text('Add Your Doctor', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: const Text('Or use invite link'),
            ),
            const Divider(),
            _buildSettingTile(
              Icons.privacy_tip,
              'Privacy Policy',
              '',
            ),
            _buildSettingTile(
              Icons.description,
              'Terms of Use',
              '',
            ),
            _buildSettingTile(
              Icons.star,
              'Rate Us',
              '',
            ),
            _buildSettingTile(
              Icons.share,
              'Share',
              '',
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LogInScreen()), // Replace with your login screen route
                  (route) =>
                      false, // Prevents user from going back to settings screen
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text('Logout',
                        style: TextStyle(
                          color: Colors.white,
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: subtitle.isNotEmpty ? const Icon(Icons.chevron_right) : null,
      onTap: () {},
    );
  }

  Widget _buildCaretakerAvatar(String name) {
    return Column(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/Profile.jpg'),
          radius: 30,
        ),
        const SizedBox(height: 5),
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildAddCaretakerButton() {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.add, size: 30),
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Add',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
