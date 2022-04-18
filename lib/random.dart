import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sevumyan_lab_2/api.dart';
import 'package:sevumyan_lab_2/card.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage>{
  final SearchGifApi searchGifApi = SearchGifApi();
  dynamic _data;
  String? request;

  @override
  void initState() {
    super.initState();
    _data = _getData();
  }

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
        title: const Text('Gif Random')
      ),
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
              child: const Text('Get Random Gif', 
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
      body: _buildAnswer(_data)
    );
  }

  _buildAnswer(dynamic data) {
    return FutureBuilder(
        future: data!,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(6),
                    child: TextFormField(
                      onChanged: (String? value) {
                        setState(() {
                          request = value;
                        });
                      },
                    )
                ),
                GifCard.fromJson(snapshot.data![0]),
              ],
            );
          }
          else {
            return Container(
                padding: const EdgeInsets.all(6),
                child: TextFormField(
                  onChanged: (String? value) {
                    setState(() {
                      request = value;
                    });
                  },
                )
            );
          }
        }
    );
  }

  _getData() => searchGifApi.getPath(() => searchGifApi.setRandomPath(request));
}