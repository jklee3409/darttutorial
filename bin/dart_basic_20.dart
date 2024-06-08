import 'dart:math';

class Point{
  var x;
  var y;

  Point([this.x = 0, this.y = 0]);

  Point.fromPoint(Point origin) : this.x = origin.x, this.y = origin.y;

  String get stringfy => "(${this.x}, ${this.y})";

  set increaseX(num value) => this.x += value;
  set increaseY(num value) => this.y += value;

  num distanceTo(Point other){
    var dx = this.x - other.x;
    var dy = this.y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}

class ColorPoint extends Point{
  int red;
  int green;
  int blue;

  ColorPoint([this.red = 1, this.green = 1, this.blue = 1, var x = 0, var y = 0]) : super(x,y);

  String get stringfy => "(${super.stringfy} with (${this.red}, ${this.green}, ${this.blue}))";

  ColorPoint operator +(ColorPoint p) => ColorPoint(255,255,255, this.x + p.x, this.y + y);
}

class Logger {
  final String name;
  bool mute = false;

  static final Map _cache = {};

  factory Logger(String name){
    return _cache.putIfAbsent(name, () => Logger._internal);
  }

  Logger._internal(this.name);

  void log(String msg){
    if (!mute) print(msg);
  }

  static get cacheLength => _cache.length;

}
