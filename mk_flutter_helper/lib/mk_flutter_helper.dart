library mk_flutter_helper;

// ignore_for_file: constant_identifier_names

import 'dart:ui';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'relative_dimension.dart';

class MkText extends StatelessWidget {
  final double? size;
  final String? text;
  final Color? textColor;
  final TextStyle? textStyle;
  final TextAlign? alignment;
  final Color? bgColor;
  final String? googleFont;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final List<Shadow>? shadows;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final Color? decorationColor;
  final double? decorationThickness;
  final EdgeInsets? padding;

  const MkText({
    Key? key,
    this.size = 30,
    this.text = "text",
    this.textColor = Colors.black,
    this.alignment = TextAlign.start,
    this.bgColor,
    this.googleFont = 'Righteous',
    this.fontWeight = FontWeight.normal,
    this.maxLines,
    this.overflow,
    this.shadows,
    this.decoration = TextDecoration.none,
    this.decorationStyle,
    this.decorationColor,
    this.decorationThickness,
    this.textStyle,
    this.padding,
  }) : super(key: key);

  TextStyle getTextStyle() {
    // return GoogleFonts.getFont(google_font!,textStyle: TextStyle(color: text_color,backgroundColor: bg_colour,fontSize: size,fontWeight: font_weight ));
    return GoogleFonts.getFont(googleFont!,
        textStyle: TextStyle(
          color: textColor,
          backgroundColor: bgColor,
          fontSize: size,
          fontWeight: fontWeight,
          decoration: decoration,
          decorationStyle: decorationStyle,
          decorationColor: decorationColor,
          decorationThickness: decorationThickness,
          shadows: shadows,
        ));
  }

  static TextStyle style(
          {String googleFont = MkFonts.font_righteous,
          Color textColor = Colors.black,
          Color bgColour = Colors.transparent,
          double size = 30.0,
          FontWeight fontWeight = FontWeight.normal,
          List<Shadow>? shadows,
          TextDecoration? decoration = TextDecoration.none,
          TextDecorationStyle? decorationStyle,
          Color? decorationColor,
          double? decorationThickness}) =>
      GoogleFonts.getFont(
        googleFont,
        textStyle: TextStyle(
          color: textColor,
          backgroundColor: bgColour,
          fontSize: size,
          fontWeight: fontWeight,
          decoration: decoration,
          decorationColor: decorationColor,
          decorationStyle: decorationStyle,
          decorationThickness: decorationThickness,

        ),
        shadows: shadows,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text ?? "text",
        textAlign: alignment,
        style: textStyle ?? getTextStyle(),
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }
}

class CalcButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String? text;
  final Color? textColor;
  final double? textSize;
  final String? googleFont;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final Color? bgColor;

  const CalcButton({
    Key? key,
    this.width = 40,
    this.height = 40,
    this.text,
    this.textColor,
    this.textSize,
    this.googleFont,
    this.fontWeight,
    this.borderRadius = 10,
    this.bgColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius!),
        color: bgColor,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        MkText(
          text: text ?? "button",
          bgColor: Colors.transparent,
          textColor: textColor,
          size: textSize ?? grh(height, 0.8),
          googleFont: googleFont ?? 'Righteous',
          fontWeight: fontWeight ?? FontWeight.normal,
        )
      ]),
    );
  }
}

class MkButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String? text;
  final AssetImage iconImg;
  final double borderRadius;
  final Color? bgColor;

  const MkButton({
    Key? key,
    required this.iconImg,
    this.width = 40,
    this.height = 40,
    this.text,
    this.borderRadius = 10,
    this.bgColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.white,
      shadowColor: Colors.white,
      borderRadius: BorderRadius.circular(50),
      elevation: 9.0,
      // shape: BoxShape.circle,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: bgColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image(image: iconImg)],
        ),
      ),
    );
  }
}

