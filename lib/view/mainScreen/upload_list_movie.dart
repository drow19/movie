import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttercinema/model/upload.dart';
import 'package:fluttercinema/view/detail/detail_movie.dart';

class UploadMovie extends StatefulWidget {
  final List<Upload> list;

  const UploadMovie({Key key, this.list}) : super(key: key);

  @override
  _UploadMovieState createState() => _UploadMovieState();
}

class _UploadMovieState extends State<UploadMovie> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      height: 160,
      child: ListView.builder(
          itemCount: widget.list.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (contex, index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (contex) => DetailMovie(
                      rating: widget.list[index].rating,
                      url: widget.list[index].url,
                      images: widget.list[index].images,
                      title: widget.list[index].title,
                    )));
              },
              child: Container(
                  margin: EdgeInsets.only(right: 8),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Hero(
                          tag: widget.list[index].images,
                          child: CachedNetworkImage(
                            imageUrl: widget.list[index].images,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 150,
                        width: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.black54.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    widget.list[index].rating,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                              child: Text(
                                widget.list[index].title,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            );
          }),
    );
  }
}
