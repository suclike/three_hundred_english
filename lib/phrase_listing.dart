import 'package:flutter/material.dart';
import 'package:three_hundred_english/phrase.dart';
import 'phrase_details.dart';

class PhraseListing extends StatefulWidget {
  final String searchText;

  PhraseListing({Key key, this.searchText}) : super(key: key);
  @override
  _SearchListState createState() => new _SearchListState();
}

class _SearchListState extends State<PhraseListing> {
  List<Phrase> _list;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    _list = List();
    _list.add(new Phrase("1", "You know, ___", ["General"]));
    _list.add(new Phrase("2", "In terms of ___ noun/v.+ING, ___, ___. ___ is ___ in terms of ___.", ["General"]));
    _list.add(new Phrase.withAdditionalList("3", "When it comes to noun/v.+ING, ___ is/are ___. ___ is/are ___ when it comes to ___.", ["General"], ["When it *came* to noun/v.+ING /what/where/how ___, ___."]));
    _list.add(new Phrase.withAdditionalList("4", "As far as ___ noun/v.+ING ___ go/goes, ___.", ["General"], ["As far as ___ noun/v.+ING is/are concerned, ___."]));
    _list.add(new Phrase.withAdditionalList("5", "Regarding ___, ___.", ["General"], ["___ regarding ___.", "As regards ___, ___.", "In regard to ___, ___.", "With regard to ___, ___."]));
    _list.add(new Phrase("6", "With respect to ___, ___.", ["General"]));
    _list.add(new Phrase("7", "I like v.+ING. I like v.+ING because ___. In addition, I also like v.+ING.", ["General"]));
    _list.add(new Phrase("8", "Oh really? +Three questions (Why? What kind of ___? Is there anything else about ___? )", ["General"]));
    _list.add(new Phrase.withAdditionalList("9", "Well, ___.", ["General"], ["In my case, ___.", "What about you?"]));
    _list.add(new Phrase.withAdditionalList("10", "Well, I enjoy v.+ING. That's because ___.", ["General"], ["Oh really? That's interesting. Tell me more.", "Is this your first time v.+ING?"]));
    _list.add(new Phrase("11", "You know, this is/isn't my first time v.+ING. I have/haven't p.p. before.", ["General"]));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
          padding: new EdgeInsets.symmetric(vertical: 8.0),
          children: _buildSearchList(widget.searchText)
      ),
    );
  }

  List<ChildItem> _buildList() {
    return _list.map((contact) => new ChildItem(contact)).toList();
  }

  List<ChildItem> _buildSearchList(String searchText) {
    if (searchText == null || searchText.isEmpty) {
      return _buildList();

    } else {
      List<Phrase> searchList = List();
      for (int i = 0; i < _list.length; i++) {
        Phrase phrase = _list.elementAt(i);
        //TODO filter by additional sentences
        if (phrase.id.toLowerCase().contains(searchText.toLowerCase())
            || phrase.value.toLowerCase().contains(searchText.toLowerCase())
            || phrase.getCategoriesAsString().toLowerCase().contains(searchText.toLowerCase())) {
          searchList.add(phrase);
        }
      }
      return searchList.map((phrase) => new ChildItem(phrase)).toList();
    }
  }

}

class ChildItem extends StatelessWidget {
  final Phrase phrase;
  ChildItem(this.phrase);
  @override
  Widget build(BuildContext context) {
    return new ListTile(
        title: new Text(
          this.phrase.toString(),
          textAlign: TextAlign.justify
        ),
        subtitle: new Text(
          this.phrase.getCategoriesAsString(),
          textAlign: TextAlign.justify
        ),
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new PhraseDetails(
                phrase: this.phrase
            )),
          );
        }
    );
  }


}