class MkIconButton extends StatelessWidget {
  final GestureTapCallback? onTapFunction;
  final IconData icon;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final double size;
  final EdgeInsets? padding;
  final EdgeInsets? internalMargin;
  final EdgeInsets? internalPadding;
  final Color color;
  final Color backgroundColor;
  final BoxShape? backgroundShape;
  final double borderWidth;
  final Color borderColor;
  final BorderStyle borderStyle;
  final BorderRadius? borderRadius;

  const MkIconButton({
    Key? key,
    this.icon = Icons.edit,
    this.size = 10,
    this.padding,
    this.internalPadding,
    this.internalMargin,
    this.color = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.backgroundShape,
    this.borderWidth = 0,
    this.borderColor = Colors.transparent,
    this.borderStyle = BorderStyle.solid,
    this.onTapFunction,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double editIconSize = size;

    return GestureDetector(
      onTap: onTapFunction,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Container(
          margin: internalMargin ?? const EdgeInsets.all(15),
          padding: internalPadding ?? EdgeInsets.zero,
          width: editIconSize,
          height: editIconSize,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(400)),
              border: Border.all(
                  color: borderColor, width: borderWidth, style: borderStyle)),
          child: Icon(icon, size: editIconSize, color: color),
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MkAlertDialog extends StatelessWidget {
  final String btn1Name;
  final String btn2Name;
  final String title;
  final String content;
  final VoidCallback? btn1Func;
  final VoidCallback? btn2Func;
  final EdgeInsetsGeometry titlePadding;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry actionsPadding;
  final TextStyle? titleTextStyle;
  final TextStyle? contentTextStyle;
  final TextStyle? actionsTextStyle;
  final List<Widget>? actions;
  final MainAxisAlignment? actionsAlignment;
  final AlignmentGeometry? alignment;
  final Color? backgroundColor;
  final double? elevation;
  final String? semanticLabel;

  const MkAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    this.btn1Name = "Cancel",
    this.btn2Name = "Continue",
    this.btn1Func,
    this.btn2Func,
    this.titlePadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
    this.titleTextStyle,
    this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
    this.contentTextStyle,
    this.actionsTextStyle,
    this.actions,
    this.actionsPadding = const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
    this.actionsAlignment,
    this.backgroundColor,
    this.elevation,
    this.semanticLabel,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: actions ??
          [
            TextButton(
              onPressed: btn1Func ?? () {},
              child: Text(
                btn1Name,
                style: actionsTextStyle,
              ),
            ),
            TextButton(
              onPressed: btn2Func ?? () {},
              child: Text(btn2Name, style: actionsTextStyle),
            ),
          ],
      backgroundColor: backgroundColor,
      alignment: alignment,
      semanticLabel: "semanticLabel",
      actionsAlignment: actionsAlignment,
      contentPadding: contentPadding,
      titlePadding: titlePadding,
      actionsPadding: actionsPadding,
      titleTextStyle: titleTextStyle,
      contentTextStyle: contentTextStyle,
    );
  }
}

class NeumorphicTile extends StatelessWidget {
  final Color bgColor;
  final Color shadowStart;
  final Color shadowEnd;
  final double? height;
  final double? width;
  final Widget? child;
  final Color? gradientStart;
  final Color? gradientEnd;
  final BorderRadiusGeometry? borderRadius;
  final Gradient? gradient;
  final Offset? offsetShadow1;
  final Offset? offsetShadow2;
  final double? blurRadiusShadow1;
  final double? blurRadiusShadow2;
  final double? spreadRadiusShadow1;
  final double? spreadRadiusShadow2;
  final List<BoxShadow>? boxShadow;

  const NeumorphicTile(
      {Key? key,
      required this.bgColor,
      required this.shadowStart,
      required this.shadowEnd,
      this.height,
      this.width,
      this.child,
      this.gradientStart,
      this.gradientEnd,
      this.borderRadius,
      this.gradient,
      this.offsetShadow1,
      this.offsetShadow2,
      this.blurRadiusShadow1,
      this.blurRadiusShadow2,
      this.spreadRadiusShadow1,
      this.spreadRadiusShadow2,
      this.boxShadow})
      : super(key: key);

