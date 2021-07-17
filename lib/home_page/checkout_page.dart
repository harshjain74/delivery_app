import 'package:delivery_app/home_page/track_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckoutPageWidget extends StatefulWidget {
  final int totalorder;
  final int totalamount;

  CheckoutPageWidget(this.totalorder, this.totalamount);

  @override
  _CheckoutPageWidgetState createState() => _CheckoutPageWidgetState();
}

class _CheckoutPageWidgetState extends State<CheckoutPageWidget> {
  TextEditingController notetextController,
      addresscontroller,
      phonenumbercontroller;
  final auth = FirebaseAuth.instance;
  Razorpay _razorpay;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String name = '';
  String address = '';
  double lati;
  double longi;
  getposition(String addr) async {
    /*await _firestore
        .collection('userCart')
        .doc(auth.currentUser.email)
        .collection('userdetail')
        .doc('data')
        .get()
        .then((value) async {*/
    var addresses = await Geocoder.local.findAddressesFromQuery(addr);
    var first = addresses.first;
    setState(() {
      lati = first.coordinates.latitude;
      longi = first.coordinates.longitude;
      // });
    });
  }

  final _firestore = FirebaseFirestore.instance;
  getUserData() async {
    await _firestore
        .collection('userCart')
        .doc(auth.currentUser.email)
        .collection('userdetail')
        .doc('data')
        .get()
        .then((value) {
      setState(() {
        name = value.data()['firstname'] + ' ' + value.data()['lastname'];
        address = value.data()['address'];
      });
    });
  }

  fetching() async {
    await getUserData();
  }

  @override
  void initState() {
    super.initState();
    notetextController = TextEditingController();
    addresscontroller = TextEditingController();
    phonenumbercontroller = TextEditingController();
    fetching();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_ZBAKTObE5Un25F',
      'amount': 100,
      'name': 'Harsh',
      'description': 'Payment',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e);
    }
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
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
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
                                  'Checkout',
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
                      padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Customer Information',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Color(0xFFFEC006),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment(0, 0),
                            child: Text(
                              'Edit',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        name,
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        address,
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFFC7C6C6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment(0, 0),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: TextFormField(
                            controller: notetextController,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Note...',
                              hintStyle: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                            ),
                            maxLines: 30,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        'Order Information',
                        style: FlutterFlowTheme.title2.override(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      child: StreamBuilder(
                          initialData: null,
                          stream: _firestore
                              .collection('userCart')
                              .doc(auth.currentUser.email)
                              .collection('cart')
                              .snapshots(),
                          builder: (BuildContext context, snap) {
                            return !snap.hasData
                                ? Container()
                                : ListView.builder(
                                    itemCount: snap.data.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Text(
                                          '${snap.data.docs[index]['quantity']}x   ${snap.data.docs[index]['name']}',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      );
                                    });
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text('Enter your address',
                          style: TextStyle(color: Colors.black)),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: TextFormField(
                        controller: addresscontroller,
                        obscureText: false,
                        decoration: InputDecoration(
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        'Enter your phone number',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: TextFormField(
                        controller: phonenumbercontroller,
                        obscureText: false,
                        decoration: InputDecoration(
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

                      /*'Payment Method',
                        style: FlutterFlowTheme.title2.override(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),*/
                      //  ),
                    ),
                    /* Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        'I have to add a Selector for payment',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    )*/
                  ],
                ),
              ),
              Container(
                width: 100,
                height: 130,
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
                                'result for ${widget.totalorder} orders',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              )
                            ],
                          ),
                          Text(
                            '\$${widget.totalamount}',
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
                          onPressed: () async {
                            if (phonenumbercontroller.text != '') {
                              if (phonenumbercontroller.text.length == 10) {
                                openCheckout();
                              } else {
                                print('enter correct phone number');
                              }
                            } else {
                              print('enter phone number');
                            }
                          },
                          text: 'Payment',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 40,
                            color: Color(0xFFFEC006),
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    var now = DateTime.now();
    var months = [
      "Jan",
      "Feb",
      "Mar",
      "April",
      "May",
      "June",
      "July",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    await getposition(address); //address
    int currentid;
    await _firestore
        .collection('userCart')
        .doc(auth.currentUser.email)
        .collection('cart')
        .get()
        .then((snapshot) async {
      await _firestore
          .collection('orders')
          //.where('usermail',
          //    isEqualTo: auth.currentUser.email)
          //.doc(auth.currentUser.email)
          //.collection('orders')
          .get()
          .then((value) async {
        setState(() {
          print('value aayi $value');
          if (value.docs.length > 0) {
            currentid = value.docs.length + 1;
          } else {
            currentid = 1;
          }
        });
        print(phonenumbercontroller.text);
        String time = now.minute >= 10 ? '${now.minute}' : '0${now.minute}';

        await _firestore.collection('orders').doc(currentid.toString())
            // .doc(auth.currentUser.email)
            // .collection('orders')
            // .doc('$currentid')
            .set({
          'note': 'nothing',
          'completed': false,
          'userlat': lati,
          'userlong': longi,
          'address': addresscontroller.text,
          'dellong': 77.3049,
          'status': 'started',
          'usermail': auth.currentUser.email,
          'name': name,
          'phone': phonenumbercontroller.text,
          'totalamount': widget.totalamount,

          //shop location

          'dellat': 29.92065,
          'deliveredtime': 'Not yet',
          'currentdate': "${months[now.month - 1]} ,${now.day}",
          'currenttime':
              "${(now.hour - 12)}:$time${(DateTime.now().hour - 12) > 0 ? 'pm' : 'am'}" //shop location
        });
        int count = 0;
        for (DocumentSnapshot ds in snapshot.docs) {
          await _firestore.collection('orders').doc(currentid.toString())
              //  .collection('userCart')
              // .doc(auth.currentUser.email)
              //  .collection('orders')
              //  .doc('$currentid')
              //.set({ds.id: ds.data()}, SetOptions(merge: true));
              .set({
            'items': {count.toString(): ds.data()}
          }, SetOptions(merge: true));
          ds.reference.delete();
          count = count + 1;
        }

        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return TrackPageWidget(
            address: addresscontroller.text,
            userlocation: LatLng(lati, longi),
            orderid: currentid.toString(),
            outdelivery: 'started',
          );
        }), (Route<dynamic> route) => false);
      });
    });
    // Do something when payment succeeds
    Fluttertoast.showToast(
        msg: "success ${response.orderId}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('Error ${response.code}');
    Fluttertoast.showToast(
        msg: "Error ${response.code}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    Fluttertoast.showToast(
        msg: "Eternal wallet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
