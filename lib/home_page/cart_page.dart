import 'package:delivery_app/home_page/checkout_page.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CartPageWidget extends StatefulWidget {
  @override
  _CartPageWidgetState createState() => _CartPageWidgetState();
}

class _CartPageWidgetState extends State<CartPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  int totalorder = 0;
  int totalamount = 0;
  void initState() {
    super.initState();
    checkcartlength();
  }

  bool cartempty = true;
  void checkcartlength() async {
    await _firestore
        .collection('userCart')
        .doc(auth.currentUser.email)
        .collection('cart')
        .get()
        .then((value) {
      setState(() {
        cartempty = value.docs.length == 0;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
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
          alignment: Alignment(0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFD050505),
                      ),
                      alignment: Alignment(0, 0),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xFFDBD7D7),
                            size: 25,
                          ),
                          iconSize: 25,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment(-0.3, 0),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'My Order',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.title3.override(
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                  ),
                  alignment: Alignment(0, 0),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 10, 8),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Color(0xFFFFC107),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(2, 20, 0, 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 15, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Your Location',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.title2.override(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      'Harsh jain ,jain chock nakur(Saharanpur)',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF4CA4E),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                alignment: Alignment(0, 0),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  iconSize: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                    initialData: null,
                    stream: _firestore
                        .collection('userCart')
                        .doc(auth.currentUser.email)
                        .collection('cart')
                        .snapshots(),
                    builder: (BuildContext context, snap) {
                      totalamount = 0;
                      totalorder = 0;

                      return snap.hasData
                          ? snap.data.docs.length == 0
                              ? Card(
                                  color: Color(0xFFEEEEEE),
                                  child: Center(
                                    child: Text('Your cart is Empty!'),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: snap.data.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Future.delayed(Duration.zero, () async {
                                      setState(() {
                                        totalamount = (snap.data.docs[index]
                                                    ['price'] *
                                                snap.data.docs[index]
                                                    ['quantity']) +
                                            totalamount;
                                        totalorder = snap.data.docs[index]
                                                ['quantity'] +
                                            totalorder;
                                      });
                                    });

                                    return Padding(
                                      //  key: Key(total_amount.toString()),
                                      padding: EdgeInsets.fromLTRB(1, 10, 0, 0),
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                        ),
                                        alignment: Alignment(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: ListView(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFEEEEEE),
                                                ),
                                                alignment: Alignment(0, 0),
                                                child: Align(
                                                  alignment:
                                                      Alignment(0.05, -0.05),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.network(
                                                          '${snap.data.docs[index]['image']}',
                                                          width: 50,
                                                          height: 50,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                10, 0, 0, 0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '\$${snap.data.docs[index]['price'] * snap.data.docs[index]['quantity']}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .title2
                                                                      .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                              ),
                                                            ),
                                                            Text(
                                                              '${snap.data.docs[index]['name']}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 0, 0, 0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.45,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFEEEEEE),
                                                  ),
                                                  alignment: Alignment(0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 35,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFBDB9B9),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        alignment:
                                                            Alignment(0, 0),
                                                        child: IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              if (snap.data.docs[
                                                                          index]
                                                                      [
                                                                      'quantity'] >
                                                                  0) {
                                                                _firestore
                                                                    .collection(
                                                                        'userCart')
                                                                    .doc(auth
                                                                        .currentUser
                                                                        .email)
                                                                    .collection(
                                                                        'cart')
                                                                    .doc(snap
                                                                        .data
                                                                        .docs[
                                                                            index]
                                                                        .id)
                                                                    .set({
                                                                  'quantity': snap
                                                                          .data
                                                                          .docs[index]['quantity'] -
                                                                      1
                                                                }, SetOptions(merge: true));
                                                                totalamount = totalamount -
                                                                    snap.data.docs[
                                                                            index]
                                                                        [
                                                                        'price'];
                                                                totalorder =
                                                                    totalorder -
                                                                        1;
                                                              }
                                                            });
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .remove_rounded,
                                                            color: Colors.black,
                                                            size: 18,
                                                          ),
                                                          // iconSize: 20,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${snap.data.docs[index]['quantity']}',
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 35,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFBDB9B9),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        alignment:
                                                            Alignment(0, 0),
                                                        child: IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _firestore
                                                                  .collection(
                                                                      'userCart')
                                                                  .doc(auth
                                                                      .currentUser
                                                                      .email)
                                                                  .collection(
                                                                      'cart')
                                                                  .doc(snap
                                                                      .data
                                                                      .docs[
                                                                          index]
                                                                      .id)
                                                                  .set(
                                                                      {
                                                                    'quantity':
                                                                        snap.data.docs[index]['quantity'] +
                                                                            1
                                                                  },
                                                                      SetOptions(
                                                                          merge:
                                                                              true));
                                                              totalamount = totalamount +
                                                                  snap.data.docs[
                                                                          index]
                                                                      ['price'];
                                                              totalorder =
                                                                  totalorder +
                                                                      1;
                                                            });
                                                          },
                                                          icon: Icon(
                                                            Icons.add,
                                                            color: Colors.black,
                                                            size: 18,
                                                          ),
                                                          // iconSize: 20,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFF62323),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        alignment:
                                                            Alignment(0, 0),
                                                        child: IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _firestore
                                                                  .collection(
                                                                      'userCart')
                                                                  .doc(auth
                                                                      .currentUser
                                                                      .email)
                                                                  .collection(
                                                                      'cart')
                                                                  .doc(snap
                                                                      .data
                                                                      .docs[
                                                                          index]
                                                                      .id)
                                                                  .delete();
                                                            });
                                                          },
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: Colors.black,
                                                            size: 24,
                                                          ),
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
                                  },
                                )
                          : Card(
                              color: Color(0xFFEEEEEE),
                              child: Center(
                                child: Text('Your cart is Empty!'),
                              ),
                            ); //Add Spinner
                    }),
              ),
              Container(
                width: 100,
                height: 120,
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                ),
                alignment: Alignment(0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total',
                                style: FlutterFlowTheme.title2.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'result for $totalorder items',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              )
                            ],
                          ),
                          Text(
                            '\$$totalamount',
                            style: FlutterFlowTheme.title2.override(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                        child: FFButtonWidget(
                          onPressed: () {
                            if (!cartempty) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return CheckoutPageWidget(
                                    totalorder, totalamount);
                              }));
                            } else {
                              print('Your cart is empty');
                            }
                          },
                          text: 'Checkout Order',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 40,
                            color: cartempty ? Colors.red : Color(0xFFFEC006),
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF080707),
                              fontWeight: FontWeight.w600,
                            ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 12,
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
      ),
    );
  }
}
