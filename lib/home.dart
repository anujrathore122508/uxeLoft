import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  final User? user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/images/logo.png', height: 30),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(size.width * 0.04),
              child: Text(
                'Hi, ${user?.displayName ?? user?.email ?? 'User'}\nWhat are you looking for today?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('lib/assets/images/poster.png'),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Center(
              child: Image.asset(
                'lib/assets/images/Devider.png',
                height: 20,
                width: 20,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryName(label: 'Recommend'),
                    SizedBox(width: size.width * 0.05),
                    CategoryName(label: 'Cell Phone'),
                    SizedBox(width: size.width * 0.05),
                    CategoryName(label: 'Car Products'),
                    SizedBox(width: size.width * 0.05),
                    CategoryName(label: 'Department Store'),
                    SizedBox(width: size.width * 0.05),
                    CategoryName(label: 'See More'),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryIconWithImage(
                    label: 'Beauty',
                    imagePath: 'lib/assets/images/beauty.png',
                  ),
                  CategoryIconWithImage(
                    label: 'Offers',
                    imagePath: 'lib/assets/images/offers.png',
                  ),
                  CategoryIconWithImage(
                    label: 'Fashion',
                    imagePath: 'lib/assets/images/fashion.png',
                  ),
                  CategoryIconWithImage(
                    label: 'Home',
                    imagePath: 'lib/assets/images/home.png',
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryIconWithImage(
                    label: 'Shirt',
                    imagePath: 'lib/assets/images/shirt.png',
                  ),
                  CategoryIconWithImage(
                    label: 'Woman Bag',
                    imagePath: 'lib/assets/images/woman_bag.png',
                  ),
                  CategoryIconWithImage(
                    label: 'Dress',
                    imagePath: 'lib/assets/images/dress.png',
                  ),
                  CategoryIconWithImage(
                    label: 'Mobiles',
                    imagePath: 'lib/assets/images/mobiles.png',
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.all(size.width * 0.04),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: size.width * 0.03,
                mainAxisSpacing: size.height * 0.02,
                childAspectRatio: 0.8,
                children: [
                  ProductCard(
                    images: 'lib/assets/images/multi_kit.png',
                    name: 'Multi Kit',
                    price: '\$500',
                    reviews: '86 Reviews',
                    fit: BoxFit.cover,
                  ),
                  ProductCard(
                    images: 'lib/assets/images/lipstick.png',
                    name: 'Lipstick',
                    price: '\$400',
                    reviews: '48 Reviews',
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class CategoryIconWithImage extends StatelessWidget {
  final String label;
  final String imagePath;

  const CategoryIconWithImage({required this.label, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[200],
          backgroundImage: AssetImage(imagePath),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

class CategoryName extends StatelessWidget {
  final String label;

  const CategoryName({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String images;
  final String name;
  final String price;
  final String reviews;
  final BoxFit fit;

  ProductCard({
    required this.images,
    required this.name,
    required this.price,
    required this.reviews,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  images,
                  fit: fit,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(price, style: TextStyle(color: Colors.orange)),
            Text(reviews, style: TextStyle(fontSize: 12, color: Colors.grey)),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: Text('Add'),
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 36)),
            ),
          ],
        ),
      ),
    );
  }
}
