import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urun_katalog_projesi/screens/book_details.dart';

class BestSellerScreen extends StatefulWidget {
  @override
  _BestSellerScreenState createState() => _BestSellerScreenState();
}

class _BestSellerScreenState extends State<BestSellerScreen> {
  final List<Map<String, String>> books = [
    {
      "title": "Dune",
      "author": "Frank Herbert",
      "price": "\$15.99",
      "imagePath": "assets/book/dune.png",
      "summary": "An epic science fiction novel set in a desert world.",
    },
    {
      "title": "1984",
      "author": "George Orwell",
      "price": "\$12.99",
      "imagePath": "assets/book/1984.png",
      "summary": "A dystopian novel about surveillance and authoritarianism.",
    },
    {
      "title": "Ikıgai",
      "author": "Héctor García",
      "price": "\$10.99",
      "imagePath": "assets/book/ikigai.jpg",
      "summary": "A philosophical story about following your dreams.",
    },
    {
      "title": "Çavdar Tarlasında Çocuklar",
      "author": "J. D. Salinger",
      "price": "\$8.99",
      "imagePath": "assets/book/cavdar_tarlasında_cocuklar.png",
      "summary": "A classic romantic novel of manners and courtship.",
    },
    {
      "title": "Kürk Mantolu Madonna",
      "author": "Sabahattin Ali",
      "price": "\$14.99",
      "imagePath": "assets/book/kurk_mantolu_madonna.jpg",
      "summary": "A historical novel exploring Russian society.",
    },
    {
      "title": "Tutunamayanlar",
      "author": "Oğuz Atay ",
      "price": "\$9.99",
      "imagePath": "assets/book/tutunamayanlar.jpg",
      "summary": "An adventure of a man's obsession with a great whale.",
    },
    {
      "title": "Dönüşüm",
      "author": "Franz Kafka",
      "price": "\$9.99",
      "imagePath": "assets/book/dönüşüm.jpg",
      "summary": "The Metamorphosis is a long story by Franz Kafka. It was first published in 1915. It can be considered Kafka's most popular work. The story begins with Gregor Samsa finding himself transformed into a giant insect one morning and continues by describing the changes in his life.",
    },
    {
      "title": "Altıncı Koğuş",
      "author": "Anton Çeho",
      "price": "\$9.99",
      "imagePath": "assets/book/altıncı_kogus.jfif",
      "summary": "Ward Six is ​​a short story by Anton Chekhov, published in 1892. It was first published in the November issue of Russkaya mysl, one of the most popular Russian magazines of the period, and attracted considerable attention. In this work, Chekhov draws two different types of people, Ivan Dmitriç, an educated mental patient, and Doctor Andrey Yefimich.",
    },
  ];

  List<Map<String, String>> filteredBooks = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredBooks = books; // İlk olarak tüm kitapları göster
  }

  void filterBooks(String query) {
    setState(() {
      filteredBooks = books
          .where((book) =>
      book["title"]!.toLowerCase().contains(query.toLowerCase()) ||
          book["author"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 215.0),
          child: Text('Best Seller'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Arama Çubuğu
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) => filterBooks(value),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search by title or author",

                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          filterBooks('');
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
                ),
              ],
            ),
            SizedBox(height: 16),

            // Kitap GridView
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                itemCount: filteredBooks.length,
                itemBuilder: (context, index) {
                  final book = filteredBooks[index];
                  return _buildBookCard(
                    context,
                    book['title']!,
                    book['author']!,
                    book['price']!,
                    book['imagePath']!,
                    book['summary']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookCard(BuildContext context, String title, String author, String price, String imagePath, String summary) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsPage(
              title: title,
              author: author,
              price: price,
              imagePath: imagePath,
              summary: summary,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFFE6E6FF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            // Kitap görseli
            Image.asset(
              imagePath,
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            // Kitap detayları
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(author, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 8),
            Text(price, style: TextStyle(color: Color(0xFF6251DD))),
          ],
        ),
      ),
    );
  }
}