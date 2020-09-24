import 'package:flutter/material.dart';
import 'package:fluttercinema/view/viewAll/search_screen.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = new TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _searchController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
                hintText: "search movie", border: InputBorder.none),
          )),
          new Material(
            child: new InkWell(
              onTap: () {
                if (_searchController.text != "") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (contex) => SearchScreen(
                                search: _searchController.text,
                              ))).then((value) {
                    _searchController.clear();
                  });
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
              child: Container(
                height: 40,
                color: Colors.transparent,
                child: Center(
                  child: Icon(Icons.search),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
