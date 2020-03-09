import 'package:flutter/material.dart';
import 'package:storytap/screens/authenticate/authenticate.dart';

import 'package:storytap/services/auth.dart';
// Screens
import 'package:storytap/screens/home/home.dart';
import 'package:storytap/screens/browse/browse.dart';
import 'package:storytap/screens/create/create.dart';
import 'package:storytap/screens/profile/profile.dart';
import 'package:storytap/screens/settings/settings.dart';
import 'package:storytap/screens/create/create_book.dart';

// Models
import 'package:storytap/models/book.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBar createState() => _NavigationBar();
}

class _NavigationBar extends State<NavigationBar> {
  int _currentIndex = 0;
  bool _clickedCenterBtn = false;
  String _text = "Home";
  String _titleText = "Home";
  Color bgColor = primaryThemeColor;
  List<Widget> _appBarWidgets;
  final List<Widget> _children = [
    Home(),
    Browse(),
    Create(),
    Profile(),
    Settings(),
  ];

  List<Widget> appBarIcons(BuildContext context) {
    final newBook = new Book(title: "", cover: "", creationDate: DateTime.now(), description: "", genre: "", isComplete: true, lastUpdated: DateTime.now());
    // Return  appBar icons based on current tab
    if (_currentIndex == 0) {
      // Home
      setState(() {
        _appBarWidgets = <Widget>[];
      });
      return _appBarWidgets;
    } else if (_currentIndex == 1) {
      // Browse
      setState(() {
        _appBarWidgets = <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ];
      });
      return _appBarWidgets;
    } else if (_currentIndex == 2) {
      // Create
      setState(() {
        _appBarWidgets = <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateBook(book: newBook)));
            },
          ),
        ];
      });
      return _appBarWidgets;
    } else if (_currentIndex == 3) {
      // Profile
      setState(() {
        _appBarWidgets = <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          )
        ];
      });
      return _appBarWidgets;
    } else if (_currentIndex == 4) {
      // Settings

      setState(() {
        _appBarWidgets = <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed:
                  () {}), /* async {
            try {
                  Auth auth = Provider.of(context).auth;
                  await auth.signOut();
                  print("Signed out");
                } catch (error) {
                  print(error);
                }
                
          }), */
        ];
      });
      return _appBarWidgets;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    //call this method on click of each bottom app bar item to update the screen
    void updateTabSelection(int index, String titleText, String btnText) {
      setState(() {
        _titleText = titleText;
        _currentIndex = index;
        _text = btnText;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titleText,
        ),
        centerTitle: true,
        backgroundColor: secondaryThemeColor,
        actions: appBarIcons(context),
      ),
      backgroundColor: Colors.white,
      body: _children[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, //specify the location of the FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryThemeColor,
        onPressed: () {
          setState(() {
            if (_clickedCenterBtn == false) {
              _clickedCenterBtn = true;
              setState(() {
                bgColor = primaryThemeColor; // Colors.blueGrey[300];
              });
            }
            updateTabSelection(2, "Create", "Create");
            // _clickedCenterBtn = !_clickedCenterBtn; //to update the animated container
          });
        },
        tooltip: "CenterBtn",
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Icon(
            Icons.create,
            color: _currentIndex == 2 ? Colors.lightBlueAccent : Colors.white,
          ),
        ),
        elevation: 4.0,
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        color: secondaryThemeColor,
        child: Container(
          height: _height * 0.08,
          margin: EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                //update the bottom app bar view each time an item is clicked
                onPressed: () {
                  if (_clickedCenterBtn == false) {
                    _clickedCenterBtn = true;
                  }
                  setState(() {
                    if (_clickedCenterBtn == true) {
                      _clickedCenterBtn = !_clickedCenterBtn;
                      bgColor = primaryThemeColor;
                    }
                  });
                  updateTabSelection(0, "Home", "Home");
                },
                iconSize: 27.0,
                icon: Icon(
                  Icons.home,
                  //darken the icon if it is selected or else give it a different color
                  color: _currentIndex == 0
                      ? Colors.lightBlueAccent
                      : Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (_clickedCenterBtn == false) {
                      _clickedCenterBtn = true;
                    }
                    if (_clickedCenterBtn == true) {
                      _clickedCenterBtn = !_clickedCenterBtn;
                      bgColor = primaryThemeColor;
                    }
                  });
                  updateTabSelection(1, "Browse", "Browse");
                },
                iconSize: 27.0,
                icon: Icon(
                  Icons.book,
                  color: _currentIndex == 1
                      ? Colors.lightBlueAccent
                      : Colors.white,
                ),
              ),
              //to leave space in between the bottom app bar items and below the FAB
              SizedBox(
                width: 50.0,
              ),
              IconButton(
                onPressed: () {
                  if (_clickedCenterBtn == false) {
                    _clickedCenterBtn = true;
                  }
                  setState(() {
                    if (_clickedCenterBtn == true) {
                      _clickedCenterBtn = !_clickedCenterBtn;
                      bgColor = primaryThemeColor;
                    }
                  });
                  updateTabSelection(3, "Profile", "Profile");
                  Navigator.of(context).pushNamed('/convertAnon');
                },
                iconSize: 27.0,
                icon: Icon(
                  Icons.person,
                  color: _currentIndex == 3
                      ? Colors.lightBlueAccent
                      : Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_clickedCenterBtn == false) {
                    _clickedCenterBtn = true;
                  }
                  setState(() {
                    if (_clickedCenterBtn == true) {
                      _clickedCenterBtn = !_clickedCenterBtn;
                      bgColor = primaryThemeColor;
                    }
                  });
                  updateTabSelection(4, "Settings", "Settings");
                },
                iconSize: 27.0,
                icon: Icon(
                  Icons.settings,
                  color: _currentIndex == 4
                      ? Colors.lightBlueAccent
                      : Colors.white,
                ),
              ),
            ],
          ),
        ),
        //to add a space between the FAB and BottomAppBar
        shape: CircularNotchedRectangle(),
        //color of the BottomAppBar
      ),
    );
  }
}