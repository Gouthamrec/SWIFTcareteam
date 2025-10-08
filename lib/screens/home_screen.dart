import 'package:flutter/material.dart';
import 'sos_screen.dart'; // You'll create this next
import 'request_list_screen.dart'; // Optional: for viewing submitted requests

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SwiftCare Dashboard')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              child: Text('Raise SOS Request'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SOSScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('View Requests'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RequestListScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}