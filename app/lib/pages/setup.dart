import 'package:flutter/material.dart';
import 'package:robot_app/services/ble_connection/ble_interface.dart';
import '../services/ble_connection/ble_driver.dart'; 
import '../widgets/ble_connect_button.dart';         

class SetupWizardPage extends StatelessWidget {
  final BleInterface bleDriver;

  const SetupWizardPage({super.key, required this.bleDriver});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Setup Wizard")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: [
            // 1. Header Text
            
            const SizedBox(height: 20),
            const Text(
              'Step 1: Connect Bluetooth',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),


            const SizedBox(height: 40),

            // 2. The Custom Connect Button
            // This button handles the scanning logic automatically
            BleConnectButton(bleDriver: bleDriver),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white
              ),
              onPressed: () async {
                print("Sending 'T' to Robot...");
                try{  
                  // converting 'T' to bytes [84] and sending
                  await bleDriver.writeToCharacteristic('T'.codeUnits);
                  print("✅ 'T' Sent!");

                } catch (e) {
                  print("❌ Failed to send: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Send failed: $e")),
                  );
                }
                },
                child: const Text("Test: Send 'T'"),
              

            ),



            
          ],
        ),
      ),
    );
  }
}