import 'package:delivery_app/home_page/home_page_widget.dart';
import 'package:delivery_app/screens/register.dart';

import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:email_validator/email_validator.dart';

import 'package:google_fonts/google_fonts.dart';

import 'animations.dart';

class RenderScreenWidget extends StatefulWidget {
  RenderScreenWidget({Key key}) : super(key: key);

  @override
  _RenderScreenWidgetState createState() => _RenderScreenWidgetState();
}

class _RenderScreenWidgetState extends State<RenderScreenWidget> {
  TextEditingController emailTextController;
  TextEditingController passwordTextController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  /* checkuseralreadyloginornot() async {
    User user = _auth.currentUser;
    print('user $user');
    if (user != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return HomePageWidget();
      }));
      //    return true;
    }
    //  return false;
  }*/
  List<AnimationItem> animationlist = [];
  @override
  void initState() {
    super.initState();
    //  checkuseralreadyloginornot();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    delayAnimatiom(
        AnimationItem(
          name: 'padding_top_label',
          tween: Tween<double>(begin: 0.0, end: 1),
        ),
        Duration(milliseconds: 1500), (animation) {
      setState(() {
        animationlist.add(animation);
      });
    });
    delayAnimatiom(
        AnimationItem(
          name: 'button_scale',
          tween: Tween<double>(begin: 0.0, end: 0.9),
        ),
        Duration(milliseconds: 5000), (animation) {
      setState(() {
        animationlist.add(animation);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async => false,
          child: TweenAnimationBuilder(
              duration: Duration(milliseconds: 5000),
              curve: Curves.easeOutCubic,
              tween: findAnimation('padding_top_label', 20, animationlist),
              builder: (context, value, child) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF110631),
                  ),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      AnimatedOpacity(
                        opacity: value == 20 ? 0 : 1,
                        duration: Duration(milliseconds: 2000),
                        child: Container(
                          // alignment: Alignment(0.06, -0.63),
                          child: Image.asset(
                            'assets/logo.png',
                            //'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/flutterflow_assets/ff_full_logo_light.png',
                            width: 280,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      Container(
                        // alignment: Alignment(0, 0),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedOpacity(
                                opacity: value == 20 ? 0 : 1,
                                duration: Duration(milliseconds: 2000),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                                  child: Container(
                                    width: 285,
                                    height: 40,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment(0, 0),
                                          child: TextFormField(
                                            controller: emailTextController,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              hintText: 'Username',
                                              hintStyle: GoogleFonts.getFont(
                                                'Lato',
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF3C2452),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF3C2452),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                            ),
                                            style: GoogleFonts.getFont(
                                              'Lato',
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment(0.95, 0.5),
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedOpacity(
                                opacity: value == 20 ? 0 : 1,
                                duration: Duration(milliseconds: 2000),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                                  child: Container(
                                    width: 285,
                                    height: 40,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment(0, 0),
                                          child: TextFormField(
                                            controller: passwordTextController,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              hintText: 'Password',
                                              hintStyle: GoogleFonts.getFont(
                                                'Lato',
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF3C2452),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF3C2452),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                            ),
                                            style: GoogleFonts.getFont(
                                              'Lato',
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment(0.95, 0.5),
                                          child: Icon(
                                            Icons.lock_open,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedOpacity(
                                opacity: value == 20 ? 0 : 1,
                                duration: Duration(milliseconds: 2000),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FFButtonWidget(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder:
                                                  (BuildContext context) {
                                            return SignupPageWidget();
                                          }));
                                        },
                                        text: 'Sign up',
                                        options: FFButtonOptions(
                                          width: 125,
                                          height: 40,
                                          color: Color(0x00FFFFFF),
                                          textStyle: GoogleFonts.getFont(
                                            'Lato',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFF553BBA),
                                            width: 2,
                                          ),
                                          borderRadius: 0,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(35, 0, 0, 0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            await loginverify();
                                          },
                                          text: 'Sign in',
                                          options: FFButtonOptions(
                                            width: 125,
                                            height: 40,
                                            color: Color(0x00FFFFFF),
                                            textStyle: GoogleFonts.getFont(
                                              'Lato',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                            borderSide: BorderSide(
                                              color: Color(0xFF553BBA),
                                              width: 2,
                                            ),
                                            borderRadius: 0,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              AnimatedOpacity(
                                opacity: value == 20 ? 0 : 1,
                                duration: Duration(milliseconds: 2000),
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.getFont(
                                    'Lato',
                                    color: Color(0xFF676767),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  loginverify() async {
    try {
      emailTextController.text == ''
          ? print('nothin')
          : await _firestore
              .collection('userCart')
              .doc(emailTextController.text)
              .get()
              .then((value) async {
              if (value.data != null) {
                if (emailTextController.text != '' &&
                    passwordTextController.text != '') {
                  if (EmailValidator.validate(emailTextController.text)) {
                    final loginUser = await _auth.signInWithEmailAndPassword(
                        email: emailTextController.text,
                        password: passwordTextController.text);
                    if (loginUser != null) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return HomePageWidget();
                      }));
                    } else {
                      print(
                          "Enter correct password"); //  it is called when something wrong while loginuser
                    }
                  } else {
                    print("Enter correct email ");
                  }
                } else {
                  print("Please enter email or password");
                }
              } else {
                print('You are not registered');
              }
            });
    } catch (e) {
      print(e
          .code); // show flushbar or navigate to same page with a text show 'wrong email or password'
    }
  }
}

/*class _RenderScreenWidgetState extends State<RenderScreenWidget> {
  TextEditingController emailTextController;
  TextEditingController passwordTextController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  /* checkuseralreadyloginornot() async {
    User user = _auth.currentUser;
    print('user $user');
    if (user != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return HomePageWidget();
      }));
      //    return true;
    }
    //  return false;
  }*/

  @override
  void initState() {
    super.initState();
    //  checkuseralreadyloginornot();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF110631),
          ),
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                // alignment: Alignment(0.06, -0.63),
                child: Image.asset(
                  'assets/logo.png',
                  //'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/flutterflow_assets/ff_full_logo_light.png',
                  width: 280,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Container(
                // alignment: Alignment(0, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: Container(
                          width: 285,
                          height: 40,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment(0, 0),
                                child: TextFormField(
                                  controller: emailTextController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Username',
                                    hintStyle: GoogleFonts.getFont(
                                      'Lato',
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF3C2452),
                                        width: 2,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF3C2452),
                                        width: 2,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: GoogleFonts.getFont(
                                    'Lato',
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment(0.95, 0.5),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: Container(
                          width: 285,
                          height: 40,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment(0, 0),
                                child: TextFormField(
                                  controller: passwordTextController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: GoogleFonts.getFont(
                                      'Lato',
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF3C2452),
                                        width: 2,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF3C2452),
                                        width: 2,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: GoogleFonts.getFont(
                                    'Lato',
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment(0.95, 0.5),
                                child: Icon(
                                  Icons.lock_open,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FFButtonWidget(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return SignupPageWidget();
                                }));
                              },
                              text: 'Sign up',
                              options: FFButtonOptions(
                                width: 125,
                                height: 40,
                                color: Color(0x00FFFFFF),
                                textStyle: GoogleFonts.getFont(
                                  'Lato',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xFF553BBA),
                                  width: 2,
                                ),
                                borderRadius: 0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  await loginverify();
                                },
                                text: 'Sign in',
                                options: FFButtonOptions(
                                  width: 125,
                                  height: 40,
                                  color: Color(0x00FFFFFF),
                                  textStyle: GoogleFonts.getFont(
                                    'Lato',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFF553BBA),
                                    width: 2,
                                  ),
                                  borderRadius: 0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        'Forgot Password?',
                        style: GoogleFonts.getFont(
                          'Lato',
                          color: Color(0xFF676767),
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  loginverify() async {
    try {
      emailTextController.text == ''
          ? print('nothin')
          : await _firestore
              .collection('userCart')
              .doc(emailTextController.text)
              .get()
              .then((value) async {
              if (value.data != null) {
                if (emailTextController.text != '' &&
                    passwordTextController.text != '') {
                  if (EmailValidator.validate(emailTextController.text)) {
                    final loginUser = await _auth.signInWithEmailAndPassword(
                        email: emailTextController.text,
                        password: passwordTextController.text);
                    if (loginUser != null) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return HomePageWidget();
                      }));
                    } else {
                      print(
                          "Enter correct password"); //  it is called when something wrong while loginuser
                    }
                  } else {
                    print("Enter correct email ");
                  }
                } else {
                  print("Please enter email or password");
                }
              } else {
                print('You are not registered');
              }
            });
    } catch (e) {
      print(e
          .code); // show flushbar or navigate to same page with a text show 'wrong email or password'
    }
  }
}
*/
