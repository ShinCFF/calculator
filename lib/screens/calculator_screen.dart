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
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    "0",
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
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: setColorButton(value),
        clipBehavior: Clip.hardEdge,
        shape: const OutlineInputBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(30),
            right: Radius.circular(30),
          ),
          borderSide: BorderSide(
            color: Colors.white54,
          ),
        ),
        child: InkWell(
          onTap: () {},
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color setColorButton(value) {
    return [ButtonValues.del, ButtonValues.clr].contains(value)
        ? Colors.blueGrey
        : [
            ButtonValues.per,
            ButtonValues.multiply,
            ButtonValues.add,
            ButtonValues.subtract,
            ButtonValues.divide,
            ButtonValues.calculate,
          ].contains(value)
            ? Colors.orange
            : Colors.black;
  }
}
