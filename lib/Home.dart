import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'NewsScreen.dart';



class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
List<NewsModel> newsarticle = new List<NewsModel>();
bool _loading = true;

@override
  void initState() {
    super.initState();
     getNews();
  }

  getNews() async{
  News newsClass = News();
  await newsClass.getNews();
  newsarticle = newsClass.news;
  setState(() {
    _loading = false;
  });
  }
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return _loading ? Container(
      child: Center(
        child: Text(
          'Loading...'
        ),
      ),
    ) : Container(
      child:ListView.builder(
          itemCount: newsarticle.length,
          itemBuilder:(context,index){
            return NewsColumn(image: newsarticle[index].image, title: newsarticle[index].title, size: _size,url: newsarticle[index].urlforNews,
            );
          })
    );
  }
}

class NewsColumn extends StatelessWidget {
  final Size size;
  final String image;
  final String title;
  final String url;

  NewsColumn({@required this.image,@required this.title,@required this.size,@required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context , MaterialPageRoute(builder: (context)
          {
            return NewsScreen(
                      webUrl: url,
            );
          }));
        },
        child: Container(
          height: size.height / 4.5,
          width: size.width,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 10,
                blurRadius: 5,
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: <Widget>[
              Container(
                height: size.height/4,
                width: size.width/2.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:20,right:10,top:5,
                bottom: 5),
                child: Container(
                  width: size.width/2.7,
                  height: size.height/4,
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                      fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewsModel{
  String image;
  String title;
  String urlforNews;
  NewsModel({
    @required this.title,
    @required this.image,
    @required this.urlforNews,
});
}

class News{

  List<NewsModel> news = [];

  Future<void> getNews() async {
    var url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=Api" ;//enter api key
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if(jsonData['status']=="ok"){
      jsonData["articles"].forEach((element){

        if(element["urlToImage"] != null && element['description'] != null){

          NewsModel newsModel = NewsModel(title: element["title"], image: element["urlToImage"],urlforNews: element["url"]
          );
          news.add(newsModel);
        }
      });
    }
  }
}

