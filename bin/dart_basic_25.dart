import 'dart:ffi';

heavyLoadFunction1() {
  print("[heavyLoadFunction1(): started.]");
  var sum = 0;
  for (var tmp = 0; tmp < 100000000; tmp++) {
    sum += tmp;
  }
  print('[heavyLoadFunction1: completed.]');
  return sum;
}

heavyLoadFunction2() {
  print("[heavyLoadFunction2(): started.]");
  var sum = 0;
  for (var tmp = 0; tmp < 1000000; tmp++) {
    sum += tmp;
  }
  print('[heavyLoadFunction2: completed.]');
  return sum;
}

heavyLoadFunction3() {
  print("[heavyLoadFunction3(): started.]");
  var sum = 0;
  for (var tmp = 0; tmp < 10000000; tmp++) {
    sum += tmp;
  }
  print('[heavyLoadFunction3: completed.]');
  return sum;
}

heavyLoadFunction4() {
  print("[heavyLoadFunction4(): started.]");
  var sum = 0;
  for (var tmp = 0; tmp < 100000; tmp++) {
    sum += tmp;
  }
  print('[heavyLoadFunction4: completed.]');
  return sum;
}

Future takeTimeA() async {
  print('[takeTimeA(): started.]');
  var status1 = await heavyLoadFunction1();
  var status2 = await heavyLoadFunction2();
  print('takeTimeA(): complete and result is $status1 $status2');
}

Future takeTimeB() async {
  print('[takeTimeB(): started.]');
  var status1 = await heavyLoadFunction3();
  var status2 = await heavyLoadFunction4();
  print('takeTimeB(): complete and result is $status1 $status2');
}

Future main() async {
  print("[main(): started]");
  await takeTimeA();
  await takeTimeB();
  print("[main(): completed]");
}
