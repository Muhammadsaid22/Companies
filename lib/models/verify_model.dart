import 'dart:convert';

Verify verifyFromJson(String str) => Verify.fromJson(json.decode(str));

String verifyToJson(Verify data) => json.encode(data.toJson());

class Verify {
  Verify({
    required this.token,
  });

  final String token;

  factory Verify.fromJson(Map<String, dynamic> json) => Verify(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}
