/// Calcula la propina voluntaria de una cuenta, sin decimales.
///
/// Por defecto usa el 10 % del [subtotal]; con [porcentaje] se puede pedir
/// otro valor, por ejemplo 15. Se usa división entera (`~/`) para que el
/// resultado siempre sea un número entero de pesos.
int calcularPropina(int subtotal, {int porcentaje = 10}) {
  return subtotal * porcentaje ~/ 100;
}

/// Calcula el total a pagar de una cuenta.
///
/// Si [conPropina] es `true` (valor por defecto) suma al [subtotal] la propina
/// del 10 % que calcula [calcularPropina]; si es `false` devuelve solo el
/// subtotal.
int calcularTotal(int subtotal, {bool conPropina = true}) {
  // Cuando el cliente no quiere propina, el total es igual al subtotal.
  if (!conPropina) {
    return subtotal;
  }
  int propina = calcularPropina(subtotal);
  return subtotal + propina;
}

/// Convierte un valor en pesos al formato colombiano, por ejemplo
/// `$ 100.100`.
///
/// Recorre las cifras del número de derecha a izquierda y agrega un punto
/// cada tres cifras como separador de miles.
String formatearPesos(int valor) {
  String cifras = valor.abs().toString();
  String resultado = '';
  int contador = 0;

  for (int i = cifras.length - 1; i >= 0; i--) {
    // Antes de cada nuevo grupo de tres cifras se pone el separador.
    if (contador > 0 && contador % 3 == 0) {
      resultado = '.$resultado';
    }
    resultado = cifras[i] + resultado;
    contador++;
  }

  // Los valores negativos conservan su signo delante de las cifras.
  String signo = valor < 0 ? '-' : '';
  return '\$ $signo$resultado';
}

/// Código de prueba de la guía: debe quedar igual para comparar la salida
/// con el resultado esperado.
void main() {
  int subtotal = 91000;
  print('Subtotal: ${formatearPesos(subtotal)}');
  print('Propina 10 %: ${formatearPesos(calcularPropina(subtotal))}');
  print('Propina 15 %: ${formatearPesos(calcularPropina(subtotal, porcentaje: 15))}');

  print('Total con propina: ${formatearPesos(calcularTotal(subtotal))}');
  print('Total sin propina: ${formatearPesos(calcularTotal(subtotal, conPropina: false))}');
  print(formatearPesos(999));
  print(formatearPesos(1000000));
}
