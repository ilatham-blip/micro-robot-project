import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'pages/landing.dart';
import 'pages/setup.dart';
import 'pages/controls.dart';
import 'pages/sensor.dart';
import 'pages/video.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int selectedIndex = 0;

  final pages = const [
    LandingPage(),
    SetupWizardPage(),
    RobotControlsPage(),
    SensorLogPage(),
    VideoLogPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 600;

        // Sidebar width
        final double railWidth = isWide ? 350 : 120;

        return Scaffold(
          appBar: AppBar(title: const Text('Robot Controller')),
          body: Row(
            children: [
              SafeArea(
                child: Container(
                  width: math.min(railWidth, constraints.maxWidth * 0.6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IntrinsicHeight(
                        child: NavigationRail(
                          extended: isWide,
                          selectedIndex: selectedIndex,
                          onDestinationSelected: (i) =>
                              setState(() => selectedIndex = i),
                          destinations: const [
                            NavigationRailDestination(
                              icon: Icon(Icons.home),
                              label: Text('Home'),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.settings),
                              label: Text('Set-up Wizard'),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.route),
                              label: Text('Robot Controls'),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.polyline),
                              label: Text('Sensor Log'),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.camera),
                              label: Text('Video Log'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const VerticalDivider(width: 1),

              Expanded(
                child: pages[selectedIndex],
              ),
            ],
          ),
        );
      },
    );
  }
}
