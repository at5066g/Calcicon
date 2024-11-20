import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'unitconv.dart';
import 'About.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "";
  String _output = "";
  double num1 = 0;
  double num2 = 0;
  String operand = "";
  bool opused = false;
  bool decused = false;

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "";
      num1 = 0;
      num2 = 0;
      operand = "";
      opused = false;
      decused = false;
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "×" ||
        buttonText == "÷") {
      if (!opused) {
        opused = true;
        decused = false;
        operand = buttonText;
        _output += " " + buttonText + " ";
      }
    } else if (buttonText == "<") {
      if (_output.isNotEmpty) {
        if (_output.substring(_output.length - 1, _output.length) == " ") {
          _output = _output.substring(0, _output.length - 3);
        } else {
          _output = _output.substring(0, _output.length - 1);
        }
      }
    } else if (buttonText == "=") {
      List<String> str = _output.split(" ");
      if (str.length == 3) {
        num1 = double.parse(str[0]);
        num2 = double.parse(str[2]);
        opused = false;
        decused = false;
        if (operand == "+") {
          _output = (num1 + num2).toString();
        } else if (operand == "-") {
          _output = (num1 - num2).toString();
        } else if (operand == "×") {
          _output = (num1 * num2).toString();
        } else if (operand == "÷") {
          if (num2 != 0) {
            _output = (num1 / num2).toString();
          } else {
            _output = "Error";
          }
        }
        num1 = 0;
        num2 = 0;
        operand = "";
      }
    } else {
      if (buttonText != "<") {
        if (buttonText == "." && decused) {
          // Handle multiple decimal points.
        } else {
          _output += buttonText;
          if (buttonText == ".") {
            decused = true;
          }
        }
      }
    }

    setState(() {
      output = _output;
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
          title: Text(
        'Calculator and Unit Converter App',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      )),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue.shade200, Colors.blue.shade400]),
        ),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Text(
                output,
                style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[buildButton("C"), buildButton('<')],
                ),
                Row(
                  children: <Widget>[
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButton("÷")
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButton("×")
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButton("-")
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("."),
                    buildButton("0"),
                    buildButton("+")
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("="),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThUf2cz9QPRlVz-dDFiVDrYIGcWBo_TTnpAA&usqp=CAU'),
                    fit: BoxFit.fill)),
            child: Text(
              'Menu',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.calculate_outlined),
            title: Text(
              'Calculator',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => Calculator()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.architecture_outlined),
            title: Text('Unit Converter',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => UnitConverter()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text('About',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => PeopleList()),
              );
            },
          ),
        ],
      ),
    );
  }
}
