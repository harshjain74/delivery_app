import 'package:delivery_app/home_page/cart_page.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ItemPageWidget extends StatefulWidget {
  final String imagepath;
  final int amount;
  final String id;
  final String foodname;
  final String foodcat;
  ItemPageWidget(
      this.imagepath, this.amount, this.foodname, this.foodcat, this.id);

  @override
  _ItemPageWidgetState createState() => _ItemPageWidgetState();
}

class _ItemPageWidgetState extends State<ItemPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  int quantity = 1;
  _ItemPageWidgetState();
  addToCart() async {
    var check = await _firestore
        .collection('userCart')
        .doc(auth.currentUser.email)
        .collection('cart')
        .doc(widget.id) //widget.amount.toString())
        .get()
        .then((value) {
      return value.data(); //check product is available or not already
    });

    check == null
        ? await _firestore
            .collection('userCart')
            .doc(auth.currentUser.email)
            .collection('cart')
            .doc(widget.id)
            //.doc(widget.amount.toString()) //product id will be use
            .set({
            'image': widget.imagepath,
            'name': widget.foodname,
            'price': widget.amount,
            'quantity': quantity
          })
        : await _firestore
            .collection('userCart')
            .doc(auth.currentUser.email)
            .collection('cart')
            .doc(widget.id)
            //.doc(widget.amount.toString()) //product id will be use
            .set({
            // 'image': widget.imagepath,
            // 'name': widget.foodname,
            // 'price': widget.amount,
            'quantity': quantity + check['quantity'],
          }, SetOptions(merge: true));
    /* SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      List data = json.decode(pref.getString('cart'));

      data.add({
        'image': widget.imagepath,
        'name': widget.foodname,
        'price': widget.amount,
        'quantity': quantity
      });
      pref.setString('cart', json.encode(data));
    } catch (e) {
      print(e);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          alignment: Alignment(0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                  ),
                  alignment: Alignment(0, 0),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        width: 375,
                        height: 375,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment(0, 0),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    widget.imagepath,
                                    //'https://picsum.photos/seed/230/600',
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    height:
                                        MediaQuery.of(context).size.height * 1,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment(-0.8, -0.78),
                              child: Container(
                                width: 50,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Color(0x830E0D0D),
                                ),
                                alignment: Alignment(0, 0),
                              ),
                            ),
                            Align(
                              alignment: Alignment(-0.74, -0.79),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Color(0x6EF8F4F4),
                                  size: 30,
                                ),
                                iconSize: 30,
                              ),
                            ),
                            Align(
                              alignment: Alignment(0.79, -0.8),
                              child: Container(
                                width: 100,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFC107),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment(0, 0),
                                child: Text(
                                  widget.foodcat,
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                          ),
                          alignment: Alignment(0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                child: Text(
                                  widget.foodname,
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Color(0xFF797575),
                                    size: 30,
                                  ),
                                  iconSize: 30,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 1, 10, 10),
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                          ),
                          alignment: Alignment(0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(1, 5, 0, 0),
                                    child: Text(
                                      '\$',
                                      style: FlutterFlowTheme.title3.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    widget.amount.toString(),
                                    style: FlutterFlowTheme.title3.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(2, 2, 20, 2),
                                    child: Container(
                                      width: 40,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFC8D7F1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment(0, 0),
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (quantity <= 0) {
                                            } else {
                                              quantity = quantity - 1;
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                        iconSize: 20,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                    child: Text(
                                      quantity.toString(),
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 40,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF5B79C),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment(0, 0),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          quantity = quantity + 1;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      iconSize: 20,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                        child: Text(
                          'Description',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                        child: Text(
                          'The strawberry is a succulent and fragrant fruit of bright red colour, obtained from the plant with the same name. In the West it is considered as the \" queen of the fruit\". ... ',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                  ),
                  alignment: Alignment(0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Price',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '\$',
                                  style: FlutterFlowTheme.title3.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '${widget.amount * quantity}',
                                  style: FlutterFlowTheme.title3.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: FFButtonWidget(
                          onPressed: () async {
                            await addToCart();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return CartPageWidget();
                            }));
                          },
                          text: 'Add to card',
                          options: FFButtonOptions(
                            width: 150,
                            height: double.infinity,
                            color: Color(0xFFFFC107),
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF060606),
                              fontWeight: FontWeight.w500,
                            ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 15,
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
  }
}
