import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> translate() async {
  final http.Response response = await http.post(
    'https://translation.googleapis.com/language/translate/v2?key=AIzaSyDat1jys70j1ZbZl4MyD3oeRg1WQpT-9rU',
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      "q":
          "The Great Pyramid of Giza (also known as the Pyramid of Khufu or the Pyramid of Cheops) is the oldest and largest of the three pyramids in the Giza pyramid complex.",
      "source": "en",
      "target": "Ar",
      "format": "text"
    }),
  );

  if (response.statusCode == 200) {
    Map jsonResponse = json.decode(response.body);
    return jsonResponse["data"]["translations"][0]['translatedText'];
  } else {
    throw Exception('Failed to create data.');
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      home: FutureBuilder<String>(
        future: translate(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
