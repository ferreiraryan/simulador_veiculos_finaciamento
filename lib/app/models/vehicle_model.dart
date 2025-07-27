abstract class VehicleModel {
  final String nome;
  final double preco;
  final String descricao;
  final String imagemUrl;

  VehicleModel({
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.imagemUrl,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    final String type = json['type'];
    final Map<String, dynamic> data = json['data'];

    switch (type) {
      case 'car':
        return CarModel.fromJson(data);
      case 'moto':
        return MotoModel.fromJson(data);
      case 'caminhao':
        return CaminhaoModel.fromJson(data);
      default:
        throw Exception('Tipo de veículo desconhecido: $type');
    }
  }
}

class CarModel extends VehicleModel {
  final String tipoCarroceria;
  final int numeroPortas;

  CarModel({
    required super.nome,
    required super.preco,
    required super.descricao,
    required super.imagemUrl,
    required this.tipoCarroceria,
    required this.numeroPortas,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      nome: json['nome'],
      preco: json['preco'],
      descricao: json['descricao'],
      imagemUrl: json['imagemUrl'],
      tipoCarroceria: json['tipoCarroceria'],
      numeroPortas: json['numeroPortas'],
    );
  }
}

class MotoModel extends VehicleModel {
  final int cilindradas;
  final String tipo;

  MotoModel({
    required super.nome,
    required super.preco,
    required super.descricao,
    required super.imagemUrl,
    required this.cilindradas,
    required this.tipo,
  });

  factory MotoModel.fromJson(Map<String, dynamic> json) {
    return MotoModel(
      nome: json['nome'],
      preco: json['preco'],
      descricao: json['descricao'],
      imagemUrl: json['imagemUrl'],
      cilindradas: json['cilindradas'],
      tipo: json['tipo'],
    );
  }
}

class CaminhaoModel extends VehicleModel {
  final double capacidadeCarga;
  final int numeroEixos;

  CaminhaoModel({
    required super.nome,
    required super.preco,
    required super.descricao,
    required super.imagemUrl,
    required this.capacidadeCarga,
    required this.numeroEixos,
  });

  factory CaminhaoModel.fromJson(Map<String, dynamic> json) {
    return CaminhaoModel(
      nome: json['nome'],
      preco: json['preco'],
      descricao: json['descricao'],
      imagemUrl: json['imagemUrl'],
      capacidadeCarga: json['capacidadeCarga'],
      numeroEixos: json['numeroEixos'],
    );
  }
}
