import 'package:flutter/material.dart';
import 'package:rhttp/rhttp.dart';
import 'package:zain_test/dynamic_fields/screen.dart';

Future<void> main() async {
  await Rhttp.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => makeHTTP3Request(context),
              child: Text("Make HTTP3 Request"),
            ),
            SizedBox(height: 36),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DynamicFieldsScreen()),
                );
              },
              child: Text("Test Dynamic Fields"),
            ),
          ],
        ),
      ),
    );
  }
}

makeHTTP3Request(BuildContext context) async {
  try {
    HttpTextResponse response = await Rhttp.get(
      'https://cloudflare-quic.com',
      settings: const ClientSettings(
        httpVersionPref: HttpVersionPref.http3,
      ),
    );

    print(response.statusCode);
    print(response.version);
    print(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('HTTP3 Request Completed Without Errors')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error Making HTTP3 Request')),
    );
  }
}
