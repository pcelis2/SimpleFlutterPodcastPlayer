import 'package:flutter/material.dart';
import 'package:simplepodcastplayer/models/podcast_model.dart';

class Episode extends StatefulWidget {
  final PodcastModel podcastEpisode;
  Episode({@required this.podcastEpisode});
  @override
  _EpisodeState createState() => _EpisodeState();
}

class _EpisodeState extends State<Episode> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
