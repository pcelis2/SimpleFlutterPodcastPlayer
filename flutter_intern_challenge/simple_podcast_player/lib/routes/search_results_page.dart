import 'package:flutter/material.dart';
import 'package:simplepodcastplayer/models/podcast_model.dart';
import 'package:simplepodcastplayer/services/podcast_service.dart';
import 'package:simplepodcastplayer/constants/widgets.dart' as widgets;
import 'package:simplepodcastplayer/constants/image_location.dart' as images;
import 'package:simplepodcastplayer/constants/styling.dart' as styling;

class SearchResults extends StatefulWidget {
  final PodcastService podcastService;
  final String searchTerm;
  SearchResults({@required this.podcastService, @required this.searchTerm});
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  Future<List<PodcastModel>> listOfPodcasts;
  @override
  void initState() {
    // TODO: implement initState
    //loads the list of podcast asynchronously at initialization
    listOfPodcasts = this
        .widget
        .podcastService
        .getListOfPodcastWithSearch(this.widget.searchTerm);

    super.initState();
  }

//This is a stack, there is background and then a foreground, i.e., Scaffold.
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Search results for ' + this.widget.searchTerm),
          ),
          body: SafeArea(
            child: FutureBuilder(
              future: listOfPodcasts,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                //Meanwhile data is being fetched provide a loading animation
                //once finished will display relevant page.
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return widgets.waitingWidget();
                  case ConnectionState.done:
                    return getListPage(snapshot.data);
                  default:
                    return Text('Default');
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Widget background() {
    return widgets.gradientContainer(Colors.lightBlueAccent, null);
  }

  Widget getListPage(List<PodcastModel> podcasts) {
    // if the returned list, display an error page that the search came back empty
    // else display the list
    if (podcasts == null || podcasts.isEmpty) {
      return widgets.getErrorWidget('No results, consider a new search?');
    }

    return getListOfResults(podcasts);
  }

  Widget getListOfResults(List<PodcastModel> podcasts) {
    //returns a list view, the individual cells are a list of search results
    return Container(
      margin: const EdgeInsets.only(top: 2),
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        // to make sure that we are in bounds
        itemCount: podcasts.length - 1,
        itemBuilder: (BuildContext context, int index) {
          // to make sure that we do not repeat the featured podcast
          PodcastModel podcast = podcasts[index + 1];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              elevation: styling.kBrandingElevation,
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
    );
  }
}
