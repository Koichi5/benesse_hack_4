List<String> printResult(List<int> vector) {
  List<String> strList = [
    '小学校の先生',
    '医者',
    '漫画家',
    '保育士',
    '歌手',
    'プログラマー',
    '商品開発',
    '弁護士',
    '公務員',
    '看護師',
    'アパレル',
    '教授職'
  ];
  Map<String, List<int>> strVector = {
    '小学校の先生': [3, 2, 0, 4, 1, 2],
    '医者': [4, 4, 3, 1, 4, 2],
    '漫画家': [0, 4, 4, 0, 0, 1],
    '保育士': [0, 2, 0, 4, 1, 2],
    '歌手': [0, 3, 3, 3, 0, 3],
    'プログラマー': [4, 3, 1, 3, 3, 1],
    '商品開発': [2, 1, 4, 2, 4, 3],
    '弁護士': [4, 3, 3, 4, 2, 1],
    '公務員': [3, 4, 0, 2, 4, 1],
    '看護師': [1, 2, 1, 4, 4, 0],
    'アパレル': [1, 2, 1, 4, 1, 4],
    '教授職': [4, 4, 3, 0, 3, 3],
  };

  Map<String, int> distMap = {};

  String result = ''; // デフォルト値を代入
  //norm_vector = normalize(vector);
  var dist = 0;
  var argmin = 0;
  var distPrev = 1000;

  for (int i = 0; i < strList.length; i++) {
    dist = calDist(strVector[strList[i]], vector);
    distMap[strList[i]] = dist;
    if (dist < distPrev) {
      argmin = i;
      distPrev = dist;
    }
  }

  // print(distMap);

  List<MapEntry<String, int>> sortedEntries = distMap.entries.toList()
    ..sort((a, b) => a.value.compareTo(b.value));

  Map<String, int> sortedMap = Map.fromEntries(sortedEntries);

  //  List<String> resultList = getList(sortedMap);

  // print(sortedMap);

  List<String> sublist = sortedMap.keys.toList().sublist(0, 4);
  //print(sublist);
  return sublist;
}

calDist(List<int>? strVectorComp, List<int> vector) {
  if (strVectorComp == null) {
    throw ArgumentError('strVector must not be null');
  }
  var dist = 0;
  for (int i = 0; i < vector.length; i++) {
    if (i < strVectorComp.length) {
      dist += (strVectorComp[i] - vector[i]) * (strVectorComp[i] - vector[i]);
    }
  }
  return dist;
}

void main() {
  List<int> vector = [0, 0, 0, 0, 0, 0];
  // Iterable<String> result = printResult(vector);
  // print(result);
  List<String> sublist = printResult(vector);
  print(sublist);
}
