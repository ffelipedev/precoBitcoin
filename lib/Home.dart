import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _preco = '0';

  void _recuperarPreco() async {
    String url = 'https://blockchain.info/ticker';
    http.Response response = await http
        .get(url); //get faz a consulta na web, await aguarda a responsta

    Map<String, dynamic> retorno = json.decode(response.body);
    setState(() {
      _preco = retorno["BRL"]["buy"].toString();
    });
    print('Resultado: ' +
        retorno["BRL"]["buy"].toString()); //recupera endereço da api
  } //metodo para recuperar preço

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding:
              EdgeInsets.all(32), //da um espaçamento em todos os lados de 32
          child: Center(
            //cenntraliza todo o conteudo no container
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, //centraliza tudo
              children: [
                Image.asset('imagens/bitcoin.png'), //cod para adicionar imagem
                Padding(
                  padding: EdgeInsets.only(
                      top: 30, bottom: 30), // espaçamento entre imagem e botão
                  child: Text(
                    'R\$ ' + _preco,
                    //para utlizar $ como texto precisa utlizar \ para funcionar como texto,
                    style:
                        TextStyle(fontSize: 35), // adicionado estilo ao texto
                  ),
                ),
                RaisedButton(
                  child: Text(
                    'Atualizar',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  color: Colors.orange,
                  // adicionando color
                  padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                  // paddin adicionando o valor de espaço das areas
                  onPressed: _recuperarPreco,
                ),
              ],
            ),
          )),
    );
  }
}
