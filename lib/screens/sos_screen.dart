import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SOSScreen extends StatefulWidget {
  const SOSScreen({super.key});

  @override
  _SOSScreenState createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> {
  final _locationController = TextEditingController();
  String _requestType = 'Ambulance';
  String _severity = 'Moderate';

  Future<void> _submitRequest() async {
    try {
      await FirebaseFirestore.instance.collection('sos_requests').add({
        'type': _requestType,
        'location': _locationController.text.trim(),
        'severity': _severity,
        'status': 'Pending',
        'timestamp': Timestamp.now(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request submitted successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Raise SOS Request')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              initialValue: _requestType,
              items: ['Ambulance', 'Medicine', 'Blood', 'Doctor Call']
                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (val) => setState(() => _requestType = val!),
              decoration: InputDecoration(labelText: 'Request Type'),
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            DropdownButtonFormField<String>(
              initialValue: _severity,
              items: ['Mild', 'Moderate', 'Critical']
                  .map((level) => DropdownMenuItem(value: level, child: Text(level)))
                  .toList(),
              onChanged: (val) => setState(() => _severity = val!),
              decoration: InputDecoration(labelText: 'Severity'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _submitRequest, child: Text('Submit Request')),
          ],
        ),
      ),
    );
  }
}