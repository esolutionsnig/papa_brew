import 'package:papabrew/models/brew.dart';
import 'package:papabrew/screens/home/brew_list.dart';
import 'package:papabrew/screens/home/settings_form.dart';
import 'package:papabrew/shared/color.dart';
import 'package:papabrew/services/auth.dart';
import 'package:papabrew/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:papabrew/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel()  {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 60.0
          ),
          child: SettinsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: caccent,
        appBar: AppBar(
          title: Text(appName),
          backgroundColor: cprimary,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text(
                "Sign Out",
                style: TextStyle(color: cwhite),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text(
                "Settings",
                style: TextStyle(color: cwhite),
              ),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
