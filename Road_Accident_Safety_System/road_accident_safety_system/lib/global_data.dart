import 'package:flutter/material.dart';

import 'mk_theme_provider.dart';

class RASfonts{
  static const String algreya = 'Alegreya Sans';
  static const String annieUseYourTelescope = 'Annie Use Your Telescope';
  static const String blinker = 'Blinker';
  static const String josefinSlab = 'Josefin Slab';
  static const String oswald ='Oswald';
  static const String ptSans ='PT Sans';
  static const String rancho ='Rancho';
  static const String sniglet ='Sniglet';
  static const String teko ='Teko';
  static const String vibur ='Vibur';
  static const String inter ='Inter';
}

class GlobalData{
  static int lastThemeIndex = 0;

  static Map<MkColor, Color> lightTheme = {
    MkColor.theme : Colors.white,
    MkColor.contrast : Colors.black,
    MkColor.navBar : Colors.black,
    MkColor.statusBar : Colors.black,
  };

  static String appName = "Road Accident Safety App";
  static const AssetImage logo =  AssetImage('images/logo.png');

  static String? getEmailError(String email) {
    if (email.isEmpty) return "email cannot be empty!";
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) return "enter valid email!";
    return null;
  }


  static String? getNameError(String name) {
    if (name.isEmpty) return "name cannot be empty!";
    if (!RegExp(r"[a-zA-Z]+").hasMatch(name)) return "enter valid name!";
    return null;
  }

  static String? getPhoneError(String phone) {
    if (phone.isEmpty) return "phone cannot be empty!";
    if ((phone.length != 10) || !RegExp(r"^(\+91)?[0-9]{10}$").hasMatch(phone)) return "enter valid phone number!";
    return null;
  }

  static String? getPasswordError(String password){
    if (password.isEmpty) return "password cannot be empty!";
    if (password.length < 6) return 'password should be at least 6 characters long!';
    return null;
  }

}

// Google Maps API KEY: AIzaSyBQatGCJ6IyglQ-vN49cvaFKTudsW9i_xQ
