import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttercinema/widget/star_display.dart';

class TileDetail extends StatelessWidget {
  final images, title, rating, cast, desc, genre;
  TileDetail({this.title, this.images, this.desc, this.genre, this.rating, this.cast});

  @override
  Widget build(BuildContext context) {
    String rate = rating.toString().substring(0, 1);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: 100,
                  child: CachedNetworkImage(
                    imageUrl: images,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      child: Text(
                        title.toString().substring(0,
                            title.toString().length - 6),
                        style: TextStyle(
                            fontSize: 16, color: Colors.white),
                        maxLines: 2,
                      ),
                    ),
                    Row(
                      children: [
                        Text(rating,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.yellowAccent)),
                        SizedBox(
                          width: 4,
                        ),
                        StarDisplayWidget(
                          color: Colors.yellowAccent,
                          value: double.parse(rate) / 2,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Cast :',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        cast,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Genre :',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      width: 250,
                      child: Text(
                        genre ?? ' - ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Synopsis : ',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 4,
          ),
          Expanded(
            child: Container(
              child: Text(
                desc,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  height: 1.2,
                ),
                maxLines: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
