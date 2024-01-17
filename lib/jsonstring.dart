// data.dart
import 'dart:convert';

String jsonStringWeather = """
{
    "latitude": 0.0,
    "longitude": 0.0,
    "current": {
        "time": "",
        "temperature": 0.0,
        "perceived_temperature": 0.0,
        "is_day": 0,
        "precipitation": 0.0
    }
}
""";

void updateJsonStringWeather(Map<String, dynamic> newData) {
  jsonStringWeather = json.encode(newData);
}
