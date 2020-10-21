final tool = Primes();

void main() {
  var primes = [1, for (var i = 2; i < 1000; i++) tool.isPrime(i) ? i : null];
  primes.removeWhere((element) => element == null);
  primes.forEach((el) => {print(el?.toString())});
}

class Primes {
  bool isPrime(int number) {
    if (number == 2) {
      return true;
    }
    if (number % 2 == 0) {
      return false;
    }
    for (var i = 3; i < number / 2; i++) {
      if (number % i == 0) {
        return false;
      }
    }
    return true;
  }
}