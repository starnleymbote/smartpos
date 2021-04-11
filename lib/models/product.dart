class Product {
  int id;
  String name;
  String costPrice;
  String sellingPrice;

  productMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['cost'] = costPrice;
    mapping['sell'] = sellingPrice;

    return mapping;
  }
}
