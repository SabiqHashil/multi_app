import 'package:flutter/material.dart';
import 'package:multi_app/api/api_client.dart';
import 'package:multi_app/screens/jokes/jokes_widget.dart';

class JokesScreen extends StatefulWidget {
  @override
  _JokesScreenState createState() => _JokesScreenState();
}

class _JokesScreenState extends State<JokesScreen> {
  late Future<String> _jokeFuture;
  final JokesApiClient _jokesApiClient = JokesApiClient();

  @override
  void initState() {
    super.initState();
    _jokeFuture = _jokesApiClient.fetchRandomJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jokes'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _jokeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return JokeWidget(snapshot.data!);
            } else {
              return Text('No joke found');
            }
          },
        ),
      ),
    );
  }
}