  static Gradient getGradient(
      {required Color gradientStart, required Color gradientEnd}) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        gradientStart,
        gradientEnd,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 217,
      height: height ?? 217,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        gradient: gradient ??
            LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                gradientStart ?? bgColor,
                gradientEnd ?? bgColor,
              ],
            ),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: shadowStart,
                offset: offsetShadow1 ?? const Offset(-20.0, -20.0),
                blurRadius: blurRadiusShadow2 ?? 43,
                spreadRadius: spreadRadiusShadow1 ?? 0.0,
              ),
              BoxShadow(
                color: shadowEnd,
                offset: offsetShadow2 ?? const Offset(20.0, 20.0),
                blurRadius: blurRadiusShadow2 ?? 43,
                spreadRadius: spreadRadiusShadow2 ?? 0.0,
              ),
            ],
      ),
      child: child ??
          const Icon(
            Icons.star,
            size: 72,
            color: Colors.amber,
          ),
    );
  }
}

class NeumorphicButton extends StatefulWidget {
  final Color bgColor;
  final Color shadowStart;
  final Color shadowEnd;
  final double? height;
  final double? width;
  final Widget? child;
  final Color? gradientStart;
  final Color? gradientEnd;
  final BorderRadiusGeometry? borderRadius;
  final Gradient? gradient;
  final Offset? offsetShadow1;
  final Offset? offsetShadow2;
  final double? blurRadiusShadow1;
  final double? blurRadiusShadow2;
  final double? spreadRadiusShadow1;
  final double? spreadRadiusShadow2;
  final List<BoxShadow>? boxShadow;
  final Duration? duration;
  final bool? onTapInset;

  const NeumorphicButton(
      {Key? key,
      required this.bgColor,
      required this.shadowStart,
      required this.shadowEnd,
      this.height,
      this.width,
      this.child,
      this.gradientStart,
      this.gradientEnd,
      this.borderRadius,
      this.gradient,
      this.offsetShadow1,
      this.offsetShadow2,
      this.blurRadiusShadow1,
      this.blurRadiusShadow2,
      this.spreadRadiusShadow1,
      this.spreadRadiusShadow2,
      this.boxShadow,
      this.onTapInset = true,
      this.duration})
      : super(key: key);

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent pointerDownEvent) =>
          setState(() => _isTapped = true),
      onPointerUp: (PointerUpEvent pointerUpEvent) =>
          setState(() => _isTapped = false),
      child: AnimatedContainer(
        duration: widget.duration ?? const Duration(milliseconds: 150),
        width: widget.width ?? 217,
        height: widget.height ?? 217,
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
          gradient: widget.gradient ??
              LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.gradientStart ?? widget.bgColor,
                  widget.gradientEnd ?? widget.bgColor,
                ],
              ),
          boxShadow: widget.boxShadow ??
              [
                BoxShadow(
                  color: widget.shadowStart,
                  offset: widget.offsetShadow1 ?? const Offset(-20.0, -20.0),
                  blurRadius: widget.blurRadiusShadow2 ?? 43,
                  spreadRadius: widget.spreadRadiusShadow1 ?? 0.0,
                  inset: (widget.onTapInset != null) ? _isTapped : false,
                ),
                BoxShadow(
                  color: widget.shadowEnd,
                  offset: widget.offsetShadow2 ?? const Offset(20.0, 20.0),
                  blurRadius: widget.blurRadiusShadow2 ?? 43,
                  spreadRadius: widget.spreadRadiusShadow2 ?? 0.0,
                  inset: (widget.onTapInset != null) ? _isTapped : false,
                ),
              ],
        ),
        child: widget.child ??
            const Icon(
              Icons.star,
              size: 72,
              color: Colors.amber,
            ),
      ),
    );
  }
}

