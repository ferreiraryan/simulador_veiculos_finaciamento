import 'package:flutter/material.dart';
import 'package:simulador_financeiro/app/models/vehicle_model.dart';
import 'package:simulador_financeiro/app/services/financing_service.dart';

// Tela de detalhes
class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

// Estados da tela de detalhe
class _DetailScreenState extends State<DetailScreen> {
  final _formKey =
      GlobalKey<FormState>(); // Chave de acesso aos dados do formulario
  final _entradaController =
      TextEditingController(); // Controladora da caixa de texto
  final _prazoController = TextEditingController();
  double _valorParcela = 0.0;

  // Funcao que valida os formularios e usa o servico para calcular
  void _calcular(double precoVeiculo) {
    if (_formKey.currentState!.validate()) {
      final double entrada = double.tryParse(_entradaController.text) ?? 0.0;
      final int prazo = int.tryParse(_prazoController.text) ?? 0;

      final double parcela = FinancingService.calcularParcela(
        precoVeiculo: precoVeiculo,
        entrada: entrada,
        prazo: prazo,
      );

      if (entrada >= precoVeiculo) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'A entrada não pode ser maior ou igual ao preço do veículo.',
            ),
            backgroundColor: Colors.orange,
          ),
        );
      }

      setState(() {
        _valorParcela = parcela;
      });
    }
  }

  // Limpa os dados de formulario quando sumir da tela
  @override
  void dispose() {
    _entradaController.dispose();
    _prazoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final veiculo =
        ModalRoute.of(context)!.settings.arguments
            as VehicleModel; // Pega o veiculo pela requisicao das rotas

    return Scaffold(
      appBar: AppBar(title: Text(veiculo.nome)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVehicleInfoSection(
              context,
              veiculo,
            ), // Chama a funcao que constroi os dados do veiculo
            const Divider(height: 32, thickness: 1),
            _buildCalculatorSection(
              context,
              veiculo.preco,
            ), // Chama a funcao que constroi a calculadora
          ],
        ),
      ),
    );
  }

  // Retorna uma coluna que mostra de forma estilizada os dados do veiculo
  Widget _buildVehicleInfoSection(BuildContext context, VehicleModel veiculo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.network(
            veiculo.imagemUrl,
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 250,
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.error, color: Colors.grey, size: 60),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          veiculo.nome,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'R\$ ${veiculo.preco.toStringAsFixed(2)}',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(color: Colors.green[700]),
        ),
        const SizedBox(height: 8),
        Text(veiculo.descricao, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 16),

        if (veiculo is CarModel) ...[
          _buildDetailRow('Tipo de Carroceria', veiculo.tipoCarroceria),
          _buildDetailRow('Número de Portas', veiculo.numeroPortas.toString()),
        ],
        if (veiculo is MotoModel) ...[
          _buildDetailRow('Cilindradas', '${veiculo.cilindradas} cc'),
          _buildDetailRow('Tipo', veiculo.tipo),
        ],
        if (veiculo is CaminhaoModel) ...[
          _buildDetailRow(
            'Capacidade de Carga',
            '${veiculo.capacidadeCarga} t',
          ),
          _buildDetailRow('Número de Eixos', veiculo.numeroEixos.toString()),
        ],
      ],
    );
  }

  // Retorna uma sessao de detalhes
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text('$title: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  // Retorna uma calculadora de formulario estilizada
  Widget _buildCalculatorSection(BuildContext context, double precoVeiculo) {
    return Form(
      key: _formKey, // Chave que sera usada para acessar os dados
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Simule seu Financiamento',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _entradaController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Valor de Entrada (R\$)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.attach_money),
            ),
            // Valida o valor inserido
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, informe um valor de entrada.';
              }
              if (double.tryParse(value) == null) {
                return 'Por favor, informe um número válido.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _prazoController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Prazo (em meses)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.calendar_today),
            ),

            // Valida o valor inserido
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, informe o prazo.';
              }
              final prazo = int.tryParse(value);
              if (prazo == null || prazo <= 0) {
                return 'O prazo deve ser um número maior que zero.';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () => _calcular(
                precoVeiculo,
              ), // Chama a funcao que calcula o financiamento
              child: const Text('Calcular Parcelas'),
            ),
          ),
          const SizedBox(height: 24),
          // So mostra a sessao de financiamento se o financiamento for valido
          if (_valorParcela > 0)
            Center(
              child: Column(
                children: [
                  Text(
                    'Valor estimado da parcela:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${_prazoController.text}x de R\$ ${_valorParcela.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '(Juros de 2% a.m.)',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
