import 'package:benesse_hack/view/itnitial_page.dart';
import 'package:benesse_hack/view/result_view.dart';
import 'package:flutter/material.dart';

import 'component/reader_chart.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: InitialPage()
    );
  }
}