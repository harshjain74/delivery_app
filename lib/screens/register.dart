import 'package:delivery_app/home_page/home_page_widget.dart';
import 'dart:io';
import 'dart:ui';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPageWidget extends StatefulWidget {
  @override
  _SignupPageWidgetState createState() => _SignupPageWidgetState();
}

class _SignupPageWidgetState extends State<SignupPageWidget> {
  final auth = FirebaseAuth.instance;
  TextEditingController firstnametextController;
  TextEditingController lastnametextController;
  TextEditingController emailtextController;
  TextEditingController contacttextController;
  TextEditingController addresstextController;
  TextEditingController citytextController;
  TextEditingController statetextController;
  TextEditingController zipcodetextController;
  TextEditingController countrytextController;
  TextEditingController passwordtextController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _firestore = FirebaseFirestore.instance;

  File _image;
  final picker = ImagePicker();
  Future setImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
    // await setimg();
  }

  String path =
      'https://images2.minutemediacdn.com/image/upload/c_crop,h_1126,w_2000,x_0,y_181/f_auto,q_auto,w_1100/v1554932288/shape/mentalfloss/12531-istock-637790866.jpg';

  Future setimg() async {
    try {
      if (_image != null) {
        print('error 2');
        Reference firebaseReference = FirebaseStorage.instance
            .ref()
            .child("profilepics")
            .child("${auth.currentUser.email}.jpg");

        final UploadTask task = firebaseReference.putFile(_image);

        await (await task).ref.getDownloadURL().then((value) async {
          setState(() {
            path = value;
          });
          await _firestore
              .collection('userCart')
              .doc(auth.currentUser.email)
              .collection('userdetail')
              .doc('data')
              .set({'image data': value}, SetOptions(merge: true));
        });
      } else {
        print('problem to take image');
        //path = null;
      }
    } catch (e) {
      print('error $e');
    }
  }

  @override
  void initState() {
    super.initState();
    firstnametextController = TextEditingController();
    lastnametextController = TextEditingController();
    emailtextController = TextEditingController();
    contacttextController = TextEditingController();
    addresstextController = TextEditingController();
    citytextController = TextEditingController();
    statetextController = TextEditingController();
    zipcodetextController = TextEditingController();
    countrytextController = TextEditingController();
    passwordtextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setImage();
                      },
                      child: Align(
                        alignment: Alignment(0, 0),
                        child: Container(
                          width: 120,
                          height: 120,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: _image != null
                                  ? FileImage(_image)
                                  : NetworkImage(
                                      'https://picsum.photos/seed/533/600'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.26, 0.92),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent, //Color(0xFF122AE7),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 30,
                          ),
                          iconSize: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'First Name',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: TextFormField(
                                  controller: firstnametextController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Harsh',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Last Name',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: TextFormField(
                                  controller: lastnametextController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Jain',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: TextFormField(
                            controller: emailtextController,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'hkakjains@gmail.com',
                              hintStyle: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal,
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact number',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: TextFormField(
                            controller: contacttextController,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: '+917417875876',
                              hintStyle: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal,
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: TextFormField(
                            controller: addresstextController,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'jain chock, nakur',
                              hintStyle: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal,
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'City',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: TextFormField(
                                  controller: citytextController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Saharanpur',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'State',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: TextFormField(
                                  controller: statetextController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Uttar Pradesh',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Zip Code',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: TextFormField(
                                  controller: zipcodetextController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: '247342',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Country',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: TextFormField(
                                  controller: countrytextController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'India',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: TextFormField(
                            controller: passwordtextController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: '********',
                              hintStyle: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal,
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        verifyregister();
                      },
                      text: 'Sign up',
                      options: FFButtonOptions(
                        width: 130,
                        height: 40,
                        color: FlutterFlowTheme.primaryColor,
                        textStyle: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 12,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future setuserdata(
    String firstname,
    String lastname,
    String email,
    String contact,
    String address,
    String city,
    String state,
    String zipcode,
    String country,
    String password,
  ) async {
    await _firestore.collection('userCart').doc(email).set({'isowner': false});
    await _firestore
        .collection('userCart')
        .doc(email)
        .collection('userdetail')
        .doc('data')
        .set({
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'contact': contact,
      'address': address,
      'addcity': city,
      'addstate': state,
      'zipcode': zipcode,
      'country': country,
      'isowner': false,
      'password': password,
    }).then((value) => userinputclear());
  }

  userinputclear() {
    emailtextController.clear();
    firstnametextController.clear();
    contacttextController.clear();
    lastnametextController.clear();
    citytextController.clear();
    statetextController.clear();
    zipcodetextController.clear();
    countrytextController.clear();
    passwordtextController.clear();
    addresstextController.clear();
  }

  verifyregister() async {
    if (EmailValidator.validate(emailtextController.text)) {
      final emailcheck = await _firestore
          .collection('userCart')
          .doc(emailtextController.text)
          .get();
      final emailcheckowner = await _firestore
          .collection('owner')
          .doc(emailtextController.text)
          .get();

      try {
        if (!emailcheck.exists && !emailcheckowner.exists) {
          if (firstnametextController.text != '' &&
              lastnametextController.text != '' &&
              emailtextController.text != '' &&
              citytextController.text != '' &&
              contacttextController.text != '' &&
              addresstextController.text != '' &&
              statetextController.text != '' &&
              zipcodetextController.text != '' &&
              countrytextController.text != '' &&
              passwordtextController.text != '') {
            final user = await auth.createUserWithEmailAndPassword(
                email: emailtextController.text,
                password: passwordtextController.text);
            final User currentUser = auth.currentUser;

            assert(user.user.uid == currentUser.uid);

            await setuserdata(
                    firstnametextController.text,
                    lastnametextController.text,
                    emailtextController.text,
                    contacttextController.text,
                    addresstextController.text,
                    citytextController.text,
                    statetextController.text,
                    zipcodetextController.text,
                    countrytextController.text,
                    passwordtextController.text)
                .whenComplete(() async {
              setimg();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HomePageWidget();
                  },
                ),
              );
            });

            //show a pop up please add a valid email id. in else part or password length minimum6
          } else {
            print('fill all details');
          }
        } else {
          print('email is already registered');
        }
      } catch (e) {
        print('$e found in verify register');
      }
    } else {
      print('Enter valid email');
    }
  }
}
