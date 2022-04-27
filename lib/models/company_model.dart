import 'dart:convert';

Companies companiesFromJson(String str) => Companies.fromJson(json.decode(str));

String companiesToJson(Companies data) => json.encode(data.toJson());

class Companies {
  Companies({
    required this.items,
  });

  final List<Item> items;

  factory Companies.fromJson(Map<String, dynamic> json) => Companies(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    required this.id,
    required this.status,
    required this.name,
    required this.city,
    required this.shortDescription,
    required this.rating,
    required this.description,
    required this.logo,
    required this.welcome_text,
  });

  final int id;
  final String status;
  final String name;
  final String city;
  final String shortDescription;
  final num rating;
  final String description;
  final String? logo;
  final String welcome_text;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    status: json["status"]??'No status',
    name: json["name"],
    city: json["city"]??'No city',
    shortDescription: json["short_description"] ?? 'No short description',
    rating: json["rating"],
    description: json["description"] ?? 'No description',
    logo: json["logo"] == null ? null : json["logo"]["urls"]["original"],
    welcome_text: json["setting"]["welcome_text"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "name": name,
    "city": city,
    "short_description": shortDescription,
    "rating": rating,
    "description": description,
    "logo": logo,
    "welcome_text": welcome_text,
  };
}
