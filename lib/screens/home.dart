import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uni_clima/constants/api_constants.dart';
import 'package:uni_clima/constants/text_constants.dart';
import 'package:uni_clima/model/clima_model.dart';
import 'package:uni_clima/model/geo_model.dart';
import 'package:uni_clima/widgets/clima_widget.dart';

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
  bool isLoading = false;
  TextEditingController cidadeController = TextEditingController();

  carregaGeolocalizacao() async {
    final params = {'q': cidadeSelecionada, 'appid': ApiConstants.apiKey};

    final geoResponse = await http
        .get(Uri.https(ApiConstants.apiUrl, ApiConstants.geoPath, params));

    if (geoResponse.statusCode == 200) {
      geolocalizacao = Geolocalizacao.fromJSON(jsonDecode(geoResponse.body));
    }
  }

  carregaClima() async {
    setState(() {
      isLoading = true;
    });
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
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    carregaClima();
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
              //Para travar as capitais:
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
              ),
              //Row(
              //  children: [
              //     Expanded(
              //        child: TextField(
              //         controller: cidadeController,
              //        maxLength: 120,
              //        decoration: const InputDecoration(
              //            labelText: TextConstants.localizacao),
              //        onChanged: (value) {
              //         setState(() {
              //          cidadeSelecionada = cidadeController.text;
              //         });
              //       },
              //        onSubmitted: (value) => carregaClima(),
              //        )),
              // IconButton(
              //      onPressed: () => carregaClima(),
              //      icon: const Icon(Icons.search))
              //  ],
              //  ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(6),
                          child: isLoading
                              ? const CircularProgressIndicator(
                            strokeWidth: 6,
                            valueColor: AlwaysStoppedAnimation(Colors.blue),
                          )
                              : climaModel != null
                              ? ClimaWidget(climaModel: climaModel)
                              : const Text(TextConstants.semDados)),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: isLoading
                              ? Text(
                            TextConstants.carregando,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headlineMedium,
                          )
                              : IconButton(
                            onPressed: carregaClima,
                            icon: const Icon(Icons.refresh),
                            iconSize: 50,
                            color: Colors.blue,
                            tooltip: TextConstants.recarregar,
                          ))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}