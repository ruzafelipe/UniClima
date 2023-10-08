import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

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