class MkTextFormField extends StatefulWidget {
  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final TextStyle? textStyle;
  final TextStyle? errorTextStyle;
  final TextStyle? hintTextStyle;
  final Color? cursorColor;
  final int minLines;
  final int maxLines;
  final TextAlign textAlignment;
  final OutlineMode? mode;
  final double borderRadius;
  final EdgeInsets contentPadding;
  final Function(String) onTextChange;
  final Function()? onEditingComplete;
  final double? height;
  final double? width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autoFocus;
  final Function? onTapFunction;
  final TextInputType? textInputType;
  final bool obscureText;
  final bool? enableSuggestions;
  final bool? autocorrect;
  final Widget? suffixIconWidget;
  final double suffixIconSize;
  final Color? suffixIconColorWhenObscureTextHidden;
  final double underlineWidth;
  final TextInputAction? textInputAction;
  final bool expands;
  final BoxConstraints? prefixIconConstraints;
  final Widget? prefixIconWidget;
  final double prefixSuffixPaddingFactorWhenErrorText;
  final TextCapitalization textCapitalization;

  const MkTextFormField(
      {Key? key,
      required this.onTextChange,
      this.initialValue,
      this.hintText,
      this.errorText,
      this.errorTextStyle,
      this.textStyle,
      this.cursorColor,
      this.minLines = 1,
      this.maxLines = 1,
      this.textAlignment = TextAlign.center,
      this.mode = OutlineMode.underline,
      this.borderRadius = 2,
      this.contentPadding = EdgeInsets.zero,
      this.height = 50,
      this.width = 50,
      this.suffixIconSize = 15,
      this.underlineWidth = 1,
      this.prefixSuffixPaddingFactorWhenErrorText = 0.017,
      this.textCapitalization = TextCapitalization.none,
      this.expands = false,
      this.onEditingComplete,
      this.hintTextStyle,
      this.controller,
      this.textInputAction,
      this.focusNode,
      this.autoFocus,
      this.onTapFunction,
      this.textInputType,
      this.obscureText = false,
      this.autocorrect,
      this.enableSuggestions,
      this.suffixIconWidget,
      this.suffixIconColorWhenObscureTextHidden,
      this.prefixIconConstraints,
      this.prefixIconWidget})
      : super(key: key);

  @override
  State<MkTextFormField> createState() => _MkTextFormFieldState();
}

class _MkTextFormFieldState extends State<MkTextFormField> {
  late bool _hideText = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    Color suffixIconColor = widget.cursorColor ?? Colors.black;
    Color suffixIconColorWhenHidden =
        widget.suffixIconColorWhenObscureTextHidden ?? suffixIconColor;
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: widget.height,
        // width: widget.width,
        child: TextFormField(
          onTap: widget.onTapFunction != null ? widget.onTapFunction!() : () {},
          autofocus: widget.autoFocus ?? false,
          focusNode: widget.focusNode,
          controller: widget.controller,
          onChanged: widget.onTextChange,
          onEditingComplete: widget.onEditingComplete,
          keyboardType: widget.textInputType ?? TextInputType.multiline,
          textInputAction: widget.textInputAction,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          style: widget.textStyle,
          cursorColor: widget.cursorColor,
          textAlign: widget.textAlignment,
          initialValue: widget.initialValue,
          obscureText: _hideText,
          textCapitalization: widget.textCapitalization,
          enableSuggestions:
              widget.enableSuggestions ?? (widget.obscureText) ? false : true,
          autocorrect:
              widget.autocorrect ?? (widget.obscureText) ? false : true,
          expands: widget.expands,
          decoration: InputDecoration(
            contentPadding: (widget.errorText != null)
                ? const EdgeInsets.all(12)
                : widget.contentPadding,
            fillColor: Colors.white,
            hintText: widget.hintText,
            hintStyle: widget.hintTextStyle,
            errorText: widget.errorText,
            errorStyle: widget.errorTextStyle,
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                bottom: (widget.errorText!=null)?grh(context, widget.prefixSuffixPaddingFactorWhenErrorText):0,
                left: (widget.mode == OutlineMode.box)?10:0,
                right: (widget.textAlignment == TextAlign.start)?10:0
              ),
              child: widget.prefixIconWidget,
            ),
            prefixIconConstraints: widget.prefixIconConstraints ??
                const BoxConstraints(
                  minWidth: 2,
                  minHeight: 2,
                ),
            suffixIcon: Padding(
              padding: EdgeInsets.only(
                bottom: (widget.errorText!=null)?grh(context, widget.prefixSuffixPaddingFactorWhenErrorText):0,
                right: (widget.mode == OutlineMode.box)?10:0
              ),
              child: (widget.obscureText)
                  ? GestureDetector(
                      onTap: () => setState(() => _hideText = !_hideText),
                      child: Icon(Icons.remove_red_eye_rounded, color: (_hideText) ? widget.cursorColor: suffixIconColorWhenHidden, size: widget.suffixIconSize)
                    )
                  : widget.suffixIconWidget,
            ),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 2,
              minHeight: 2,
            ),
            focusedBorder: widget.mode == OutlineMode.underline
                ? UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.cursorColor ?? Colors.blue,
                      width: widget.underlineWidth + 1,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      color: widget.cursorColor ?? Colors.blue,
                      width: 2,
                    ),
                  ),
            enabledBorder: widget.mode == OutlineMode.underline
                ? UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.cursorColor ?? Colors.blue,
                      width: widget.underlineWidth,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      color: widget.cursorColor ?? Colors.blue,
                      width: 1,
                    )),
          ),
        ),
      ),
    );
  }
}

