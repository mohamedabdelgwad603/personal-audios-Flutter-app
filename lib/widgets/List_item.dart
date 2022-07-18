import 'package:flutter/material.dart';
import '../data/data.dart';

class ListItem extends StatefulWidget {
  final int i;
  final Function tap;
  ListItem(this.i, this.tap);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: InkWell(
        onTap: widget.tap,
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: ExactAssetImage(MusicList[widget.i].urlcover),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(MusicList[widget.i].title,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                Text(MusicList[widget.i].owner,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
