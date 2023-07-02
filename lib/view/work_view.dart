import 'package:flutter/material.dart';

class WorkView extends StatelessWidget {
  const WorkView({super.key, required this.work});

  final String work;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("適正職業"),),
      body: Center(
        child: Column(
          children: [
            Image.asset(
                "assets/image/${work}.png"
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1,)
          ],
        ),
        // child: Image.asset("assets/image/${work}.png"),
      )
    );
  }
}