class MkFlatTiles extends StatelessWidget {
  final List<Widget> listOfTiles;
  final double tileVerticalSpacing;
  final double tileHorizontalSpacing;
  final TileArrangement tileArrangement;
  final CrossAxisAlignment crossAxisAlignment;

  const MkFlatTiles({
    Key? key,
    required this.listOfTiles,
    this.tileVerticalSpacing = 30,
    this.tileHorizontalSpacing = 30,
    this.tileArrangement = TileArrangement.twoXtwo,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (tileArrangement == TileArrangement.twoXtwo)
        ? Column(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              for (int index = 0; index < listOfTiles.length; index += 2) ...[
                Row(
                  children: [
                    listOfTiles[index],
                    if (index + 1 < listOfTiles.length)
                      SizedBox(width: tileHorizontalSpacing),
                    if (index + 1 < listOfTiles.length) listOfTiles[index + 1],
                  ],
                ),
                SizedBox(height: tileVerticalSpacing),
              ],
            ],
          )
        : Container();
  }
}

class FlatStfulTile extends StatefulWidget {
  final Icon? tileIcon;
  final String tileText;
  final List<Color>? tileColors;
  final Color? shadowColor;
  final GestureTapCallback? onTapFunc;
  final EdgeInsets? padding;
  final List<Widget>? tileChildren;
  final Color? bgColor;
  final Color? gradientStart;
  final Color? gradientEnd;
  final bool alignMkTextsVertically;
  final bool insetBool;
  final DecorationImage? bgImage;

  const FlatStfulTile({
    Key? key,
    this.tileIcon,
    this.tileText = "",
    this.tileColors,
    this.bgImage,
    this.onTapFunc,
    this.padding,
    this.tileChildren,
    this.shadowColor,
    this.bgColor,
    this.gradientStart,
    this.gradientEnd,
    this.alignMkTextsVertically = true,
    this.insetBool = true,
  }) : super(key: key);

  @override
  State<FlatStfulTile> createState() => _FlatStfulTileState();
}

class _FlatStfulTileState extends State<FlatStfulTile> {
  bool isTapped = false;
  double? tileHeight, tileWidth;
  List<Color>? tileColors;

