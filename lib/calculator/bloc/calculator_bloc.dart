import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {

  // initial data
  String userInput;
  String operator = '';

  CalculatorBloc({required this.userInput }) : super(CalculatorDisplayNumber(userInput, null)) {
    //  event Handlers
    on<CalculatorNumberPressed>(_onCalculatorNumberPressed);

    on<CalculatorNumberDeleted>(_onCalculatorNumberDeleted);
    on<CalculatorClearPressed>(_onCalculatorClearPressed);
    
    // on<CalculatorOperationPressed>(_onCalculatorOperationPressed);
    on<CalculatorEqualPressed>(_onCalculatorEqualPressed);
  }

  void _onCalculatorEqualPressed(CalculatorEqualPressed event, Emitter<CalculatorState> emit) {
    // here we do the evaluation
    Parser p = Parser();
    Expression exp = p.parse(userInput);
    ContextModel cm = ContextModel();
    String eval = exp.evaluate(EvaluationType.REAL, cm).toString();
    // update result
    emit(CalculatorDisplayResult(userInput, eval));
    
    // update UserInput after emitting, to update history?
    userInput = eval;
  }

  void _onCalculatorClearPressed(CalculatorClearPressed event, Emitter<CalculatorState> emit){
    // do something here
    if (userInput.isNotEmpty) {
      userInput = '';
    }
     emit(CalculatorDisplayNumber('', null));
  }

  void _onCalculatorNumberDeleted(CalculatorNumberDeleted event, Emitter<CalculatorState> emit) {
    
    if (userInput.isNotEmpty) {
      userInput = userInput.substring(0, userInput.length - 1);
    }
    emit(CalculatorDisplayNumber(userInput, null));
  }

  // On Number Pressed
  void _onCalculatorNumberPressed(CalculatorNumberPressed event, Emitter<CalculatorState> emit) {
    // number pressed
    var numberPressed  = event.number;
    if (userInput.startsWith('0')) {
      userInput = '';
      userInput += numberPressed;
    } else {
      userInput += numberPressed;
    }
    emit(CalculatorDisplayNumber(userInput, null));
  }

}
