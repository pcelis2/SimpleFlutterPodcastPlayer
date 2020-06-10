import 'package:flutter/cupertino.dart';

class PodcastModel {
  String title;
  String _description;
  String dateCreated;
  String lengthOfEpisode;
  Image image;
  String audioFeed;
  PodcastModel(String title, String description, String dateCreated,
      String lengthOfEpisode, Image image, String audioFeed) {
    this.title = title;
    this._description = 'No available description';
    if (description != null) this._description = description;
    this.dateCreated = dateCreated;
    this.lengthOfEpisode = lengthOfEpisode;
    this.image = image;
    this.audioFeed = audioFeed;
  }
  String getShortDescription() {
    if (this._description.length >= 78)
      return this._description.substring(0, 77) + '...';
    else
      return this._description;
  }

  String getFullDescription() {
    return this._description;
  }

  @override
  String toString() {
    // TODO: implement toString
    String toBeReturned = "";
    toBeReturned += "Title: " + this.title + "\n";
    toBeReturned += "Description: " + this._description + "\n";
    toBeReturned += "Date Created: " + this.dateCreated + "\n";
    toBeReturned += "Length of Episode: " + this.lengthOfEpisode + "\n";
    return toBeReturned;
  }
}
