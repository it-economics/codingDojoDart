import 'dart:convert';
import 'dart:io' as io;

const instruction = {
  62: Instruction.INCR_PTR, // >
  60: Instruction.DECR_PTR, // <
  43: Instruction.INCR_MEM, // +
  45: Instruction.DECR_MEM, // -
  46: Instruction.WMEM, // .
  44: Instruction.RMEM, // ,
  91: Instruction.LSTART, // [
  93: Instruction.LEND // ]
};

enum Instruction {
  INCR_PTR,
  DECR_PTR,
  INCR_MEM,
  DECR_MEM,
  WMEM,
  RMEM,
  LSTART,
  LEND,
}

// hello world
// ++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.+++.

void main() {
  io.stdout.writeln('Please input a brainfuck program or file containing it: ');
  var input = '';
  var interpreter = BrainfuckInterpreter();
  while (true) {
    input = _promptInput();
    if (input == 'exit') {
      break;
    }

    if (interpreter.isBrainfuck(input)) {
      interpreter.execute(input);
    } else {
      var fileInput = _readFile(input);
      if (fileInput == null) {
        print('File not found');
      } else {
        interpreter.execute(fileInput);
      }
    }
  }
}

String _promptInput() {
  io.stdout.write('|> ');
  return io.stdin.readLineSync();
}

String _readFile(String fileName) {
  var file = io.File(fileName);

  if (!file.existsSync()) {
    return null;
  }
  return file.readAsStringSync(encoding: Encoding.getByName('ASCII'));
}

class BrainfuckInterpreter {
  bool isBrainfuck(String input) =>
      RegExp(r'^(>|<|\+|-|\.|,|\[|\])+$').hasMatch(input);

  void execute(String input) {
    var mem = Memory();
    var stack = LoopStack();
    var progPtr = 0;
    var prog = _parse(input);

    while (progPtr < prog.length) {
      switch (prog[progPtr]) {
        case Instruction.INCR_MEM:
          mem.incrementValue();
          progPtr++;
          break;
        case Instruction.DECR_MEM:
          mem.decrementValue();
          progPtr++;
          break;
        case Instruction.INCR_PTR:
          mem.incrementPointer();
          progPtr++;
          break;
        case Instruction.DECR_PTR:
          mem.decrementPointer();
          progPtr++;
          break;
        case Instruction.WMEM:
          io.stdout.writeCharCode(mem.get());
          progPtr++;
          break;
        case Instruction.RMEM:
          mem.put(io.stdin.readByteSync());
          progPtr++;
          break;
        case Instruction.LEND:
          if (mem.get() == 0) {
            progPtr++;
          } else {
            progPtr = stack.getStart() + 1;
          }
          break;
        case Instruction.LSTART:
          if (mem.get() == 0) {
            progPtr = _findLend(progPtr + 1, prog) + 1;
          } else {
            stack.start(progPtr);
            progPtr++;
          }

          break;
      }
    }
    io.stdout.writeln();
  }

  List<Instruction> _parse(String input) {
    var prog = <Instruction>[];

    var total = input.length;
    var actualInstructions = 0;

    io.stdout.write('Total   : ');
    for (var i = 0; i < 100; i++) {
      io.stdout.write('-');
    }
    io.stdout.writeln();
    io.stdout.write('Progress: ');

    for (var code in input.codeUnits) {
      var instr = instruction[code];
      if (instr != null) {
        prog.add(instr);
        actualInstructions++;
      }
    }

    io.stdout.writeln();
    io.stdout.writeln(
        'Done Parsing: $total characters, instructions: $actualInstructions');
    return prog;
  }

  int _findLend(int progPtr, List<Instruction> prog) {
    var lstarts = 0;
    for (var i = progPtr; i < prog.length; i++) {
      var instr = prog[i];
      if (instr == Instruction.LEND) {
        if (lstarts == 0) {
          return i;
        } else {
          lstarts--;
        }
      } else if (instr == Instruction.LSTART) {
        lstarts++;
      }
    }

    throw Error();
  }
}

class Memory {
  var positiveSpace = <int>[];
  var negativeSpace = <int>[];
  var pointer = 0;

  Memory() {
    positiveSpace.add(0);
    negativeSpace.add(0);
  }

  void incrementPointer() {
    pointer += 1;
    if (pointer >= 0 && pointer >= positiveSpace.length) {
      positiveSpace.add(0);
    }
  }

  void decrementPointer() {
    pointer -= 1;
    if (pointer < 0 && pointer.abs() > negativeSpace.length) {
      negativeSpace.add(0);
    }
  }

  void incrementValue() {
    _addAtPtrPos(1);
  }

  void decrementValue() {
    _addAtPtrPos(-1);
  }

  int get() {
    return pointer >= 0
        ? positiveSpace[pointer]
        : negativeSpace[pointer.abs() - 1];
  }

  void put(int val) {
    if (pointer >= 0) {
      positiveSpace[pointer] = val;
    } else {
      negativeSpace[pointer.abs() - 1] = val;
    }
  }

  void _addAtPtrPos(int val) {
    if (pointer >= 0) {
      positiveSpace[pointer] += val;
    } else {
      negativeSpace[pointer.abs() - 1] += val;
    }
  }
}

class LoopStack {
  var stack = <int>[];

  void start(int programIndex) => stack.add(programIndex);

  int getStart() => stack.last;

  int end() => stack.removeLast();
}