import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Especial de la Semana',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SelectionView(),
    );
  }
}

class SelectionView extends StatefulWidget {
  const SelectionView({super.key});

  @override
  State<SelectionView> createState() => _SelectionViewState();
}

class _SelectionViewState extends State<SelectionView> {
  Map<String, dynamic>? _specialOfTheWeek;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMenuData();
  }

  Future<void> _fetchMenuData() async {
    final response = await http.get(Uri.parse('https://nutrimap.unlimiteds.workers.dev/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      _selectSpecialOfTheWeek(data);
    } else {
      throw Exception('Failed to load menu data');
    }
  }

  void _selectSpecialOfTheWeek(List data) {
    final random = Random();
    final store = data[random.nextInt(data.length)];
    final menu = store['menus'][random.nextInt(store['menus'].length)];

    setState(() {
      _specialOfTheWeek = {
        'nameStore': store['nameStore'],
        'menu': menu,
      };
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Especial de la Semana'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _specialOfTheWeek == null
              ? const Center(child: Text('No se pudo cargar el especial de la semana'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _specialOfTheWeek!['nameStore'],
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Image.network(
                        _specialOfTheWeek!['menu']['preview'],
                        height: 200,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _specialOfTheWeek!['menu']['nombre'],
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Precio: ${_specialOfTheWeek!['menu']['precio']}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _specialOfTheWeek!['menu']['descripcion'],
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
    );
  }
}
