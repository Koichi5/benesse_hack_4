import 'package:flutter/cupertino.dart';

List<int> swipe(bool isTrue, int index, List<int> prevData) {
  var personalData = prevData;
  if (isTrue) {
    personalData[index] += 1;
  }
  return personalData;
}
