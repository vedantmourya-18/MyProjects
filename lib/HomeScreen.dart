import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Home.dart';
import 'CityScreen.dart';
import 'CategoryScreen.dart';

class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  int _currentindex = 1;
  List<Widget> _widgetChoice = <Widget>[
   Category(),
    Home(),
    cityScreen(),
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
          foregroundColor: Colors.black,
        title: Text('News',
            style: GoogleFonts.cinzelDecorative(
              textStyle: TextStyle(
                fontSize: 40,
                color: Color(0xFF525252),
                decoration: TextDecoration.none,
              ),
            )),
      ),
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _currentindex,
        selectedItemColor: Colors.deepPurple,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.category,),
          title: Text('Categories'),backgroundColor:Color(0xFF525252),),
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined,),
              title: Text('Home'),backgroundColor:Color(0xFF525252) ),
          BottomNavigationBarItem(icon: Icon(Icons.search,),
              title: Text('Search'),backgroundColor:Color(0xFF525252) )
        ],
        onTap: (index){
          setState(() {
            _currentindex = index;
          });
        },
      ),
      body: _widgetChoice.elementAt(_currentindex),
    );
  }
}
