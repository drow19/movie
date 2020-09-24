import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttercinema/helper/helper.dart';
import 'package:fluttercinema/model/popular.dart';
import 'package:fluttercinema/view/detail/detail_movie.dart';
import 'package:fluttercinema/widget/loading_view.dart';

class SearchScreen extends StatefulWidget {
  final search;

  SearchScreen({this.search});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Helper _helper = new Helper();
  List<Popular> _list = new List<Popular>();

  bool _isloading = false;

  getData() async {
    _isloading = true;
    await _helper.searchMovie(widget.search).then((value) {
      setState(() {
        _isloading = false;
        _list = value;
      });
    }).catchError((e) {
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
      backgroundColor: Color(0xff1A237E).withOpacity(0.3),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff1A237E).withOpacity(0.0),
        elevation: 0,
        title: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
      ),
      body: SafeArea(
        child: _isloading
            ? Center(child: LoadingView())
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: _list.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailMovie(
                                                  url: _list[index].url,
                                                  title: _list[index].title,
                                                  images: _list[index].images,
                                                  rating: _list[index].rating,
                                                  genre: _list[index].genre,
                                                )));
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 16),
                                        width: MediaQuery.of(context).size.width,
                                        height: 130,
                                        margin:
                                            EdgeInsets.only(top: 20, bottom: 20),
                                        decoration: BoxDecoration(
                                            color: Color(0xff303F9F)
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                      ),
                                      Align(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: 140,
                                                width: 120,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  child: Hero(
                                                    tag: _list[index].images,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          _list[index].images,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _list[index].title,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          color: _list[index]
                                                                      .rating ==
                                                                  '0'
                                                              ? Colors.grey
                                                              : Colors.yellow,
                                                          size: 20,
                                                        ),
                                                        SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          _list[index].rating,
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      _list[index].genre,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
