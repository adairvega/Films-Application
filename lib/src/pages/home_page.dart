import 'package:films/src/providers/peliculas_provider.dart';
import 'package:films/src/widgets/card_swiper_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
          //centerTitle: true, #In case of Center title required
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[_swiperTarjetas()],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    final peliculasProvier = new PeliculasProvier();
    peliculasProvier.getEnCines();

    return CardSwiper(
      peliculas: [1, 2, 3, 4, 5],
    );
  }
}
