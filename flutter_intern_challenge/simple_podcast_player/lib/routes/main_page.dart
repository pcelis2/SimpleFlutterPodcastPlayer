import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simplepodcastplayer/constants/styling.dart' as styling;
import 'package:simplepodcastplayer/constants/widgets.dart' as widgets;
import 'package:simplepodcastplayer/routes/search_results_page.dart';
import 'package:simplepodcastplayer/services/podcast_service.dart';
import 'package:simplepodcastplayer/models/podcast_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<List<PodcastModel>> listOfPodcasts;
  AudioPlayer _assetsAudioPlayer = new AudioPlayer();
  PodcastModel currentPodcast;
  PodcastService podcastService;
  bool isPlaying;
  void fetchData() async {
    listOfPodcasts = podcastService.getMostPopularPodcasts();
  }

  void initState() {
    podcastService = new PodcastService();
    fetchData();
    isPlaying = false;
    super.initState();
  }

  Widget searchBar() {
    return TextField(
      decoration: widgets.kTextFieldDecoration.copyWith(
        hintText: 'Episodes, Shows or topics ',
        prefixIcon: Icon(FontAwesomeIcons.search),
      ),
      onSubmitted: searchTerm,
    );
  }

  void searchTerm(String searchTerm) {
    print(searchTerm);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchResults(
                  podcastService: this.podcastService,
                  searchTerm: searchTerm,
                )));
  }

  void playTrack(PodcastModel podcastModel) {
    this._assetsAudioPlayer.stop();
    this._assetsAudioPlayer.play(podcastModel.audioFeed);
    setState(() {
      this.currentPodcast = podcastModel;
      this.isPlaying = true;
    });
  }

  Widget featuredPodcast(PodcastModel podcast) {
    return FlatButton(
      onPressed: () {
        playTrack(podcast);
      },
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: podcast.image,
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text(
                        podcast.title,
                        style: styling.whiteText.copyWith(fontSize: 20),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        podcast.getFullDescription(),
                        style: styling.whiteText,
                        textAlign: TextAlign.left,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        podcast.dateCreated + '•' + podcast.lengthOfEpisode,
                        style: styling.whiteText,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget displayCuratedList(List<PodcastModel> podcasts) {
    return Column(
      children: <Widget>[
        Expanded(
          // Search bar, portion, takes 2/19 of the screen
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: searchBar(),
          ),
        ),
        Expanded(
          // Featured podcast, takes 6/19 of the screen
          flex: 6,
          child: Card(
            elevation: styling.kBrandingElevation,
            color: Colors.orangeAccent,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Featured',
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Pacifico',
                          color: Colors.white,
                          shadows: [styling.kShadowGrey]),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 1,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: featuredPodcast(podcasts[0]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              (podcasts.length - 1).toString() + ' other podcast just for you',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Expanded(
          // List portion, takes 9/19 of the screen
          flex: 9,
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            // to make sure that we are in bounds
            itemCount: podcasts.length - 1,
            itemBuilder: (BuildContext context, int index) {
              // to make sure that we do not repeat the featured podcast
              PodcastModel podcast = podcasts[index + 1];
              return FlatButton(
                onPressed: () {
                  playTrack(podcast);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListTile(
                    title: Text(podcast.title),
                    subtitle: Text(podcast.getShortDescription()),
                    leading: podcast.image,
                    isThreeLine: true,
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          // music player, takes 2/19
          flex: 2,
          child: widgets.gradientContainer(Colors.orangeAccent, getPlayer()),
        )
      ],
    );
  }

  void togglePlayPausePlayer() {
    if (isPlaying) {
      this._assetsAudioPlayer.pause();
    } else {
      this._assetsAudioPlayer.play(currentPodcast.audioFeed);
    }
    setState(() {
      this.isPlaying = !this.isPlaying;
    });
  }

  Widget getPlayer() {
    if (currentPodcast == null) {
      return Text('Nothing is playing');
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: this.currentPodcast.image,
          ),
          Expanded(
            flex: 4,
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 12.0),
              child: Text(
                this.currentPodcast.title,
                style: styling.whiteText,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              child: FlatButton(
                onPressed: togglePlayPausePlayer,
                child: isPlaying
                    ? Icon(
                        FontAwesomeIcons.playCircle,
                        color: Colors.white,
                      )
                    : Icon(
                        FontAwesomeIcons.pauseCircle,
                        color: Colors.white,
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getMainPage(List<PodcastModel> podcasts) {
    // if error then display error widget
    // else display curated list
    if (podcasts == null || podcasts.isEmpty) {
      return widgets
          .getErrorWidget('An error occurred, we got our best dev on it!');
    }
    return displayCuratedList(podcasts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: listOfPodcasts,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.connectionState);
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return widgets.waitingWidget();
              case ConnectionState.done:
                return getMainPage(snapshot.data);
              default:
                return Text('Default');
            }
          },
        ),
      ),
    );
  }
}
