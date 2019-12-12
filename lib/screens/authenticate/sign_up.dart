import 'package:papabrew/shared/color.dart';
import 'package:papabrew/shared/constants.dart';
import 'package:papabrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:papabrew/widgets/general.dart';

import '../../services/auth.dart';

class SignUp extends StatefulWidget {

  final Function toggleView;
  SignUp({ this.toggleView });

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool _autoValidate = false;

  // text field stat
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Material(
                      child: Form(
                        key: _formKey,
                        autovalidate: _autoValidate,
                        child: FormUI(),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }

  

  // Form UI
  Widget FormUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ClipPath(
          clipper: MyClipper(),
          child: header("assets/papadrewheader.png"),
        ),
        title("SIGN UP"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Text(
            error,
            style: TextStyle(color: cred, fontSize: 14.0),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Icon(
                  Icons.email,
                  color: cprimary,
                ),
              ),
              Container(
                height: 30.0,
                width: 1.0,
                color: Colors.grey.withOpacity(0.5),
                margin: const EdgeInsets.only(left: 00.0, right: 10.0),
              ),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Email Address', labelText: 'Email Address'),
                  validator: validateEmail,
                  // validator: (val) => val.isEmpty ? 'Email is required' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Icon(
                  Icons.vpn_key,
                  color: cprimary,
                ),
              ),
              Container(
                height: 30.0,
                width: 1.0,
                color: Colors.grey.withOpacity(0.5),
                margin: const EdgeInsets.only(left: 00.0, right: 10.0),
              ),
              Expanded(
                child: TextFormField(
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Password', labelText: 'Password'),
                  validator: validatePassword,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  splashColor: caccent,
                  color: cprimary,
                  disabledColor: disabledColor,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'CREATE MY ACCOUNT',
                          style: TextStyle(color: cwhite),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Transform.translate(
                        offset: Offset(15.0, 0.0),
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                            splashColor: caccent,
                            color: cwhite,
                            child: Icon(Icons.person_add, color: cprimary,),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error =
                                        'Authentication failed, please supply valid credential';
                                    loading = false;
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      setState(() => loading = true);
                      dynamic result = await _auth.signUpWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          _autoValidate = true;
                          error = 'Authentication failed, please supply valid credential';
                          loading = false;
                        });
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Already have an account? SIGN UP HERE',
                      style: TextStyle(color: cprimary),
                    ),
                  ),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom)),
      ],
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email address is required';
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.length < 6) {
      return 'Password is required';
    } else {
      return null;
    }
  }

}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
