class Point<T> {
  T x;
  T y;

  Point(T xcord, T ycord)
      : this.x = xcord,
        this.y = ycord;
}

void main() {
  var iPoint = Point(5, 5);
  var dPoint = Point(10.0, 10.0);
  var sPoint = Point("A", "A");

  print('Integer: (${iPoint.x}, ${iPoint.y})');
  print('Double: (${dPoint.x}, ${dPoint.y})');
  print('String: (${sPoint.x}, ${sPoint.y})');
}
