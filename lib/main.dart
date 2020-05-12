import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Cost Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  _MyFuelFormState createState() => _MyFuelFormState();
}

class _MyFuelFormState extends State<FuelForm> {
  String result = '';
  final _currencies = ['Dollars', 'Euro', 'Pounds', 'Yen'];
  String currency = 'Dollars';
  final double _formDistance = 15.0;
  TextEditingController distanceController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(top: _formDistance, bottom: _formDistance),
              child: TextField(
                controller: distanceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    hintText: "e.g. 124",
                    labelStyle: Theme.of(context).textTheme.title,
                    labelText: 'Distance'),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: _formDistance, bottom: _formDistance),
              child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    hintText: "e.g. 17",
                    labelStyle: Theme.of(context).textTheme.title,
                    labelText: 'Distance per unit'),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: _formDistance, bottom: _formDistance),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: avgController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          hintText: "e.g. 1.65",
                          labelStyle: Theme.of(context).textTheme.title,
                          labelText: 'Price'),
                    ),
                  ),
                  Container(
                    width: 2 * _formDistance,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      value: currency,
                      onChanged: (String value) {
                        onDropDownChanged(value);
                      },
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        result = _calculate();
                      });
                    },
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      'Submit',
                      textScaleFactor: 1.5,
                    ),
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        _reset();
                      });
                    },
                    textColor: Theme.of(context).primaryColorDark,
                    child: Text(
                      'Reset',
                      textScaleFactor: 1.5,
                    ),
                    color: Theme.of(context).buttonColor,
                  ),
                )
              ],
            ),
            Text(result)
          ],
        ),
      ),
    );
  }

  void _reset() {
    distanceController.text="";
    avgController.text="";
    priceController.text="";
    result = '';
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _fuelCost = double.parse(priceController.text);
    double _consumption = double.parse(avgController.text);
    double _totalCost = (_distance / _consumption) * _fuelCost;
    return 'The total cost for your trip is ' +
        _totalCost.toStringAsFixed(2) +
        " " +
        currency;
  }

  void onDropDownChanged(String value) {
    setState(() {
      currency = value;
    });
  }
}
