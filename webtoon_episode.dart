class webtoonEpisodeModel {
  final String title, id, rating, date;

  webtoonEpisodeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        rating = json['rating'],
        date = json['date'];
}
