import 'package:calculator/screens/top_title.dart';
import 'package:calculator/system/buttons.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number_1 = "";
  String number_2 = "";
  String operand = "";

  @override
  Widget build(BuildContext context) {
    final screeenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const TopTitle(title: 'Calculator'),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    "$number_1$operand$number_2".isEmpty
                        ? "0"
                        : "$number_1$operand$number_2",
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w400,
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
            left: Radius.circular(40),
            right: Radius.circular(40),
          ),
          borderSide: BorderSide(),
        ),
        child: InkWell(
          onTap: () => onTap(value),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTap(String value) {
    switch (value) {
      case ButtonValues.del:
        delete();
        return;
      case ButtonValues.equal:
        calculate();
        return;
      case ButtonValues.clr:
        clearAll();
        return;
      case ButtonValues.percent:
        convetToPercentage();
        return;
    }
    append(value);
  }

  void calculate() {
    if (number_1.isEmpty || number_2.isEmpty || operand.isEmpty) {
      return;
    }

    final double temp_1 = double.parse(number_1);
    final double temp_2 = double.parse(number_2);

    var res = 0.0;
    switch (operand) {
      case ButtonValues.add:
        res = temp_1 + temp_2;
        break;
      case ButtonValues.subtract:
        res = temp_1 - temp_2;
        break;
      case ButtonValues.multiply:
        res = temp_1 * temp_2;
        break;
      case ButtonValues.divide:
        res = temp_1 / temp_2;
        break;
      default:
    }

    setState(() {
      number_1 = res.toStringAsPrecision(3);
      if (number_1.endsWith(".0")) {
        while (number_1.endsWith("0")) {
          number_1 = number_1.substring(0, number_1.length - 1);
        }
        number_1 = number_1.substring(0, number_1.length - 1);
      }
      operand = number_2 = "";
    });
  }

  void append(String value) {
    if (value != ButtonValues.dot && int.tryParse(value) == null) {
      if (number_1.isNotEmpty || operand.isNotEmpty) {
        calculate();
      }
      operand = value;
    } else if (number_1.isEmpty || operand.isEmpty) {
      if (value == ButtonValues.dot && number_1.contains(ButtonValues.dot)) {
        return;
      }
      if (value == ButtonValues.dot && (number_1.isEmpty || number_1 == "0")) {
        value = "0.";
      }
      if ((value == ButtonValues.n0 || value == ButtonValues.n00) &&
          number_1.isEmpty) {
      } else {
        number_1 += value;
      }
    } else if (number_2.isEmpty || operand.isNotEmpty) {
      if (value == ButtonValues.dot && number_2.contains(ButtonValues.dot)) {
        return;
      }
      if (value == ButtonValues.dot && (number_2.isEmpty || number_2 == "0")) {
        value = "0.";
      }
      if ((value == ButtonValues.n0 || value == ButtonValues.n00) &&
          number_2.isEmpty) {
      } else {
        number_2 += value;
      }
    }
    setState(() {});
  }

  void convetToPercentage() {
    calculate();
    if (operand.isNotEmpty) {
      return;
    }
    setState(() {
      number_1 = "${(double.parse(number_1) / 100)}";
      operand = number_2 = "";
    });
  }

  void clearAll() {
    setState(() {
      number_1 = operand = number_2 = "";
    });
  }

  void delete() {
    if (number_2.isNotEmpty) {
      number_2 = number_2.substring(0, number_2.length - 1);
    } else if (operand.isNotEmpty) {
      operand = operand.substring(0, operand.length - 1);
    } else if (number_1.isNotEmpty) {
      number_1 = number_1.substring(0, number_1.length - 1);
    }
    setState(() {});
  }

  Color setColorButton(value) {
    return [ButtonValues.del, ButtonValues.clr].contains(value)
        ? Colors.blueGrey
        : [
            ButtonValues.percent,
            ButtonValues.multiply,
            ButtonValues.add,
            ButtonValues.subtract,
            ButtonValues.divide,
            ButtonValues.equal,
          ].contains(value)
            ? Colors.orange
            : Colors.black;
  }
}
