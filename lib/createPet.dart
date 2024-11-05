import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:teste_api_dot/homepage.dart';
import 'package:teste_api_dot/requisicoes/requisicoes.dart';
import 'package:teste_api_dot/server/server.dart';

class CriarPet extends StatefulWidget {
  const CriarPet({super.key});

  @override
  State<CriarPet> createState() => _CriarPetState();
}

class _CriarPetState extends State<CriarPet> {
  final TextEditingController especie = TextEditingController();
  final TextEditingController nome = TextEditingController();
  final TextEditingController idade = TextEditingController();
  final TextEditingController raca = TextEditingController();
  final TextEditingController sexo = TextEditingController();
  final TextEditingController descricao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Criar',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            form(especie, 'Especie'),
            form(nome, 'Nome'),
            form(idade, 'Idade'),
            form(raca, 'Raça'),
            form(sexo, 'Sexo'),
            form(descricao, 'Descrição'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                Req().cadastrarPet(especie.text, nome.text, idade.text, raca.text,
                    sexo.text, descricao.text);
                especie.clear();
                nome.clear();
                idade.clear();
                raca.clear();
                sexo.clear();
                descricao.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: Text(
                'Enviar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget form(controler, String hint) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5, top: 5),
    child: TextFormField(
      controller: controler,
      decoration: InputDecoration(border: OutlineInputBorder(), hintText: hint),
    ),
  );
}
