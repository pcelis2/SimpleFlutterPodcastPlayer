import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:simplepodcastplayer/models/podcast_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//Default url request for currently most popular podcasts

const String urlRequestCurrentMostPopularPodcasts =
    'https://rss.itunes.apple.com/api/v1/us/podcasts/top-podcasts/all/50/explicit.json';

//The Following are attributes that can be changed

const String ITUNES_FULLY_QUALIFIED_URL = "https://itunes.apple.com/search?";
const String COUNTRY_CODE = "&country=US"; //required
const String MEDIA_TYPE = "&media=podcast";
const String ENTITY_TYPE = "&entity=podcast";
//const String ATTRIBUTE_TYPE = "attribute=titleTerm";
const String LANGUAGE_TYPE = "&lang=en_us";
//TODO: Figure out what callback means
const String CALLBACK = ""; //required
const String LIMIT = "&limit=25";

void main() async {
  PodcastService service = PodcastService();
  List<PodcastModel> results = await service.getMostPopularPodcasts();
  for (PodcastModel entry in results) {
    print(entry.toString());
    print('=======================================');
  }
}

//TODO: it is required to insert a term
class PodcastService {
  List<PodcastModel> curratedList;
  PodcastService() {
    curratedList = new List<PodcastModel>();
    curratedList.add(
      new PodcastModel(
          '1619',
          '\“1619\” is a New York Times audio series, hosted by Nikole Hannah-Jones, that examines the long shadow of American slavery. Listen to the episodes below, or read the transcripts by clicking the icon to the right of the play bar. For more information about the series, visit nytimes.com/1619podcast.',
          'October 11, 2019',
          '36:40',
          Image.network(
              'https://is5-ssl.mzstatic.com/image/thumb/Podcasts123/v4/f6/9e/78/f69e78f7-2d62-141d-66b5-dddece6bfa4d/mza_2095735916194243097.jpeg/200x200bb.png'),
          'https://content.production.cdn.art19.com/validation=1591804413,1fc66803-328c-5668-8b89-8660b5502a45,EXAEDhh-1dRXEWZnYUmq1-BhyB8/episodes/17bdc8f1-733b-400a-9e24-f2a2b72c9217/08c83f975827c03a478e395692773d76600673d6f2dee96af8ee324dc500e5b16aace3cd87bccc8f7f2990a88746e34f31c897f74a936225c22f8b5d973a82cb/20191011%201619%20SUGAR%20PT%202%20-%20BF%20MIX%203%20-%20NO%20ADS-MP3%20320k.mp3'),
    );
    curratedList.add(
      new PodcastModel(
          'The Joe Rogan Experience',
          'Andrew Schulz is a stand up comedian, actor, and host. Check out his podcasts \"Flagrant 2\" & \"The Brilliant Idiots\" co-hosted with Charlamagne tha God.',
          'June 9, 2020',
          '02:56:02',
          Image.network(
              'https://is5-ssl.mzstatic.com/image/thumb/Podcasts113/v4/e5/8a/10/e58a108f-f5d0-f622-c94a-13f66edd570c/mza_3025981348644196724.jpg/200x200bb.png'),
          'https://hwcdn.libsyn.com/p/d/3/9/d39733a6693230bf/p1488.mp3?c_id=75195185&cs_id=75195185&destination_id=19997&expiration=1591754509&hwt=4ddff30266e2f5743a0e332ffd4f7a3d'),
    );
    curratedList.add(
      new PodcastModel(
        'The Daily',
        'This episode contains strong language.\nSeveral major U.S. cities are proposing ways to defund and even dismantle their police departments. But what would that actually look like? Guest: John Eligon, a national correspondent covering race for The New York Times. For more information on today’s episode, visit nytimes.com/thedaily\nBackground reading: In protests across the country, pleas for changes in policing have ranged from reform to abolition. Some proposed measures include restricting police use of military-style equipment and requiring officers to face strict discipline in cases of misconduct.Nine members of the Minneapolis City Council — a veto-proof majority — pledged to dismantle the city’s Police Department, promising to create a new system of public safety.',
        'June 9, 2020',
        '00:25:22',
        Image.network(
            'https://is3-ssl.mzstatic.com/image/thumb/Podcasts114/v4/93/cf/99/93cf9960-fff3-205e-6655-72c03ddeccb2/mza_10545582232493904175.jpeg/200x200bb.png'),
        'https://content.production.cdn.art19.com/validation=1591825112,7d3ec2c2-2b9d-5124-8b5b-28b7fea23ffd,b5kRXnNeDJGlu9LBZjNyrDl0Lps/episodes/dfbb3014-94af-40c1-b2e3-f7b944d64af5/17b4f87cd5c112053c8ef145b9aa84e783ee69782cef764adc7998767482e21a5a66a9a20f9fd23f7cf233192b361f9db34c2684bca717d933ee720544d8739f/20200609%20TD%20MASTER%20SUBMIX%20FULL%20CW%20FINAL.mp3',
      ),
    );
    curratedList.add(
      new PodcastModel(
          'Code Switch',
          'The last few weeks have been filled with devastating news — stories about the police killing black people. At this point, these calamities feel familiar — so familiar, in fact, that their details have begun to echo each other.',
          'May 31, 2020',
          '00:22:50',
          Image.network(
              'https://is4-ssl.mzstatic.com/image/thumb/Podcasts113/v4/dd/e6/06/dde606ee-7f64-b01c-ba82-1fa0e178541e/mza_7463267581738583805.jpg/200x200bb.png'),
          'https://edge2.pod.npr.org/anon.npr-podcasts/podcast/npr/codeswitch/2020/05/20200529_codeswitch_actual_final-e4eaafff-48c1-4b76-bfe5-87c4c4846242.mp3/20200529_codeswitch_actual_final-e4eaafff-48c1-4b76-bfe5-87c4c4846242.mp3_e66162db5892230ecaadc4b5026627f1_21917006.mp3?awCollectionId=510312&awEpisodeId=865261916&orgId=1&topicId=1015&aggIds=868567696&d=1357&p=510312&story=865261916&t=podcast&e=865261916&size=21671664&ft=pod&f=510312&hash_redirect=1&x-total-bytes=21917006&x-ais-classified=download&listeningSessionID=0CD_382_160__a389aa8ccb8344871e908f74c07184f34e6b2371'),
    );
//    curratedList.add(
//      new PodcastModel(
//          'Crime Junkie',
//          'In the 1980s something strange was going on in Ohio. Almost a dozen young girls were kidnapped and murdered, many of the killers still unknown to this day. And it all started in June of 1980 with the case of Asenath Dukat.',
//          'June 8, 2020',
//          '00:56:46',
//          Image.network(
//              'https://is2-ssl.mzstatic.com/image/thumb/Podcasts113/v4/35/1d/90/351d9072-fb88-46c3-bde7-2c4ff389aeb9/mza_10451957470167384816.png/200x200bb.png')),
//    );
    curratedList.add(
      new PodcastModel(
          'Pod Save the People',
          'This week DeRay sits down with John Rappaport, a law professor and research scholar examining criminal procedures in the justice system. They discuss Rappaport\'s findings regarding police misconduct and the effects of police behavior on communities. ',
          'June 9, 2020',
          '00:48:27',
          Image.network(
              'https://is2-ssl.mzstatic.com/image/thumb/Podcasts113/v4/49/67/7f/49677fcb-ecfa-2ffb-13eb-1aaa95640c2d/mza_3028845891124170385.jpeg/200x200bb.png'),
          'https://dcs.megaphone.fm/DGT1443733070.mp3?key=bad13483752e44723ab51fc8d6d4c3f2'),
    );
    curratedList.add(
      new PodcastModel(
          'Unlocking Us with Brené Brown',
          'I\'m talking with professor Ibram Kendi, New York Times bestselling author of How to Be an Antiracist and the Director of the Antiracist Research and Policy Center at American University. We talk about racial disparities, policy, and equality, but we really focus on How to Be an Antiracist, which is a groundbreaking approach to understanding uprooting racism and inequality in our society and in ourselves.',
          'June 2, 2020',
          '01:01:35',
          Image.network(
              'https://is5-ssl.mzstatic.com/image/thumb/Podcasts123/v4/1c/0f/9d/1c0f9de6-1434-792b-320c-5e8abeb130bb/mza_13236693715648709278.jpg/200x200bb.png'),
          'https://dcs.megaphone.fm/CAD5180796840.mp3?key=df6a28c9f2aa7075721011db7d0f947d'),
    );
    curratedList.add(
      new PodcastModel(
        'Dr. Phil McGraw',
        'Through an unprecedented global pandemic and widespread civil unrest following the May 25 death of George Floyd, the unarmed Minneapolis man who lost his life while in police custody, Dr. Phil leads a discussion with prominent members of the Black community analyzing the events of the past week and what may have sparked them.',
        'June 9, 2020',
        '00:50:17',
        Image.network(
            'https://is5-ssl.mzstatic.com/image/thumb/Podcasts113/v4/fd/c1/55/fdc155d5-2004-e42c-b73a-506616368eee/mza_18019138770695228156.jpg/200x200bb.png'),
        'https://21883.mc.tritondigital.com/OMNY_PHILINTHEBLANKS_PODCAST_P/media-session/82c2757c-36da-422d-b020-71a61185a6c9/d/clips/aaea4e69-af51-495e-afc9-a9760146922b/ae4a91b3-7592-4845-9cae-aadc00162d07/94a9040e-d40b-4b47-9891-abd5008363ef/audio/direct/t1591690013/America_on_Fire.mp3?t=1591690013&in_playlist=cfdcd88c-6044-4e43-81e6-aadc00162d13&utm_source=Podcast',
      ),
    );
    curratedList.add(
      new PodcastModel(
          'Up First',
          'George Floyd will be buried in Houston, Texas today. We\'ll hear from friends who say his death has sparked new conversations about being black in America. Also, New York\'s legislature quickly passed new laws regulating police policy. And, an NPR investigation found many companies have sought exceptions to EPA rules during the pandemic.',
          'June 9, 2020',
          '00:13:14',
          Image.network(
              'https://is3-ssl.mzstatic.com/image/thumb/Podcasts113/v4/3a/b6/27/3ab6274d-59a6-0ac7-c596-b907b6ef7938/mza_16293744033284542565.png/200x200bb.png'),
          'https://play.podtrac.com/npr-510318/edge1.pod.npr.org/anon.npr-mp3/npr/upfirst/2020/06/20200609_upfirst_new_uf_6_9.mp3?awCollectionId=510318&awEpisodeId=871738536&orgId=1&d=805&p=510318&story=871738536&t=podcast&e=871738536&size=12864450&ft=pod&f=510318'),
    );
  }

