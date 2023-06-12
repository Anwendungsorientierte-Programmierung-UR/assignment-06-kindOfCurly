import 'package:flutter/material.dart';

const List<String> buttonTexts = [
  '(',
  ')',
  'AC',
  '/',
  '7',
  '8',
  '9',
  '*',
  '4',
  '5',
  '6',
  '-',
  '1',
  '2',
  '3',
  '+',
  '0',
  '.',
  '⌫',
  '='
];

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

Widget createCalculatorButton(String buttonText) {
  Color? buttonColor = Colors.grey[900];
  if ('()AC/*-+='.contains(buttonText)) {
    buttonColor = Colors.brown[400];
  }
  return Container(
    margin: const EdgeInsets.all(10),
    child: ElevatedButton(
      onPressed: () => print("Button pressed: $buttonText"),
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: const CircleBorder(),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 35),
      ),
    ),
  );
}

List<Widget> createCalculatorButtons() {
  List<Widget> calculatorButtons = [];

  for (final buttonText in buttonTexts) {
    calculatorButtons.add(createCalculatorButton(buttonText));
  }

  return calculatorButtons;
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          color: Colors.grey[800],
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    "calculation",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Flexible(
                child: Align(
                  alignment: Alignment.topRight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      "solution",
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          children: createCalculatorButtons(),
        ),
      ],
    );
  }
}
