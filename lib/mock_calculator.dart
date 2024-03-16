import 'package:flutter/material.dart';

class MockCalculator extends StatefulWidget {
  @override
  _MockCalculatorState createState() => _MockCalculatorState();
}

class _MockCalculatorState extends State<MockCalculator> {
  String _output = "0";
  String _outputFull = "";
  String _operand = "";
  double _num1 = 0.0;
  double _num2 = 0.0;

  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _num1 = 0.0;
      _num2 = 0.0;
      _operand = "";
      _output = "0";
      _outputFull = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
      _num1 = double.parse(_output);
      _operand = buttonText;
      _outputFull = _outputFull + buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        print("Already contains a decimals");
        return;
      } else {
        _output = _output + buttonText;
        _outputFull = _outputFull + buttonText;
      }
    } else if (buttonText == "=") {
      _num2 = double.parse(_output);

      if (_operand == "+") {
        _output = (_num1 + _num2).toString();
      }
      if (_operand == "-") {
        _output = (_num1 - _num2).toString();
      }
      if (_operand == "*") {
        _output = (_num1 * _num2).toString();
      }
      if (_operand == "/") {
        _output = (_num1 / _num2).toString();
      }

      _num1 = 0.0;
      _num2 = 0.0;
      _operand = "";
      _outputFull = _output;
    } else {
      _output = _output == "0" ? buttonText : _output + buttonText;
      _outputFull = _outputFull == "0" ? buttonText : _outputFull + buttonText;
    }

    setState(() {
      _output = _output;
      _outputFull = _outputFull;
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(24.0),
        ),
        child: Text(buttonText,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        child: Column(children: <Widget>[
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(_outputFull, style: TextStyle(fontSize: 48.0))),
          Expanded(child: Divider()),
          Column(children: [
            Row(children: [
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("/")
            ]),
            Row(children: [
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("*")
            ]),
            Row(children: [
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("-")
            ]),
            Row(children: [
              buildButton("."),
              buildButton("0"),
              buildButton("00"),
              buildButton("+")
            ]),
            Row(children: [
              buildButton("CLEAR"),
              buildButton("=")
            ])
          ])
        ]),
      ),
    );
  }
}
