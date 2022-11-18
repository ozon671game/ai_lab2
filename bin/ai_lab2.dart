import 'dart:convert';
import 'dart:io';

// max count = N;
// max count of single step = K;

void main() {
  List<int> k = [1, 2];
  // print('input N:');
  // int n = int.parse(stdin.readLineSync(encoding: utf8).toString());
  int n = 10;
  bool userWin = false;
  while (n > 0) {
    userWin = true;
    n = pcStep(n, k);
    print('curValue: $n');
    userWin = false;
    n = userStep(n);
    print('curValue: $n');
  }
  if (userWin) {
    print('user win!');
  } else {
    print('pc win!');
  }
}

int pcStep(int n, List<int> k) {
  print('===pc step===');
  for (var element in k) {
    var val = n % element;
    print('ostaatok = $val');
    if (val == 1) {
      print('$n - $element');
      return n - element;
    }
  }
  return n - k.first;
}

int userStep(int n) {
  print('===user step===');
  int val = int.parse(stdin.readLineSync(encoding: utf8).toString());
  return n - val;
}
