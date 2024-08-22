import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webtoon/screen/detailscreen.dart';

class MyWidget extends StatelessWidget {
  const MyWidget(
      {super.key, required this.title, required this.id, required this.thumb});
  final String title;
  final String id;
  final String thumb;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  detailWidget(id: id, thumb: thumb, title: title),
              fullscreenDialog: true,
            ));
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      offset: Offset(5, 0),
                      color: Colors.white,
                    )
                  ]),
              child: Image.network(thumb),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
