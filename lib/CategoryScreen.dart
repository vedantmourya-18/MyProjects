import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'PassOnPage.dart';


class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    String Api;
    return Container(

      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CategoryBlock(size: _size,name:'Sports',
                onPressed: (){
                Navigator.push(context , MaterialPageRoute(builder: (context)
                {
                  return Onpass(
                    Url: "https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=$Api", Title: "Sports",
                  );
                }));
              },),
              CategoryBlock(size: _size,name: 'Business',onPressed: (){
                Navigator.push(context , MaterialPageRoute(builder: (context)
                {
                  return Onpass(
                    Url: "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=$Api", Title: "Business",
                  );
                }));
              },),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CategoryBlock(size: _size,name: 'Entertainment',onPressed: (){
                Navigator.push(context , MaterialPageRoute(builder: (context)
                {
                  return Onpass(
                    Url: "https://newsapi.org/v2/top-headlines?country=in&category=entertainment&apiKey=$Api", Title: "entertainment",
                  );
                }));
              },),
              CategoryBlock(size: _size,name: 'Health',onPressed: (){
                Navigator.push(context , MaterialPageRoute(builder: (context)
                {
                  return Onpass(
                    Url: "https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=$Api", Title: "Health",
                  );
                }));
              },),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CategoryBlock(size: _size,name: 'Science',onPressed: (){
                Navigator.push(context , MaterialPageRoute(builder: (context)
                {
                  return Onpass(
                    Url: "https://newsapi.org/v2/top-headlines?country=in&category=science&apiKey=$Api", Title: "Science",
                  );
                }));
              },),
              CategoryBlock(size: _size,name: 'World',onPressed: (){
                Navigator.push(context , MaterialPageRoute(builder: (context)
                {
                  return Onpass(
                    Url: "https://newsapi.org/v2/everything?q=world&apiKey=$Api" , Title: "World",
                  );
                }));
              },),
            ],
          )
        ],
      ),
    );
  }
}

class CategoryBlock extends StatelessWidget {
  const CategoryBlock({
    Key key,
    @required Size size,
    @required String name,
    @required Function onPressed,
  }) : _size = size, _name = name,_onPressed = onPressed ,super(key: key);

  final Size _size;
  final String _name;
  final Function _onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
      child: GestureDetector(
        onTap: _onPressed,
        child: Container(
          height: _size.height/4.5,
          width: _size.width/3,
          decoration: BoxDecoration(
            color: Color(0xFF7874DA).withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
              boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              _name,style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: _size.width/25,
                )
            ),
            ),
          ),
        ),
      ),
    );
  }
}
