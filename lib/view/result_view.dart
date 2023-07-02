import 'package:benesse_hack/view/work_view.dart';
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
      body: Center(
        child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Text("あなたに適性のある職業は"),
                    for(int i = 0; i < occupationList.length; i++) ... {
                      ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => WorkView(work: occupationList[i],)));
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
        ),)
    );
  }
}
