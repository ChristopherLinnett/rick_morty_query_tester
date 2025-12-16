/// Character model representing a Rick and Morty character from the API
class Character {
  /// The id of the character
  final int id;

  /// The name of the character
  final String name;

  /// The status of the character ('Alive', 'Dead' or 'unknown')
  final String status;

  /// The species of the character
  final String species;

  /// The type or subspecies of the character
  final String type;

  /// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown')
  final String gender;

  /// Name and link to the character's origin location
  final CharacterLocation origin;

  /// Name and link to the character's last known location
  final CharacterLocation location;

  /// Link to the character's image. All images are 300x300px
  final String image;

  /// List of episodes in which this character appeared
  final List<String> episode;

  /// Link to the character's own URL endpoint
  final String url;

  /// Time at which the character was created in the database
  final DateTime created;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  /// Creates a Character from JSON data
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      type: json['type'] as String,
      gender: json['gender'] as String,
      origin: CharacterLocation.fromJson(json['origin'] as Map<String, dynamic>),
      location: CharacterLocation.fromJson(json['location'] as Map<String, dynamic>),
      image: json['image'] as String,
      episode: List<String>.from(json['episode'] as List),
      url: json['url'] as String,
      created: DateTime.parse(json['created'] as String),
    );
  }

  /// Converts this Character to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin.toJson(),
      'location': location.toJson(),
      'image': image,
      'episode': episode,
      'url': url,
      'created': created.toIso8601String(),
    };
  }

  /// Creates a copy of this Character with some properties optionally overridden
  Character copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    CharacterLocation? origin,
    CharacterLocation? location,
    String? image,
    List<String>? episode,
    String? url,
    DateTime? created,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      origin: origin ?? this.origin,
      location: location ?? this.location,
      image: image ?? this.image,
      episode: episode ?? this.episode,
      url: url ?? this.url,
      created: created ?? this.created,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Character) return false;
    return other.id == id &&
        other.name == name &&
        other.status == status &&
        other.species == species &&
        other.type == type &&
        other.gender == gender &&
        other.origin == origin &&
        other.location == location &&
        other.image == image &&
        _listEquals(other.episode, episode) &&
        other.url == url &&
        other.created == created;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      status,
      species,
      type,
      gender,
      origin,
      location,
      image,
      Object.hashAll(episode),
      url,
      created,
    );
  }

  @override
  String toString() {
    return 'Character(id: $id, name: $name, status: $status, species: $species, '
        'type: $type, gender: $gender, origin: $origin, location: $location, '
        'image: $image, episode: $episode, url: $url, created: $created)';
  }

  /// Helper method to compare lists
  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

/// Location model representing origin or location data
class CharacterLocation {
  /// The name of the location
  final String name;

  /// The URL endpoint for this location
  final String url;

  const CharacterLocation({required this.name, required this.url});

  /// Creates a Location from JSON data
  factory CharacterLocation.fromJson(Map<String, dynamic> json) {
    return CharacterLocation(name: json['name'] as String, url: json['url'] as String);
  }

  /// Converts this Location to JSON
  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }

  /// Creates a copy of this Location with some properties optionally overridden
  CharacterLocation copyWith({String? name, String? url}) {
    return CharacterLocation(name: name ?? this.name, url: url ?? this.url);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CharacterLocation) return false;
    return other.name == name && other.url == url;
  }

  @override
  int get hashCode => Object.hash(name, url);

  @override
  String toString() => 'Location(name: $name, url: $url)';
}
