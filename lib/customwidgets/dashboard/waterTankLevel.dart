import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/providers/settingsProvider.dart';
import 'package:suf_linux/styles.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' as Vector;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart';

class WaterTankLevel extends StatelessWidget {
  final double fullness;

  //controller for animation
  WaterTankLevel({@required this.fullness});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();

    double _yOffset = (200 / 100) * (100 - fullness);
    int yOffset = _yOffset.round();

    return LayoutBuilder(builder: (context, constraints) {
      Size size = constraints.biggest;
      return Card(
        elevation: cardElavation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        color: theme.cardColor,
        child: Container(
          height: size.height,
          width: size.width - 16,
          child: fullness > 8
              ? Stack(
                  children: [
                    new AnimationBody(
                      size: size,
                      xOffset: 0,
                      yOffset: 5 + yOffset,
                      color: Color(0xFF3f51b5),
                    ),
                    new Opacity(
                      opacity: 0.5,
                      child: new AnimationBody(
                        size: size,
                        xOffset: 80,
                        yOffset: 10 + yOffset,
                        color: Color(0xFF3f51b5),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 4),
                      alignment: Alignment.topCenter,
                      child: Text(
                        "$fullness%",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w100,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  alignment: Alignment.center,
                  child: new Text(
                    "Empty",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
        ),
      );
    });
  }
}

class AnimationBody extends StatefulWidget {
  final Size size;
  final int xOffset;
  final int yOffset;
  final Color color;

  AnimationBody(
      {Key key, @required this.size, this.xOffset, this.yOffset, this.color})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _AnimationBodyState();
  }
}

class _AnimationBodyState extends State<AnimationBody>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<Offset> animList1 = [];

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));

    animationController.addListener(() {
      animList1.clear();
      for (int i = -2 - widget.xOffset;
          i <= widget.size.width.toInt() + 2;
          i++) {
        animList1.add(
          new Offset(
              i.toDouble() + widget.xOffset,
              sin((animationController.value * 360 - i) %
                          360 *
                          Vector.degrees2Radians) *
                      20 +
                  20 +
                  widget.yOffset),
        );
      }
    });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: new AnimatedBuilder(
        animation: new CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
        builder: (context, child) => new ClipPath(
          child: new Container(
            width: widget.size.width,
            height: widget.size.height,
            color: widget.color,
          ),
          clipper:
              new WaveClipper(animationController.value, animList1, context),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animation;

  final BuildContext c;

  List<Offset> waveList1 = [];

  WaveClipper(this.animation, this.waveList1, this.c);

  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.addPolygon(waveList1, false);

    path.lineTo(size.width, size.height - borderRadius);
    path.arcToPoint(Offset(size.width - borderRadius, size.height),
        radius: Radius.circular(borderRadius));
    path.lineTo(borderRadius, size.height);
    path.arcToPoint(Offset(0, size.height - borderRadius),
        radius: Radius.circular(borderRadius));

    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      animation != oldClipper.animation;
}
