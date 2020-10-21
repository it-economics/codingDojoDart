import 'package:test/test.dart';

import '../../bin/kata/Primes.dart';

void main() {
  var primes = Primes();

  var parameters = {
    3: true,
    5: true,
    2: true,
    15: false,
    21: false,
    100: false,
    997: true
  };

  parameters.forEach((input, expectation) {
    test('${input}  -> is prime number: ${expectation}', () {
      expect(primes.isPrime(input), expectation);
    });
  });
}