import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webtoon/model/webtoon_episode.dart';

class EpisodePage extends StatelessWidget {
  const EpisodePage({
    super.key,
    required this.episodes,
    required this.webtoonid,
  });

  final webtoonEpisodeModel episodes;
  final String webtoonid;

  onButtonTap() async {
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonid&no=${episodes.id}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            episodes.title,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: Colors.white,
          ),
        ]),
      ),
    );
  }
}
