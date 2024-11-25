import 'package:flutter/material.dart';
import 'package:urun_katalog_projesi/screens/best_seller_screen.dart';

class CategoriesScreen extends StatelessWidget {

  List<Map<String, String>> filteredBooks = [];
  TextEditingController searchController = TextEditingController();

  @override

  Widget build(BuildContext context) {
    // Ekran boyutlarını al
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Image.asset(
            'assets/logo.png',
            height: screenHeight * 0.2,
            width: screenWidth * 0.2,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 225.0),
          // Space between the logo and the title
          child: Text('Catalog'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
       child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kategoriler
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryCard("All"),
                  _buildCategoryCard("Classics"),
                  _buildCategoryCard("Horror"),
                  _buildCategoryCard("Romance"),
                  _buildCategoryCard("Science Fiction"),
                  _buildCategoryCard("Romance"),
                  _buildCategoryCard("Children"),
                  _buildCategoryCard("Philosophy"),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Arama Çubuğu
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search",
                suffixIcon: IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    // Filtre işlemi
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                fillColor: Color(0xFFE6E6FF),
                filled: true,
              ),
            ),
            SizedBox(height: 16),

            // Best Seller Bölümü
            _buildSectionHeader(
              context,
              title: "Best Seller",
              onViewAllPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BestSellerScreen()),
                );
              },
            ),
            _buildResponsiveBookRow([
              {"title": "Dune", "image": "assets/book/dune.png", "price": "\$20.99", "author":"Frank Herbert"},
              {"title": "1984", "image": "assets/book/1984.png", "price": "\$15.99", "author":"George Orwell"},
              {"title": "Ikıgai", "image": "assets/book/ikigai.jpg", "price": "\$18.99", "author":"Héctor García"},
            ]),

            // Classics Bölümü
            SizedBox(height: 16),
            _buildSectionHeader(
              context,
              title: "Classics",
              onViewAllPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BestSellerScreen()),
                );
              },
            ),
            _buildResponsiveBookRow([
              {"title": "Romeo ve Juliet", "image": "assets/book/romeo.jpg", "price": "\$10.99","author":"William Shakespeare"},
              {"title": "Olağanüstü Bir Gece", "image": "assets/book/olaganustu_bir_gece.png", "price": "\$12.99","author":"Stefan Zweig"},
              {"title": "Genç Werther'in Acıları", "image": "assets/book/genc_werther.jpg", "price": "\$14.99","author":" Johann Wolfgang von Goethe"},
            ]),
            // Classics Bölümü
            SizedBox(height: 16),
            _buildSectionHeader(
              context,
              title: "Children",
              onViewAllPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BestSellerScreen()),
                );
              },
            ),
            _buildResponsiveBookRow([
              {"title": "Mor Bir Fil Gördüm Sanki!", "image": "assets/book/mor_fil.jpg", "price": "\$10.99","author":"Varol Yaşaroğlu"},
              {"title": "Alev Saçlı Çocuk", "image": "assets/book/alev_saclı.jpg", "price": "\$12.99","author":"Christine Nöstlinger"},
              {"title": "Melodi", "image": "assets/book/melodi.jpg", "price": "\$14.99","author":"Anıl Basılı"},
            ]),
            // Classics Bölümü
            SizedBox(height: 16),
            _buildSectionHeader(
              context,
              title: "Philosophy",
              onViewAllPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BestSellerScreen()),
                );
              },
            ),
            _buildResponsiveBookRow([
              {"title": "Mutlu Olma Santı", "image": "assets/book/mutlu_olma_sanatı.jfif", "price": "\$10.99","author":"Arthur Schopenhauer"},
              {"title": "Meditasyonun Temelleri", "image": "assets/book/meditasyon_temelleri.jfif", "price": "\$12.99","author":"Bora Ercan"},
              {"title": "Metafizik", "image": "assets/book/metafizik.jfif", "price": "\$14.99","author":"Aristoteles"},
            ]),

          ],
        ),
      ),
    ));
  }

  Widget _buildCategoryCard(String categoryName) {
    return GestureDetector(
      onTap: () {
        // Kategori detaylarına yönlendirme
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFE6E6FF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          categoryName,
          style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context,
      {required String title, required VoidCallback onViewAllPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onViewAllPressed,
          child: Text(
            "View All",
            style: TextStyle(
              color: Color(0xFFEF6B4A),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveBookRow(List<Map<String, String>> books) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: books.map((book) => _buildBookCard(book)).toList(),
      ),
    );
  }

  Widget _buildBookCard(Map<String, String> book) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Color(0xFFE6E6FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Book image
          Image.asset(
            book["image"]!,
            height: 120,
            width: 70,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 8),
          // Book details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book["title"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(book["author"]!, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 8),
                Text(book["price"]!, style: TextStyle(color: Color(0xFF6251DD))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
