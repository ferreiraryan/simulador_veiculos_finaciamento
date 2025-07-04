// lib/screen/detalhes_screen.dart

import 'package:flutter/material.dart';

// TODO: Importe as classes de veículos quando criadas
// Exemplo:
// import '../veiculos/carros_widget.dart';
// import '../veiculos/moto_widget.dart';
// import '../veiculos/caminhao_widget.dart';

class DetalhesScreen extends StatelessWidget {
  // Supondo que todos os veículos herdem de VeiculoWidget
  final dynamic veiculo;

  const DetalhesScreen({Key? key, required this.veiculo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${veiculo.nome} - Detalhes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Imagem do veículo
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                veiculo.imagemUrl,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Nome do veículo
            Text(
              veiculo.nome,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const Divider(),

            // Descrição
            Text("Descrição: ${veiculo.descricao}"),

            const SizedBox(height: 8),

            // Preço
            Text("Preço: R\$ ${veiculo.preco.toStringAsFixed(2)}"),

            const SizedBox(height: 8),

            // Mostrar propriedades específicas do veículo
            _exibirPropriedadesEspecificas(context, veiculo),

            const Divider(height: 32),

            // Simulador de Financiamento
            const Text(
              "Simular Financiamento",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            const Text("Valor de entrada:"),
            TextField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                // TODO: Salvar valor de entrada e recalcular
              },
              decoration: const InputDecoration(
                hintText: "Ex: 5000",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),

            const Text("Prazo em meses:"),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                // TODO: Salvar prazo e recalcular
              },
              decoration: const InputDecoration(
                hintText: "Ex: 48",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                // TODO: Implementar cálculo real aqui com base nos campos acima
                _mostrarDialogSimulacao(context);
              },
              child: const Text("Calcular Parcelas"),
            ),
          ],
        ),
      ),
    );
  }

  // Método para exibir propriedades específicas do veículo (ex: portas, cilindradas)
  Widget _exibirPropriedadesEspecificas(BuildContext context, dynamic veiculo) {
    if (veiculo is CarroWidget) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Portas: ${veiculo.portas}"),
          Text("Motor: ${veiculo.motor} L"),
        ],
      );
    } else if (veiculo is MotoWidget) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Cilindradas: ${veiculo.cilindradas} cc"),
          Text("Tipo: ${veiculo.tipoMoto}"),
        ],
      );
    } else if (veiculo is CaminhaoWidget) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Capacidade de Carga: ${veiculo.capacidadeCarga} toneladas"),
          Text("Eixos: ${veiculo.numeroEixos}"),
        ],
      );
    } else {
      return const Text("Informações adicionais não disponíveis.");
    }
  }

  void _mostrarDialogSimulacao(BuildContext context) {
    // Valores fictícios para demonstração
    double entrada = 5000;
    int meses = 48;
    double valorFinanciado = veiculo.preco - entrada;
    double jurosMensal = 0.02; // 2% ao mês
    double parcela = (valorFinanciado / meses) + (valorFinanciado * jurosMensal);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Resultado da Simulação"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Entrada: R\$ $entrada"),
            Text("Parcelas: $meses meses"),
            Text("Valor financiado: R\$ ${valorFinanciado.toStringAsFixed(2)}"),
            Text("Valor da parcela: R\$ ${parcela.toStringAsFixed(2)}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text("Fechar"),
          )
        ],
      ),
    );
  }
}

// TODO: Criar estas classes conforme orientação da atividade
// Classe abstrata VeiculoWidget
abstract class VeiculoWidget extends StatelessWidget {
  final String nome;
  final double preco;
  final String descricao;
  final String imagemUrl;
  final VoidCallback onTap;

  const VeiculoWidget({
    Key? key,
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.imagemUrl,
    required this.onTap,
  }) : super(key: key);
}

// Exemplo de classe filha: CarroWidget
class CarroWidget extends VeiculoWidget {
  final int portas;
  final double motor;

  const CarroWidget({
    Key? key,
    required String nome,
    required double preco,
    required String descricao,
    required String imagemUrl,
    required VoidCallback onTap,
    required this.portas,
    required this.motor,
  }) : super(
          key: key,
          nome: nome,
          preco: preco,
          descricao: descricao,
          imagemUrl: imagemUrl,
          onTap: onTap,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.network(imagemUrl, width: 80, height: 80, fit: BoxFit.cover),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nome, style: const TextStyle(fontSize: 18)),
                    Text("R\$ ${preco.toStringAsFixed(2)}"),
                    Text("$portas portas, Motor ${motor}L"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Exemplo de classe filha: MotoWidget
class MotoWidget extends VeiculoWidget {
  final int cilindradas;
  final String tipoMoto;

  const MotoWidget({
    Key? key,
    required String nome,
    required double preco,
    required String descricao,
    required String imagemUrl,
    required VoidCallback onTap,
    required this.cilindradas,
    required this.tipoMoto,
  }) : super(
          key: key,
          nome: nome,
          preco: preco,
          descricao: descricao,
          imagemUrl: imagemUrl,
          onTap: onTap,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.network(imagemUrl, width: 80, height: 80, fit: BoxFit.cover),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nome, style: const TextStyle(fontSize: 18)),
                    Text("R\$ ${preco.toStringAsFixed(2)}"),
                    Text("$cilindradas cc - $tipoMoto"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Exemplo de classe filha: CaminhaoWidget
class CaminhaoWidget extends VeiculoWidget {
  final double capacidadeCarga;
  final int numeroEixos;

  const CaminhaoWidget({
    Key? key,
    required String nome,
    required double preco,
    required String descricao,
    required String imagemUrl,
    required VoidCallback onTap,
    required this.capacidadeCarga,
    required this.numeroEixos,
  }) : super(
          key: key,
          nome: nome,
          preco: preco,
          descricao: descricao,
          imagemUrl: imagemUrl,
          onTap: onTap,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.network(imagemUrl, width: 80, height: 80, fit: BoxFit.cover),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nome, style: const TextStyle(fontSize: 18)),
                    Text("R\$ ${preco.toStringAsFixed(2)}"),
                    Text("${capacidadeCarga} Ton, ${numeroEixos} Eixos"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
