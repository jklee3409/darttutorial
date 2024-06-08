import 'dart_basic_20.dart';

class ColorPointDrawer extends ColorPoint with ActivationFlag{
  
  ColorPointDrawer(var r, var g, var b, var x, var y) : super(r,g,b,x,y);

  @override
  String get stringfy => (this.flagActivated = true) ? "${super.stringfy} is activated" : "null";
}

mixin ActivationFlag{
  bool flag = true;

  bool get flagActivated => this.flag;
  set flagActivated(bool givenFlag) => (this.flag = givenFlag);
}