  Future<List<PodcastModel>> getListOfPodcastWithSearch(String keyword) async {
    String term = createTermFromInput(keyword);

    try {
      http.Response response = await http
          .get(ITUNES_FULLY_QUALIFIED_URL + term + MEDIA_TYPE + LIMIT);
      print(ITUNES_FULLY_QUALIFIED_URL + term + MEDIA_TYPE);
      if (response.statusCode == 200) {
        List<dynamic> decodedList =
            jsonDecode(response.body)['results']; //feed.results

        List<PodcastModel> results = new List<PodcastModel>();
        for (final entry in decodedList) {
          var title = entry['artistName'];
          var description = 'not yet done';
          var dateCreated = 'not yet done';
          var lengthOfEpisode = 'not yet done';
          var imageURL = entry['artworkUrl100'];
          Image image;
          try {
            image = Image.network(imageURL);
          } on Exception {
            image = Image.asset('images/png_images/microphone.png');
          }
          results.add(new PodcastModel(
              title.toString(),
              description.toString(),
              dateCreated.toString(),
              lengthOfEpisode.toString(),
              image,
              'not done'));
        }
        return results;
      } else {
        throw Exception('Failed to load podcasts');
      }
    } on Exception catch (e) {
      //TODO: handle this exception. Make sure that it works
      print('Could not fetch most popular podcasts this went wrong:');
      print(e);
      List<PodcastModel> failedConnection = new List<PodcastModel>();
      failedConnection.add(new PodcastModel(
          'Could not get title',
          'Could not get description',
          'Could not get data created',
          'Could not get duration',
          Image.asset("images/png_images/error.png"),
          'Could not get audio feed'));
    }
  }

