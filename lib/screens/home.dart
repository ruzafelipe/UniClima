import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:uni_clima/constants/api_constants.dart';
import 'package:uni_clima/model/clima_model.dart';
import 'package:uni_clima/model/geo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final List<String> cidades = [
    'Aracaju',
    'Belém',
    'Belo Horizonte',
    'Boa Vista',
    'Brasilia',
    'Campo Grande',
    'Cuiaba',
    'Curitiba',
    'Florianópolis',
    'Fortaleza',
    'Goiania',
    'João Pessoa',
    'Macapá',
    'Maceió',
    'Manaus',
    'Natal',
    'Palmas',
    'Porto Alegre',
    'Porto Velho',
    'Recife',
    'Rio Branco',
    'Rio de Janeiro',
    'Salvador',
    'São Luís',
    'São Paulo',
    'Teresina',
    'Vitória'
  ];

  String cidadeSelecionada = 'São Paulo';
  late Geolocalizacao geolocalizacao;
  late ClimaModel climaModel;

  carregaGeolocalizacao() async {
    final params = {'q': cidadeSelecionada, 'appid': ApiConstants.apiKey};

    final geoResponse = await http
        .get(Uri.https(ApiConstants.apiUrl, ApiConstants.geoPath, params));

    if (geoResponse.statusCode == 200) {
      geolocalizacao = Geolocalizacao.fromJSON(jsonDecode(geoResponse.body));
    }
  }

  carregaClima() async {
    await carregaGeolocalizacao();
    final params = {
      'lat': geolocalizacao.latitude.toString(),
      'lon': geolocalizacao.longitude.toString(),
      'appid': ApiConstants.apiKey,
      'units': ApiConstants.units,
      'lang': ApiConstants.lang
    };

    final climaReponse = await http
        .get(Uri.https(ApiConstants.apiUrl, ApiConstants.weatherPath, params));

    if (climaReponse.statusCode == 200) {
      climaModel = ClimaModel.fromJSON(jsonDecode(climaReponse.body));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cidadeSelecionada),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              DropdownSearch<String>(
                items: cidades,
                selectedItem: 'São Paulo',
                popupProps: const PopupProps.menu(),
                onChanged: (value) {
                  setState(() {
                    cidadeSelecionada = value!;
                    carregaClima();
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}