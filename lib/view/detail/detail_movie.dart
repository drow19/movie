import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttercinema/helper/constant.dart';
import 'package:fluttercinema/helper/helper.dart';
import 'package:fluttercinema/model/detail.dart';
import 'package:fluttercinema/view/detail/tile.dart';
import 'package:fluttercinema/widget/loading_view.dart';
import 'package:fluttercinema/widget/star_display.dart';

class DetailMovie extends StatefulWidget {
  final url;
  final images;
  final genre;
  final rating;
  final title;

  DetailMovie(
      {Key key, this.url, this.images, this.genre, this.rating, this.title})
      : super(key: key);

  @override
  _DetailMovieState createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  Helper _helper = new Helper();
  Detail detail = new Detail();
  bool _isloading = false;

  getData() async {
    _isloading = true;
    await _helper.detailMovie(widget.url).then((value) {
      setState(() {
        _isloading = false;
        detail = value;
      });
    }).catchError((e) {
      _isloading = false;
      print("print error : $e");
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primeColor,
      body: Stack(
        children: [
          Positioned.fill(
              child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    child: Hero(
                      tag: widget.images,
                      child: CachedNetworkImage(
                        imageUrl: widget.images,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black45.withOpacity(0),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  color: Color(0xff133b5c).withOpacity(0.5),
                ),
              ),
            ],
          )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            margin: EdgeInsets.only(top: 50),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.black54),
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () => Navigator.pop(context))),
                  IconButton(
                      icon: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                      onPressed: null),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                margin: EdgeInsets.fromLTRB(9, 0, 9, 30),
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xff16213e),
                    borderRadius: BorderRadius.circular(12)),
                child: _isloading
                    ? LoadingView()
                    : TileDetail(
                        title: widget.title,
                        genre: widget.genre,
                        rating: widget.rating,
                        images: widget.images,
                        desc: detail.desc,
                        cast: detail.artis,
                      )
                ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.videocam,
                          color: Colors.white,
                        ),
                        Text(
                          'Watch Trailer',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                        Text(
                          'Play Now',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
