import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
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
  List categorias = ['😺 Gato', '🐶 Cachorro', '🐹 Hamster', '🐰 Coelho'];
  final List<Color> categoriasColors = [
    Color(0xffFFF9BF),
    Color(0xffC5D3E8),
    Color(0xffFFDDAE),
    Color(0xffD6C0B3)
  ];
  @override
  void initState() {
    super.initState();
    futurePets = Req().getPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffFFDDAE),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CriarPet()),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: Icon(
          PhosphorIcons.equals_bold,
          size: 30,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              PhosphorIcons.magnifying_glass_bold,
              size: 25,
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Olá, ',
                    style: GoogleFonts.poppins(
                        textStyle:
                            TextStyle(color: Colors.black, fontSize: 20)),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Erika.',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xff343434),
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 40,
                  height: 10,
                  color: Colors.amber,
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 400,
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categorias.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: categoriasColors[index],
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          categorias[index],
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Color(0xff343434),
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  );
                },
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
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 15, bottom: 10, top: 10),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFE9E9E9),
                                  borderRadius: BorderRadius.circular(20)),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFD24A),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.network(
                                              'https://www.petlove.com.br/images/breeds/192401/profile/original/srd-p.jpg?1532539578',
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                 Icon(
                                                    PhosphorIcons.heart_straight,
                                                    color: Color(0xFF8E8D8D),
                                                    size: 20,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                pet.raca,
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Color(0xff343434),
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              Text(
                                                pet.nome,
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Color(0xFF8E8D8D),
                                                      fontSize: 13),
                                                ),
                                              ),
                                              Text(
                                                pet.especie,
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Color(0xFF8E8D8D),
                                                      fontSize: 13),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(
                                                    PhosphorIcons.gender_male,
                                                    color: Color(0xFF8E8D8D),
                                                    size: 20,
                                                  ),
                                                  Text(
                                                    pet.sexo,
                                                    style:GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Color(0xFF8E8D8D),
                                                      fontSize: 14),
                                                ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
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
