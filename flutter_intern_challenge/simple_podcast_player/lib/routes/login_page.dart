import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplepodcastplayer/constants/styling.dart' as styling;
import 'package:simplepodcastplayer/constants/widgets.dart' as widgets;
import 'package:simplepodcastplayer/constants/image_location.dart' as images;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  void submit() {}

  Widget loginWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Hero(
              tag: images.LOGO,
              child: SvgPicture.asset(images.LOGO),
            ),
          ),
          Container(
            child: Text(
              'Login',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Pacifico',
                  shadows: [styling.kShadowOrange]),
            ),
          ),
          TextField(
            decoration: widgets.kTextFieldDecoration.copyWith(
                hintText: 'Spotify email',
                prefixIcon: Icon(
                  FontAwesomeIcons.envelope,
                  color: Colors.lightBlueAccent,
                )),
          ),
          TextField(
            decoration: widgets.kTextFieldDecoration.copyWith(
                hintText: 'Spotfiy password',
                prefixIcon: Icon(
                  FontAwesomeIcons.key,
                  color: Colors.lightBlueAccent,
                )),
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              color: Colors.orangeAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0)),
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: submit,
            ),
          )
        ],
      ),
    );
  }

  Widget foreground(context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Expanded(
          flex: 2,
          child: loginWidget(),
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
