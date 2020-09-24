import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttercinema/model/popular.dart';
import 'package:fluttercinema/view/detail/detail_movie.dart';

class MostPopularMovie extends StatefulWidget {
  final List<Popular> list;

  MostPopularMovie({this.list});

  @override
  _MostPopularMovieState createState() => _MostPopularMovieState();
}

class _MostPopularMovieState extends State<MostPopularMovie> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
                itemCount: widget.list.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.80),
                itemBuilder: (context, index) {
                  return Container(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => DetailMovie(
                                    images: widget.list[index].images,
                                    url: widget.list[index].url,
                                    rating: widget.list[index].rating,
                                    genre: widget.list[index].genre,
                                    title: widget.list[index].title,
                                  )));
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.list[index].images,
                                    height: 150,
                                    width: 160,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  height: 150,
                                  width: 160,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.black54.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
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
                                            Container(
                                              padding: EdgeInsets.all(4),
                                              decoration:BoxDecoration(
                                                  color: Color(0xff1A237E).withOpacity(1)
                                              ),
                                              child: Text(
                                                'HD',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 4,),
                          Text(
                            widget.list[index].title,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4,),
                          Text(
                            widget.list[index].genre,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ));
                }),
          )
        ],
      ),
    );
  }
}
