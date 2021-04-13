import 'package:flutter/material.dart';
import 'package:smartpos/helpers/search_data.dart';
import 'package:smartpos/models/product.dart';
import 'package:smartpos/services/product_service.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  //create data controllers
  var _productNameController = TextEditingController();
  var _productSellingController = TextEditingController();
  var _productCostController = TextEditingController();

  //edit controllers
  var _editproductNameController = TextEditingController();
  var _editproductSellingController = TextEditingController();
  var _editproductCostController = TextEditingController();

  var _product = Product();
  var _productService = ProductService();
  //var _searchProduct = DataSearch();

  List<Product> _productList = List<Product>();
  List<String> _nameList = ['ok', 'it', 'is'];

  var product;

  @override
  void initState() {
    super.initState();

    getAllProducts();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  getNames() {
    _nameList = List<String>();
    var products = _productService.readProducts();

    products.forEach((product) {
      setState(() {
        _nameList.add(product['name']);
      });
    });
    return _nameList;
  }

  //read all the products
  getAllProducts() async {
    _productList = List<Product>();
    var products = await _productService.readProducts();

    products.forEach((product) {
      setState(() {
        var productModel = Product();

        productModel.id = product['id'];
        productModel.name = product['name'];
        productModel.costPrice = product['cost'];
        productModel.sellingPrice = product['sell'];

        print(productModel.sellingPrice);
        print('heellooooo');

        _productList.add(productModel);
      });
    });
  }

  //edit a products details
  _editProduct(BuildContext context, productId) async {
    product = await _productService.readProductsById(productId);

    setState(() {
      _editproductNameController.text = product[0]['name'] ?? 'No Name';
      _editproductCostController.text = product[0]['cost'] ?? 'No Cost Price';
      _editproductSellingController.text =
          product[0]['sell'] ?? 'No Selling Price';

      _editFormDialog(context);
    });
  }

  //Show Input Form to insert data
  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                color: Colors.redAccent,
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                color: Colors.greenAccent,
                onPressed: () async {
                  _product.name = _productNameController.text;
                  _product.costPrice = _productCostController.text;
                  _product.sellingPrice = _productSellingController.text;

                  _productService.saveProduct(_product);

                  Navigator.pop(context);
                  getAllProducts();
                  _productNameController.clear();
                  _productCostController.clear();
                  _productSellingController.clear();
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            title: Text('Add a product'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _productNameController,
                    decoration: InputDecoration(
                        hintText: 'Input Product Name',
                        labelText: 'Product Name'),
                  ),
                  TextField(
                    controller: _productCostController,
                    decoration: InputDecoration(
                        hintText: 'Input cost price', labelText: 'Cost Price'),
                  ),
                  TextField(
                    controller: _productSellingController,
                    decoration: InputDecoration(
                        hintText: 'Input selling price',
                        labelText: 'Selling Price'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //Edit an item
  _editFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                color: Colors.redAccent,
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                color: Colors.greenAccent,
                onPressed: () async {
                  _product.id = product[0]['id'];
                  _product.name = _editproductNameController.text;
                  _product.costPrice = _editproductCostController.text;
                  _product.sellingPrice = _editproductSellingController.text;

                  var results = _productService.updateProduct(_product);

                  Navigator.pop(context);
                  getAllProducts();
                  _showSuccessSnackBar(Text("Updated Successfully"));
                },
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            title: Text('Edit a product'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _editproductNameController,
                    decoration: InputDecoration(
                        hintText: 'Product Name', labelText: 'Edit Name'),
                  ),
                  TextField(
                    controller: _editproductCostController,
                    decoration: InputDecoration(
                        hintText: 'Edit cost price', labelText: 'Cost Price'),
                  ),
                  TextField(
                    controller: _editproductSellingController,
                    decoration: InputDecoration(
                        hintText: 'Input selling price',
                        labelText: 'Edit selling Price'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _readProductById(BuildContext context, productId) async {
    product = await _productService.readProductsById(productId);
    print(product);

    setState(() {
      _editproductNameController.text = product[0]['name'] ?? 'No Name';
      _editproductCostController.text = product[0]['cost'] ?? 'No Cost Price';
      _editproductSellingController.text =
          product[0]['sell'] ?? 'No Selling Price';

      _readFormDialog(context);
    });
  }

  _readFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                color: Colors.redAccent,
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            title: Text('Product details'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  // Text('${_productService.readProductsById(productId)}'),
                  TextField(
                    controller: _editproductNameController,
                    decoration: InputDecoration(
                        hintText: 'Product Name', labelText: 'Product Name'),
                  ),
                  TextField(
                    controller: _editproductCostController,
                    decoration: InputDecoration(
                        hintText: 'Cost Price', labelText: 'Cost Price'),
                  ),
                  TextField(
                    controller: _editproductSellingController,
                    decoration: InputDecoration(
                        hintText: 'Selling price', labelText: 'Selling Price'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, productId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                color: Colors.blueAccent,
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                color: Colors.redAccent,
                onPressed: () async {
                  var results = _productService.deleteProduct(productId);

                  Navigator.pop(context);
                  getAllProducts();
                  _showSuccessSnackBar(Text("Deleted Successfully"));
                },
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            title: Text('Are you sure you want to delete this?'),
            // content: SingleChildScrollView(
            //   child: Column(
            //     children: [
            //       TextField(
            //         controller: _editproductNameController,
            //         decoration: InputDecoration(
            //             hintText: 'Product Name', labelText: 'Edit Name'),
            //       ),
            //       TextField(
            //         controller: _editproductCostController,
            //         decoration: InputDecoration(
            //             hintText: 'Edit cost price', labelText: 'Cost Price'),
            //       ),
            //       TextField(
            //         controller: _editproductSellingController,
            //         decoration: InputDecoration(
            //             hintText: 'Input selling price',
            //             labelText: 'Edit selling Price'),
            //       ),
            //     ],
            //   ),
            // ),
          );
        });
  }

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: RaisedButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CategoryScreen())),
          child: Icon(
            Icons.home_filled,
            color: Colors.white,
          ),
          color: Colors.blue,
          elevation: 0.0,
        ),
        title: Text('Product List'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context, delegate: DataSearch(_productList));
                //print(getAllProducts().toString());
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: ListView.builder(
          itemCount: _productList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                top: 4.0,
                left: 8.0,
                right: 4.0,
              ),
              child: Card(
                elevation: 7.5,
                child: ListTile(
                  onTap: () {
                    _readProductById(context, _productList[index].id);
                  },
                  leading: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      _editProduct(context, _productList[index].id);
                    },
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _productList[index].name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            letterSpacing: 1),
                      ),
                      IconButton(
                          onPressed: () {
                            _deleteFormDialog(context, _productList[index].id);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
