import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  // Cat Animation
  Animation<double> catAnimation;
  AnimationController catController;
  // Box Animation
  Animation<double> boxAnimation;
  AnimationController boxController;

  @override
  void initState() {
    super.initState();
// Box ANIMATION
    boxController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    boxAnimation = Tween(begin: 0.0, end: 3.14)
       .animate(
         CurvedAnimation(
           parent: boxController,
           curve: Curves.linear
         )
       );
// Cat ANIMATION
    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    catAnimation = Tween(begin:-35.0, end: -80.0)
       .animate(
         CurvedAnimation(
           parent: catController,
           curve: Curves.easeIn
         )
       );   
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
    } else if (catController.status == AnimationStatus.forward) {
      catController.reverse();
    } else if (catController.status == AnimationStatus.reverse) {
      catController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: [
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap()
            ],
          ),
        ),
        onTap: onTap,
        ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width:  200.0,
      color: Colors.brown
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0, top: 1.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,    
          width: 125.0,
          color: Colors.brown
          ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.topLeft,
            angle: boxAnimation.value
        );
        }
      ),
    );
  }
}