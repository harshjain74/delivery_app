import 'dart:collection';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class TrackPageWidget extends StatefulWidget {
  TrackPageWidget(
      {this.address, this.userlocation, this.orderid, this.outdelivery});
  final String address;
  final LatLng userlocation;
  final String orderid;
  final String outdelivery;

  @override
  _TrackPageWidgetState createState() => _TrackPageWidgetState();
}

class _TrackPageWidgetState extends State<TrackPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final auth = FirebaseAuth.instance;
  String outfordelivery = 'started';
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _firestore = FirebaseFirestore.instance;

  void _setMarker(
      LatLng pointed, String titled, double clr, String deliverystarted) {
    //   latlng.add(pointed);

    setState(() {
      outfordelivery = deliverystarted;
      _markers.add(Marker(
        markerId: MarkerId(titled),
        position: pointed,
        infoWindow: InfoWindow(
          title: titled,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(clr),
      ));
      /* _polyline.add(Polyline(
        polylineId: PolylineId(pointed.toString()),
        visible: true,
        //latlng is List<LatLng>
        points: latlng,
        color: Colors.blue,
      ));*/
    });
  }

  Set<Marker> _markers = HashSet();
  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(29.92009, 77.3049),
    zoom: 14.4746,
  );
  // below three lines used for _polyline
  //Set<Polyline> _polyline = HashSet();

  //List<LatLng> latlng = List();
  //LatLng _new = LatLng(27.29002, 77.3049);
  double lat = 29.29002;
  double lon = 77.3049;
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
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Color(0xFF080707),
                      ),
                    ),
                    alignment: Alignment(0, 0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment(0, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: StreamBuilder(
                              stream: _firestore
                                  //   .collection('userCart')
                                  //   .doc(auth.currentUser.email)
                                  .collection('orders')
                                  .doc(widget.orderid)
                                  .snapshots(),
                              builder: (BuildContext context, snap) {
                                getLocation();

                                return GoogleMap(
                                  //  polylines: _polyline,
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    setState(() {
                                      _setMarker(
                                          widget.userlocation,
                                          'Delivery location',
                                          BitmapDescriptor.hueRed,
                                          widget.outdelivery);
                                    });
                                  },
                                  initialCameraPosition: _kGooglePlex,
                                  markers: _markers,
                                  /*onTap: (point) {
                                    _setMarker(point, 'Out for Delivery',
                                        BitmapDescriptor.hueAzure);
                                  },*/
                                );
                              },
                            ),
                            //google
                          ),
                        ),
                        Align(
                          alignment: Alignment(-0.89, -0.91),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0x1D7B7878),
                            ),
                            alignment: Alignment(0, 0),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Color(0xFF5C5858),
                                  size: 24,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                ),
                alignment: Alignment(0, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(2, 20, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                              ),
                              alignment: Alignment(0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow[200],
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xFF060606),
                                      ),
                                    ),
                                    alignment: Alignment(0, 0),
                                    child: FaIcon(
                                      FontAwesomeIcons.edit,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Text(
                                      'Ordered',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                              ),
                              alignment: Alignment(0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow[200],
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xFF060606),
                                      ),
                                    ),
                                    alignment: Alignment(0, 0),
                                    child: Icon(
                                      Icons.restore,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Text(
                                      'Process',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                              ),
                              alignment: Alignment(0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: outfordelivery ==
                                                  'Out for delivery' ||
                                              outfordelivery == 'Delivered'
                                          ? Colors.yellow[200]
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xFF060606),
                                      ),
                                    ),
                                    alignment: Alignment(0, 0),
                                    child: Icon(
                                      Icons.delivery_dining,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Text(
                                      'Delivery',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                              ),
                              alignment: Alignment(0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: outfordelivery == 'Delivered'
                                          ? Colors.yellow[200]
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xFF060606),
                                      ),
                                    ),
                                    alignment: Alignment(0, 0),
                                    child: FaIcon(
                                      FontAwesomeIcons.delicious,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Text(
                                      'Received',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
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
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.timelapse,
                                  color: Color(0xFFFEC006),
                                  size: 28,
                                ),
                                Container(
                                  width: 5,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFEC006),
                                  ),
                                  alignment: Alignment(0, 0),
                                ),
                                Icon(
                                  Icons.location_pin,
                                  color: Color(0xFFFEC006),
                                  size: 24,
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Estimated Time',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '25 minutes',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Your location',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        widget.address,
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
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

  getLocation() async {
    print('getlocation called');
    try {
      await _firestore
          // .collection('userCart')
          // .doc(auth.currentUser.email)
          .collection('orders')
          .doc(widget.orderid)
          .get()
          .then((value) async {
        List l = [value.data()['dellat'], value.data()['dellong']];
        //  print('$lat, $l');
        _setMarker(LatLng(l[0], l[1]), 'Out for Delivery',
            BitmapDescriptor.hueAzure, value.data()['status']);
        //  lat = lat + 0.0050;
        //  lon = lon + 0.0050;
        /*await _firestore
            .collection('orders')
            //.doc(auth.currentUser.email)
            //.collection('orders')
            .doc(widget.orderid)
            .set({'dellong': l[1], 'dellat': l[0]},
                SetOptions(merge: true)).then((value) {
          print('done ');
        });*/
      });
    } catch (e) {
      print(e);
    }
  }

  /*void updateevery() {
    var time = const Duration(seconds: 1);
    Timer.periodic(time, (timer) async {
      if (!timer.isActive) {
        timer.cancel();
      }
      await getLocation();
      print(timer.isActive);
    });
  }*/
}
