import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  Widget customBut(String custText) {
    var butHeight = MediaQuery.of(context).size.height * 0.1;
    var butWidth = MediaQuery.of(context).size.height * 0.11;
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
          // side: BorderSide(
          //     color: Colors.black, width: 1, style: BorderStyle.solid),
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

  Widget customButExp(String custText) {
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
                color: Colors.black, width: 1, style: BorderStyle.solid)),
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

  Widget customButClear(String custText) {
    var butHeight = MediaQuery.of(context).size.height * 0.11;
    var butWidth = MediaQuery.of(context).size.height * 0.12;
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
                color: Colors.black, width: 1, style: BorderStyle.solid)),
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
    Color bgColor = Colors.grey[900];
    // Color cardDisplayColor = Colors.grey[700];
    Color cardColor = Colors.grey[800];

    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            customButClear("C"),
                            customBut("7"),
                            customBut("4"),
                            customBut("1"),
                            customBut(" "),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            customButClear("⌫"),
                            customBut("8"),
                            customBut("5"),
                            customBut("2"),
                            customBut("0"),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            customButExp("%"),
                            customBut("9"),
                            customBut("6"),
                            customBut("3"),
                            customBut("."),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            customButExp("÷"),
                            customButExp("×"),
                            customButExp("-"),
                            customButExp("+"),
                            customButExp("="),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
