import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sevumyan_lab_2/api.dart';
import 'package:sevumyan_lab_2/card.dart';

class SearchPage extends StatefulWidget{
  const SearchPage({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{
  final SearchGifApi searchGifApi = SearchGifApi();
  dynamic _data;
  String request = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Gif Search')
      ),
      body: _buildAnswer(_data),
      bottomNavigationBar: BottomAppBar(
        child: TextButton(
          onPressed: () {
            setState(() {
              _data = _getData();
            });
          },
          child: Container(
              width: MediaQuery.of(context).size.width*0.95,
              height: 50,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: const Text('Search',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.transparent,
                    fontSize: 20
                ),
              )
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade100,
    );
  }

  _buildAnswer(dynamic data) {
    return FutureBuilder(
        future: data,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(6),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            request = value;
                          });
                        },
                      )
                  ),
                  ListView.builder(
                      itemCount: snapshot.data![0].length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int i) {
                        return GifCard.fromJson(snapshot.data![0][i]);
                      }
                  ),
                ],
              ),
            );
          }
          else {
            return Container(
                padding: const EdgeInsets.all(6),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      request = value;
                    });
                  },
                  controller: TextEditingController(
                      text: request
                  ),
                )
            );
          }
        }
    );
  }

  _getData() => searchGifApi.getPath(() => searchGifApi.setSearchPath(request, 20, 'g'));
}