  void tileTapped(TapDownDetails tapDownDetails) {
    setState(() {
      isTapped = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    tileHeight = isTapped ? grh(context, 0.095) : grh(context, 0.105);
    tileWidth = isTapped ? grw(context, 0.4) : grw(context, 0.415);
    double tileFontSize = grw(tileWidth, 0.18);
    tileColors = (widget.tileColors == null)
        ? [Colors.yellowAccent, Colors.cyanAccent]
        : widget.tileColors;
    Offset offset = Offset(grw(tileWidth, 0.095), grh(tileHeight, 0.135));
    double blurRadius = 32.5;
    Color gradientStart = widget.gradientStart ?? Colors.grey;
    Color gradientEnd = widget.gradientEnd ?? Colors.grey;

    return Listener(
      onPointerDown: (PointerDownEvent pointerDownEvent) =>
          setState(() => isTapped = true),
      onPointerUp: (PointerUpEvent pointerUpEvent) =>
          setState(() => isTapped = false),
      child: GestureDetector(
        onTap: widget.onTapFunc,
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 75),
            alignment: Alignment.center,
            width: tileWidth,
            height: tileHeight,
            transformAlignment: Alignment.center,
            decoration: BoxDecoration(
              image: widget.bgImage,
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.bgColor ?? Colors.grey,
                  widget.bgColor ?? Colors.grey
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: gradientStart,
                  offset: Offset(-(offset.dx - 5.0), -(offset.dy - 10.0)),
                  blurRadius: blurRadius,
                  spreadRadius: 0.0,
                  inset: isTapped && widget.insetBool,
                ),
                BoxShadow(
                  color: gradientEnd,
                  offset: offset,
                  blurRadius: blurRadius,
                  spreadRadius: 0.0,
                  inset: isTapped && widget.insetBool,
                ),
              ],
            ),
            padding:
                (widget.padding != null) ? widget.padding : EdgeInsets.zero,
            child: (widget.alignMkTextsVertically)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.tileChildren ??
                        [
                          MkText(
                              text: widget.tileText,
                              googleFont: MkFonts.font_oswald,
                              size: tileFontSize,
                              textColor: isTapped
                                  ? Colors.yellowAccent
                                  : Colors.yellow),
                        ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.tileChildren ??
                        [
                          MkText(
                              text: widget.tileText,
                              googleFont: MkFonts.font_oswald,
                              size: tileFontSize,
                              textColor: isTapped
                                  ? Colors.yellowAccent
                                  : Colors.yellow),
                        ],
                  )),
      ),
    );
  }
}

class MkComboBox extends StatefulWidget {
  final Color bgColor;
  final Color shadowColor;
  final double? itemWidth;
  final double? itemHeight;
  final double comboBoxWidth;
  final double comboBoxHeight;
  final double dropDownMaxHeight;
  final Map<String, Widget> dropDownItems;
  final Function(String)? onTapFunc;
  final Widget? icon;
  final double? iconSize;
  final Widget? hint;
  final String? initialVal;
  final AlignmentGeometry? alignment;

  const MkComboBox({
    Key? key,
    required this.dropDownItems,
    this.bgColor = Colors.white,
    this.shadowColor = Colors.black87,
    this.onTapFunc,
    this.comboBoxWidth = 80,
    this.comboBoxHeight = 48,
    this.itemWidth,
    this.itemHeight,
    this.alignment,
    this.dropDownMaxHeight = 100,
    this.icon,
    this.iconSize,
    this.hint,
    this.initialVal,
  }) : super(key: key);

  @override
  State<MkComboBox> createState() => _MkComboBoxState();
}

class _MkComboBoxState extends State<MkComboBox> {
  late String _selectedItem =
      widget.initialVal ?? widget.dropDownItems.keys.first;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.comboBoxWidth,
        decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(2, 2),
                  color: widget.shadowColor,
                  blurRadius: 1)
            ]),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
              alignment: widget.alignment ?? Alignment.center,
              dropdownColor: widget.bgColor,
              icon: widget.icon,
              iconSize: (widget.icon != null) ? widget.iconSize ?? 24 : 0,
              itemHeight: widget.itemHeight ?? widget.comboBoxHeight,
              value: _selectedItem,
              focusColor: widget.bgColor,
              isExpanded: (widget.icon != null),
              hint: widget.hint,
              menuMaxHeight: widget.dropDownMaxHeight,
              items: [
                for (String itemKey in widget.dropDownItems.keys)
                  DropdownMenuItem<String>(
                      value: itemKey,
                      child: SizedBox(
                          width: widget.itemWidth ?? widget.comboBoxWidth,
                          height: widget.itemHeight,
                          child: widget.dropDownItems[itemKey]))
              ],
              onChanged: (value) => setState(() {
                    _selectedItem = value as String;
                    (widget.onTapFunc != null)
                        ? widget.onTapFunc!(_selectedItem)
                        : () {};
                  })),
        ));
  }
}

