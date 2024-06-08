import 'dart:io';

void main() {
  // #1 Local variable for user input
  var myNum = 0;

  // #2 Print usage for user
  stdout.write('Enter number between 1 to 9> ');

  // #3 Check input wether integer or not
  try {
    // #3.1 Convert string to integer
    myNum = int.parse(stdin.readLineSync()!);
  } catch (e) {
    // #3.2 Print error message and exit program
    stdout.writeln("error> enter integer number between 1to 9.");
    return;
  }

  // #4 Check input wether in right range
  if (1 <= myNum && myNum <= 9) {
    // #4.1 Calculates result
    for (var i = 1; i <= 9; i++) {
      stdout.writeln("$myNum x $i = ${myNum * i}");
    }
  } else {
    // #4.2 Print error message
    stdout.writeln("error> enter number between 1 to 9.");
  }
}
