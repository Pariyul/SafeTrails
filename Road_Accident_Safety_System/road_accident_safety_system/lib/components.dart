
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mk_flutter_helper/mk_flutter_helper.dart';
import 'package:mk_flutter_helper/relative_dimension.dart';
import 'package:road_accident_safety_system/models.dart';

import 'global_data.dart';


const String headingFont = RASfonts.algreya;
const String inputFont = RASfonts.josefinSlab;

class CustomInputTextBox extends StatelessWidget {
  final dynamic Function(String) onTextChange;
  final String headingText;
  final String hintText;
  final IconData? iconData;
  final String? errorText;
  final bool obscureText;
  final String initialText;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final TextInputType textInputType;


  const CustomInputTextBox({
    super.key,
    this.obscureText = false,
    this.initialText = "",
    this.hintText = "",
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.textInputType = TextInputType.text,
    required this.onTextChange,
    required this.headingText,
    required this.iconData,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: (errorText!=null)?grh(context, 0.01):0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          MkText(text: headingText,googleFont: RASfonts.inter, textColor: Colors.white, size: grw(context, 0.06),padding: EdgeInsets.only(bottom:(errorText!=null)? 10:0),),
          MkTextFormField(
            textInputAction: textInputAction,
            underlineWidth: 2,
            // mode: OutlineMode.box,
            onTextChange: onTextChange,
            width: grw(context, 0.75, maxWidth: 500),
            height: grh(context, 0.057),
            cursorColor: Colors.white60,
            textStyle: MkText.style(googleFont: RASfonts.algreya, size: grh(context, 0.027), fontWeight: FontWeight.w400, textColor: Colors.white.withOpacity(0.8)),
            errorText: errorText,
            errorTextStyle: MkText.style(textColor: Colors.deepOrangeAccent, size: 15, googleFont: RASfonts.inter, ),

            initialValue: initialText,
            hintText: hintText,
            obscureText: obscureText,
            prefixIconWidget: Icon(iconData, size: grh(context, 0.025), color: Colors.yellow.shade700,),
            suffixIconSize: grh(context, 0.02),
            textAlignment: TextAlign.start,
            textCapitalization: textCapitalization,
            textInputType: textInputType,
          ),
        ],
      ),
    );
  }
}


class CustomArrowButton extends StatelessWidget {
  final IconData iconData;
  final void Function()? onTap;
  final MainAxisAlignment rowAlignment;

  const CustomArrowButton({super.key, required this.iconData, this.onTap, this.rowAlignment = MainAxisAlignment.end});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: grw(context, 0.75, maxWidth: 500),
        child: Row(
          mainAxisAlignment: rowAlignment,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Material(
                color: Colors.transparent,
                shape: CircleBorder(
                    side: BorderSide(color: Colors.white60, width: 1.8)),
                child: Padding(
                  padding: const EdgeInsets.all(3.7),
                  child: Icon(
                    iconData,
                    color: Colors.white60,
                    size: grh(context, 0.032),
                  ),
                ),
              ),
            )
          ],
        )
    )
    ;
  }
}


class AddAccidentDialog extends StatefulWidget {
  final AccidentReport accidentReport;
  final void Function() onSubmitAccidentReport;
  final bool isLoading;
  const AddAccidentDialog({super.key, required this.accidentReport, required this.onSubmitAccidentReport, required this.isLoading});

  @override
  State<AddAccidentDialog> createState() => _AddAccidentDialogState();
}

class _AddAccidentDialogState extends State<AddAccidentDialog> {
  late int _severityVal;
  String _address = "Location";

  Future<void> getAddressFromLatLng(LatLng latLng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    Placemark place = placemarks[0];
    setState(() {
      _address = '${place.street}, ${place.subLocality}\n${place.subAdministrativeArea}, ${place.postalCode}';
    });
  }

