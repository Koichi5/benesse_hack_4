List<int> swipe(bool isTrue, List<int> index, List<int> prevData) {
  var personalData = prevData;
  if (isTrue) {
    for (int i = 0; i < index.length; i++) {
      personalData[index[i]] += 1;
      print("${isTrue}, $index, $prevData");
    }
  }
  return personalData;
}
