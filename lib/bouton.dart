import 'package:flutter/material.dart';

class BoutonGenerique extends StatelessWidget {
  final Color couleur;
  final String texte;
  final double taille;
  final VoidCallback action;
  const BoutonGenerique({
    Key? key,
    required this.couleur,
    required this.texte,
    required this.taille,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: action,
      color: couleur,
      minWidth: taille,
      child: Text(
        texte,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}


typedef CallbackSetting = void Function(String, int);
class BoutonParametre extends StatelessWidget {
  final Color couleur;
  final String texte;
  final int valeur;
  final String parametre;
  final CallbackSetting action;
  BoutonParametre({
    Key? key,
    required this.couleur,
    required this.texte,
    required this.valeur,
    required this.parametre,
    required this.action,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        this.texte,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => this.action(this.parametre, this.valeur),
      color: this.couleur,
    );
  }
}
