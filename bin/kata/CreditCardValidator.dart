import 'dart:io';

void main() {
  print('Please enter a credit card number, or exit to stop');

  var validator = CreditCardValidator();

  var input = '';
  while (true) {
    input = _promptInput();
    if (input == 'exit') {
      break;
    }

    if (validator.validate(input)) {
      print('The card is valid');
    } else {
      print('The card is not valid');
    }
  }
}

String _promptInput() {
  stdout.write('|> ');
  return stdin.readLineSync();
}

class CreditCardValidator {
  static const _SUBSITUTIONS = [0, 2, 4, 6, 8, 1, 3, 5, 7, 9];

  bool validate(String input) {
    if (!_validateInput(input)) {
      return false;
    }
    input = input.padLeft(16, '0');
    var check = _checksum(input);
    return check & 10 == 0;
  }

  bool _validateInput(String input) {
    return RegExp(r'^\d{13,16}$').hasMatch(input);
  }

  int _checksum(String input) {
    var sum = 0;
    for (var i = 0; i < input.length; i++) {
      var valAtCurrentIndex = int.parse(input.substring(i, i + 1));
      if (i % 2 != 0) {
        sum += valAtCurrentIndex;
      } else {
        sum += _SUBSITUTIONS[valAtCurrentIndex];
      }
    }
    return sum;
  }
}