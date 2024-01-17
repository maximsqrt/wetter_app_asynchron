import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wetter_app_asynchron/background.dart';
import 'package:wetter_app_asynchron/jsonString.dart';
import 'package:http/http.dart' as http;

class WetterApp extends StatefulWidget {
  const WetterApp({Key? key}) : super(key: key);

  @override
  _WetterAppState createState() => _WetterAppState();
}

class _WetterAppState extends State<WetterApp> {
  double latitude = 0.0;
  double longitude = 0.0;
  String time = '';
  double temperature = 0.0;
  double perceivedTemperature = 0.0;
  bool isDay = true;
  double precipitation = 0.0;

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=48.783333&longitude=9.183333&current=temperature_2m,apparent_temperature,is_day,precipitation&timezone=Europe%2FBerlin&forecast_days=1'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _updateValuesFromJsonString(jsonData);

        // Save the fetched data to jsonStringWeather
        updateJsonStringWeather(jsonData);
      } else {
        print('Fehler bei der Anfrage. Statuscode: ${response.statusCode}');
      }
    } catch (e) {
      print('Fehler beim Abrufen der Daten: $e');
    }
  }

  void _updateValuesFromJsonString(Map<String, dynamic> jsonData) {
    setState(() {
      latitude = jsonData['latitude'];
      longitude = jsonData['longitude'];
      time = jsonData['current']['time'];
      temperature = jsonData['current']['temperature_2m'];
      perceivedTemperature = jsonData['current']['apparent_temperature'];
      isDay = jsonData['current']['is_day'] == 1;
      precipitation = jsonData['current']['precipitation'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Wetter-App'),
          backgroundColor: Colors.purple,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ThermometerBackground(
                    temperature: temperature,
                    maxHeight: MediaQuery.of(context).size.height / 2,
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(16.0),
                    children: [
                      Text('Latitude: $latitude'),
                      Text('Longitude: $longitude'),
                      Text('Time: $time'),
                      Text('Temperature 2m: $temperature'),
                      Text('Apparent Temperature: $perceivedTemperature'),
                      Text('Is Day: $isDay'),
                      Text('Precipitation: $precipitation'),
                      ElevatedButton(
                        onPressed: () {
                          fetchData();
                        },
                        child: Text('Vorhersage aktualisieren'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height - 100.0,
              child: ThermometerBackground(temperature: temperature, maxHeight: 100.0),
            ),
          ],
        ),
      ),
    );
  }
}
