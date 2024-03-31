import 'dart:math';

import 'package:flutter/material.dart';

double grh(var context,double heightFactor, {double maxHeight = double.maxFinite}){
  /// get relative height
  double widgetHeight;
  if (context is BuildContext) {widgetHeight = gch(context);}
  else {widgetHeight = context;}
  return min(maxHeight,widgetHeight * heightFactor);
}

double grw(var context,double widthFactor, {double maxWidth = double.maxFinite}){
  /// get relative width
  double widgetWidth;
  if (context is BuildContext) {widgetWidth = gcw(context);}
  else {widgetWidth = context;}
  return min(maxWidth, widgetWidth * widthFactor);
}

double grs(var context, double factor, {double maxShortSide = double.maxFinite}){
  /// get relative short side
  double widgetShortSide;
  if (context is BuildContext) {widgetShortSide = gcs(context);}

  else {widgetShortSide = context;}
  return min(maxShortSide, widgetShortSide * factor);
}

double grl(var context,double factor, {double maxLongSide = double.maxFinite}){
  /// get relative long side
  double widgetLongSide;
  if (context is BuildContext) {widgetLongSide = gcl(context);}
  else {widgetLongSide = context;}
  return min(maxLongSide, widgetLongSide * factor);
}

double gcs(context){
  /// get shortest side of screen
  return MediaQuery.of(context).size.shortestSide;
}

double gcl(context){
  /// get longest side of screen
  return MediaQuery.of(context).size.longestSide;
}

double gch(context){
  /// get height of screen
  return MediaQuery.of(context).size.height;
}

double gcw(context){
  /// get width of screen
  return MediaQuery.of(context).size.width;
}

Size getSizeOfText(
    {BuildContext? context, String? text, TextStyle? textStyle}){
  return (TextPainter(
      text: TextSpan(text: text, style: textStyle),
      maxLines: 1,
      textScaleFactor: (context!=null) ? MediaQuery.of(context).textScaleFactor : 1,
      textDirection: TextDirection.ltr)
    ..layout())
      .size;
}

