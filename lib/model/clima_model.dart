class ClimaModel {
  final double temperatura;
  final double tempMin;
  final double tempMax;
  final double sensacaoTermica;
  final int pressao;
  final int umidade;
  final int visibilidade;
  final String descricao;
  final String icone;

  ClimaModel(
      {required this.temperatura,
        required this.tempMin,
        required this.tempMax,
        required this.sensacaoTermica,
        required this.pressao,
        required this.umidade,
        required this.visibilidade,
        required this.descricao,
        required this.icone});

  factory ClimaModel.fromJSON(Map<String, dynamic> json) {
    return ClimaModel(
        temperatura: json['main']['temp'].toDouble(),
        tempMin: json['main']['temp_min'].toDouble(),
        tempMax: json['main']['temp_max'].toDouble(),
        sensacaoTermica: json['main']['feels_like'].toDouble(),
        pressao: json['main']['pressure'].toInt(),
        umidade: json['main']['humidity'].toInt(),
        visibilidade: json['visibility'].toInt(),
        descricao: json['weather'][0]['description'],
        icone: json['weather'][0]['icon']);
  }
}