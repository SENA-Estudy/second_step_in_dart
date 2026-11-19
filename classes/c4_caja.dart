/// La caja registradora del restaurante.
///
/// Todos sus datos son privados: desde afuera solo se pueden leer con los
/// getters y modificar con los métodos, que validan cada operación antes de
/// tocar el dinero.
class Caja {
  /// Base máxima con la que se permite abrir la caja.
  static const int baseMaxima = 10000000;

  bool _abierta = false;
  int _base = 0;
  final Map<String, int> _ventasPorMedio = {
    'efectivo': 0,
    'debito': 0,
    'credito': 0,
  };
  final List<({String concepto, int valor})> _egresos = [];
  int _cantidadVentas = 0;

  /// Indica si la caja está abierta.
  bool get abierta => _abierta;

  /// Suma de todas las ventas registradas, sin importar el medio de pago.
  int get totalVendido {
    int suma = 0;
    for (var valor in _ventasPorMedio.values) {
      suma += valor;
    }
    return suma;
  }

  /// Suma de todos los egresos pagados con dinero de la caja.
  int get totalEgresos {
    int suma = 0;
    for (var egreso in _egresos) {
      suma += egreso.valor;
    }
    return suma;
  }

  /// Efectivo que debería haber en la caja: la base más las ventas en
  /// efectivo menos los egresos.
  int get efectivoEsperado =>
      _base + _ventasPorMedio['efectivo']! - totalEgresos;

  /// Abre la caja con una [base] entre 0 y [baseMaxima].
  ///
  /// Al abrir, se borran las ventas y los egresos de la jornada anterior.
  bool abrir(int base) {
    if (_abierta) {
      print('Error: la caja ya está abierta');
      return false;
    }
    if (base < 0 || base > baseMaxima) {
      print('Error: la base debe estar entre 0 y $baseMaxima');
      return false;
    }
    _abierta = true;
    _base = base;
    _ventasPorMedio.updateAll((medio, valor) => 0);
    _egresos.clear();
    _cantidadVentas = 0;
    print('Caja abierta con base $base');
    return true;
  }

  /// Registra una venta por [total] pagada con [medio] (`efectivo`, `debito`
  /// o `credito`). La caja debe estar abierta y el total debe ser mayor que 0.
  bool registrarVenta(int total, String medio) {
    if (!_abierta) {
      print('Error: la caja está cerrada');
      return false;
    }
    if (!_ventasPorMedio.containsKey(medio)) {
      print('Error: medio de pago $medio no válido');
      return false;
    }
    if (total <= 0) {
      print('Error: el total de la venta debe ser mayor que 0');
      return false;
    }
    _ventasPorMedio[medio] = _ventasPorMedio[medio]! + total;
    _cantidadVentas++;
    return true;
  }

  /// Registra un gasto pagado con el efectivo de la caja, como la compra de
  /// hielo. Solo es posible con la caja abierta y un [valor] mayor que 0.
  bool registrarEgreso(String concepto, int valor) {
    if (!_abierta) {
      print('Error: la caja está cerrada');
      return false;
    }
    if (valor <= 0) {
      print('Error: el valor del egreso debe ser mayor que 0');
      return false;
    }
    _egresos.add((concepto: concepto, valor: valor));
    print('Egreso registrado: $concepto ($valor)');
    return true;
  }

  /// Hace el cierre de la jornada.
  ///
  /// Muestra el resumen de ventas y egresos, compara el efectivo esperado
  /// con el [efectivoContado], cierra la caja y devuelve el resultado del
  /// arqueo.
  String cerrar(int efectivoContado) {
    if (!_abierta) {
      return 'Error: la caja está cerrada';
    }
    print('===== CIERRE DE CAJA =====');
    print('Ventas: $_cantidadVentas por $totalVendido');
    print('Por medio de pago: $_ventasPorMedio');
    print('Egresos: $totalEgresos');
    print('Efectivo esperado: $efectivoEsperado');
    print('Efectivo contado: $efectivoContado');

    String resultado = _resultadoArqueo(efectivoEsperado, efectivoContado);
    _abierta = false;
    return resultado;
  }

  /// Describe la diferencia entre el efectivo [esperado] y el [contado]:
  /// `Caja cuadrada`, `Sobrante de X` o `Faltante de X`.
  String _resultadoArqueo(int esperado, int contado) {
    int diferencia = contado - esperado;
    if (diferencia == 0) {
      return 'Caja cuadrada';
    }
    if (diferencia > 0) {
      return 'Sobrante de $diferencia';
    }
    return 'Faltante de ${-diferencia}';
  }
}

/// Código de prueba de la guía: debe quedar igual para comparar la salida
/// con el resultado esperado.
void main() {
  var caja = Caja();
  caja.registrarVenta(45000, 'efectivo');
  caja.abrir(200000);

  List<int> totales = [45000, 120000, 38000, 76000, 54000, 91000];
  List<String> medios = ['efectivo', 'debito', 'efectivo', 'credito', 'efectivo', 'debito'];
  for (var i = 0; i < totales.length; i++) {
    caja.registrarVenta(totales[i], medios[i]);
  }
  caja.registrarVenta(50000, 'bitcoin');

  caja.registrarEgreso('Compra de hielo', 15000);
  caja.registrarEgreso('Recarga de gas', 20000);

  print(caja.cerrar(300000));
  caja.registrarVenta(10000, 'efectivo');
}
