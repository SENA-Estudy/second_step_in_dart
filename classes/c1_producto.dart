/// Un producto de la carta del restaurante.
///
/// El nombre no cambia después de crear el producto. El precio solo se
/// modifica con [cambiarPrecio], que valida el nuevo valor, y el producto se
/// puede marcar como agotado cuando la cocina se queda sin él.
class Producto {
  final String nombre;
  int precio;
  String categoria;
  bool disponible;

  /// Crea un producto con parámetros con nombre. Todo producto empieza
  /// disponible, salvo que se indique lo contrario.
  Producto({
    required this.nombre,
    required this.precio,
    required this.categoria,
    this.disponible = true,
  });

  /// Describe el producto para mostrarlo en la carta, por ejemplo
  /// `Ajiaco (Platos fuertes): 28000 - disponible`.
  String descripcion() {
    String estado = disponible ? 'disponible' : 'agotado';
    return '$nombre ($categoria): $precio - $estado';
  }

  /// Cambia el precio si [nuevoPrecio] es mayor que 0.
  ///
  /// Si el precio no es válido lo avisa en consola, deja el precio anterior
  /// y devuelve `false`.
  bool cambiarPrecio(int nuevoPrecio) {
    if (nuevoPrecio <= 0) {
      print('Precio no válido para $nombre: $nuevoPrecio');
      return false;
    }
    precio = nuevoPrecio;
    return true;
  }

  /// Marca el producto como no disponible.
  void marcarAgotado() {
    disponible = false;
  }

  @override
  String toString() => 'Producto($nombre, $precio)';
}

/// Código de prueba de la guía: debe quedar igual para comparar la salida
/// con el resultado esperado.
void main() {
  List<Producto> carta = [
    Producto(nombre: 'Ajiaco', precio: 28000, categoria: 'Platos fuertes'),
    Producto(nombre: 'Sancocho', precio: 26000, categoria: 'Platos fuertes'),
    Producto(nombre: 'Limonada', precio: 6000, categoria: 'Bebidas'),
    Producto(nombre: 'Postre del día', precio: 9000, categoria: 'Postres'),
  ];

  carta[0].cambiarPrecio(-100);
  bool cambio = carta[2].cambiarPrecio(6500);
  print('¿Se cambió el precio de la limonada? $cambio');
  carta[1].marcarAgotado();

  print('--- Carta ---');
  int disponibles = 0;
  for (var producto in carta) {
    print(producto.descripcion());
    if (producto.disponible) {
      disponibles++;
    }
  }
  print('Disponibles: $disponibles de ${carta.length}');
  print(carta[2]);
}
