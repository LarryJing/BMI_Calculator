import 'dart:math';

class Calculator {
  double height;
  double weight;
  double _bmi;

  Calculator(this.height, this.weight);

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String calculateResult() {
    if (_bmi >= 50)
      return 'Morbidly Obese';
    else if (_bmi >= 25)
      return 'Overweight';
    else if (_bmi >= 18.5)
      return 'Normal';
    else
      return 'Underweight';
  }

  String getExplanation() {
    if (_bmi >= 50)
      return 'Lose some weight. You\'re fat.';
    else if (_bmi >= 25)
      return 'Your body weight is higher than normal. Try to eat healthier and exercise more!';
    else if (_bmi >= 18.5)
      return 'Your body weight is normal. Keep doing what you\'re doing!';
    else
      return 'Your body weight is lower than normal. Try to eat more and sleep better!';
  }
}
