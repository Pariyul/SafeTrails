
// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class DbFields{
  static const String NAME = "name";
  static const String PHONE = "phone";
  static const String CONTACTS = "contacts";
  static const String RELATIONSHIP = "relationship";
  static const String USER_ID = "user_id";
  static const String EMAIL = "email";
  static const String PASSWORD = "password";
  static const String LOCATION = "location";
  static const String DESCRIPTION = "description";
  static const String TIMESTAMP = "timestamp";
  static const String SEVERITY = "severity";
  static const String VEHICLES_INVOLVED = "vehicles_involved";
}

class FirestoreHelper{
  static final CollectionReference usersCollection = FirebaseFirestore.instance.collection("users");
  static final CollectionReference contactsCollection = FirebaseFirestore.instance.collection("contacts");
  static final CollectionReference accidentsCollection = FirebaseFirestore.instance.collection("accidents");

  static Future<DocumentReference<Object?>> addUser(UserModel user) async {
    DocumentReference userDocRef = usersCollection.doc(user.userId);
    await userDocRef.set(user.toJSON());
    return userDocRef;
  }

  static Future<DocumentReference> addContact(EmergencyContact contact) async => await contactsCollection.add(contact.toJSON());

  static Future<DocumentReference> addAccidentReport(AccidentReport report) async => await accidentsCollection.add(report.toJSON());

  static Stream<QuerySnapshot> accidentReportsStream() {
    return accidentsCollection.snapshots();
  }

  // static User getUser(String uid){
  //
  // }
}


class EmergencyContact{
  String contactId;
  String name;
  String phoneNumber;
  String relationship;
  String userId;

  EmergencyContact({
    this.contactId = "",
    this.name = "",
    this.phoneNumber = "",
    this.relationship = "",
    this.userId = "",
  });

  Map<String, String> toJSON() => {
    DbFields.NAME: name,
    DbFields.PHONE: phoneNumber,
    DbFields.RELATIONSHIP: relationship,
    DbFields.USER_ID: userId,
  };
}

class UserModel{
  String userId = "";
  String name = "";
  String email = "";
  String password = "";
  String phoneNumber = "";
  List<EmergencyContact> emergencyContacts = [];

  UserModel(
      {this.userId = "",
      this.name = "",
      this.email = "",
      this.password = "",
      this.phoneNumber = "",}){emergencyContacts = [EmergencyContact()];}

  Map<String, dynamic> toJSON(){
    return {
      DbFields.NAME: name,
      DbFields.PHONE: phoneNumber,
      DbFields.CONTACTS: [...emergencyContacts.map((e) => e.contactId)]
    };
  }
}



class AccidentReport{
  String reportId;
  String reportedBy;
  LatLng location;
  DateTime timestamp;
  int severity;
  String description;
  int vehiclesInvolved;

  AccidentReport(
      this.location,
      this.timestamp,
      {
        this.reportId = "",
        this.severity = 5,
        this.description = "",
        this.reportedBy = "",
        this.vehiclesInvolved = 0,
      });

  Map<String,dynamic> toJSON() {
    return {
      DbFields.USER_ID : reportedBy,
      DbFields.LOCATION : GeoPoint(location.latitude, location.longitude),
      DbFields.TIMESTAMP : timestamp,
      DbFields.SEVERITY : severity,
      DbFields.DESCRIPTION : description,
      DbFields.VEHICLES_INVOLVED : vehiclesInvolved,
    };
  }
}

