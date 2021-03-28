library number_transcriber;

import 'dart:math';

/// A Number to Text Transcriber.
class NumberTranscriber {
  
  /// Returns [value] in Text.
  String transcribe(double value) {
    const conjunction = ' e ';
    const negative = 'menos ';
    const separator = ', ';

    const dictionary = {
      0: 'zero',
      1: 'um',
      2: 'dois',
      3: 'três',
      4: 'quatro',
      5: 'cinco',
      6: 'seis',
      7: 'sete',
      8: 'oito',
      9: 'nove',
      10: 'dez',
      11: 'onze',
      12: 'doze',
      13: 'treze',
      14: 'quatorze',
      15: 'quinze',
      16: 'dezesseis',
      17: 'dezessete',
      18: 'dezoito',
      19: 'dezenove',
      20: 'vinte',
      30: 'trinta',
      40: 'quarenta',
      50: 'cinquenta',
      60: 'sessenta',
      70: 'setenta',
      80: 'oitenta',
      90: 'noventa',
      100: 'cento',
      200: 'duzentos',
      300: 'trezentos',
      400: 'quatrocentos',
      500: 'quinhentos',
      600: 'seiscentos',
      700: 'setecentos',
      800: 'oitocentos',
      900: 'novecentos',
      1000: 'mil',
      1000000: 'milhão',
      1000000000: 'bilhão',
      1000000000000: 'trilhão',
      1000000000000000: 'quatrilhão',
      1000000000000000000: 'quinquilhão'
    };

    const dictionaryPlural = {
      1000000: 'milhões',
      1000000000: 'bilhões',
      1000000000000: 'trilhões',
      1000000000000000: 'quatrilhões',
      1000000000000000000: 'quinquilhões'
    };

    if (value < 0) {
      return negative + transcribe(value.abs());
    }

    String string;

    var valueString = value.toString().split('.');

    var numberString = valueString[0];
    var number = double.parse(numberString);

    var fractionString = valueString.length > 1 ? valueString[1] : "0";
    var fraction = double.parse(fractionString);

    if (value < 21) {
      string = dictionary[value];
    } else if (value < 100) {
      var tens = double.parse(numberString[0]) * 10;
      var units = number % 10;

      string = dictionary[tens];

      if (units != 0) {
        string = string + conjunction + dictionary[units];
      }
    } else if (value < 1000) {
      var hundreds = double.parse(numberString[0]) * 100;
      var remaining = number % 100;

      string = dictionary[hundreds];

      if (remaining != 0) {
        string = string + conjunction + transcribe(remaining);
      }
    } else {
      var numExponent = number.round().toString().length;
      var baseUnit = pow(10, numExponent - 1);

      var remaining;

      if(baseUnit >= 10000) {
        var exponentRemaining = numExponent % 3;

        if (exponentRemaining == 0) {
          exponentRemaining = 3;
        }

        var toTranscriptString = number.round().toString().substring(0, exponentRemaining);

        var baseUnitAbove = pow(10, numExponent - exponentRemaining);
        var toTranscript = double.parse(toTranscriptString);

        remaining = number % baseUnitAbove;

        var transcripted = transcribe(toTranscript);

        if (baseUnit < 1000000) {
          string = '$transcripted ${dictionary[1000]}';
        } else if (baseUnit < 1000000000) {
          string = '$transcripted ${toTranscript > 1 ? dictionaryPlural[1000000] : dictionary[1000000]}';
        } else if (baseUnit < 1000000000000) {
          string = '$transcripted ${toTranscript > 1 ? dictionaryPlural[1000000000] : dictionary[1000000000]}';
        } else if (baseUnit < 1000000000000000) {
          string = '$transcripted ${toTranscript > 1 ? dictionaryPlural[1000000000000] : dictionary[1000000000000]}';
        } else if (baseUnit < 1000000000000000000) {
          string = '$transcripted ${toTranscript > 1 ? dictionaryPlural[1000000000000000] : dictionary[1000000000000000]}';
        } else {
          string = '$transcripted N/S';
        }
      } else {
        var numBaseUnits = double.parse(numberString[0]);
        remaining = number % baseUnit;

        string = '${transcribe(numBaseUnits)} ${dictionary[1000]}';
      }

      if (remaining != 0) {
        if (remaining < 100) {
          string = string + conjunction;
        }
        else {
          string = string + separator;
        }

        string = string + transcribe(remaining);
      }
    }

    if (fraction != null && fraction > 0) {
      string = string + conjunction;

      if (fraction < 21) {
        string = string + dictionary[fraction];
      } else {
        var tens = double.parse(fractionString[0]) * 10;
        var units = fraction % 10;

        var _fractionString = dictionary[tens];

        if (units != 0) {
          string = string + _fractionString + conjunction + dictionary[units];
        }
      }
    }

    return string;
  }
}
