import 'dart:async';

class Spacecraft{
  String name;
  DateTime? launchDate;

  Spacecraft(this.name, this.launchDate);

  Spacecraft.unluanched(String name) : this(name, null);

  int? get launchYear => launchDate?.year;

  void describe(){
    print('Spacecraft: $name');
    if(launchDate != null){
      int years = DateTime.now().difference(launchDate!).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    }else{
      print('Unlaunched');
    }
  }
}

mixin Piloted {
  int astronauts = 1;

  void describeCrew(){
    print('Number of astronauts: $astronauts');
  }
}

class PilotedCraft extends Spacecraft with Piloted { 
  num altitude;
  
  PilotedCraft(String name, DateTime launchDate, this.altitude) : super(name, launchDate);
}

Future<int> futureNumber(){
  return Future<int>.delayed(Duration(seconds: 3), (){
      throw 'error!';
  });
}

void main(){
  Future<int> future = futureNumber();

  future.then((val){
    print('val : $val');
  }).catchError((error){
    print('error: $error');
  });

  print('기다리는 중...');
  
}