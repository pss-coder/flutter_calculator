import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calculator/calculator/calculator.dart';
import 'package:flutter_calculator/simple_bloc_observer.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(const CalculatorApp());
}
