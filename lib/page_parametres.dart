import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bouton.dart';
import 'main.dart';

const String TEMPS_TRAVAIL = '30';
const String PAUSE_COURTE = '5';
const String PAUSE_LONGUE = '20';

class PageParametres extends StatefulWidget {
  const PageParametres({Key? key}) : super(key: key);

  @override
  State<PageParametres> createState() => _PageParametresState();
}



class _PageParametresState extends State<PageParametres> {
  final TextEditingController txtTempsTravail = TextEditingController();
  final TextEditingController txtTempsPauseCourte = TextEditingController();
  final TextEditingController txtTempsPauseLongue = TextEditingController();

  @override
  void initState() {
    lireParametres();
    super.initState();
  }

  void allerAccueil(BuildContext context) {
    Navigator.pop(context);
  }

  void majParametres(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    switch (key) {
      case TEMPS_TRAVAIL:
        int tempsTravail =
            preferences.getInt(CLE_TEMPS_TRAVAIL) ?? TEMPS_TRAVAIL_DEFAUT;
        tempsTravail += value;
        if (tempsTravail >= 1 && tempsTravail <= 180) {
          preferences.setInt(CLE_TEMPS_TRAVAIL, tempsTravail);
          setState(() {
            txtTempsTravail.text = tempsTravail.toString();
          });
        }
        break;
      case PAUSE_COURTE:
        int tempsPauseCourte =
            preferences.getInt(CLE_PAUSE_COURTE) ?? TEMPS_PAUSE_COURTE_DEFAUT;
        tempsPauseCourte += value;
        if (tempsPauseCourte >= 1 && tempsPauseCourte <= 10) {
          preferences.setInt(CLE_PAUSE_COURTE, tempsPauseCourte);
          setState(() {
            txtTempsPauseCourte.text = tempsPauseCourte.toString();
          });
        }
        break;
      case PAUSE_LONGUE:
        int tempsPauseLongue =
            preferences.getInt(CLE_PAUSE_LONGUE) ?? TEMPS_PAUSE_LONGUE_DEFAUT;
        tempsPauseLongue += value;
        if (tempsPauseLongue >= 10 && tempsPauseLongue <= 30) {
          preferences.setInt(CLE_PAUSE_LONGUE, tempsPauseLongue);
          setState(() {
            txtTempsPauseLongue.text = tempsPauseLongue.toString();
          });
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTexte = TextStyle(fontSize: 16);
    final List<PopupMenuItem<String>> elementsMenu = [];
    elementsMenu.add(PopupMenuItem(
      value: 'Acc',
      child: Text('Accueil'),
    ));
    return Scaffold(
      appBar: AppBar(
          title: Text('Paramètres'),
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return elementsMenu.toList();
              },
              onSelected: (s) {
                if (s == 'Acc') {
                  allerAccueil(context);
                }
              },
            ),
          ]
      ),
      body:  GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: EdgeInsets.all(20),
        childAspectRatio: 3,
        children: <Widget>[
        Text(
        'Temps de travail',
        style: styleTexte,
      ),
        Text(''),
        Text(''),
        BoutonParametre(
            couleur : Color(0xff455A64),
            texte: '-',
            valeur : -1,
            parametre: TEMPS_TRAVAIL,
            action: majParametres),
        TextField(
          controller: txtTempsTravail,
          style: styleTexte,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
        ),
        BoutonParametre(
            couleur : Color(0xff009688),
            texte: '+',
            valeur : 1,
            parametre: TEMPS_TRAVAIL,
            action: majParametres),
        Text(
          'Temps pour une pause courte',
          style: styleTexte,
        ),
        Text(''),
        Text(''),
        BoutonParametre(
            couleur: Color(0xff455A64),
            texte: '-',
            valeur: -1,
            parametre: PAUSE_COURTE,
            action: majParametres),

        TextField(
          controller: txtTempsPauseCourte,
          style: styleTexte,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
        ),
        BoutonParametre(
            couleur: Color(0xff009688),
            texte: '+',
            valeur: 1,
            parametre: PAUSE_COURTE,
            action: majParametres),
        Text(
          'Temps pour une pause longue',
          style: styleTexte,
        ),
        Text(''),
        Text(''),
        BoutonParametre(
            couleur: Color(0xff455A64),
            texte: '-',
            valeur: -1,
            parametre: PAUSE_LONGUE,
            action: majParametres),
          TextField(
            controller: txtTempsPauseLongue,
            style: styleTexte,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          BoutonParametre(
            couleur: Color(0xff009688),
            texte: '+',
            valeur: 1,
            parametre: PAUSE_LONGUE,
            action: majParametres),
        ],


      )

    );
  }
  lireParametres() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? tempsTravail = preferences.getInt(CLE_TEMPS_TRAVAIL);
    if (tempsTravail == null) {
      await preferences.setInt(CLE_TEMPS_TRAVAIL, TEMPS_TRAVAIL_DEFAUT);
    }
    int? tempsPauseCourte = preferences.getInt(CLE_PAUSE_COURTE);
    if (tempsPauseCourte == null) {
      await preferences.setInt(CLE_PAUSE_COURTE, TEMPS_PAUSE_COURTE_DEFAUT);
    }
    int? tempsPauseLongue = preferences.getInt(CLE_PAUSE_LONGUE);
    if (tempsPauseLongue == null) {
      await preferences.setInt(CLE_PAUSE_LONGUE, TEMPS_PAUSE_LONGUE_DEFAUT);
    }
    setState(() {
      txtTempsTravail.text = tempsTravail.toString();
      txtTempsPauseCourte.text = tempsPauseCourte.toString();
      txtTempsPauseLongue.text = tempsPauseLongue.toString();
    });
  }
}