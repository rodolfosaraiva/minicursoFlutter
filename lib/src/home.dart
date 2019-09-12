import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _search = "marcelo";
  Future<Map> _getUsers() async {
    http.Response response;
    
    response = await http.get("https://api.github.com/search/users?q=${_search}&per_page=10");

    return json.decode(response.body);
  }

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
            child: FutureBuilder<Map>(
              future: _getUsers(),
              builder: (context, snapshot){
                switch (snapshot.connectionState){
                  case ConnectionState.waiting:

                  case ConnectionState.none:
                    return Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(

                      ),

                    );

                  default:
                    if (snapshot.hasError && !snapshot.hasData) {
                      return Container();
                    } else {
                      return _createGitTable(context, snapshot);
                    }
                }
              },
            )
          )
        ],
      ),
    );
  }

  Widget _createGitTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 0.65,
      ),
      itemCount: snapshot.data["items"].length,
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
                        snapshot.data["items"][index]["avatar_url"],
                        fit: BoxFit.cover
                    )
                ),
                Expanded(
                    child: Center(
                      child: Text(
                          snapshot.data["items"][index]["login"],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18
                          )
                      ),
                    )
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
