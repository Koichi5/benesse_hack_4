import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

class InitialPage extends StatelessWidget {
  InitialPage({Key? key}) : super(key: key);

  final List<SwipeItem> _swipeItems = [];
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> _names = ["Red", "Blue", "Green", "Yellow", "Orange"];
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("initial page")),
    );
  }
}