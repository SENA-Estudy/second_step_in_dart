/// Base máxima con la que se permite abrir la caja.
const int baseMaxima = 10000000;

/// Revisa si se puede abrir la caja con los datos recibidos.
///
/// Devuelve `null` cuando la apertura es válida o el mensaje de error del
/// primer problema encontrado. Las validaciones se hacen en este orden: que
/// la caja no esté abierta, que el [rol] sea `cajero` o `admin`, que la
/// [base] no sea negativa y que no supere [baseMaxima].
String? validarAperturaCaja(String rol, int base, bool cajaAbierta) {
  if (cajaAbierta) {
    return 'Ya hay una caja abierta';
  }
  if (rol != 'cajero' && rol != 'admin') {
    return 'El rol $rol no puede abrir la caja';
  }
  if (base < 0) {
    return 'La base no puede ser negativa';
  }
  if (base > baseMaxima) {
    return 'La base supera el máximo permitido';
  }
  return null;
}

/// Devuelve el estado de la caja en texto: `ABIERTA` o `CERRADA`.
String estadoCaja(bool abierta) => abierta ? 'ABIERTA' : 'CERRADA';

/// Código de prueba de la guía: debe quedar igual para comparar la salida
/// con el resultado esperado.
void main() {
  List<String> roles = ['cajero', 'mesero', 'admin', 'cajero', 'admin'];
  List<int> bases = [200000, 200000, -5000, 10000001, 100000];
  List<bool> abiertas = [false, false, false, false, true];

  for (var i = 0; i < roles.length; i++) {
    String? error = validarAperturaCaja(roles[i], bases[i], abiertas[i]);
    bool quedaAbierta = abiertas[i] || error == null;
    String resultado = error ?? 'Caja abierta con base ${bases[i]}';
    print('Caso ${i + 1}: $resultado. Estado: ${estadoCaja(quedaAbierta)}');
  }
}
