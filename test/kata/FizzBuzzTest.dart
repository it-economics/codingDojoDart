import 'package:test/test.dart';

import '../../bin/kata/FizzBuzz.dart';

void main() {
  final fizzBuzz = FizzBuzz();

  test('If number 3 is calculated -> Fizz', () {
    expect(fizzBuzz.evaluate(3), equals('Fizz'));
  });

  test('If number 33 is calculated -> Fizz', () {
    expect(fizzBuzz.evaluate(33), equals('Fizz'));
  });

  test('If number 5 is calculated -> Buzz', () {
    expect(fizzBuzz.evaluate(5), equals('Buzz'));
  });

  test('If number 15 is calculated -> FizzBuzz', () {
    expect(fizzBuzz.evaluate(15), equals('FizzBuzz'));
  });

  test('If number 56 is calculated -> 56', () {
    expect(fizzBuzz.evaluate(56), equals('56'));
  });

  test('If number 98 is calculated -> 98', () {
    expect(fizzBuzz.evaluate(98), equals('98'));
  });
}