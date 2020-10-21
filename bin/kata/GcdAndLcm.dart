import 'dart:io';

enum OperationType { GCD, LCM }

class Operation {
  OperationType type;
  int num1;
  int num2;

  Operation(OperationType type, int num1, int num2) {
    this.type = type;
    this.num1 = num1;
    this.num2 = num2;
  }
}

final tool = GcdAndLcm();

void main() {
  stdout.writeln(
      "Input hcf, lcm or 'exit' to stop (ex: 'hcf 17 21'; 'lcm 14 28'): ");

  var input = '';
  while (input != 'exit') {
    input = _promptInput();
    var op = _parse(input);
    if (op != null) {
      _exec(op);
    }
  }
}

String _promptInput() {
  stdout.write('|> ');
  return stdin.readLineSync();
}

Operation _parse(String input) {
  var parts = input.split(' ');
  if (parts.length != 3) {
    stdout.writeln('input error');
    return null;
  }
  var operationType = parseType(parts[0]);
  var num1 = _parseNum(parts[1]);
  var num2 = _parseNum(parts[2]);
  if (operationType == null || num1 == null || num2 == null) {
    return null;
  }
  return Operation(operationType, num1, num2);
}

OperationType parseType(String input) {
  switch (input) {
    case 'gcd':
      return OperationType.GCD;
    case 'lcm':
      return OperationType.LCM;
    default:
      stdout.writeln('wrong op type');
      return null;
  }
}

int _parseNum(String input) {
  return int.tryParse(input);
}

void _exec(Operation op) {
  switch (op.type) {
    case OperationType.GCD:
      _execGCD(op.num1, op.num2);
      break;
    case OperationType.LCM:
      _execLCM(op.num1, op.num2);
      break;
  }
}

void _execGCD(int num1, int num2) {
  var result = tool.determineGCD(num1, num2);

  stdout.writeln('The greatest common divisor is $result');
}

void _execLCM(int num1, int num2) {
  var result = tool.determineLowestCommonMultiple(num1, num2);

  stdout.writeln('The lowest common multiple is $result');
}

class GcdAndLcm {
  int determineGCD(int num1, int num2) {
    int remainder;
    while (num2 != 0) {
      remainder = num1 % num2;
      num1 = num2;
      num2 = remainder;
    }

    return num1;
  }

  int determineLowestCommonMultiple(int num1, int num2) {
    if (num1 == 0 || num2 == 0) {
      return 0;
    }
    return ((num1 * num2) / determineGCD(num1, num2)).round();
  }
}