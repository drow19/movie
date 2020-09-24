import 'package:fluttercinema/model/detail.dart';
import 'package:fluttercinema/model/popular.dart';
import 'package:fluttercinema/model/upload.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

class Helper {
  newUpload() async {
    String _url = "https://.../";

    final response = await get(_url);
    final document = parse(response.body);

    List<Upload> _list = new List<Upload>();

    String title;
    String images;
    String url;
    String rating;

    document
        .getElementsByClassName('col-lg-2 col-sm-3 col-xs-4 item')
        .forEach((element) {
      title = element.getElementsByTagName('h3')[0].text;
      images = element.getElementsByTagName('img')[0].attributes['src'];
      url = element.getElementsByTagName('a')[0].attributes['href'];
      rating = element.getElementsByClassName('rating')[0].text;

      _list.add(Upload(title: title, url: url, rating: rating, images: images));
    });

    return _list;
  }

  thumbnailPopular() async {
    String _url = "https://.../";

    final response = await get(_url);
    final document = parse(response.body);
    List<Popular> _list = new List<Popular>();

    String title;
    String images;
    String url;
    String rating;
    String genre;

    document.querySelectorAll('#populer').forEach((element) {
      element
          .getElementsByClassName('col-lg-2 col-sm-2 col-xs-4 item')
          .forEach((ele) {
        url = ele.getElementsByTagName('a')[0].attributes['href'];
        images = ele.getElementsByTagName('img')[0].attributes['src'];
        title = ele.getElementsByTagName('h1')[0].text;
        rating = ele.getElementsByClassName('rating')[0].text;

        ele.getElementsByClassName('grid-categories').forEach((e) {
          genre = e.getElementsByTagName('a')[0].text +
              ", " +
              e.getElementsByTagName('a')[1].text;
        });

        String sub1 = title.replaceAll(' Nonton Film', '');
        String sub2 =
            sub1.replaceAll('Subtitle Indonesia Streaming Movie Download', '');

        _list.add(Popular(
            images: images,
            rating: rating,
            title: sub2,
            url: url,
            genre: genre));
      });
    });

    return _list;
  }

  mostPopularList(String pages, String filter) async {
    String _url = '';
    filter == null
        ? _url = "https://.../populer/page/$pages/"
        : _url = "https://.../genre/$filter/page/$pages/";

    final response = await get(_url);
    final document = parse(response.body);

    List<Popular> _list = new List<Popular>();

    String images;
    String title;
    String url;
    String rating;
    String genre;

    document
        .getElementsByClassName(
            'col-lg-2 col-sm-3 col-xs-4 page-$pages infscroll-item')
        .forEach((element) {
      images = element.getElementsByTagName('img')[0].attributes['src'];
      rating = element.getElementsByClassName('rating')[0].text;
      title = element.getElementsByTagName('h1')[0].text;
      url = element.getElementsByTagName('a')[0].attributes['href'];

      String sub1 = title.replaceAll(' Nonton Film', '');
      String sub2 =
          sub1.replaceAll('Subtitle Indonesia Streaming Movie Download', '');

      element.getElementsByClassName('grid-categories').forEach((e) {
        genre = e.getElementsByTagName('a')[0].text +
            ", " +
            e.getElementsByTagName('a')[1].text +
            ", " +
            e.getElementsByTagName('a')[2].text;
      });

      _list.add(Popular(
          images: images, rating: rating, title: sub2, url: url, genre: genre));
    });

    return _list;
  }

  detailMovie(String _url) async {
    final response = await get(_url);
    final document = parse(response.body);

    String images;
    String title;
    String url;
    String desc;
    String quality;
    String artis;

    document.getElementsByClassName('row toggle-more').forEach((element) {
      images = element.getElementsByTagName('img')[0].attributes['src'];
      quality = element.getElementsByTagName('h3')[0].text;
      element.getElementsByClassName('col-xs-10 content').forEach((ele) {
        artis = ele.getElementsByTagName('h3')[3].text +
            ", " +
            ele.getElementsByTagName('h3')[4].text +
            ", " +
            ele.getElementsByTagName('h3')[5].text;
        desc = ele.getElementsByTagName('p')[0].text;
      });
    });

    return Detail(desc: desc, quality: quality, artis: artis);
  }

  searchMovie(String search) async {

    String _url = 'https://.../?s=$search';
    final response = await get(_url);
    final document = parse(response.body);

    List<Popular> _list = new List<Popular>();

    print("print : ${_url}");

    String images;
    String title;
    String url;
    String rating;
    String genre;

    document
        .getElementsByClassName(
        'col-lg-2 col-sm-3 col-xs-4 page-1 infscroll-item')
        .forEach((element) {
      images = element.getElementsByTagName('img')[0].attributes['src'];
      rating = element.getElementsByClassName('rating')[0].text;
      title = element.getElementsByTagName('h1')[0].text;
      url = element.getElementsByTagName('a')[0].attributes['href'];

      String sub1 = title.replaceAll(' Nonton Film', '');
      String sub2 =
      sub1.replaceAll('Subtitle Indonesia Streaming Movie Download', '');

      element.getElementsByClassName('grid-categories').forEach((e) {
        genre = e.getElementsByTagName('a')[0].text +
            ", " +
            e.getElementsByTagName('a')[1].text +
            ", " +
            e.getElementsByTagName('a')[2].text;
      });

      _list.add(Popular(
          images: images, rating: rating, title: sub2, url: url, genre: genre));
    });

    return _list;
  }
}
