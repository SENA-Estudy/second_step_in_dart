/// Producto sencillo para este ejercicio: solo nombre y precio, que no
/// cambian después de crearlo.
class Producto {
  final String nombre;
  final int precio;

  Producto(this.nombre, this.precio);
}

/// Una línea del pedido: un producto, cuántas unidades se piden y una
/// observación opcional para la cocina.
class ItemPedido {
  final Producto producto;
  int cantidad;
  String? observacion;

  ItemPedido(this.producto, this.cantidad, {this.observacion});

  /// Valor de la línea: precio del producto por la cantidad.
  int get subtotal => producto.precio * cantidad;
}

/// El pedido de una mesa, tomado por un mesero.
///
/// Si se agrega un producto que ya está en el pedido no se crea otra línea:
/// se suma la cantidad a la existente.
class Pedido {
  final int mesa;
  final String mesero;
  final List<ItemPedido> items = [];

  Pedido(this.mesa, this.mesero);

  /// Busca la línea del pedido que tiene el producto llamado [nombre].
  /// Devuelve `null` si el producto no está en el pedido.
  ItemPedido? _buscarItem(String nombre) {
    for (var item in items) {
      if (item.producto.nombre == nombre) {
        return item;
      }
    }
    return null;
  }

  /// Agrega [cantidad] unidades de [producto] al pedido.
  ///
  /// Si el producto ya estaba, suma la cantidad y conserva su observación;
  /// si esa línea no tenía observación, toma la nueva.
  void agregarProducto(Producto producto, int cantidad, {String? observacion}) {
    ItemPedido? existente = _buscarItem(producto.nombre);
    if (existente != null) {
      existente.cantidad += cantidad;
      existente.observacion ??= observacion;
      return;
    }
    items.add(ItemPedido(producto, cantidad, observacion: observacion));
  }

  /// Quita [cantidad] unidades del producto llamado [nombre].
  ///
  /// Si la cantidad llega a 0 o menos, la línea se elimina del pedido. Si el
  /// producto no está en el pedido lo avisa y devuelve `false`.
  bool quitarProducto(String nombre, int cantidad) {
    ItemPedido? item = _buscarItem(nombre);
    if (item == null) {
      print('$nombre no está en el pedido');
      return false;
    }
    item.cantidad -= cantidad;
    if (item.cantidad <= 0) {
      items.remove(item);
    }
    return true;
  }

  /// Valor total del pedido: la suma de los subtotales de cada línea.
  int get total {
    int suma = 0;
    for (var item in items) {
      suma += item.subtotal;
    }
    return suma;
  }

  /// Número total de unidades pedidas, sumando todas las líneas.
  int get cantidadArticulos {
    int suma = 0;
    for (var item in items) {
      suma += item.cantidad;
    }
    return suma;
  }

  /// Imprime la comanda con la mesa, el mesero, cada línea con su
  /// observación (si tiene) y el total del pedido.
  void imprimirComanda() {
    print('Mesa $mesa - Mesero: $mesero');
    for (var item in items) {
      String nota = item.observacion != null ? ' (${item.observacion})' : '';
      print('${item.cantidad} x ${item.producto.nombre}$nota = ${item.subtotal}');
    }
    print('Total: $total ($cantidadArticulos artículos)');
  }
}

/// Código de prueba de la guía: debe quedar igual para comparar la salida
/// con el resultado esperado.
void main() {
  var bandeja = Producto('Bandeja paisa', 32000);
  var limonada = Producto('Limonada', 6000);
  var postre = Producto('Postre del día', 9000);

  var pedido = Pedido(4, 'Carlos');
  pedido.agregarProducto(bandeja, 2, observacion: 'Una sin chicharrón');
  pedido.agregarProducto(limonada, 2);
  pedido.agregarProducto(postre, 1);
  pedido.agregarProducto(limonada, 1);
  pedido.quitarProducto('Postre del día', 1);
  pedido.quitarProducto('Ajiaco', 1);
  pedido.imprimirComanda();
}
