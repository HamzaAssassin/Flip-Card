import 'dart:math';

import 'package:flutter/material.dart';

class TranformPractice extends StatefulWidget {
  final String urlFront;
  final String urlBack;
  const TranformPractice(
      {required this.urlFront, required this.urlBack, super.key});
  @override
  State<TranformPractice> createState() => _TranformPracticeState();
}

class _TranformPracticeState extends State<TranformPractice>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double verticalDrag = 0;
  bool isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: GestureDetector(
            onHorizontalDragStart: (details) {
              _controller.reset();
              setState(() {
                isFront = true;
                verticalDrag = 0;
              });
            },
            onHorizontalDragUpdate: (details) {
              setState(() {
                verticalDrag += details.delta.dx;
                verticalDrag %= 360;

                setImageSide();
              });
            },
            onHorizontalDragEnd: (details) {
              final double end = 360 - verticalDrag >= 180 ? 0 : 360;
              _animation = Tween<double>(begin: verticalDrag, end: end)
                  .animate(_controller)
                ..addListener(() {
                  setState(() {
                    verticalDrag = _animation.value;
                    setImageSide();
                  });
                });
              _controller.forward();
            },
            child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(verticalDrag / 180 * pi),
                alignment: Alignment.center,
                child: isFront
                    ? Image.asset(
                        widget.urlFront,
                        height: height * 0.8,
                        width: width * 0.8,
                      )
                    : Transform(
                        transform: Matrix4.identity(),
                        alignment: Alignment.center,
                        child: Image.asset(
                          widget.urlBack,
                          height: height * 0.8,
                          width: width * 0.8,
                        ))),
          ),
        ),
      ),
    );
  }

  void setImageSide() {
    if (verticalDrag <= 90 || verticalDrag >= 270) {
      isFront = true;
    } else {
      isFront = false;
    }
  }
}
