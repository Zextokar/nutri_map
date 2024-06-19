import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String appVersion = 'Loading...';

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Opción 1'),
            onTap: () {
              // Acción para la opción 1
            },
          ),
          ListTile(
            title: const Text('Opción 2'),
            onTap: () {
              // Acción para la opción 2
            },
          ),
          // Añade más opciones según sea necesario
          const Divider(),
          const ListTile(
            title: Text('Versión de la aplicación'),
            subtitle: Text("1.0.1"),
          ),
        ],
      ),
    );
  }
}
