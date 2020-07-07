import 'dart:convert';

import 'package:films/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvier {
  //String _apiKey: introduce your api key signing up in https://www.themoviedb.org/
  String _apiKey = '67646533ff20f872ad220eca3ec84d9c';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }
}
