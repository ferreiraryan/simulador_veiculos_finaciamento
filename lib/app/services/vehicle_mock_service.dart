import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:simulador_financeiro/app/models/vehicle_model.dart';

// Classe responsável pelo controle do json que contem os veículos
class VehicleMockService {
  static Future<List<VehicleModel>> getVehicles() async {
    final String response = await rootBundle.loadString(
      'assets/data/vehicles.json',
    );
    final List<dynamic> data = json.decode(response);
    return data.map((json) => VehicleModel.fromJson(json)).toList();
  }
}
