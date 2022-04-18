import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sevumyan_lab_2/random.dart';
import 'package:sevumyan_lab_2/search.dart';
import 'package:sevumyan_lab_2/translation.dart';
import 'package:sevumyan_lab_2/api.dart';
import 'card.dart';

class PopularPage extends StatefulWidget {
  const PopularPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  final SearchGifApi searchGifApi = SearchGifApi();
  static const IconData translate =
      IconData(0xe67b, fontFamily: 'MaterialIcons');
  //late final Dio dio;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.location_searching_rounded),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => RandomPage()));
              },
            ),
            title: const Text('Gif Popular'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TranslatePage()));
                  },
                  icon: const Icon(translate)
              ),
              const SizedBox(width: 8,)
            ],
          ),
          body: _buildBody(),
          backgroundColor: Colors.grey.shade100,
          bottomNavigationBar: BottomAppBar(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const SearchPage()));
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: const Text(
                    'Search Gif',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.transparent,
                        fontSize: 20),
                  )),
            ),
          ),
        );
      }
    );
  }

  _buildBody() {
    return FutureBuilder(
        future: _getData()!,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return Scrollbar(
              child: ListView.builder(
                itemCount: snapshot.data![0].length,
                  itemBuilder: (BuildContext context, int i) {
                      return GifCard.fromJson(snapshot.data![0][i]);
                  }
              ),
            );
          }
          else {
            return const Center(
              child: CircularProgressIndicator()
            );
          }
        }
    );
  }

  _getData() => searchGifApi.getPath(() => searchGifApi.setPopularPath(0, 'g', 20));

}
