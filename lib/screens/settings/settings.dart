// Dependencies
import 'package:flutter/material.dart';
// Services
import 'package:storytap/services/auth.dart';
// Shared
import 'package:storytap/shared/provider.dart';
// Screens
import 'package:storytap/screens/authenticate/authenticate.dart';

// *** 
// Displays settings screen.

class Settings extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Container(
      height: _height,
      width: _width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FlatButton(
            child: Text("Sign out of session"),
            onPressed: () async {
              try {
                final auth = Provider.of(context).auth;
                if (await auth.isAnon()){
                  print ("This is anon");
                  await auth.deleteUser();
                  print("Deleted successfully.");
                }
                else {
                  print ("Real user");
                  await auth.signOut();
                }
                print("Signed Out!");
              } catch (e) {
                print (e);
              }
            },
          ),
          ),
        ),
      );
  }
}
