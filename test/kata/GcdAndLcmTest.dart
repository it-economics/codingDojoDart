import 'package:test/test.dart';

import '../../bin/kata/GcdAndLcm.dart';

void main() {
  final gcdAndLcm = GcdAndLcm();

  test('When determineGCD 15, 5  -> 5', () {
    expect(gcdAndLcm.determineGCD(15, 5), 5);
  });

  test('When determineGCD 15, 10  -> 5', () {
    expect(gcdAndLcm.determineGCD(15, 5), 5);
  });

  test('When determineGCD 0, 5  -> 5', () {
    expect(gcdAndLcm.determineGCD(0, 5), 5);
  });

  test('When determineGCD 5, 0  -> 5', () {
    expect(gcdAndLcm.determineGCD(5, 0), 5);
  });

  test('When determineLowestCommonMultiple 43, 13  -> 5', () {
    expect(gcdAndLcm.determineLowestCommonMultiple(43, 13), 559);
  });

}