import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calculator/calculator/bloc/calculator_bloc.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> buttons = [
      'C',
      '+/-',
      '%',
      'DEL',
      '7',
      '8',
      '9',
      '/',
      '4',
      '5',
      '6',
      'x',
      '1',
      '2',
      '3',
      '-',
      '0',
      '.',
      '=',
      '+',
    ];

    return BlocProvider(
      create: (_) => CalculatorBloc(userInput: ''),
      child: CalculatorView(buttons: buttons),
    );
  }
}

class CalculatorView extends StatefulWidget {
  const CalculatorView({
    super.key,
    required this.buttons,
  });

  final List<String> buttons;

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("Calculator App"),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            alignment: Alignment.centerRight,
                            child:
                                Text(state.number), // see what user press
                          ),
                          Container(
                            //TODO: HERE IS WHERE WE PLACE THE STATE DISPLAY, RESULTS AND ERROR
                            padding: const EdgeInsets.all(15),
                            alignment: Alignment.centerRight,
                            child: Text(state.result ?? ''),
                          )
                        ]),
                  ),
                ),
                // numbers/operations
                Expanded(
                  flex: 3,
                  child: Container(
                    child: GridView.builder(
                        itemCount: widget.buttons.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemBuilder: (context, index) {
                          // Clear Button
                          if (index == 0) {
                            return MyButton(
                              buttontapped: () {
                                context
                                  .read<CalculatorBloc>()
                                  .add(const CalculatorClearPressed()); // TODO: IMPLEMENTATION
                              },
                              buttonText: widget.buttons[index],
                              color: Colors.blue[50],
                              textColor: Colors.black,
                            );
                          }

                          // +/- button
                          else if (index == 1) {
                            return MyButton(
                              buttonText: widget.buttons[index],
                              color: Colors.blue[50],
                              textColor: Colors.black,
                            );
                          }
                          // % Button
                          else if (index == 2) {
                            return MyButton(
                              buttontapped: () {},
                              buttonText: widget.buttons[index],
                              color: Colors.blue[50],
                              textColor: Colors.black,
                            );
                          }
                          // Delete Button
                          else if (index == 3) {
                            return MyButton(
                              buttontapped: () {
                                context
                                  .read<CalculatorBloc>()
                                  .add(CalculatorNumberDeleted());
                              },
                              buttonText: widget.buttons[index],
                              color: Colors.blue[50],
                              textColor: Colors.black,
                            );
                          }

                          // Equal  Button
                          else if (index == 18) {
                            return MyButton(
                              buttontapped: () {
                                 context
                                  .read<CalculatorBloc>()
                                  .add(CalculatorEqualPressed());
                              },
                              buttonText: widget.buttons[index],
                              color: Colors.orange[700],
                              textColor: Colors.white,
                            );
                          }

                          // Others :)
                          //TODO: Seperate the operations also ??
                          else {
                            return MyButton(
                              buttontapped: () {
                                // numbers pressed
                                context
                                  .read<CalculatorBloc>()
                                  .add(CalculatorNumberPressed(number: widget.buttons[index]));
                              },
                              buttonText: widget.buttons[index],
                            );
                          }
                        }),
                  ),
                )
              ],
            ));
      },
    );
  }
}

// creating Stateless Widget for buttons
class MyButton extends StatelessWidget {
  // declaring variables
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;

  //Constructor
  MyButton(
      {this.color,
      this.textColor,
      required this.buttonText,
      this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(25),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
