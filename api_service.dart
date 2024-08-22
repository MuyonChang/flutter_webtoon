import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon/model/webtoon_detail.dart';
import 'package:webtoon/model/webtoon_episode.dart';
import 'package:webtoon/model/webtoon_model.dart';

class Webtoonservice {
  static List<WebtoonModel> webtooninstances = [];
  static const String baseurl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";
  static Future<List<WebtoonModel>> getTodaysToon() async {
    final url = Uri.parse('$baseurl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtooninstances.add(WebtoonModel.fromJson(webtoon));
      }

      return webtooninstances;
    }
    throw Error();
  }

  static Future<webtoon_detail> getToonById(String id) async {
    final url = Uri.parse("$baseurl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return webtoon_detail.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<webtoonEpisodeModel>> getToonEpisode(String id) async {
    List<webtoonEpisodeModel> episodeInstance = [];
    final url = Uri.parse("$baseurl/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodeInstance.add(webtoonEpisodeModel.fromJson(episode));
      }
      return episodeInstance;
    }

    throw Error();
  }
}
