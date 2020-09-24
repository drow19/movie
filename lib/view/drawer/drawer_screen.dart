import 'package:flutter/material.dart';
import 'package:fluttercinema/helper/constant.dart';
import 'package:fluttercinema/view/drawer/drawer_list.dart';
import 'package:fluttercinema/view/mainScreen/main_screen.dart';
import 'package:fluttercinema/view/viewAll/list_all_movie.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: appBarColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: drawerList
                .map((e) => Container(
                      width: 250,
                      child: GestureDetector(
                        onTap: () {
                          if (e['name'] == 'Home') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => MainScreen()));
                          } else if (e['name'] == 'Genre') {
                            print(e['name']);
                          } else if (e['name'] == 'Most Popular Movie') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => ListAllMovie()));
                          } else if (e['name'] == 'Download') {
                            print(e['name']);
                          }
                        },
                        child: ListTile(
                          leading: e['icon'],
                          title: Text(
                            e['name'],
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          Container(
            width: 250,
            margin: EdgeInsets.only(bottom: 30),
            child: ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              title: Text("Exit",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    );
  }
}
