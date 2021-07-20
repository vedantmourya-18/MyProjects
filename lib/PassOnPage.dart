import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'NewsScreen.dart';

class Onpass extends StatefulWidget {
final String Url;
final String Title;
Onpass({this.Url,this.Title});
  @override
  _OnpassState createState() => _OnpassState();
}

class _OnpassState extends State<Onpass> {
  List<ArticleModel> newsarticle = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getArticles();
  }
  getArticles() async{
    Articles newsClass = Articles(SiteUrl: widget.Url);
    await newsClass.getarticles();
    newsarticle = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xFF525252),
        ),
        title:  Text(widget.Title,
        style: GoogleFonts.cinzelDecorative(
        textStyle: TextStyle(
        fontSize: 30,
        color: Color(0xFF525252),
    ),
    )
      )
      ),
      body: _loading?Container(
        child: Center(
          child: Text('Loading...'),
        ),
      ):Container(
              child:  ListView.builder(
                  itemCount: newsarticle.length,
                  itemBuilder:(context,index){
                    return NewsColumn(image: newsarticle[index].image, title: newsarticle[index].title, size: _size,WebUrl: newsarticle[index].url,);
                  }),
      ),
    );
  }
}

class NewsColumn extends StatelessWidget {
  final Size size;
  final String image;
  final String title;
  final String WebUrl;

  NewsColumn({@required this.image,@required this.title,@required this.size,@required this.WebUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: (){
       Navigator.push(context , MaterialPageRoute(builder: (context)
       {
         return NewsScreen(
           webUrl: WebUrl,
         );
       }));
     },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
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

class ArticleModel{
  String image;
  String title;
  String url;

  ArticleModel({
    @required this.title,
    @required this.image,
    @required this.url,
  });
}

class Articles{
   var SiteUrl ;
   Articles({this.SiteUrl});
  List<ArticleModel> news = [];

  Future<void> getarticles() async {
    var url = SiteUrl;
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if(jsonData['status']=="ok"){
      jsonData["articles"].forEach((element){

        if(element["urlToImage"] != null && element['description'] != null){

          ArticleModel articlesModel = ArticleModel(title: element["title"], image: element["urlToImage"],url: element["url"]
          );
          news.add(articlesModel);
        }
      });
    }
  }
}

