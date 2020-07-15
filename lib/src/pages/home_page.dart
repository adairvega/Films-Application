import 'package:films/src/providers/peliculas_provider.dart';
import 'package:films/src/search/search_delegate.dart';
import 'package:films/src/widgets/card_swiper_widget.dart';
import 'package:films/src/widgets/movie_horizontal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final peliculasProvier = new PeliculasProvier();

  @override
  Widget build(BuildContext context) {
    peliculasProvier.getPopulares();
    return Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
          //centerTitle: true, #In case of Center title required
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DataSearch(),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swiperTarjetas(),
              _footer(context),
            ],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
        future: peliculasProvier.getEnCines(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return CardSwiper(peliculas: snapshot.data);
          } else {
            return Container(
                height: 400.0,
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget _footer(context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: peliculasProvier.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvier.getPopulares,
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}
