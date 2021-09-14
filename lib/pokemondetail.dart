import 'package:flutter/material.dart';
import 'package:pokemon/pokemon.dart';

class PokeDetail extends StatelessWidget {
   final Pokemon pokemon;

   PokeDetail({this.pokemon});

   bodyWidget(BuildContext context) => Stack(
    children: <Widget>[
      Positioned(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width - 20,
        left: 10.0,
        top: MediaQuery.of(context).size.height * 0.1,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 70.0,
              ),
              Text(
                pokemon.name,
                style:
                TextStyle(fontFamily: 'Pokemon_Font',fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
              Text("Height: ${pokemon.height}",style: TextStyle(fontFamily: 'Pokemon_Font',fontSize:9)),
              Text("Weight: ${pokemon.weight}",style: TextStyle(fontFamily: 'Pokemon_Font',fontSize:9)),
              Text(
                "Types",
                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Pokemon_Font',fontSize:12),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.type
                    .map((t) => FilterChip(

                    backgroundColor: Colors.amber,
                    label: Text(t,style: TextStyle(fontFamily: 'Pokemon_Font',fontSize:9)),
                    onSelected: (b) {}))
                    .toList(),
              ),
              Text("Weakness",
                  style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Pokemon_Font',fontSize:12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.weaknesses
                    .map((t) => FilterChip(
                    backgroundColor: Colors.red,
                    label: Text(
                      t,
                      style: TextStyle(color: Colors.black,fontFamily: 'Pokemon_Font',fontSize:9),
                    ),
                    onSelected: (b) {}))
                    .toList(),
              ),
              Text("Next Evolution",
                  style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Pokemon_Font',fontSize:12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.nextEvolution == null
                    ? <Widget>[Text("This is the final form",style:TextStyle(fontFamily: 'Pokemon_Font',fontSize:9))]
                    : pokemon.nextEvolution
                    .map((n) => FilterChip(
                  backgroundColor: Colors.green,
                  label: Text(
                    n.name,
                    style: TextStyle(color: Colors.black,fontFamily: 'Pokemon_Font',fontSize:9),
                  ),
                  onSelected: (b) {},
                ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Hero(
            tag: pokemon.img,
            child: Container(
              height: 150.0,
              width: 150.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(pokemon.img))),
            )),
      )
    ],
  );

    @override

    Widget build(BuildContext context) {
       return Scaffold(
       backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[900],
        title: Text(
            pokemon.name,
            style:  TextStyle(
                color: Colors.amber[900],
                fontFamily: 'Pokemon_Font'
            ),
        ),
      ),
      body: bodyWidget(context),
    );
  }
}
