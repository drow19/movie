import 'package:flutter/material.dart';
import 'package:fluttercinema/view/viewAll/list_all_movie.dart';

class FilterByGenre extends StatefulWidget {
  @override
  _FilterByGenreState createState() => _FilterByGenreState();
}

class _FilterByGenreState extends State<FilterByGenre> {
  List<String> _genre = [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'Film-Noir',
    'History',
    'Horror',
    'Music',
    'Musical',
    'Mystery',
    'Romance',
    'Sci-fi',
    'Sport',
    'Thriller',
    'War',
    'Western'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GridView.builder(
          itemCount: _genre.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ListAllMovie(filter: _genre[index],)));
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xff1A237E).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  _genre[index],
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            );
          }),
    );
  }
}
