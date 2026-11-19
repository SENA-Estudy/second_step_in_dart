/// Calcula el porcentaje de descuento que le corresponde a una compra.
///
/// Los descuentos se suman: 10 % si el [subtotal] es de 150.000 o más,
/// 15 % con el cupón `CUMPLE`, 5 % con el cupón `ESTUDIANTE` y 5 % si es
/// [clienteFrecuente]. El resultado nunca supera el [maximo] (20 % por
/// defecto). El [cupon] se acepta en mayúsculas o minúsculas; si no es
/// válido se avisa en consola y no suma descuento.
int calcularPorcentajeDescuento({
  required int subtotal,
  String? cupon,
  bool clienteFrecuente = false,
  int maximo = 20,
}) {
  int porcentaje = 0;

  if (subtotal >= 150000) {
    porcentaje += 10;
  }

  if (cupon != null) {
    switch (cupon.toUpperCase()) {
      case 'CUMPLE':
        porcentaje += 15;
      case 'ESTUDIANTE':
        porcentaje += 5;
      default:
        print('Cupón $cupon no válido');
    }
  }

  if (clienteFrecuente) {
    porcentaje += 5;
  }

  // El descuento acumulado se limita al tope permitido.
  return porcentaje > maximo ? maximo : porcentaje;
}

/// Devuelve el total después de restarle al [subtotal] el [porcentaje] de
/// descuento, sin decimales.
int aplicarDescuento(int subtotal, int porcentaje) {
  int descuento = subtotal * porcentaje ~/ 100;
  return subtotal - descuento;
}

/// Código de prueba de la guía: debe quedar igual para comparar la salida
/// con el resultado esperado.
void main() {
  List<int> subtotales = [162000, 162000, 80000, 80000];
  List<String?> cupones = ['CUMPLE', null, 'estudiante', 'GRATIS'];
  List<bool> frecuentes = [true, true, false, false];

  for (var i = 0; i < subtotales.length; i++) {
    int porcentaje = calcularPorcentajeDescuento(
      subtotal: subtotales[i],
      cupon: cupones[i],
      clienteFrecuente: frecuentes[i],
    );
    int total = aplicarDescuento(subtotales[i], porcentaje);
    print('Caso ${i + 1}: subtotal ${subtotales[i]}, descuento $porcentaje %, total $total');
  }
}
