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
  List<String> occupationList = [];
  List<SwipeItem> _swipeItems = [];
  // 論理的思考力、継続力、チャレンジ精神、協調性、計画力、主体性
  List<int> vector = [0, 0, 0, 0, 0, 0];
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  // List<String> _names = ["Red", "Blue", "Green", "Yellow", "Orange"];
  // key: 質問内容, value: 質問内容が属する属性のインデックス
  Map <String, List<int>> _questionList = {
    "数学や理科の問題を考えることが好き":  [0,2],
    "「なぜそうなるのか？」を考えるのが好き": [0,5],
    "学校や習い事をあまり休まない":  [1,3],
    "一度始めたことは根気よく続けられる": [1, 4],
    "出来るかどうか分からないことでもとりあえずやってみる": [2, 5],
    "期間限定商品を試してみる": [2, 3],
    "班行動や部活動などみんなと協力して何かをするのが好きだ": [3,4],
    "あいさつやお礼をしっかり言える": [1, 3],
    "夏休みの宿題を余裕をもって終わらせられる": [1, 4],
    "友達と遊びに行くとき、家を出る時間を考えることができる": [0, 4],
    "洋服や持ち物は自分で選びたい": [0, 5],
    "学校行事などで当事者意識をもって行動できる": [2, 5],
  };
  List<Color> _colors = [
    Colors.red[100]!,
  ];

  @override
  void initState() {
    var colorIndex = 0;
    for (String key in _questionList.keys) {
      _swipeItems.add(SwipeItem(
          content: Content(text: key, color: _colors[colorIndex]),
          likeAction: () {
            setState(() {
              vector = swipe(true, [_questionList[key]!.first, _questionList[key]!.last,], vector);
              print(vector);
            });
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text("Liked $key and index is ${_questionList[key]}"),
            //   duration: Duration(milliseconds: 500),
            // ));
          },
          nopeAction: () {
            setState(() {
              vector = swipe(false, [_questionList[key]!.first, _questionList[key]!.last,], vector);
              print(vector);
            });
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text("Nope $key and index is ${_questionList[key]}"),
            //   duration: Duration(milliseconds: 500),
            // ));
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
          title: const Text("ホーム"),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
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
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      );
                    },
                    onStackFinished: () {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text("Stack Finished"),
                      //   duration: Duration(milliseconds: 500),
                      // ));
                      setState(() {
                        occupationList = printResult(vector);
                        _isResultButtonShowed = true;
                      });
                      print(printResult([1 ,0, 0, 0]));
                    },
                    itemChanged: (SwipeItem item, int index) {
                      print("item: ${item.content.text}, index: $index");
                    },
                    upSwipeAllowed: true,
                    fillSpace: true,
                  ),
                ),
                Center(
                  child: _isResultButtonShowed
                      ? ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ResultView(
                          //この verctor が変更されていなければ rederchart も表示されない
                            vector: vector,
                            occupationList: occupationList)
                    )
                    );
                  }, child: const Text("結果を見る"))
                      : SizedBox(),),
              ]
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("いいえ", style: TextStyle(fontSize: 20),),
                  Text("はい", style: TextStyle(fontSize: 20),)
                ],
              ),
            ],
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