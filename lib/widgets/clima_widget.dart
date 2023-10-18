import 'package:flutter/material.dart';
import 'package:uni_clima/constants/text_constants.dart';
import 'package:uni_clima/model/clima_model.dart';

class ClimaWidget extends StatelessWidget {
  final ClimaModel climaModel;

  const ClimaWidget({Key? key, required this.climaModel}) : super(key: key);

  String primeiraMaiuscula(String s) =>
      '${s[0].toUpperCase()}${s.substring(1)}';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
            'https://openweathermap.org/img/wn/${climaModel.icone}@2x.png',
            fit: BoxFit.fill,
            width: 120),
        Text('${climaModel.temperatura.toStringAsFixed(0)}º',
            style: const TextStyle(fontSize: 50)),
        Text(primeiraMaiuscula(climaModel.descricao),
            style: const TextStyle(fontSize: 30)),
        const SizedBox(height: 20),
        Text(
            '${TextConstants.sensacaoTermica}: ${climaModel.sensacaoTermica.toStringAsFixed(0)}º',
            style: const TextStyle(fontSize: 18)),
        Text('${TextConstants.min}: ${climaModel.tempMin.toStringAsFixed(0)}º',
            style: const TextStyle(fontSize: 18)),
        Text('${TextConstants.max}: ${climaModel.tempMax.toStringAsFixed(0)}º',
            style: const TextStyle(fontSize: 18)),
        Text('${TextConstants.umidRel}: ${climaModel.umidade}%',
            style: const TextStyle(fontSize: 18)),
        Text('${TextConstants.pressaoAtm}: ${climaModel.pressao} hPa',
            style: const TextStyle(fontSize: 18)),
        Text('${TextConstants.visibilidade}: ${climaModel.visibilidade} Km',
            style: const TextStyle(fontSize: 18))
      ],
    );
  }
}