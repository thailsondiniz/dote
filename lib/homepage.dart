import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:teste_api_dot/createPet.dart';
import 'package:teste_api_dot/models/petModel.dart';
import 'package:teste_api_dot/requisicoes/requisicoes.dart';
import 'package:teste_api_dot/server/server.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.petModel});
  final Pet? petModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Pet>> futurePets;

  @override
  void initState() {
    super.initState();
    futurePets = Req().getPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CriarPet()),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Teste',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(
              'This is Google Fonts',
              style: GoogleFonts.lato(
                textStyle: TextStyle(color: Colors.blue, letterSpacing: .5),
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Olá, ',
                style: GoogleFonts.lato(
                    textStyle:
                        TextStyle(color: Colors.black, letterSpacing: .5)),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Erika',
                    style: GoogleFonts.lato(
                      textStyle:
                          TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Pet>>(
                future: futurePets,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('Nenhum pet cadastrado.'),
                    );
                  }
                  final pets = snapshot.data!;
                  return ListView.builder(
                    itemCount: pets.length,
                    itemBuilder: (context, index) {
                      final pet = pets[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(color: Colors.grey),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 150,
                                        decoration:
                                            BoxDecoration(color: Colors.amber),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            pet.nome,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            pet.especie,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            pet.raca,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            pet.sexo,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
