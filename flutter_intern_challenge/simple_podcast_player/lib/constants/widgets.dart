import 'package:simplepodcastplayer/constants/header_clipper.dart';
import 'package:simplepodcastplayer/constants/styling.dart';
import 'package:flutter/material.dart';
import 'styling.dart' as styling;
import 'image_location.dart' as images;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

AppBar KAppBar = AppBar(
  elevation: kAppBarElevation,
  title: Text('Simply Podcast'),
);

const BoxDecoration kContainerRoundEdges = BoxDecoration(
  borderRadius: BorderRadius.all(
    (Radius.circular(100)),
  ),
);
Widget waitingWidget() {
  return Column(
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Container(),
      ),
      Expanded(
          child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomCenter,
            child: Hero(
              tag: images.LOGO,
              child: SvgPicture.asset(images.LOGO),
            ),
          ),
          Container(
            child: SpinKitThreeBounce(
              size: 25,
              color: styling.MAIN_ICON_COLOR,
            ),
          ),
        ],
      ))
    ],
  );
}

Widget getErrorWidget(String errorMessage) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Image.asset(images.ERROR),
          ),
        ),
        Expanded(
          child: Container(
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: styling.kHeaderStyling.copyWith(
                fontFamily: 'Mono',
                fontSize: 20,
                color: Colors.black,
                shadows: [styling.kShadowGrey],
              ),
            ),
          ),
        )
      ],
    ),
  );
}

const InputDecoration kTextFieldDecoration = InputDecoration(
    hintText: 'Fill in',
    hintStyle: TextStyle(
      color: Colors.lightBlueAccent,
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
        borderRadius: BorderRadius.all((Radius.circular(32.0)))),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
        borderRadius: BorderRadius.all((Radius.circular(32.0)))));
Container gradientContainer(Color color, Widget child) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color, color.withOpacity(.5)],
      ),
    ),
    child: child,
  );
}

class TopToBottomBlueCutOut extends StatelessWidget {
  final Widget child;
  // This class allows for the rounded clip. If it doesn't have a child
  // then it will just return clip, otherwise if it does have a child it
  // will the clip with the information

  TopToBottomBlueCutOut({@required this.child});

  Widget ClipAndInformation(BuildContext context) {
    if (child == null) {
      return ClipPath(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.lightBlueAccent, Colors.blueAccent],
            ),
          ),
        ),
        clipper: HeadClipper(),
      );
    } else {
      return ClipPath(
        child: Container(
          child: child,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.lightBlueAccent, Colors.blueAccent],
            ),
          ),
        ),
        clipper: HeadClipper(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipShadowPath(
        shadow: Shadow(
            blurRadius: 10.0, color: Colors.blueGrey, offset: Offset(5.0, 5.0)),
        clipper: HeadClipper(),
        child: ClipAndInformation(context));
  }
}

// This is not my code
// Source: https://gist.github.com/coman3/e631fd55cd9cdf9bd4efe8ecfdbb85a7
// Author: coman3

@immutable
class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  ClipShadowPath({
    @required this.shadow,
    @required this.clipper,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      key: UniqueKey(),
      painter: _ClipShadowShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipPath(child: child, clipper: this.clipper),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
