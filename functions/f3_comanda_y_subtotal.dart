/// Menú del día con el precio de cada producto en pesos.
final Map<String, int> menuDelDia = {
  'Ajiaco': 28000,
  'Bandeja paisa': 32000,
  'Sancocho': 26000,
  'Limonada': 6000,
  'Jugo natural': 7000,
  'Gaseosa': 5000,
  'Postre del día': 9000,
};

/// Suma el valor de los productos del [pedido] que existen en el [menu].
///
/// El [pedido] relaciona cada producto con la cantidad pedida. Los productos
/// que no están en el menú no se cobran.
int calcularSubtotalPedido(Map<String, int> menu, Map<String, int> pedido) {
  int subtotal = 0;
  pedido.forEach((producto, cantidad) {
    int? precio = menu[producto];
    if (precio != null) {
      subtotal += precio * cantidad;
    }
  });
  return subtotal;
}

/// Devuelve los nombres de los productos del [pedido] que no están en el
/// [menu], para avisarle al mesero.
List<String> productosNoEncontrados(
  Map<String, int> menu,
  Map<String, int> pedido,
) {
  List<String> noEncontrados = [];
  for (var producto in pedido.keys) {
    if (!menu.containsKey(producto)) {
      noEncontrados.add(producto);
    }
  }
  return noEncontrados;
}

/// Imprime la comanda de una [mesa] para la cocina.
///
/// Muestra el encabezado, una línea por cada producto válido con su valor,
/// los productos que no existen en el menú (si los hay) y el subtotal. Se
/// apoya en [productosNoEncontrados] y [calcularSubtotalPedido].
void imprimirComanda(int mesa, Map<String, int> menu, Map<String, int> pedido) {
  print('--- COMANDA MESA $mesa ---');

  pedido.forEach((producto, cantidad) {
    int? precio = menu[producto];
    if (precio != null) {
      print('$cantidad x $producto = ${precio * cantidad}');
    }
  });

  List<String> noEncontrados = productosNoEncontrados(menu, pedido);
  if (noEncontrados.isNotEmpty) {
    print('No están en el menú: $noEncontrados');
  }

  print('Subtotal: ${calcularSubtotalPedido(menu, pedido)}');
}

/// Código de prueba de la guía: debe quedar igual para comparar la salida
/// con el resultado esperado.
void main() {
  Map<String, int> pedidoMesa4 = {
    'Bandeja paisa': 2,
    'Limonada': 3,
    'Postre del día': 1,
    'Cazuela': 1,
  };
  imprimirComanda(4, menuDelDia, pedidoMesa4);

  Map<String, int> pedidoMesa9 = {'Ajiaco': 2, 'Gaseosa': 2};
  imprimirComanda(9, menuDelDia, pedidoMesa9);
}
