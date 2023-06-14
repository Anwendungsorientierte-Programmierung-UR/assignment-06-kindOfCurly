import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

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

class _CalculatorState extends State<Calculator> {
  Parser parser = Parser();
  ContextModel contextModel = ContextModel();

  String currentCalculation = '';
  String currentSolution = '';

  TextStyle textStyleCurrentCalculation =
      const TextStyle(fontSize: 50, fontWeight: FontWeight.bold);

  void solve() {
    try {
      Expression expression = parser.parse(currentCalculation);
      dynamic result = expression.evaluate(EvaluationType.REAL, contextModel);
      // double to int
      if (result % 1 == 0) {
        result = result.toInt();
      }

      setState(() {
        currentSolution = result.toString();
      });
    } catch (error) {
      displayError(error.toString());
    }
  }

  void displayError(String errorMessage) {
    setState(() {
      currentSolution = errorMessage;
    });
  }

  void deleteLastInput() {
    if (currentCalculation.isNotEmpty) {
      setState(() {
        currentSolution = '';
        currentCalculation =
            currentCalculation.substring(0, currentCalculation.length - 1);
      });
    }
  }

  void clearAll() {
    setState(() {
      currentCalculation = '';
      currentSolution = '';
    });
  }

  void addNewChar(String char) {
    calculateMaxCharacterCount(context, textStyleCurrentCalculation);
    setState(() {
      currentCalculation += char;
    });
  }

  int calculateMaxCharacterCount(BuildContext context, TextStyle style) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final double maxWidth = renderBox.size.width;

    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: 'A', style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    final double characterWidth = textPainter.width;
    final int maxCharacterCount = (maxWidth / characterWidth).floor();

    return maxCharacterCount;
  }

  void onCalculatorButtonPressed(String buttonText) {
    if (buttonText == '=') {
      solve();
    } else if (buttonText == 'AC') {
      clearAll();
    } else if (buttonText == '⌫') {
      deleteLastInput();
    } else {
      addNewChar(buttonText);
    }
  }

  Widget createCalculatorButton(String buttonText) {
    Color? buttonColor = Colors.grey[900];
    if ('()AC/*-+='.contains(buttonText)) {
      buttonColor = Colors.brown[400];
    }
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () => onCalculatorButtonPressed(buttonText),
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
                    currentCalculation,
                    style: const TextStyle(
                        fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Flexible(
                child: Align(
                  alignment: Alignment.topRight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      currentSolution,
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
