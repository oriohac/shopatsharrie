import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopatsharrie/Screens/home.dart';

Future<void> main() async {
  if (kReleaseMode) {
    await dotenv.load(fileName: ".env.prod");
  } else {
    await dotenv.load(fileName: ".env");
  }

  runApp(const Shopatsharrie());
}

class Shopatsharrie extends StatelessWidget {
  const Shopatsharrie({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
