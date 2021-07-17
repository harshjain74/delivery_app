import 'package:delivery_app/home_page/cart_page.dart';
import 'package:delivery_app/home_page/profile.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'item_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'orders_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  TextEditingController textController;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  String drawerName = 'Unknown';
  String drawerImage =
      'https://images2.minutemediacdn.com/image/upload/c_crop,h_1126,w_2000,x_0,y_181/f_auto,q_auto,w_1100/v1554932288/shape/mentalfloss/12531-istock-637790866.jpg';

  String _selectedFood = 'null';

  String productinsale = 'Sale';

  drawerData() async {
    await _firestore
        .collection('userCart')
        .doc(_auth.currentUser.email)
        .collection('userdetail')
        .doc('data')
        .get()
        .then((value) {
      setState(() {
        drawerName = value.data()['firstname'] + ' ' + value.data()['lastname'];
        drawerImage = value.data()['userimage'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    drawerData();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Container(
          width: MediaQuery.of(context).size.width / 1.2,
          child: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ProfilePageWidget();
                    }));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.width * .30,
                    // height: 100,
                    child: DrawerHeader(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                //width: 120,
                                //height: 120,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  drawerImage,
                                  //'https://images2.minutemediacdn.com/image/upload/c_crop,h_1126,w_2000,x_0,y_181/f_auto,q_auto,w_1100/v1554932288/shape/mentalfloss/12531-istock-637790866.jpg', // 'https://picsum.photos/seed/169/600',
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                child: Text(
                                  drawerName,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.yellowAccent,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Orders'),
                  trailing: Icon(Icons.shopping_cart, color: Colors.black),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return OrdersWidget();
                    }));
                  },
                ),
                ListTile(
                  title: Text('Cart'),
                  trailing: Icon(Icons.shopping_cart, color: Colors.black),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer

                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return CartPageWidget();
                    }));
                  },
                ),
                ListTile(
                  title: Text('Logout'),
                  trailing: Icon(Icons.logout, color: Colors.black),
                  onTap: () {
                    /* Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return OrdersWidget();
                    }));*/
                  },
                ),
              ],
            ),
          ),
        ),
        key: scaffoldKey,
        body: ListView(
          /* children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
              ),
              alignment: Alignment(0, 0),
              child: Column(*/
          //mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: 150,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(0, -1),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/maincover.jpg'),
                            fit: BoxFit.cover),
                        // color: Color(0xFFFAF40A),
                      ),
                      alignment: Alignment(0, 0),
                      //  child: Image.asset('assets/maincover.jpg'),
                    ),
                  ),
                  Align(
                    alignment: Alignment(1, -1),
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(0),
                        ),
                        child: Image.asset(
                          'assets/backgroundpizza.jpg',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      /*  decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/backgroundpizza.jpg'),
                              fit: BoxFit.cover),
                        ),*/
                    ),
                  ),
                  Align(
                    alignment: Alignment(-1, -1),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: IconButton(
                          onPressed: () {
                            scaffoldKey.currentState.openDrawer();
                          },
                          icon: Icon(
                            Icons.menu,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-1, 0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Best Food',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-1, .3),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'For You Today',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0x58000000),
                  ),
                ),
                alignment: Alignment(0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search_sharp,
                        color: Colors.black,
                        size: 30,
                      ),
                      iconSize: 30,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: TextFormField(
                          controller: textController,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: FlutterFlowTheme.bodyText1.override(
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
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                  child: StreamBuilder(
                stream: _firestore.collection('carouseldata').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  return !snapshot.hasData
                      ? Container()
                      : CarouselSlider.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index, index1) {
                            return Container(
                              child: Image.network(
                                '${snapshot.data.docs[index].data()['1']}',
                              ),
                            );
                          },
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            autoPlay: true,
                            onPageChanged: (index, reason) {
                              setState(() {});
                            },
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                          ),
                        );
                },
              )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                width: 100,
                height: 60,
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(1, 10, 0, 5),
                        child: FFButtonWidget(
                          onPressed: () async {
                            setState(() {
                              _selectedIndex = 0;
                              _selectedFood = 'null';
                            });
                          },
                          text: 'Popular',
                          options: FFButtonOptions(
                            width: 130,
                            height: 30,
                            color: _selectedIndex == 0
                                ? Colors.yellowAccent
                                : Colors.blue, //Color(0xFFA4A7AE),
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Color(0x9D000000),
                            ),
                            borderSide: BorderSide(
                              color: _selectedIndex == 0
                                  ? Colors.transparent
                                  : Color(0x83756E6E),
                              width: 1,
                            ),
                            borderRadius: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
                        child: FFButtonWidget(
                          onPressed: () {
                            setState(() {
                              _selectedIndex = 1;
                              _selectedFood = 'null';
                            });
                          },
                          text: 'Discount',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: _selectedIndex == 1
                                ? Colors.yellowAccent
                                : Colors.blue,
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Color(0x9D000000),
                            ),
                            borderSide: BorderSide(
                              color: _selectedIndex == 1
                                  ? Colors.transparent
                                  : Colors
                                      .transparent, //Color(0xFFA4A7AE), //Color(0x83FCFBFB),
                              width: 1,
                            ),
                            borderRadius: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
                        child: FFButtonWidget(
                          onPressed: () {
                            setState(() {
                              _selectedIndex = 2;
                              _selectedFood = 'Fast Food';
                            });
                          },
                          text: 'Fast Food',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: _selectedIndex == 2
                                ? Colors.yellowAccent
                                : Colors.blue, //Color(0xFFA4A7AE),
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Color(0x9D000000),
                            ),
                            borderSide: BorderSide(
                              color: _selectedIndex == 2
                                  ? Colors.transparent
                                  : Color(0x83756E6E),
                              width: 1,
                            ),
                            borderRadius: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
                        child: FFButtonWidget(
                          onPressed: () {
                            setState(() {
                              _selectedIndex = 3;
                              _selectedFood = 'Indian Food';
                            });
                          },
                          text: 'Indian food',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: _selectedIndex == 3
                                ? Colors.yellowAccent
                                : Colors.blue, //Color(0xFFA4A7AE),
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Color(0x9D000000),
                            ),
                            borderSide: BorderSide(
                              color: _selectedIndex == 3
                                  ? Colors.transparent
                                  : Color(0x83756E6E),
                              width: 1,
                            ),
                            borderRadius: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
                        child: FFButtonWidget(
                          onPressed: () {
                            setState(() {
                              _selectedIndex = 4;
                              _selectedFood = 'null';
                            });
                          },
                          text: 'Pizza',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: _selectedIndex == 4
                                ? Colors.yellowAccent
                                : Colors.blue, // Color(0xFFA4A7AE),
                            // color: Colors.transparent,
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Color(0x9D000000),
                            ),
                            borderSide: BorderSide(
                              color: _selectedIndex == 4
                                  ? Colors.transparent
                                  : Color(0x83756E6E),
                              width: 1,
                            ),
                            borderRadius: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            //  Expanded(
            //  child:
            Padding(
              padding: EdgeInsets.only(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                ),
                alignment: Alignment(0, 0),
                child: // Generated code for this GridView Widget...
                    Align(
                  alignment: Alignment(0.05, 0),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: StreamBuilder(
                      stream: _selectedFood == 'null'
                          ? _selectedIndex == 0
                              ? _firestore
                                  .collection('items')
                                  .where('ispopular', isEqualTo: true)
                                  .snapshots()
                              : _selectedIndex == 1
                                  ? _firestore
                                      .collection('items')
                                      .where('isdiscount', isEqualTo: true)
                                      .snapshots()
                                  : _firestore
                                      .collection('items')
                                      .where('ispizza', isEqualTo: true)
                                      .snapshots()
                          : _firestore
                              .collection('items')
                              .where('category', isEqualTo: _selectedFood)
                              .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width /
                                      (MediaQuery.of(context).size.height * .8),
                            ),
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return ItemPageWidget(
                                        snapshot.data.docs[index]['picurl'],
                                        snapshot.data.docs[index]['price'],
                                        snapshot.data.docs[index]['name'],
                                        snapshot.data.docs[index]['category'],
                                        snapshot.data.docs[index].id);
                                  }));
                                },
                                child: Container(
                                  //width: 100,
                                  //height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                  ),
                                  child: Align(
                                    alignment: Alignment(0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            snapshot.data.docs[index]['picurl'],
                                            //  width: 100,
                                            height: 140,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 15, 0, 0),
                                          child: Text(
                                            snapshot.data.docs[index]['name'],
                                            style: FlutterFlowTheme.title3
                                                .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.docs[index]['category'],
                                          style: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                          ),
                                        ),
                                        //Expanded(
                                        Text(
                                          '\$ ${snapshot.data.docs[index]['price'].toString()}',
                                          style:
                                              FlutterFlowTheme.title3.override(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                          ),
                                        ),
                                        //),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Text('nothing');
                        }
                      },
                    ),
                  ),
                ),
                //   ),
                //),
              ),
            ),
          ],
          // ),
          // ),
          // ],
        ),
      ),
    );
  }
}
