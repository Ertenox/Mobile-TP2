import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'bouton.dart';
import 'minuteur.dart';
import 'ModeleMinuteur.dart';
import 'page_parametres.dart';

class PageAccueilMinuterie extends StatelessWidget {
  static const double REMPLISSAGE_DEFAUT = 5.0;
  PageAccueilMinuterie({Key? key}) : super(key: key);
  Minuteur minuteur = Minuteur();
  void methodeVide() {}

  void allerPageParametres(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PageParametres()));
  }

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> elementsMenu = [];
    elementsMenu.add(PopupMenuItem(
      value: 'Param',
      child: Text('Paramètres'),
    ));
    return Scaffold(
        appBar: AppBar(
          title: Text('Ma gestion du temps'),
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return elementsMenu.toList();
              },
              onSelected: (s) {
                if (s == 'Param') {
                  allerPageParametres(context);
                }
              },
            ),
          ],
        ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double largeurDisponible = constraints.maxWidth;
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: REMPLISSAGE_DEFAUT),
                  Expanded(
                    child: BoutonGenerique(
                      couleur: Colors.blue,
                      texte: 'Travail',
                      taille: REMPLISSAGE_DEFAUT,
                      action: () {
                        minuteur.demarrerTravail();
                      },
                    ),
                  ),
                  SizedBox(width: REMPLISSAGE_DEFAUT),
                  Expanded(
                    child: BoutonGenerique(
                      couleur: Colors.red,
                      texte: 'Minipause',
                      taille: REMPLISSAGE_DEFAUT,
                      action: () {
                        minuteur.demarrerPause(false);
                      },
                    ),
                  ),
                  SizedBox(width: REMPLISSAGE_DEFAUT),
                  Expanded(
                    child: BoutonGenerique(
                      couleur: Colors.green,
                      texte: 'Maxipause',
                      taille: REMPLISSAGE_DEFAUT,
                      action: () {
                        minuteur.demarrerPause(true);
                      },
                    ),
                  ),
                  SizedBox(width: REMPLISSAGE_DEFAUT),
                ],
              ),
              Expanded(
                child: StreamBuilder(
                  initialData: ModeleMinuteur('00:00', 1),
                  stream: minuteur.stream(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    ModeleMinuteur chrono = snapshot.data;
                    return CircularPercentIndicator(
                      radius: (largeurDisponible - 60.0) / 2,
                      lineWidth: 10.0,
                      percent: chrono.pourcentage ?? 1.0,
                      center: Text(
                        chrono.temps ?? '00:00',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      progressColor: const Color(0xff009688),
                    );
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: BoutonGenerique(
                      couleur: Colors.blue,
                      texte: 'Arrêter',
                      taille: REMPLISSAGE_DEFAUT,
                      action: () {
                        minuteur.arreterMinuteur();
                      },
                    ),
                  ),
                  SizedBox(width: 10), // Ajout d'un espace entre les boutons
                  Expanded(
                    child: BoutonGenerique(
                      couleur: Colors.blue,
                      texte: 'Relancer',
                      taille: REMPLISSAGE_DEFAUT,
                      action: () {
                        minuteur.relancerMinuteur();
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
