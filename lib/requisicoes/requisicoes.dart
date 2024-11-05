import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste_api_dot/models/petModel.dart';
import 'package:teste_api_dot/server/server.dart';

class Req {
  //Get Pets
  Future<List<Pet>> getPets() async {
    final response = await http.get(
      Uri.parse('${apiUrl}/pets'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print('Busca realizada com sucesso!');
      print(response.body);
      return List<Pet>.from(json.map((elemento) {
        return Pet.fromJson(elemento);
      }));
    } else {
      return Future.error("Requisição falhou, ${response.statusCode}");
    }
  }
  //Criar pets
  Future cadastrarPet(String especie, String nome, String raca, String idade,
      String sexo, String descricao) async {
    final Map<String, dynamic> petData = {
      'especie': especie,
      'nome': nome,
      'raca': raca,
      'idade': idade,
      'sexo': sexo,
      'descricao': descricao
    };

    final String petJson = jsonEncode(petData);

    try {
      final response = await http.post(Uri.parse('${apiUrl}/pets'),
          headers: {'Content-Type': 'application/json'}, body: petJson);

      if (response.statusCode == 201) {
        print('Pet cadastrado com sucesso!');
      } else {
        print('Falha ao cadastrar o pet: ${response.statusCode}');
        print('Erro: ${response.body}');
      }
    } catch (e) {
      print('Erro na requisição $e');
    }
  }
}
