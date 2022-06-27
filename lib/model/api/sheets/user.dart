class UserFields {
  static const String id = 'ID';
  static const String cpf = 'CPF DO RESPONSÁVEL';
  static const String name = 'NOME DO RESPONSÁVEL';
  static const String email = 'E-MAIL DO RESPONSÁVEL';
  static const String district = 'BAIRRO';
  static const String post = 'POSTO DE VACINAÇÃO';
  static const String animalName = 'NOME DO ANIMAL';
  static const String animalSex = 'SEXO DO ANIMAL';
  static const String animalSpecies = 'ESPÉCIE DO ANIMAL';
  static const String animalOld = 'IDADE DO ANIMAL';
  static const String dataVaccination = 'DATA DE VACINAÇÃO';

  static List<String> getFields() => [
        id,
        cpf,
        name,
        email,
        district,
        post,
        animalName,
        animalSex,
        animalSpecies,
        animalOld,
        dataVaccination
      ];
}

class User {
  final String? id;
  final String cpf;
  final String name;
  final String email;
  final String district;
  final String post;
  final String animalName;
  final String animalSex;
  final String animalSpecies;
  final String animalOld;
  final DateTime dataVaccination;

  const User(
      {this.id,
      required this.cpf,
      required this.name,
      required this.email,
      required this.district,
      required this.post,
      required this.animalName,
      required this.animalSex,
      required this.animalSpecies,
      required this.animalOld,
      required this.dataVaccination});

  static User fromJson(Map<String, dynamic> json) => User(
      id: json[UserFields.id],
      cpf: json[UserFields.cpf],
      name: json[UserFields.name],
      email: json[UserFields.email],
      district: json[UserFields.district],
      post: json[UserFields.post],
      animalName: json[UserFields.animalName],
      animalSex: json[UserFields.animalSex],
      animalSpecies: json[UserFields.animalSpecies],
      animalOld: json[UserFields.animalOld],
      dataVaccination: DateTime.parse(json[UserFields.dataVaccination]));

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.cpf: cpf,
        UserFields.name: name,
        UserFields.email: email,
        UserFields.district: district,
        UserFields.post: post,
        UserFields.animalName: animalName,
        UserFields.animalSex: animalSex,
        UserFields.animalSpecies: animalSpecies,
        UserFields.animalOld: animalOld,
        UserFields.dataVaccination: dataVaccination.toString(),
      };
}
