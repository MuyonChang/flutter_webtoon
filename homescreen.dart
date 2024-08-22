import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webtoon/model/webtoon_model.dart';
import 'package:webtoon/service/api_service.dart';
import 'package:webtoon/widget/widgets.dart';

class homeScreen extends StatelessWidget {
  homeScreen({super.key});
  final Future<List<WebtoonModel>> webtoons = Webtoonservice.getTodaysToon();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          title: const Align(
            alignment: Alignment.center,
            child: Text(
              "Today's Toon",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            ),
          )),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: makeView(snapshot),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  ListView makeView(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.all(20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        print(index);
        return MyWidget(
            title: webtoon.title, id: webtoon.id, thumb: webtoon.thumb);
      },
      separatorBuilder: (context, index) => const SizedBox(width: 20),
    );
  }
}
