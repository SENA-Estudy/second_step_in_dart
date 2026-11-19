/// Estados por los que pasa una mesa durante la atención.
enum EstadoMesa { libre, ocupada, enCuenta }

/// Una mesa del restaurante.
///
/// La mesa solo avanza en el orden libre → ocupada → enCuenta → libre. Cada
/// método revisa el estado actual, rechaza las transiciones que no tienen
/// sentido y muestra en consola lo que pasó.
class Mesa {
  final int numero;
  final int capacidad;
  EstadoMesa estado = EstadoMesa.libre;
  int comensales = 0;

  Mesa(this.numero, this.capacidad);

  /// Ocupa la mesa con [personas] comensales.
  ///
  /// Solo funciona si la mesa está libre y el número de personas está entre
  /// 1 y la capacidad de la mesa.
  bool ocupar(int personas) {
    if (estado != EstadoMesa.libre) {
      print('Mesa $numero: no se puede ocupar, está ${estado.name}');
      return false;
    }
    if (personas < 1) {
      print('Mesa $numero: el número de personas no es válido ($personas)');
      return false;
    }
    if (personas > capacidad) {
      print('Mesa $numero: $personas personas no caben (capacidad $capacidad)');
      return false;
    }
    estado = EstadoMesa.ocupada;
    comensales = personas;
    print('Mesa $numero: ocupada por $personas personas');
    return true;
  }

  /// Pasa la mesa a "en cuenta". Solo es posible si está ocupada.
  bool pedirCuenta() {
    if (estado != EstadoMesa.ocupada) {
      print('Mesa $numero: no se puede pedir la cuenta, está ${estado.name}');
      return false;
    }
    estado = EstadoMesa.enCuenta;
    print('Mesa $numero: cuenta solicitada');
    return true;
  }

  /// Deja la mesa libre y sin comensales. Solo es posible después de pedir
  /// la cuenta.
  bool liberar() {
    if (estado == EstadoMesa.libre) {
      print('Mesa $numero: ya está libre');
      return false;
    }
    if (estado != EstadoMesa.enCuenta) {
      print('Mesa $numero: no se puede liberar sin pedir la cuenta');
      return false;
    }
    estado = EstadoMesa.libre;
    comensales = 0;
    print('Mesa $numero: liberada');
    return true;
  }

  @override
  String toString() =>
      'Mesa $numero ($capacidad puestos): ${estado.name}, $comensales personas';
}

/// Código de prueba de la guía: debe quedar igual para comparar la salida
/// con el resultado esperado.
void main() {
  Mesa mesa4 = Mesa(4, 4);
  mesa4.ocupar(6);
  mesa4.ocupar(3);
  mesa4.ocupar(2);
  mesa4.liberar();
  mesa4.pedirCuenta();
  print(mesa4);
  mesa4.liberar();
  print(mesa4);
}
