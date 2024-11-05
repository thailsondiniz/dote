class Pet {
  String especie;
  String nome;
  String raca;
  String idade;
  String sexo;
  // String? imagens;

  Pet({
    required this.especie,
    required this.nome,
    required this.raca,
    required this.idade,
    required this.sexo,
    // this.imagens,
  });

  Pet.fromJson(Map<String, dynamic> json)
      : especie = json['especie'].toString(),
        nome = json['nome'].toString(),
        raca = json['raca'].toString(),
        idade = json['idade'].toString(),
        sexo = json['sexo'].toString();
  // imagens = json['imagens'].toString();
}
