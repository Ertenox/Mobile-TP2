import 'ModeleMinuteur.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Minuteur {
  int _tempsPauseCourte = 5;
  int _tempsPauseLongue = 20;
  int _tempsTravail = 30;
  double _pourcentage = 1.0;
  bool _estActif = false;
  Duration _temps = Duration();
  Duration _tempsTotal = Duration();


  String retournerTemps(Duration t) {
    String minutes = t.inMinutes.toString().padLeft(2, '0');
    int numSecondes = t.inSeconds - (t.inMinutes * 60);
    String secondes = numSecondes.toString().padLeft(2, '0');
    String tempsFormate = '$minutes:$secondes';
    return tempsFormate;
  }

  Stream<ModeleMinuteur> stream() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int a) {
      if (_estActif) {
        _temps = _temps - const Duration(seconds: 1);
      }
      if (_temps.inSeconds <= 0) {
        _estActif = false;
        _temps = const Duration();
      }
      if (_tempsTotal.inSeconds != 0) {
        _pourcentage = _temps.inSeconds / _tempsTotal.inSeconds;
      } else {
        _pourcentage = 1.0;
      }
      return ModeleMinuteur(retournerTemps(_temps), _pourcentage);
    });
  }

  void demarrerTravail1() {
    _estActif = true;
    if (_temps.inSeconds >= 0) {
      _temps = Duration(minutes: _tempsTravail.toInt());
      _tempsTotal = _temps;
    }
    print("Temps de travail: $_tempsTotal");
  }

  void demarrerTravail () async {
    await lireParametres();
    _estActif = true;
    if (_temps.inSeconds >= 0) {
      _temps = Duration(minutes: _tempsTravail.toInt());
      _tempsTotal = _temps;
    }
    print("Temps de travail: $_tempsTotal");
  }

  void arreterMinuteur() {
    _estActif = false;
  }

  void relancerMinuteur() {
    if (_temps.inSeconds > 0) {
      _estActif = true;
    }
  }

  void demarrerPause(bool estLongue) {
    _estActif = true;
    _temps = Duration(minutes: estLongue ? _tempsPauseLongue.toInt() : _tempsPauseCourte.toInt());
    _tempsTotal = _temps;

  }

  lireParametres() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _tempsTravail = preferences.getInt(CLE_TEMPS_TRAVAIL) ?? 30;
    _tempsPauseCourte = preferences.getInt(CLE_PAUSE_COURTE) ?? 5;
    _tempsPauseLongue = preferences.getInt(CLE_PAUSE_LONGUE) ?? 20;
  }


}