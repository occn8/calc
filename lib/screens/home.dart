import 'package:calc/providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatelessWidget {
  final bool isDarkThemeEnabled;
  final ThemeBloc bloc;

  HomePage(this.isDarkThemeEnabled, this.bloc);
  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.grey[900];
    return Scaffold(
      backgroundColor: bgColor,
      body: Calculator(),
      drawer: Container(
        color: Theme.of(context).cardColor,
        width: 250,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Dark Theme"),
              trailing: Switch(
                  value: isDarkThemeEnabled, onChanged: bloc.changeTheTheme),
            )
          ],
        ),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String custText) {
    setState(() {
      if (custText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (custText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (custText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = custText;
        } else {
          equation = equation + custText;
        }
      }
    });
  }

  Widget customButton(String custText) {
    var butHeight = MediaQuery.of(context).size.height * 0.1;
    var butWidth = MediaQuery.of(context).size.height * 0.115;
    Color butColor = Colors.grey[700];
    return Container(
      height: butHeight,
      width: butWidth,
      margin: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: butColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(10.0),
        onPressed: () => buttonPressed(custText),
        child: Text(
          custText,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  Widget customButtonExp(String custText) {
    var butHeight = MediaQuery.of(context).size.height * 0.11;
    var butWidth = MediaQuery.of(context).size.height * 0.12;
    Color butColor = Colors.white70;
    return Container(
      height: butHeight,
      width: butWidth,
      decoration: BoxDecoration(
        color: butColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              color: Colors.black, width: 1, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.all(10.0),
        onPressed: () => buttonPressed(custText),
        child: Text(
          custText,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
              color: Colors.teal),
        ),
      ),
    );
  }

  Widget customButtonClear(String custText) {
    var butHeight = MediaQuery.of(context).size.height * 0.11;
    var butWidth = MediaQuery.of(context).size.height * 0.125;
    Color butColor = Colors.orange[600];
    return Container(
      height: butHeight,
      width: butWidth,
      decoration: BoxDecoration(
        color: butColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              color: Colors.transparent, width: 1, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.all(10.0),
        onPressed: () => buttonPressed(custText),
        child: Text(
          custText,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    // Color cardDisplayColor = Colors.grey[700];
    Color cardColor = Colors.grey[800];

    return Container(
      height: _height,
      width: _width,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              width: _width,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Text(
                              equation,
                              style: TextStyle(
                                  fontSize: equationFontSize,
                                  color: Colors.grey[400]),
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                            child: Text(
                              result,
                              style: TextStyle(
                                  fontSize: resultFontSize,
                                  color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              width: _width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        customButtonClear("C"),
                        customButtonClear("⌫"),
                        customButtonExp("%"),
                        customButtonExp("÷"),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        customButton("7"),
                        customButton("8"),
                        customButton("9"),
                        customButtonExp("×"),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        customButton("4"),
                        customButton("5"),
                        customButton("6"),
                        customButtonExp("-"),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        customButton("1"),
                        customButton("2"),
                        customButton("3"),
                        customButtonExp("+"),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        customButton(""),
                        customButton("0"),
                        customButton("."),
                        customButtonExp("="),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
