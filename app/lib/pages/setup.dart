import 'package:flutter/material.dart';
import 'package:robot_app/services/ble_connection/ble_interface.dart';
import '../services/ble_connection/ble_driver.dart'; 
import '../widgets/ble_connect_button.dart';         
import '../services/robot_profiles.dart';

class SetupWizardPage extends StatefulWidget {
  final BleInterface bleDriver;


  const SetupWizardPage({super.key, required this.bleDriver});

  @override
  State<SetupWizardPage> createState() => _SetupWizardPageState();
}

class _SetupWizardPageState extends State<SetupWizardPage>{

  final Set<String> _selectedRobotIds = {};

  // used for the checklist
  void _toggleRobot(String id) {
    setState(() {
      if (_selectedRobotIds.contains(id)) {
        _selectedRobotIds.remove(id);
      } else {
        _selectedRobotIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. FILTER: Create the list of actual Robot objects from selected IDs
    final targetRobots = knownRobots
        .where((r) => _selectedRobotIds.contains(r.id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Setup Wizard")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Select Target Robots',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // 2. CHECKBOX LIST
            Expanded(
              child: ListView.builder(
                itemCount: knownRobots.length,
                itemBuilder: (context, index) {
                  final robot = knownRobots[index];
                  final isChecked = _selectedRobotIds.contains(robot.id);
                  return Card(
                    color: isChecked ? Colors.grey.shade600 : Colors.black,
                    child: CheckboxListTile(
                      title: Text(robot.name),
                      subtitle: Text("ID: ${robot.id}"),
                      value: isChecked,
                      onChanged: (_) => _toggleRobot(robot.id),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // 3. UPDATED BUTTON
            // We pass the filtered 'targetRobots' list to the button
            BleConnectButton(
              bleDriver: widget.bleDriver,
              targetRobots: targetRobots, // <--- Passing the selection here
            ),

            const SizedBox(height: 20),

            // Test Button 
            OutlinedButton(
              onPressed: () async {
                 try {
                   await widget.bleDriver.writeToCharacteristic('T'.codeUnits);
                   print("✅ 'T' Sent!");
                 } catch(e) { print(e); }
              },
              child: const Text("Test: Send 'T'"),
              
            ),
          ],
        ),
      ),
    );
  }
}