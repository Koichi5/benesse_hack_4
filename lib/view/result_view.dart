import 'package:flutter/material.dart';

import '../component/reader_chart.dart';

class ResultView extends StatelessWidget {
  const ResultView({required this.vector, required this.occupationList}) : super();
  final List<int> vector;
  final List<String> occupationList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("結果"),),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Text("あなたに適性のある職業は"),
                for(int i = 0; i < occupationList.length; i++) ... {
                  ElevatedButton(
                    onPressed: (){
                    },
                    child: Text("${occupationList[i]}"),
                  )
                }
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: RadarChart(vector: vector,),
          )
        ]
      )
    );
  }
}
