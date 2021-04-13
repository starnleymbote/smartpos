import 'package:smartpos/models/product.dart';
import 'package:smartpos/repositories/repository.dart';

class ProductService {
  Repository _repository;

  ProductService() {
    _repository = Repository();
  }

  saveProduct(Product product) async {
    return await _repository.insertData('products', product.productMap());
  }

  //READ PRODUCTS
  readProducts() async {
    return await _repository.readData('products');
  }

  // read data from table using id
  readProductsById(productId) async {
    return await _repository.readDataById('products', productId);
  }

  //update
  updateProduct(Product product) async {
    return await _repository.updateData('products', product.productMap());
  }

  //delete a product
  deleteProduct(productId) async {
    return await _repository.deleteData('products', productId);
  }

  searchProduct(productName) async {
    return await _repository.searchData('products', productName);
  }
}