  Map<int,String> monthMap = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December",
  };

  void chooseDateTime(){}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddressFromLatLng(widget.accidentReport.location);
    _severityVal = widget.accidentReport.severity;
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = widget.accidentReport.timestamp;
    String dateStr = "${dateTime.day} ${monthMap[dateTime.month]} ${dateTime.year}";
    String timeStr = "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";

    return Padding(
      padding: EdgeInsets.only(top: grh(context, 0.05)),
      child: Dialog(
        insetPadding: EdgeInsets.all(20),
        backgroundColor: Colors.black.withOpacity(0.3),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
        child: MkUnFocus(
          child: PhysicalModel(
            color: Colors.transparent,
            child: Container(
              height: grh(context, 0.75),
              width: 500,
              padding: const EdgeInsets.all(15),
              child:  MkSingleChildScroll(
                overflowColor: Colors.black.withOpacity(0.1),
                  child: Column(
                    children: [
                        MkText(text: "Report an Accident",googleFont: RASfonts.inter, textColor: Colors.white.withOpacity(0.8),padding: const EdgeInsets.only(top: 10),size: grh(context, 0.032),),
                        MkSizedHeight(0.04),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black.withOpacity(0.4),),
                              padding: EdgeInsets.symmetric(vertical: 27,horizontal: grh(context,0.018)),

                              child: Row(
                                children: [
                                  Icon(Icons.pin_drop, color: Colors.yellow.shade700,),
                                  MkText(text: _address, googleFont: RASfonts.inter,textColor: Colors.white70, size: grh(context, 0.015),padding: EdgeInsets.only(left: 5,bottom: 5),),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: chooseDateTime,
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black.withOpacity(0.4),),
                                padding: EdgeInsets.symmetric(vertical: 28,horizontal: grh(context,0.015)),
                                child: Column(
                                  children: [
                                    MkText(text: dateStr, googleFont: RASfonts.inter,textColor: Colors.white70, size: grh(context, 0.017),),
                                    MkText(text: timeStr, googleFont: RASfonts.inter,textColor: Colors.white70, size: grh(context, 0.017),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        MkSizedHeight(0.03),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black.withOpacity(0.4),),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MkText(text: "Severity: ", googleFont: RASfonts.inter, textColor: Colors.white60, size: 25,),
                              Slider(
                                activeColor: (_severityVal==0)?Colors.greenAccent:(_severityVal==5)?Colors.yellow.shade700:Colors.redAccent,
                                inactiveColor: Colors.black.withOpacity(0.7),
                                onChanged: (value) {
                                    setState(() {
                                      _severityVal = value.round();
                                    });
                                },
                                max: 10,
                                divisions: 2,
                                value: _severityVal*1.0,
                                label: (_severityVal==0)?"Minor":(_severityVal==5)?"Major":"Critical",
                              ),
                            ],
                          ),
                        ),
                        MkSizedHeight(0.03),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 30),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black.withOpacity(0.4),),
                          child: Row(
                            children: [
                              MkText(text: "Vehicles Involved: ", googleFont: RASfonts.inter, textColor: Colors.white60, size: 20,padding: EdgeInsets.only(right: 15),),
                              Expanded(child: MkTextFormField(onTextChange: (s){widget.accidentReport.vehiclesInvolved = int.parse(s);}, cursorColor: Colors.white60 ,textInputType: TextInputType.number, textInputAction: TextInputAction.next, textStyle: MkText.style(googleFont: RASfonts.inter, textColor: Colors.yellow.shade700, size: 23), underlineWidth: 1, initialValue: "0",))
                            ],
                          ),
                        ),
                        MkSizedHeight(0.03),
                        Container(
                        padding: EdgeInsets.all(15),
                        height: grh(context, 0.22),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black.withOpacity(0.4),),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MkText(text: "Description: ", googleFont: RASfonts.inter, textColor: Colors.white60, size: 20,padding: EdgeInsets.only(bottom: 10),),
                            Expanded(
                              child: MkTextFormField(onTextChange: (s){widget.accidentReport.description = s;}, cursorColor: Colors.white38,textInputType: TextInputType.multiline, textInputAction: TextInputAction.newline, textStyle: MkText.style(googleFont: RASfonts.inter, textColor: Colors.white60, size: 18), mode: OutlineMode.box, maxLines: 7,minLines: 7, contentPadding: EdgeInsets.all(10), textAlignment: TextAlign.start, borderRadius: 10,),
                            )
                          ],
                        ),
                      ),
                        MkSizedHeight(0.03),
                      (widget.isLoading)?CircularProgressIndicator(color: Colors.yellow.shade700,):GestureDetector(
                          onTap: widget.onSubmitAccidentReport,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.black.withOpacity(0.4),border: Border.all(color: Colors.white38, width: 1)),
                            child: MkText(text: "Done", googleFont: RASfonts.inter, textColor: Colors.white60, size: grh(context, 0.02)),
                          ),
                        ),
                    ],
                  ),
              ),
            ),

          ),
        ),
      ),
    );
  }
}