class MkUnFocus extends StatelessWidget {
  final Widget child;
  final void Function()? onUnfocus;

  const MkUnFocus({
    Key? key,
    required this.child, this.onUnfocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          if(onUnfocus!=null) onUnfocus!();
        },
        child: child);
  }
}

class MkAnimated extends StatefulWidget {
  final Widget child;
  final Duration? animationDuration;
  final Offset? beginOffset;
  final Offset? endOffset;
  final Curve? slideCurve;
  final Curve? opacityCurve;

  const MkAnimated(
      {Key? key,
      required this.child,
      this.animationDuration,
      this.beginOffset,
      this.endOffset,
      this.slideCurve,
      this.opacityCurve})
      : super(key: key);

  @override
  State<MkAnimated> createState() => _MkAnimatedState();
}

class _MkAnimatedState extends State<MkAnimated>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.animationDuration ?? const Duration(seconds: 1), //2
    vsync: this,
  )..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: widget.beginOffset ?? Offset.zero,
    end: widget.endOffset ?? Offset.zero,
  ).animate(CurvedAnimation(
      parent: _controller, curve: widget.slideCurve ?? Curves.fastOutSlowIn));

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: _offsetAnimation,
        child: FadeTransition(
            opacity: _controller.drive(
                CurveTween(curve: widget.opacityCurve ?? Curves.decelerate)),
            child: widget.child));
  }
}

class MkSingleChildScroll extends StatelessWidget {
  final Axis? scrollDirection;
  final Color? overflowColor;
  final Widget child;
  final ScrollController? controller;

  const MkSingleChildScroll(
      {Key? key,
      this.scrollDirection,
      this.overflowColor,
      required this.child,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: overflowColor ?? Colors.yellow)),
      child: SingleChildScrollView(
        controller: controller,
        scrollDirection: scrollDirection ?? Axis.vertical,
        child: child,
      ),
    );
  }
}

class MkChangeTheme extends StatelessWidget {
  final Widget child;
  final Color color;

  const MkChangeTheme({Key? key, required this.child, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: color, // header background color
            onPrimary: Colors.black, // header text color
            onSurface: Colors.black, // body text color
          ),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
            foregroundColor: Colors.black,
          )),
          // button text color
          cardColor: color,
        ),
        child: child);
  }
}

class MkTextButton extends StatelessWidget {
  final String text;
  final String? font;
  final Color? textColor;
  final Color? bgColor;
  final double? textSize;
  final EdgeInsets? padding;

  const MkTextButton(
      {Key? key,
      required this.text,
      this.textColor,
      this.bgColor,
      this.textSize,
      this.font,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(bgColor ?? Colors.yellow),
        elevation: MaterialStateProperty.all<double>(8),
        padding: MaterialStateProperty.all<EdgeInsets>(
            padding ?? const EdgeInsets.only(top: 5, left: 15, right: 15)),
      ),
      child: MkText(
        text: text,
        googleFont: font ?? MkFonts.font_vibur,
        textColor: textColor ?? Colors.black,
        size: textSize ?? grh(context, 0.035),
      ),
    );
  }
}

class MkWidgetWithCircleBg extends StatelessWidget {
  final Widget? child;
  final Color? bgColor;
  final EdgeInsets? padding;
  final String? text;

  const MkWidgetWithCircleBg(
      {Key? key, this.child, this.bgColor, this.padding, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding ?? const EdgeInsets.all(5),
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: bgColor ?? Colors.red),
        child: child ??
            MkText(
              textColor: Colors.white,
              text: text ?? '1',
              size: 15,
            ));
  }
}

class MkSizedHeight extends StatelessWidget {
  final double heightFactor;

