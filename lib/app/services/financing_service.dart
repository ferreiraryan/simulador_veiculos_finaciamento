class FinancingService {
  static const double _taxaJuros = 0.02;

  static double calcularParcela({
    required double precoVeiculo,
    required double entrada,
    required int prazo,
  }) {
    if (entrada >= precoVeiculo || prazo <= 0) {
      return 0.0;
    }

    final valorFinanciado = precoVeiculo - entrada;
    final jurosTotal = valorFinanciado * _taxaJuros * prazo;
    final valorTotalComJuros = valorFinanciado + jurosTotal;

    return valorTotalComJuros / prazo;
  }
}
