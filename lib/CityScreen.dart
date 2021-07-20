import 'package:flutter/material.dart';
import 'PassOnPage.dart';

class cityScreen extends StatefulWidget {
  @override
  _cityScreenState createState() => _cityScreenState();
}

class _cityScreenState extends State<cityScreen> {


  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    String CityName;
    final fieldText = TextEditingController();

    void clearText() {
      fieldText.clear();
    }
    return Container(
      height: _size.height,
      width: _size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('images/city3.jpg'),
        fit: BoxFit.fill,
        colorFilter: new ColorFilter.mode(
            Colors.white.withOpacity(0.5), BlendMode.dstATop),
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              height: _size.height / 15,
              width: _size.width / 2,
              child: TextField(
                onChanged: (value){
                  CityName = value;
                },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lightbulb_outline),
                      border: InputBorder.none,
                      hintText: 'Searh Anything',
                      hintStyle: TextStyle(
                        fontSize: 15,
                      )),
                controller: fieldText,),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: _size.width / 10,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: (){
                  Navigator.push(context , MaterialPageRoute(builder: (context)
                  {
                    return Onpass(
                      Url: "https://newsapi.org/v2/everything?q=$CityName&sortBy=popularity&apiKey=44c28fd5e12e49d5bdc0d8574014428f",
                      Title: CityName,
                    );
                  }));
                  clearText();
                  print(CityName);
                },
                child: Icon(Icons.search),
              ),
            ),
          )
        ],
      ),
    );
  }
}