  const MkSizedHeight(this.heightFactor, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: grh(context, heightFactor),
    );
  }
}

void mkCopyToClipboard(BuildContext context, String data,
    {String snackBarString = "Copied to clipboard",
    bool showSnackBar = false}) {
  Clipboard.setData(ClipboardData(text: data)).then((_) {
    if (showSnackBar) {
      mkShowSnackbar(
          context: context,
          contentTextString: snackBarString,
          bgColour: Colors.yellowAccent);
    }
  });
}

void mkShowSnackbar({
  required BuildContext context,
  Widget? contentWidget,
  String contentTextString = "Mk Snackbar",
  Duration? duration,
  Color? bgColour,
  Color textColour = Colors.white,
  TextAlign? textAlign,
  String googleFont = 'Josefin Sans',
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: contentWidget ??
        MkText(
          text: contentTextString,
          textColor: textColour,
          fontWeight: FontWeight.bold,
          size: 22,
          alignment: textAlign ?? TextAlign.center,
          googleFont: googleFont,
        ),
    duration: duration ?? const Duration(seconds: 4),
    backgroundColor: bgColour ?? const Color(0xFF323232),
  ));
}

void mkShowDeleteAlertDialog({
  required BuildContext context,
  String title = "Delete",
  String content = "Are you sure you want to delete the selected item?",
  VoidCallback? onTrueFunc,
  String headingFont = MkFonts.font_righteous,
  String contentFont = MkFonts.font_josefin_sans,
  FontWeight headingWeight = FontWeight.bold,
  FontWeight contentWeight = FontWeight.bold,
  double headingSize = 30,
  double contentSize = 22,
}) {
  showDialog(
      context: context,
      builder: (context) => MkAlertDialog(
            title: title,
            titleTextStyle: MkText.style(
                textColor: Colors.redAccent,
                fontWeight: headingWeight,
                googleFont: headingFont,
                size: headingSize),
            content: content,
            contentTextStyle: MkText.style(
              googleFont: contentFont,
              fontWeight: contentWeight,
              size: contentSize,
            ),
            actionsTextStyle:
                MkText.style(size: 19, textColor: Colors.lightBlue),
            btn1Func: () => Navigator.pop(context),
            btn2Func: (onTrueFunc != null)
                ? () {
                    onTrueFunc();
                    Navigator.pop(context);
                  }
                : () => Navigator.pop(context),
          ));
}

void travelToPage(BuildContext context, Widget destinationPage) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => destinationPage));
}

void travelBack(BuildContext context) => Navigator.pop(context);

class MkFonts {
  static const String font_amatic_sc = 'Amatic SC';
  static const String font_annie_use_your_telescope =
      'Annie Use Your Telescope';
  static const String font_gaegu = 'Gaegu';
  static const String font_gamja_flower = 'Gamja Flower';
  static const String font_josefin_sans = 'Josefin Sans';
  static const String font_oswald = 'Oswald';
  static const String font_roboto = 'Roboto';
  static const String font_rancho = 'Rancho';
  static const String font_righteous = 'Righteous';
  static const String font_shalimar = 'Shalimar';
  static const String font_teko = 'Teko';
  static const String font_vibur = 'Vibur';
  static const String font_sacramento = 'Sacramento';
  static const String font_pt_sans = 'PT Sans';
  static const String font_major_mono_display = 'Major Mono Display';
  static const String font_roboto_condensed = 'Roboto Condensed';
  static const String font_great_vibes = 'Great Vibes';
  static const String font_press_start_2p = 'Press Start 2P';
  static const String font_sniglet = 'Sniglet';
  static const String font_bubblegum_sans = 'Bubblegum Sans';
  static const String font_bebas_neue = 'Bebas Neue';
  static const String font_cmu_serif_italic = 'CMU Serif Italic';
  static const String font_cmu_serif_bold_italic = 'CMU Serif Bold Italic';
  static const String font_blinker = 'Blinker';
}

enum OutlineMode { underline, box }

enum TileArrangement { oneX, twoXtwo }
