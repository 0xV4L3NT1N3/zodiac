




class Stations {
  static final List<String> coins = [
    'BitCoin' , 'Ethereum', 'Tether', 'Cardano' ,'XRP' ,'Polkadot','BinanceCoin' ,'Litecoin', 'Stellar' , 'ChainLink' , 'DogeCoin'
  ];


  static List<String> getSuggestions(String query) {
    List<String> matches = List();
    matches.addAll(coins);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}