import 'dart:async';
import 'package:flutter/material.dart';
import 'view/mainpage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Georgia',
          textTheme: const TextTheme(
            headline5: TextStyle(fontSize: 20.0),
            bodyText1: TextStyle(
                fontSize: 12.0,
                fontFamily: 'Hind',
                color: Color.fromRGBO(37, 49, 64, 1)),
          ),
        ),
        title: 'Switch Currency Converter',
        home: const Scaffold(body: SplashPage()));
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/splash.png'),
                    fit: BoxFit.cover))),
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 100),
            child: Column(children: const [
              Text("Currency Converter",
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              LinearProgressIndicator(),
              Text(
                "Version 0.1",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ]))
      ],
    );
  }
}
