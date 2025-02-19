import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spectromancer/food_safe.dart';
import 'package:spectromancer/toxin_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String?> _toxins = [];
  Uri _graphUri = Uri.parse('http://0.0.1:8000/data'); // default to localhost
  bool _data = false;

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
        _graphUri = Uri.parse(data['graph_uri']);
        
        setState(() {
        _toxins = (data['toxins'] as List<dynamic>).map((item) => item as String?).toList();
        _data = true;
        });
      } else {
        _showErrorDialog('Failed to load data');
      }
    } catch (e) {
      _showErrorDialog('Failed to connect to server. Try again.');
    }
    
  }



  Future<void> _scan() async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/scan'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'scan': true}));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message']),
              duration: Duration(seconds: 3),
            ),
          );
        }
        await _fetchData();
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to scan'),
              duration: Duration(seconds: 3),
            ),
          );
          
        }
      }
    } catch (e) {
      if(mounted){
        ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to connect to server. Try again.'),
          duration: Duration(seconds: 3),
        ),
      );
      }
     
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 2,
        //backgroundColor: Theme.of(context).colorScheme.primaryContainer.withAlpha(150),
        title: Text("Spectra",style: Theme.of(context).textTheme.titleLarge,),
        actions: [
          OutlinedButton.icon(
            label: Text("Refresh"),
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
      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FoodSafe(isSafe: _toxins.isEmpty,numToxins: _toxins.length,data: _data,),
              SizedBox(height: 12,),
            
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
              onPressed: () async{
               if (await canLaunchUrl(_graphUri)) {
                  await launchUrl(_graphUri);
                } else {
                  throw 'Could not launch $_graphUri';
                }
              },
              child: Text("Open Graph"),
            ),
                  OutlinedButton(onPressed: (){
                    _scan();
                  }, child: Text("Scan again")),
                ],
              ),
          
              SizedBox(height: 12,),
              Divider(),
              ToxinWidget(toxins: _toxins),
              SizedBox(height: 12,),
            

            ]
          ),
        ),
      ),
    );
  }
}

