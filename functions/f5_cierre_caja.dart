/// Suma las ventas del día agrupadas por medio de pago.
///
/// [totales] y [medios] van en paralelo: la venta `totales[i]` se pagó con
/// `medios[i]`. El mapa resultante siempre trae `efectivo`, `debito` y
/// `credito`, aunque alguno quede en 0.
Map<String, int> totalesPorMedio(List<int> totales, List<String> medios) {
  Map<String, int> porMedio = {'efectivo': 0, 'debito': 0, 'credito': 0};
  for (var i = 0; i < totales.length; i++) {
    String medio = medios[i];
    if (porMedio.containsKey(medio)) {
      porMedio[medio] = porMedio[medio]! + totales[i];
    }
  }
  return porMedio;
}

/// Suma todos los números de una lista.
int sumarLista(List<int> valores) {
  int suma = 0;
  for (var valor in valores) {
    suma += valor;
  }
  return suma;
}

/// Calcula el efectivo que debería haber en la caja al cierre: la [base]
/// más las ventas en efectivo menos los egresos pagados con ese dinero.
int calcularEfectivoEsperado({
  required int base,
  required int ventasEfectivo,
  required int egresos,
}) {
  return base + ventasEfectivo - egresos;
}

/// Compara el efectivo [esperado] con el [contado] y describe el arqueo:
/// `Caja cuadrada`, `Sobrante de X` o `Faltante de X`.
String resultadoArqueo(int esperado, int contado) {
  int diferencia = contado - esperado;
  if (diferencia == 0) {
    return 'Caja cuadrada';
  }
  if (diferencia > 0) {
    return 'Sobrante de $diferencia';
  }
  return 'Faltante de ${-diferencia}';
}

/// Código de prueba de la guía: debe quedar igual para comparar la salida
/// con el resultado esperado.
void main() {
  int base = 200000;
  List<int> totales = [45000, 120000, 38000, 76000, 54000, 91000];
  List<String> medios = ['efectivo', 'debito', 'efectivo', 'credito', 'efectivo', 'debito'];
  List<int> egresos = [15000, 20000];

  Map<String, int> porMedio = totalesPorMedio(totales, medios);
  int esperado = calcularEfectivoEsperado(
    base: base,
    ventasEfectivo: porMedio['efectivo']!,
    egresos: sumarLista(egresos),
  );

  print('Ventas por medio: $porMedio');
  print('Total vendido: ${sumarLista(totales)}');
  print('Efectivo esperado: $esperado');
  print(resultadoArqueo(esperado, 300000));
  print(resultadoArqueo(esperado, 302000));
  print(resultadoArqueo(esperado, 305000));
}
