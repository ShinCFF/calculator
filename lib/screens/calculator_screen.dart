import 'package:calculator/screens/buttons.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    final screeenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    "00000000100000",
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            Wrap(
              children: ButtonValues.buttonValues
                  .map(
                    (value) => SizedBox(
                      width: screeenSize.width / 4,
                      height: screeenSize.width / 5,
                      child: buildButton(value),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(value) {
    return Text(value);
  }
}
