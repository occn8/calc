import 'package:calc/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:calc/providers/theme.dart';
import 'providers/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: false,
        stream: bloc.darkThemeIsEnabled,
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: snapshot.data ? ThemeData.dark() : ThemeData.light(),
            home: new HomePage(snapshot.data, bloc),
          );
        });
  }
}

final bloc = ThemeBloc();

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//     );
//   }
// }
