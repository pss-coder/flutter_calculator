part of 'calculator_bloc.dart';


@immutable
sealed class CalculatorState extends Equatable {
  const CalculatorState(this.number, this.result);

  final String number;
  final String? result;

  @override
  List<Object> get props => [number];
  
}

final class CalculatorDisplayNumber extends CalculatorState {
  const CalculatorDisplayNumber(super.number, super.result);

  @override
  String toString() => 'CalculatorDisplayNumber { number: $number, result: $result }';
}

final class CalculatorDisplayResult extends CalculatorState {
  const CalculatorDisplayResult(super.number, super.result);

  @override
  String toString() => 'CalculatorDisplayResult { number: $number, result: $result }';
}

final class CalculatorDisplayError extends CalculatorState {
  const CalculatorDisplayError(super.number, super.result);

  @override
  String toString() => 'CalculatorDisplayError { number: $number, result: $result }';
}


