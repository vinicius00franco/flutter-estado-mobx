class Item {
  const Item(this.nome, this.categoria, this.preco, this.uri, {this.quantidade = 1});

  final String nome;
  final String categoria;
  final String uri;
  final double preco;
  final int quantidade;
}
