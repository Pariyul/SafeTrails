// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mk_flutter_helper/mk_flutter_helper.dart';

import 'package:mk_flutter_helper/relative_dimension.dart';
import 'package:road_accident_safety_system/components.dart';
import 'package:road_accident_safety_system/global_data.dart';
import 'package:road_accident_safety_system/models.dart';
import 'package:road_accident_safety_system/pages/intro_page.dart';
import 'package:vibration/vibration.dart';

int THRESHOLD_DIST = 8;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController _mapController;
  late bool _alertUp = false;
  int lastMarkerId = 0;
  bool _loading = false;
  bool _initLocSet = false;
  bool _addAccidentDialogUp = false;
  late LatLng _lastLocation;

  final Map<String, Marker> _markers = {};

  Future<LatLng> getCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LatLng(pos.latitude, pos.longitude);
  }

  void animateToCurrentLocation({bool checkForAccidents = false}) async {
    LatLng currentPosition = await getCurrentLocation();

    await _mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentPosition, zoom: 19)));
    _initLocSet = true;
    if (checkForAccidents) await checkAndShowAlert();
  }

  void submitAccidentReport(AccidentReport report) {
    try {
      setState(() {
        _loading = true;
      });

      FirestoreHelper.addAccidentReport(report).then((docRef) {
        report.reportId = docRef.id;
        setState(() {
          _loading = false;
        });
        Navigator.of(context).pop();
        _addAccidentDialogUp = false;
      });
    } on FirebaseAuthException catch (ex) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  content: MkText(
                text: ex.code.toString(),
                googleFont: RASfonts.inter,
              )));
    }
  }

  double getDistance(LatLng loc1, LatLng loc2) {
    return FlutterMapMath().distanceBetween(
        loc1.latitude, loc1.longitude, loc2.latitude, loc2.longitude, "meters");
  }

  Future<bool> checkForNearbyReports() async {
    LatLng currentLoc = await getCurrentLocation();
    for (Marker marker in _markers.values) {
      double distance = getDistance(currentLoc, marker.position);
      print("[ ${marker.markerId}] DISTANCE FROM ME: $distance");
      if (distance <= THRESHOLD_DIST) {
        // String uid = await FirestoreHelper.accidentsCollection.doc(marker.markerId.toString()).get().then((DocumentSnapshot docSnap) => docSnap.get(DbFields.USER_ID));
        // if (uid == FirebaseAuth.instance.currentUser!.uid) continue;
        return true;
        // break;
      }
    }
    return false;
  }

  Future<void> checkAndShowAlert() async {
    if (await checkForNearbyReports()) {
      if (await Vibration.hasCustomVibrationsSupport() ?? true) {
        Vibration.vibrate(
            pattern: [500, 1000, 500, 1000], intensities: [1, 255], repeat: 1);
        FlutterRingtonePlayer.play(
          fromAsset: "images/alert_audio_3.mp3",
          ios: IosSounds.alarm,
          looping: true,
          // Android only - API >= 28
          volume: 1,
          // Android only - API >= 28
          asAlarm: true, // Android only - all APIs
        );
        if (context.mounted) {
          setState(() {
            _alertUp = true;
          });
          showDialog(
              context: context,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(top: grh(context, 0.05)),
                  child: Dialog(
                    insetPadding: EdgeInsets.all(20),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: grh(context, 0.25)),
                          child: PhysicalModel(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Colors.black.withOpacity(0.3),
                            shadowColor: Colors.black,
                            elevation: 30,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Colors.black.withOpacity(0.3),
                              ),
                              height: grh(context, 0.25),
                              width: 500,
                              padding: const EdgeInsets.all(15),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                      size: grh(context, 0.1),
                                    ),
                                    MkText(
                                      text: "WARNING",
                                      googleFont: RASfonts.inter,
                                      textColor: Colors.yellow.shade700,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                    ),
                                    MkText(
                                      text: "You're in an accident prone area!",
                                      googleFont: RASfonts.inter,
                                      size: grw(context, 0.05),
                                      textColor: Colors.white60,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        PhysicalModel(
                          shape: BoxShape.circle,
                          elevation: 30,

                          // borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Colors.black.withOpacity(0.3),
                          shadowColor: Colors.black,
                          child: GestureDetector(
                            onTap: dismissAlert,
                            child: Container(
                              alignment: Alignment.center,
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.3),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: MkText(
                                text: "Dismiss",
                                googleFont: RASfonts.inter,
                                textColor: Colors.white60,
                                size: grh(context, 0.025),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        }
      }
    }
  }

  void dismissAlert() {
    if (_alertUp) {
      Vibration.cancel();
      FlutterRingtonePlayer.stop();
      Navigator.of(context).pop();
      setState(() {
        _alertUp = false;
      });
    }
  }

  Future<void> checkAndPopAlert() async {
    bool stillInAccidentArea = await checkForNearbyReports();
    if (!stillInAccidentArea) dismissAlert();
  }

  _callNumber() async {
    String user_id = FirebaseAuth.instance.currentUser!.uid;
    String contact_id = ((await FirestoreHelper.usersCollection
            .doc(user_id)
            .get()
            .then((DocumentSnapshot docSnap) => docSnap.get(DbFields.CONTACTS)))
        as List<dynamic>)[0];
    String number = await FirestoreHelper.contactsCollection
        .doc(contact_id)
        .get()
        .then((DocumentSnapshot docSnap) =>
            docSnap.get(DbFields.PHONE)); //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
    // print("CALLLLLL NUMBER: $number");
  }

  void onAddAccidentClicked() async {
    AccidentReport accidentReport = AccidentReport(
        await getCurrentLocation(), DateTime.now(),
        reportedBy: FirebaseAuth.instance.currentUser!.uid); // FirebaseAuth.instance.currentUser!.uid
    if (context.mounted) {
      _addAccidentDialogUp = true;
      showDialog(
          context: context,
          builder: (BuildContext con) => AddAccidentDialog(
                accidentReport: accidentReport,
                onSubmitAccidentReport: () =>
                    submitAccidentReport(accidentReport),
                isLoading: _loading,
              ));
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation().then((value) {
      _lastLocation = value;
    }).then((value) =>
        Geolocator.getPositionStream().listen((Position newPosition) {
          LatLng newLocation =
              LatLng(newPosition.latitude, newPosition.longitude);
          double distance = getDistance(_lastLocation, newLocation);
          print("POSITION::: $newLocation");
          print("DISTANCE::: $distance");
          if (distance > 2) {
            _lastLocation = newLocation;
            if (_alertUp)
              checkAndPopAlert();
            else
              checkAndShowAlert();
          }

        }));

    // _startListeningLocationChanges();
  }

  @override
  Widget build(BuildContext context) {
    SizedBox DrawerDivider = SizedBox(
        width: grw(context, 0.6),
        child: const Divider(
          height: 1,
          color: Colors.grey,
        ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const MkText(
          text: "SafeTrails",
          textColor: Colors.white,
          googleFont: RASfonts.inter,
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DrawerTile(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    text: "Home"),
                DrawerDivider,
                _DrawerTile(onTap: (){Navigator.of(context).pop();onAddAccidentClicked();}, text: "Add an Accident"),
                DrawerDivider,
                // _DrawerTile(onTap: () {}, text: "Profile"),
                // DrawerDivider,
                // _DrawerTile(onTap: () {}, text: "Share"),
                // DrawerDivider,
                GestureDetector(
                  onTap: _callNumber,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MkText(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        text: "Call Emergency Contact",
                        size: grh(context, 0.023x),
                        googleFont: RASfonts.inter,
                        textColor: Colors.redAccent,
                      ),
                      Icon(
                        Icons.call,
                        color: Colors.redAccent,
                      )
                    ],
                  ),
                ),
                DrawerDivider,
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    travelToPage(context, IntroPage());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MkText(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        text: "Logout",
                        size: grh(context, 0.025),
                        googleFont: RASfonts.inter,
                        textColor: Colors.yellow.shade700,
                      ),
                      Icon(
                        Icons.logout_outlined,
                        color: Colors.yellow.shade700,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      // backgroundColor: Watchers.gcfct(context, MkColor.theme),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirestoreHelper.accidentReportsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("SNAPSHOT CHANGED!!");
              List<QueryDocumentSnapshot> accidentReports = snapshot.data!.docs;
              for (QueryDocumentSnapshot report in accidentReports) {
                String reportId = report.id;
                if (!_markers.containsKey(reportId)) {
                  Map<String, dynamic> reportData =
                      report.data() as Map<String, dynamic>;
                  GeoPoint geoPoint =
                      (reportData[DbFields.LOCATION] as GeoPoint);
                  Marker marker = Marker(
                    markerId: MarkerId(reportId),
                    position: LatLng(geoPoint.latitude, geoPoint.longitude),
                    infoWindow:
                        InfoWindow(title: reportData[DbFields.DESCRIPTION]),
                  );
                  _markers[reportId] = marker;
                  if (!_alertUp && _initLocSet) checkAndShowAlert();
                }
              }
              print("LEN: ${_markers.length}");
            }

            return Center(
                child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                  target: LatLng(23.473324, 77.947998), zoom: 14.4746),
              markers: Set<Marker>.of(_markers.values),
              mapType: MapType.normal,
              myLocationEnabled: true,
              compassEnabled: true,
              zoomControlsEnabled: false,
              trafficEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                animateToCurrentLocation(checkForAccidents: true);
              },
            ));
          }),
      floatingActionButton: FloatingActionButton.small(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: onAddAccidentClicked,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final String text;
  final void Function() onTap;

  const _DrawerTile({required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          MkText(
            padding: const EdgeInsets.symmetric(vertical: 20),
            text: text,
            size: grh(context, 0.025),
            googleFont: RASfonts.inter,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
