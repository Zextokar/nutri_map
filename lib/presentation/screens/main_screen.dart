import 'package:flutter/material.dart';
import 'package:nutri_map/presentation/views/home_view.dart';
import 'package:nutri_map/presentation/views/info_view.dart';
import 'package:nutri_map/presentation/views/maps_view.dart';
import 'package:nutri_map/presentation/views/selection_view.dart';
import 'package:nutri_map/presentation/views/settings_view.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 2;

  final List<Widget> screens = [
    const MapsView(),
    const SelectionView(),
    const HomeView(),
    const InfoView(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'NutriMap',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Action for search
              },
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Action for notifications
              },
            ),
          ]),
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: GNav(
            haptic: true,
            tabBorderRadius: 15,
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor:
                const Color.fromRGBO(66, 66, 66, 1).withOpacity(1),
            gap: 8,
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(icon: Icons.map),
              GButton(icon: Icons.star),
              GButton(icon: Icons.home),
              GButton(icon: Icons.info),
              GButton(icon: Icons.settings),
            ],
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
