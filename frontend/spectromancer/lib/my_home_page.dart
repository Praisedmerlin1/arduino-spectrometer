import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:spectromancer/chart_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<FlSpot> _dataPoints = [];
  List<Color> _colors = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }
  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/data'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _dataPoints = (data['data'] as List)
              .map((item) => FlSpot(
                  item['wavelength'].toDouble(), item['intensity'].toDouble()))
              .toList();
          _colors = (data['data'] as List)
              .map((item) =>
                  _getColorForWavelength(item['wavelength'].toDouble()))
              .toList();
        });
      } else {
        _showErrorDialog('Failed to load data');
      }
    } catch (e) {
      _showErrorDialog('Failed to connect to server. Try again.');
    }
  }
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Color _getColorForWavelength(double wavelength) {
    if (wavelength >= 380 && wavelength < 440) {
      return Colors.indigo;
    } else if (wavelength >= 440 && wavelength < 490) {
      return Colors.blue;
    } else if (wavelength >= 490 && wavelength < 510) {
      return Colors.green;
    } else if (wavelength >= 510 && wavelength < 580) {
      return Colors.yellow;
    } else if (wavelength >= 580 && wavelength < 645) {
      return Colors.orange;
    } else if (wavelength >= 645 && wavelength <= 780) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }
  List<Color> _getGradientColors() {
    return _dataPoints.map((point) => _getColorForWavelength(point.x)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Spectromancer"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchData,
          ),
        ],
      ),
      drawer: Drawer(
        
        width: 210,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryFixedDim,
              ),
              child: Text('Menu',style: Theme.of(context).textTheme.titleLarge,),
            ),
            ListTile(
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 300,
             
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ChartWidget(
                  dataPoints: _dataPoints,
                  colors: _colors,
                  gradientColors: _getGradientColors(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}