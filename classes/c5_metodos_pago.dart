/// Medio de pago genérico.
///
/// Es una clase abstracta: no se pueden crear objetos `MetodoPago`, solo de
/// sus clases hijas. Cada hija valida el pago a su manera, pero la caja las
/// trata a todas igual y solo llama a [procesar] (polimorfismo).
abstract class MetodoPago {
  /// Nombre del medio de pago para mostrarlo en pantalla.
  String get nombre;

  /// Intenta cobrar el [total] y devuelve un mensaje que dice si el pago fue
  /// aprobado o rechazado.
  String procesar(int total);
}

/// Pago en efectivo con el dinero que entrega el cliente.
class Efectivo extends MetodoPago {
  final int recibido;

  Efectivo(this.recibido);

  @override
  String get nombre => 'Efectivo';

  /// Aprueba el pago si el dinero [recibido] alcanza y calcula el cambio; si
  /// no alcanza, indica cuánto falta.
  @override
  String procesar(int total) {
    if (recibido < total) {
      return 'Pago rechazado. Faltan ${total - recibido}';
    }
    return 'Pago aprobado. Cambio: ${recibido - total}';
  }
}

/// Pago con tarjeta débito, identificado por la referencia del datáfono.
class Debito extends MetodoPago {
  final String referencia;

  Debito(this.referencia);

  @override
  String get nombre => 'Débito';

  /// Aprueba el pago solo si tiene referencia del datáfono.
  @override
  String procesar(int total) {
    if (referencia.isEmpty) {
      return 'Pago rechazado. Falta la referencia del datáfono';
    }
    return 'Pago aprobado. Referencia: $referencia';
  }
}

/// Pago a crédito de un cliente con un cupo disponible.
class Credito extends MetodoPago {
  final String cliente;
  int cupoDisponible;

  Credito(this.cliente, this.cupoDisponible);

  @override
  String get nombre => 'Crédito ($cliente)';

  /// Aprueba el pago si el total no supera el cupo y descuenta el valor del
  /// cupo del cliente.
  @override
  String procesar(int total) {
    if (total > cupoDisponible) {
      return 'Pago rechazado. Supera el cupo de $cupoDisponible';
    }
    cupoDisponible -= total;
    return 'Pago aprobado. Cupo restante: $cupoDisponible';
  }
}

/// Código de prueba de la guía: debe quedar igual para comparar la salida
/// con el resultado esperado.
void main() {
  int total = 100100;
  List<MetodoPago> pagos = [
    Efectivo(110000),
    Efectivo(90000),
    Debito('A-48213'),
    Debito(''),
    Credito('Ana Gómez', 150000),
    Credito('Pedro Ruiz', 50000),
  ];

  print('Total a pagar: $total');
  for (var pago in pagos) {
    print('${pago.nombre}: ${pago.procesar(total)}');
  }
}
