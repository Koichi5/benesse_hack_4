import 'package:collection/collection.dart';

String printResult(List vector) {
  List<String> strList = ["A", "B", "C", "D"];
  Map<String, List<int>> strVector = {
    'A': [1, 0, 0, 0],
    'B': [0, 1, 0, 0],
    'C': [0, 0, 1, 0],
    'D': [0, 0, 0, 1]
  };

  String result = ''; // デフォルト値を代入

  for (int i = 0; i < strList.length; i++) {
    if (ListEquality().equals(strVector[strList[i]], vector)) {
      result = strList[i];
      break; // 結果が見つかったらループを終了
    }
  }

  return result;
}
