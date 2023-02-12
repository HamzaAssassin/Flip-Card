import 'dart:math';

import 'package:flutter/material.dart';

import 'transform_practice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     // home: const MyHomePage()
     home:const TranformPractice(
        urlFront: "asssets/images/frontcard.jpg",
        urlBack: "asssets/images/backcard.jpg",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animationUpperBun;
  late Animation<Offset> _animationOnion;
  late Animation<Offset> _animationCheese;
  late Animation<Offset> _animationBurgerPatties;
  late Animation<Offset> _animationBottomBun;
  late Animation<double> _animationBurger;
  late Tween<Offset> _tweenUpperBun;
  late Tween<Offset> _tweenBottomBun;
  late Tween<Offset> _tweenBurgerPatties;
  late Tween<Offset> _tweenOnion;
  late Tween<Offset> _tweenCheese;
  late Tween<double> _tweenBuger;

  @override
  void initState() {
    super.initState();
    _tweenUpperBun =
        Tween<Offset>(begin: const Offset(0, -6), end: Offset.zero);
    _tweenBottomBun =
        Tween<Offset>(begin: const Offset(0, -20), end: Offset.zero);
    _tweenBurgerPatties =
        Tween<Offset>(begin: const Offset(0, -15), end: Offset.zero);
    _tweenOnion = Tween<Offset>(begin: const Offset(0, -12), end: Offset.zero);
    _tweenCheese = Tween<Offset>(begin: const Offset(0, -9), end: Offset.zero);
    _tweenBuger = Tween<double>(begin: 0, end: 6.0);

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    _animationBottomBun = _tweenBottomBun.animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0,
          0.2,
        )));
    _animationBurgerPatties = _tweenBurgerPatties.animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.4)));
    _animationCheese = _tweenCheese.animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.6)));
    _animationOnion = _tweenOnion.animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.8)));
    _animationUpperBun = _tweenUpperBun.animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.8,
          1,
        )));
    _animationBurger = _tweenBuger
        .animate(CurvedAnimation(parent: _controller, curve: Curves.elasticInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SlideTransition(
              position: _animationUpperBun,
              child: Container(
                width: width * 0.5,
                height: height * 0.07,
                child: RotationTransition(
                  turns: _animationBurger,
                  child: Image.asset(
                    "asssets/images/upperbun.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SlideTransition(
              position: _animationOnion,
              child: Container(
                width: width * 0.5,
                height: height * 0.07,
                child: Image.asset(
                  "asssets/images/oniion.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SlideTransition(
              position: _animationCheese,
              child: Container(
                width: width * 0.5,
                height: height * 0.07,
                child: Image.asset(
                  "asssets/images/cheese.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SlideTransition(
              position: _animationBurgerPatties,
              child: Container(
                width: width * 0.5,
                height: height * 0.07,
                child: Image.asset(
                  "asssets/images/burgerpatties.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SlideTransition(
              position: _animationBottomBun,
              child: Container(
                width: width * 0.5,
                height: height * 0.1,
                
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(45 / 180 * pi),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "asssets/images/hamburger-bun-png.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
