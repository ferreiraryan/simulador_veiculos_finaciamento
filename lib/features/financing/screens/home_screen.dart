import 'package:flutter/material.dart';
import 'package:simulador_financeiro/app/models/vehicle_model.dart';
import 'package:simulador_financeiro/app/navigation/app_router.dart';
import 'package:simulador_financeiro/app/services/vehicle_mock_service.dart';
import 'package:simulador_financeiro/features/financing/widgets/vehicle_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Veículos para Financiamento')),
      body: FutureBuilder<List<VehicleModel>>(
        future: VehicleMockService.getVehicles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar os veículos: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum veículo encontrado.'));
          }
          final veiculos = snapshot.data!;
          return ListView.builder(
            itemCount: veiculos.length,
            itemBuilder: (context, index) {
              final veiculo = veiculos[index];
              return VehicleCard(
                vehicle: veiculo,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRouter.detailRoute,
                    arguments: veiculo,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
