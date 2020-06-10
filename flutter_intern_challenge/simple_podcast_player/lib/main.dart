import 'package:flutter/material.dart';
import 'package:simplepodcastplayer/constants/routing.dart' as routes;
import 'package:simplepodcastplayer/routes/episode_page.dart';
import 'package:simplepodcastplayer/routes/login_page.dart';
import 'package:simplepodcastplayer/routes/main_page.dart';
import 'package:simplepodcastplayer/routes/search_results_page.dart';
import 'package:simplepodcastplayer/routes/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: routes.WELCOME_PAGE,
      routes: <String, WidgetBuilder>{
        routes.WELCOME_PAGE: (BuildContext context) => WelcomePage(),
        routes.LOGIN_PAGE: (BuildContext context) => LoginPage(),
        routes.MAIN_PAGE: (BuildContext context) => MainPage(),
        routes.EPISODE: (BuildContext context) => Episode(),
        routes.SEARCH_RESULTS: (BuildContext context) => SearchResults(),
      },
    );
  }
}
