import 'package:flutter/material.dart';
import 'package:simplepodcastplayer/constants/widgets.dart' as widgets;
import 'package:simplepodcastplayer/constants/image_location.dart' as images;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simplepodcastplayer/routes/login_page.dart';
import 'package:simplepodcastplayer/routes/main_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget background() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: widgets.TopToBottomBlueCutOut(
            child: null,
          ),
        ),
        Expanded(
          child: Container(),
        )
      ],
    );
  }

  Widget foreground(context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Hero(
              tag: images.LOGO,
              child: SvgPicture.asset(
                images.LOGO,
                height: 100,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Text(
              'Simply Podcast',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
                shadows: [
                  Shadow(
                      blurRadius: 10.0,
                      color: Colors.orange,
                      offset: Offset(5.0, 5.0))
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.topCenter,
            child: RaisedButton(
              elevation: 10,
              child: Text('get started'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[background(), foreground(context)],
      ),
    );
  }
}
