import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:food_app/cart/cart.dart';
import 'package:food_app/common_widget/collection_food_item_cell.dart';
import 'package:food_app/common_widget/food_item_cell.dart';
import 'package:food_app/common/color_extension.dart';
import 'package:food_app/common_widget/popular_food_item_cell.dart';
import 'package:food_app/common_widget/selection_text_view.dart';
import 'package:food_app/home/outlet_list_view.dart';
import 'package:food_app/restaurant/restaurant_detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController txtSearch = TextEditingController();

  List legendaryArr = [
    {
      "name": "Lombar Pizza",
      "address": "East 46th Street",
      "category": "Pizza, Italian",
      "image": "assets/img/l1.png"
    },
    {
      "name": "Sushi Bar",
      "address": "210 Salt Pond Rd.",
      "category": "Sushi, Japan",
      "image": "assets/img/l2.png"
    },
    {
      "name": "Steak House",
      "address": "East 46th Street",
      "category": "Steak, American",
      "image": "assets/img/l3.png"
    }
  ];

  List trendingArr = [
    {
      "name": "Seafood Lee",
      "address": "210 Salt Pond Rd.",
      "category": "Seafood, Spain",
      "image": "assets/img/t1.png"
    },
    {
      "name": "Egg Tomato",
      "address": "East 46th Street",
      "category": "Egg, Italian",
      "image": "assets/img/t2.png"
    },
    {
      "name": "Burger Hot",
      "address": "East 46th Street",
      "category": "Pizza, Italian",
      "image": "assets/img/t3.png"
    }
  ];

  List collectionsArr = [
    {"name": "Legendary food", "place": "34", "image": "assets/img/c1.png"},
    {"name": "Seafood", "place": "28", "image": "assets/img/c2.png"},
    {"name": "Fizza Meli", "place": "56", "image": "assets/img/c3.png"}
  ];

  List popularArr = [
    {"outlets": "23", "image": "assets/img/logo1.png"},
    {"outlets": "16", "image": "assets/img/logo2.png"},
    {"outlets": "31", "image": "assets/img/logo3.png"},
    {"outlets": "60", "image": "assets/img/logo4.png"}
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.bg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Legendary food
            SelectionTextView(
              title: "Legendary food",
              onSeeAllTap: () {},
            ),
            SizedBox(
              height: media.width * 0.6,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: legendaryArr.length,
                itemBuilder: (context, index) {
                  var fObj = legendaryArr[index] as Map<String, dynamic>;

                  return GestureDetector(
                    onTap: () {
                      addToCart(fObj);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantDetailView(
                            fObj: fObj,
                            addToCart: addToCart,
                          ),
                        ),
                      );
                    },
                    child: FoodItemCell(
                      fObj: fObj,
                    ),
                  );
                },
              ),
            ),
            // Trending
            SelectionTextView(
              title: "Trending this week",
              onSeeAllTap: () {},
            ),
            SizedBox(
              height: media.width * 0.6,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: trendingArr.length,
                itemBuilder: (context, index) {
                  var fObj = trendingArr[index] as Map<String, dynamic>;

                  return GestureDetector(
                    onTap: () {
                      addToCart(fObj);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantDetailView(
                            fObj: fObj,
                            addToCart: addToCart,
                          ),
                        ),
                      );
                    },
                    child: FoodItemCell(
                      fObj: fObj,
                    ),
                  );
                },
              ),
            ),
            // Collections
            SelectionTextView(
              title: "Collections",
              onSeeAllTap: () {},
            ),
            SizedBox(
              height: media.width * 0.6,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: collectionsArr.length,
                itemBuilder: (context, index) {
                  var fObj = collectionsArr[index] as Map<String, dynamic>;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantDetailView(
                            fObj: fObj,
                            addToCart: addToCart,
                          ),
                        ),
                      );
                    },
                    child: CollectionFoodItemCell(
                      fObj: fObj, name: '',
                    ),
                  );
                },
              ),
            ),
            // Popular brands
            SelectionTextView(
              title: "Popular brands",
              onSeeAllTap: () {},
            ),
            SizedBox(
              height: media.width * 0.6,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: popularArr.length,
                itemBuilder: (context, index) {
                  var fObj = popularArr[index] as Map<String, dynamic>;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OutletListView(
                            fObj: fObj,
                          ),
                        ),
                      );
                    },
                    child: PopularFoodItemCell(
                      fObj: fObj,
                      index: index,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Cart()),
          );
        },
        child: Icon(Icons.shopping_cart, color: Colors.black),
        backgroundColor: TColor.primary,
      ),
    );
  }

  void addToCart(Map<String, dynamic> fObj) {
    if (fObj != null) {
      // Add item to cart
      Cart.addItem({
        'name': fObj['name'],
        'category': fObj['category'],
      });
    } else {
      print("Error: fObj is null.");
    }
  }

}
