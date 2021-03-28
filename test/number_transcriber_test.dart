import 'package:flutter_test/flutter_test.dart';

import 'package:number_transcriber/number_transcriber.dart';

void main() {
  test('adds one to input values', () {
    final calculator = NumberTranscriber();
    expect(calculator.transcribe(2), 'dois');
    expect(() => calculator.transcribe(null), throwsNoSuchMethodError);
  });
}
