import 'package:flutter/material.dart';
import 'package:fluttercinema/helper/constant.dart';
import 'package:fluttercinema/helper/helper.dart';
import 'package:fluttercinema/model/popular.dart';
import 'package:fluttercinema/model/upload.dart';
import 'package:fluttercinema/view/drawer/drawer_screen.dart';
import 'package:fluttercinema/view/mainScreen/popular_list_movie.dart';
import 'package:fluttercinema/view/mainScreen/search.dart';
import 'package:fluttercinema/view/mainScreen/upload_list_movie.dart';
import 'package:fluttercinema/view/viewAll/list_all_movie.dart';
import 'package:fluttercinema/widget/genre.dart';
import 'package:fluttercinema/widget/loading_view.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double _size = 0;
  Helper _helper = new Helper();
  List<Upload> _list = new List<Upload>();
  List<Popular> _listPopular = List<Popular>();

  bool _isloading = false;

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  getData() async {
    _isloading = true;
    await _helper.newUpload().then((value) {
      setState(() {
        _isloading = false;
        _list = value;
      });
    }).catchError((e) {
      print("print error : $e");
    });

    await _helper.thumbnailPopular().then((value) {
      setState(() {
        _listPopular = value;
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Search(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                            child: Text(
                              "New Upload",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          UploadMovie(list: _list),
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_size == 0) {
                                  _size =
                                      MediaQuery.of(context).size.height / 4;
                                } else {
                                  _size = 0;
                                }
                              });
                            },
                            child: Container(
                              width: 100,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Color(0xff1A237E).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Filter by',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                  Icon(
                                    Icons.import_export,
                                    size: 15,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(height: _size, child: FilterByGenre()),
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                                child: Text(
                                  "Most Popular",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          color: Colors.white, fontSize: 18),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ListAllMovie()));
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 8, 16, 0),
                                  height: 20,
                                  width: 100,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xff1A237E).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Text(
                                    'View All',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                              child: MostPopularMovie(
                            list: _listPopular,
                          ))
                        ],
                      ),
                    ),
            )
          ],
        ));
  }
}
