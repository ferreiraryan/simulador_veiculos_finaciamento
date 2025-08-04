// Modelo abstrato de veiculos
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
  // Função que atribui factorys das classes respectivas
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

// Classe concreta carro
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
  // Factory: Transforma dados json em uma instancia da classe
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

// Classe concreta moto
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

  // Factory: Transforma dados json em uma instancia da classe
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

// Classe concreta caminhão
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

  // Factory: Transforma dados json em uma instancia da classe
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
