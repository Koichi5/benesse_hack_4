import 'package:benesse_hack/result.dart';
import 'package:benesse_hack/view/result_view.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../swipe.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  bool _isResultButtonShowed = false;
  List<SwipeItem> _swipeItems = [];
  // 論理的思考力、継続力、チャレンジ精神、協調性、計画力、主体性
  List<int> vector = [0, 0, 0, 0, 0];
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  // List<String> _names = ["Red", "Blue", "Green", "Yellow", "Orange"];
  // key: 質問内容, value: 質問内容が属する属性のインデックス
  Map <String, int> _questionList = {
    "質問1":  1,
    "質問2": 2,
    "質問3":  1,
    "質問4": 3,
  };
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange
  ];

  @override
  void initState() {
    var colorIndex = 0;
    for (String key in _questionList.keys) {
      _swipeItems.add(SwipeItem(
          content: Content(text: key, color: _colors[colorIndex]),
          likeAction: () {
            setState(() {
              vector = swipe(true, _questionList[key]!, vector);
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Liked $key and index is ${_questionList[key]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            setState(() {
              vector = swipe(false, _questionList[key]!, []);
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Nope $key and index is ${_questionList[key]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          // superlikeAction: () {
          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //     content: Text("Superliked $key and index is ${_questionList[key]}"),
          //     duration: Duration(milliseconds: 500),
          //   ));
          //   swipe(true, _questionList[key]!, []);
          // },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
      colorIndex + 1;
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("initial page"),
        ),
        body: Container(
            child: Column(children: [
              Container(
                height: 550,
                child: SwipeCards(
                  matchEngine: _matchEngine,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: _swipeItems[index].content.color,
                      child: Text(
                        _swipeItems[index].content.text,
                        style: TextStyle(fontSize: 100),
                      ),
                    );
                  },
                  onStackFinished: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Stack Finished"),
                      duration: Duration(milliseconds: 500),
                    ));
                    setState(() {
                      _isResultButtonShowed = true;
                    });
                  //  printresult
                  //  結果を表示する
                  //  結果表示ページ
                    print(printResult([1 ,0, 0, 0]));
                  },
                  itemChanged: (SwipeItem item, int index) {
                    print("item: ${item.content.text}, index: $index");
                  },
                  upSwipeAllowed: true,
                  fillSpace: true,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("いいえ"),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       // _matchEngine.currentItem.decision
                  //       print("Nope");
                  //     },
                  //     child: Text("Nope")),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       // _matchEngine.currentItem.superLike();
                  //       print("SuperLike");
                  //     },
                  //     child: Text("Superlike")),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       // _matchEngine.currentItem.like();
                  //       print("Like");
                  //     },
                  //     child: Text("Like"))
                  Text("はい")
                ],
              ),
              _isResultButtonShowed
                  ? ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ResultView(vector: vector, occupationList: ["消防士", "警察官", "弁護士", "検察官"])));
              }, child: const Text("結果を見る"))
                  : SizedBox()
            ]
            )
        )
    );
  }
}

class Content {
  final String text;
  final Color color;

  Content({required this.text, required this.color});
}