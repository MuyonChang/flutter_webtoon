import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webtoon/model/webtoon_detail.dart';
import 'package:webtoon/model/webtoon_episode.dart';
import 'package:webtoon/service/api_service.dart';
import 'package:webtoon/widget/episode_widget.dart';

class detailWidget extends StatefulWidget {
  final String title, id, thumb;
  const detailWidget({
    super.key,
    required this.id,
    required this.thumb,
    required this.title,
  });

  @override
  State<detailWidget> createState() => _detailWidgetState();
}

onButtonTap() async {}

class _detailWidgetState extends State<detailWidget> {
  late Future<webtoon_detail> webtoon;
  late Future<List<webtoonEpisodeModel>> episode;
  late SharedPreferences pref;
  bool isliked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefs();
    webtoon = Webtoonservice.getToonById(widget.id);
    episode = Webtoonservice.getToonEpisode(widget.id);
  }

  Future initPrefs() async {
    pref = await SharedPreferences.getInstance();
    final LikedToons = pref.getStringList('LikedToons');
    if (LikedToons != null) {
      if (LikedToons.contains(widget.id) == true) {
        setState(() {
          isliked = true;
        });
      }
    } else {
      await pref.setStringList('LikedToons', []);
      print("배열 생성 완료");
    }
  }

  onHeartTab() async {
    final LikedToons = pref.getStringList('LikedToons');
    if (LikedToons != null) {
      print("not empty");
      if (isliked) {
        LikedToons.remove(widget.id);
      } else {
        LikedToons.add(widget.id);
      }
      await pref.setStringList('LikedToons', LikedToons);
    }
    setState(() {
      isliked = !isliked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          elevation: 100,
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: onHeartTab,
              icon: Icon(
                isliked ? Icons.favorite : Icons.favorite_outline_outlined,
              ),
            )
          ],
          title: Align(
            alignment: Alignment.center,
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            ),
          )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
              // 두 위젯을 Column으로 감싸서 배치
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  width: 350,
                  child: Image.network(widget.thumb),
                ),
                const SizedBox(height: 20), // 이미지와 텍스트 사이의 간격을 추가
                Expanded(
                    child: FutureBuilder(
                  future: webtoon,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.about,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(color: Colors.amber),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              "${snapshot.data!.age} / ${snapshot.data!.genre}",
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(child: newMethod()),
                          ],
                        ),
                      );
                    }
                    return const Text('...');
                  },
                ))
              ]),
        ),
      ),
    );
  }

  FutureBuilder<List<webtoonEpisodeModel>> newMethod() {
    return FutureBuilder(
        future: episode,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (var episodes in snapshot.data!)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 100),
                      child:
                          EpisodePage(episodes: episodes, webtoonid: widget.id),
                    )
                ]);
          }
          return Container();
        });
  }
}