  String createTermFromInput(String keyword) {
    String term = 'term=';
    for (int i = 0; i < keyword.length; i++) {
      if (keyword[i].compareTo(' ') == 0) {
        term += '+';
      } else {
        term += keyword[i];
      }
    }
    return term;
  }

  Future<List<PodcastModel>> getMostPopularPodcasts() async {
    await Future.delayed(Duration(seconds: 1));
    return curratedList;

//    try {
//      http.Response response = await http.get(
//          "https://rss.itunes.apple.com/api/v1/us/podcasts/top-podcasts/all/10/explicit.json");
//
//      if (response.statusCode == 200) {
//        List<dynamic> decodedList =
//            jsonDecode(response.body)['feed']['results']; //feed.results
//
//        List<PodcastModel> results = new List<PodcastModel>();
//        for (final entry in decodedList) {
//          var title = entry['name'];
//          var description = 'not yet done';
//          var dateCreated = 'not yet done';
//          var lengthOfEpisode = 'not yet done';
//          var imageURL = entry['artworkUrl100'];
//          Image image;
//          try {
//            image = Image.network(imageURL);
//          } on Exception {
//            image = Image.asset('images/png_images/microphone.png');
//          }
//          results.add(new PodcastModel(title.toString(), description.toString(),
//              dateCreated.toString(), lengthOfEpisode.toString(), image));
//        }
//        return results;
//      } else {
//        throw Exception('Failed to load podcasts');
//      }
//    } on Exception catch (e) {
//      //TODO: handle this exception. Make sure that it works
//      print('Could not fetch most popular podcasts this went wrong:');
//      print(e);
//      List<PodcastModel> failedConnection = new List<PodcastModel>();
//      failedConnection.add(new PodcastModel(
//          'Could not get title',
//          'Could not get description',
//          'Could not get data created',
//          'Could not get duration',
//          Image.asset("images/png_images/error.png")));
//    }
  }
}
