import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                labelText: "Pesquisar..",
                labelStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                border: OutlineInputBorder()
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 0.65,
                ),
              itemCount: 4,
              padding: EdgeInsets.all(4.0),
              itemBuilder: (context, index) {
                  return InkWell(
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 0.8,
                            child: Image.network(
                              "https://uploads.metropoles.com/wp-content/uploads/2019/03/27172427/WhatsApp-Image-2019-03-27-at-16.54.41.jpeg",
                              fit: BoxFit.cover
                            )

                          )
                        ],
                      ),
                    ),
                  );
              },
            ),
          )
        ],
      ),
    );
  }
}
