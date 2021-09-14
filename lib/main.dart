import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokemon/pokemon.dart';
import 'package:pokemon/pokemondetail.dart';

void main() {
  runApp(MaterialApp(
      home: Pokemon(),
    ),
  );
}

class Pokemon extends StatefulWidget {
  @override
  _PokemonState createState() => _PokemonState();
}

class _PokemonState extends State<Pokemon> {
  int pageIndex=0;
  PageController _pageViewController = PageController(initialPage: 0);

  PokeHub pokeHub;
  var url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  @override
  void initState(){
    super.initState();

    fetchData();
    print("wait");

  }

  fetchData() async {
    setState(() {});
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    setState(() {});

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        centerTitle: true,
        title:  Text(
          "Pokédex",
          style: TextStyle(
              color: Colors.amber[900],
              fontFamily: 'Pokemon_Font'
          ),
        ),
      ),

      body: PageView(
        onPageChanged: (int index){
          setState(() {
            pageIndex = index;

          });
        },
        controller: _pageViewController,
        children: [
            Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                  color: Colors.grey[800],
                  child: Image.asset(
                      "lib/images/pokedex.png",
                      fit: BoxFit.cover)
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 20,
                margin: EdgeInsets.only(bottom: 100),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF).withOpacity(0),
                ),
                child: Text("Enter to the world of Pokémon",
                  style: TextStyle(
                    color: Colors.amber,
                    fontFamily: 'Pokemon_Font',
                    fontSize: 14.5,
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 100,
                child: IconButton(
                  onPressed: () {
                    _pageViewController.animateToPage(++pageIndex, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
                  },
                  icon: Icon(Icons.forward_sharp),
                  color: Colors.amber,
                  iconSize: 50,
                ),
              ),
              Container(
                height: 20,
                  decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF).withOpacity(0),
                  ),
                  child: Center(child: Text("CREATED BY VPD",style:TextStyle(color: Colors.grey[300],fontFamily: 'Pokemon_Font',fontSize:8)))
              )
            ]),
            Container(
                color: Colors.grey[900],
                child: pokeHub == null
                    ? Center(
                    child: CircularProgressIndicator(),
                  )
                    : GridView.count(
                  crossAxisCount: 2,
                  children: pokeHub.pokemon.map((poke) => Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(
                              builder: (context) => PokeDetail(pokemon: poke,
                              )));
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(

                                image: DecorationImage(image: NetworkImage(poke.img))
                              ),
                            ),
                            Text(
                              poke.name,
                              style: TextStyle(
                                color: Colors.brown[400],
                                fontFamily: 'Pokemon_Font',
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )).toList(),
                ),
            ),
        ]),

    );
  }
}


