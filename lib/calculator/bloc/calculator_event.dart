part of 'calculator_bloc.dart';

// Handle events from UI and what to process

@immutable
sealed class CalculatorEvent {
  const CalculatorEvent();
}

final class CalculatorNumberPressed extends CalculatorEvent {
  const CalculatorNumberPressed({required this.number});
  final String number;
}

final class CalculatorNumberDeleted extends CalculatorEvent {
  const CalculatorNumberDeleted();
}

final class CalculatorOperationPressed extends CalculatorEvent {
  const CalculatorOperationPressed({required this.operation});
  final String operation;
}

final class CalculatorClearPressed extends CalculatorEvent {
  const CalculatorClearPressed();
  
}

final class CalculatorEqualPressed extends CalculatorEvent {
  const CalculatorEqualPressed();
}
