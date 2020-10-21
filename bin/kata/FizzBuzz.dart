import 'dart:io';

void main() {
  var buzzer = FizzBuzz();

  for (var i = 1; i < 100; i++) {
    stdout.write(buzzer.evaluate(i));
    stdout.writeln();
  }
}

class FizzBuzz {
  String evaluate(int i) {
    var nextLine = '';
    if (i % 3 == 0) {
      nextLine += 'Fizz';
    }
    if (i % 5 == 0) {
      nextLine += 'Buzz';
    }
    if (i % 3 != 0 && i % 5 != 0) {
      nextLine += '$i';
    }
    return nextLine;
  }
}