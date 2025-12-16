import 'package:flutter/material.dart';
import 'package:rick_morty_query_tester/requests/character_request.dart';
import 'package:typed_cached_query/typed_cached_query.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: TypedQueryBuilder(
          query: CharacterRequest(id: 1).query(),
          builder: (context, state) {
            if (state.isLoading) {
              return const CircularProgressIndicator();
            } else if (state.isError) {
              return Text('Error: ${state.error}');
            } else if (state.data != null) {
              final character = state.data!;
              return Text('Character: ${character.toJson()}');
            } else {
              return const Text('No data');
            }
          },
        ),
      ),
    );
  }
}
