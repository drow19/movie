import 'package:flutter/material.dart';
import 'package:fluttercinema/helper/constant.dart';
import 'package:fluttercinema/helper/helper.dart';
import 'package:fluttercinema/model/popular.dart';
import 'package:fluttercinema/view/drawer/drawer_screen.dart';
import 'package:fluttercinema/view/viewAll/list_tile.dart';
import 'package:fluttercinema/widget/loading_view.dart';

class ListAllMovie extends StatefulWidget {
  final filter;

  ListAllMovie({this.filter});

  @override
  _ListAllMovieState createState() => _ListAllMovieState();
}

class _ListAllMovieState extends State<ListAllMovie> {
  ScrollController _scrollController = ScrollController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  Helper _helper = new Helper();
  List<Popular> _list = new List<Popular>();

  bool _isloading = false;
  bool visible = false;
  bool hasReachMax = false;
  int pages = 1;

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        hasReachMax = true;
        pages++;
        print("print : $pages");
      });
      getData();
    }
  }

  getData() async {
    if (hasReachMax == false) {
      setState(() {
        _isloading = true;
      });
    } else {
      setState(() {
        visible = true;
      });
    }
    await _helper.mostPopularList('$pages', widget.filter).then((value) {
      setState(() {
        if (hasReachMax == true) {
          visible = false;
          List<Popular> newList = value;
          _list = [..._list, ...newList];
        } else {
          _isloading = false;
          _list = value;
        }
      });
    }).catchError((e) {
      _isloading = false;
      print("print error : $e");
    });
  }

  @override
  void initState() {
    getData();
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: bgColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: appBarColor,
          elevation: 0,
          title: isDrawerOpen
              ? IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      xOffset = 0;
                      yOffset = 0;
                      scaleFactor = 1;
                      isDrawerOpen = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    setState(() {
                      xOffset = 230;
                      yOffset = 150;
                      scaleFactor = 0.6;
                      isDrawerOpen = true;
                    });
                  }),
        ),
        body: Stack(
          children: [
            isDrawerOpen ? DrawerScreen() : Container(),
            AnimatedContainer(
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..scale(scaleFactor)
                ..rotateY(isDrawerOpen ? -0.5 : 0),
              duration: Duration(milliseconds: 250),
              decoration: BoxDecoration(
                  color: Color(0xffc2331).withOpacity(0.001),
                  ),
              child: _isloading
                  ? Center(child: LoadingView())
                  : Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Stack(
                        children: [
                          visible
                              ? Center(
                                  child: Container(
                                      margin: EdgeInsets.only(top: 50),
                                      child: LoadingView()))
                              : Container(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: TileData(
                                list: _list,
                                scrollController: _scrollController,
                              ))
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ));
  }
}
