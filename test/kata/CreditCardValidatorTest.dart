import 'package:test/test.dart';

import '../../bin/kata/CreditCardValidator.dart';

void main() {
  final creditCardValidator = CreditCardValidator();

  test('Is valid CreditCardNumber', () {
    expect(creditCardValidator.validate('2221001262859488'), true);
  });

  test('Invalid CreditCardNumber', () {
    expect(creditCardValidator.validate('22210012628594880'), false);
    expect(creditCardValidator.validate(''), false);
  });
}