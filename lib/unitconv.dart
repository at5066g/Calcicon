import 'package:flutter/material.dart';

void main() => runApp(UnitConverterApp());

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      home: UnitConverter(),
    );
  }
}

class UnitConverter extends StatefulWidget {
  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  double inputValue = 0.0;
  String fromUnit = 'Meters';
  String toUnit = 'Feet';
  double convertedValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade200, Colors.blue.shade400],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Value',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                  ),
                  onChanged: (value) {
                    setState(() {
                      inputValue = double.tryParse(value) ?? 0.0;
                      // No need to call convertUnits here; do it when the user presses the Submit button.
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('From Unit: ',
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                  DropdownButton<String>(
                    value: fromUnit,
                    items: getUnitsList(),
                    onChanged: (value) {
                      setState(() {
                        fromUnit = value.toString();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('To Unit: ',
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                  DropdownButton<String>(
                    value: toUnit,
                    items: getUnitsList(),
                    onChanged: (value) {
                      setState(() {
                        toUnit = value.toString();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Result: ${convertedValue.toStringAsFixed(4)} $toUnit',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (inputValue <= 0.0) {
                    // Show an alert dialog for inappropriate input.
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Invalid Input'),
                          content: Text('Please enter a valid positive value.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Perform the unit conversion.
                    convertUnits();
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getUnitsList() {
    return ['Meters', 'Feet', 'Kilometers', 'Inches', 'Centimeters']
        .map((unit) {
      return DropdownMenuItem<String>(
        value: unit,
        child: Text(unit),
      );
    }).toList();
  }

  void convertUnits() {
    double convertedValue = 0.0;

    switch (fromUnit) {
      case 'Meters':
        switch (toUnit) {
          case 'Meters':
            convertedValue = inputValue;
            break;
          case 'Feet':
            convertedValue = inputValue * 3.28084;
            break;
          case 'Kilometers':
            convertedValue = inputValue * 0.001;
            break;
          case 'Inches':
            convertedValue = inputValue * 39.3701;
            break;
          case 'Centimeters':
            convertedValue = inputValue * 100.0;
            break;
        }
        break;
      case 'Feet':
        switch (toUnit) {
          case 'Meters':
            convertedValue = inputValue / 3.28084;
            break;
          case 'Feet':
            convertedValue = inputValue;
            break;
          case 'Kilometers':
            convertedValue = inputValue / 3280.84;
            break;
          case 'Inches':
            convertedValue = inputValue * 12.0;
            break;
          case 'Centimeters':
            convertedValue = inputValue * 30.48;
            break;
        }
        break;
      case 'Kilometers':
        switch (toUnit) {
          case 'Meters':
            convertedValue = inputValue * 1000.0;
            break;
          case 'Feet':
            convertedValue = inputValue * 3280.84;
            break;
          case 'Kilometers':
            convertedValue = inputValue;
            break;
          case 'Inches':
            convertedValue = inputValue * 39370.1;
            break;
          case 'Centimeters':
            convertedValue = inputValue * 100000.0;
            break;
        }
        break;
      case 'Inches':
        switch (toUnit) {
          case 'Meters':
            convertedValue = inputValue * 0.0254;
            break;
          case 'Feet':
            convertedValue = inputValue * 0.0833333;
            break;
          case 'Kilometers':
            convertedValue = inputValue * 0.0000254;
            break;
          case 'Inches':
            convertedValue = inputValue;
            break;
          case 'Centimeters':
            convertedValue = inputValue * 2.54;
            break;
        }
        break;
      case 'Centimeters':
        switch (toUnit) {
          case 'Meters':
            convertedValue = inputValue * 0.01;
            break;
          case 'Feet':
            convertedValue = inputValue * 0.0328084;
            break;
          case 'Kilometers':
            convertedValue = inputValue * 0.00001;
            break;
          case 'Inches':
            convertedValue = inputValue * 0.393701;
            break;
          case 'Centimeters':
            convertedValue = inputValue;
            break;
        }
        break;
    }
    setState(() {
      this.convertedValue = convertedValue;
    });
  }
}
