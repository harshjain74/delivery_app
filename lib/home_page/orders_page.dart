import 'package:delivery_app/flutter_flow/flutter_flow_widgets.dart';
import 'package:delivery_app/home_page/track_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersWidget extends StatefulWidget {
  OrdersWidget({Key key}) : super(key: key);

  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFEDF336),
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          iconSize: 30,
        ),
        title: AutoSizeText(
          'Orders',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Color(0xFF070707),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: StreamBuilder(
            stream: _firestore
                .collection('orders')
                .where('usermail', isEqualTo: auth.currentUser.email)
                // .collection('userCart')
                // .doc(auth.currentUser.email)
                // .collection('orders')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return !snapshot.hasData
                  ? Container()
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFFF7F2F2),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: // Row(
                                  // mainAxisSize: MainAxisSize.max,
                                  // children: [
                                  Padding(
                                padding: EdgeInsets.fromLTRB(16, 5, 5, 10),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Order id ${snapshot.data.docs[index].id}', //${snapshot.data.docs[index].id}',
                                        style:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF15212B),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        '${snapshot.data.docs[index]['currentdate']},${snapshot.data.docs[index]['currenttime']} - ${snapshot.data.docs[index]['deliveredtime']} ',
                                        style:
                                            FlutterFlowTheme.bodyText2.override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF8B97A2),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    snapshot.data.docs[index]
                                                ['deliveredtime'] ==
                                            'Cancelled'
                                        ? Container()
                                        : Align(
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                              onTap: () async {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(builder:
                                                        (BuildContext context) {
                                                  return TrackPageWidget(
                                                    address: snapshot.data
                                                        .docs[index]['address'],
                                                    userlocation: LatLng(
                                                        snapshot.data
                                                                .docs[index]
                                                            ['userlat'],
                                                        snapshot.data
                                                                .docs[index]
                                                            ['userlong']),
                                                    orderid: snapshot
                                                        .data.docs[index].id,
                                                    outdelivery: snapshot.data
                                                        .docs[index]['status'],
                                                  );
                                                }));
                                              },
                                              child: Text(
                                                'Track order', //${snapshot.data.docs[index].id}',
                                                style: FlutterFlowTheme
                                                    .subtitle2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF15212B),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder:
                                                  (BuildContext context) {
                                            return OrderDetailPageWidget(
                                                snapshot.data.docs[index].id,
                                                snapshot.data.docs[index]
                                                    .data()['usermail'],
                                                snapshot.data.docs[index]
                                                    .data()['name'],
                                                snapshot.data.docs[index]
                                                    .data()['address'],
                                                snapshot.data.docs[index]
                                                    .data()['status'],
                                                snapshot.data.docs[index]
                                                    .data()['phone'],
                                                snapshot.data.docs[index]
                                                    .data()['items'],
                                                snapshot.data.docs[index]
                                                    .data()['totalamount']);
                                          }));
                                        },
                                        child: Text(
                                          'Order details', //${snapshot.data.docs[index].id}',
                                          style: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF15212B),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}

class OrderDetailPageWidget extends StatefulWidget {
  OrderDetailPageWidget(
      this.orderid,
      this.ordermail,
      this.orderby,
      this.address,
      this.status,
      this.phonenumber,
      this.items,
      this.totalamount);
  final String orderid, status, ordermail, orderby, address, phonenumber;
  final items, totalamount;

  @override
  _OrderDetailPageWidgetState createState() => _OrderDetailPageWidgetState();
}

class _OrderDetailPageWidgetState extends State<OrderDetailPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFF0F805),
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          iconSize: 30,
        ),
        title: Text(
          'Order id ${widget.orderid}',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFF010317),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              //mainAxisSize: MainAxisSize.max,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Summary',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Customer name: ${widget.orderby}',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Status: ${widget.status}',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      // String name = widget.items[index.toString()]["name"];
                      // int price = widget.items[index.toString()]["price"];
                      // int quantity = widget.items[index.toString()]["quantity"];
                      /*  return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'kk', //name,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: Text('kk', //quantity.toString(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 16)),
                              ),
                              Expanded(
                                child: Text('kk', //price.toString(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 16)),
                              ),
                              Expanded(
                                child: Text('kk', //'${price * quantity}',
                                    textAlign: TextAlign.right,
                                    //'${widget.items[index.toString()]["price"] * widget.items["hDqH5A6YqKNHwcbYPspM"]["quantity"]}',
                                    style: TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                        ],
                      );
                  */
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
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                  ),
                                  alignment: Alignment(0, 0),
                                  child: Align(
                                    alignment: Alignment(0.05, -0.05),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            '${widget.items[index.toString()]['image']}',
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '\$${widget.items[index.toString()]['price'] * widget.items[index.toString()]['quantity']}',
                                                textAlign: TextAlign.start,
                                                style: FlutterFlowTheme.title2
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                              Text(
                                                '${widget.items[index.toString()]['name']}',
                                                style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
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
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEEEEEE),
                                    ),
                                    alignment: Alignment(0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${widget.items[index.toString()]['quantity']}',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
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
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Total amount',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${widget.totalamount}',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        'Address: ${widget.address}',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Phone number: ${widget.phonenumber}',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 15,
                        ),
                        child: FFButtonWidget(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('orders')
                                .doc(widget.orderid)
                                .update({
                              'status': 'cancelled',
                              'deliveredtime': 'Cancelled'
                            });
                            Navigator.pop(context);
                          },
                          text: 'Cancel Order',
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
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
