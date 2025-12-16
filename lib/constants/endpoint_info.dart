enum PathType {
  character('character'),
  location('location'),
  episode('episode');

  final String pathName;
  const PathType(this.pathName);
}

/// Represents a path parameter with optional ID
abstract class PathParameter {
  final PathType type;
  final int? id;

  const PathParameter(this.type, [this.id]);

  String get pathSegment {
    if (id != null) return '${type.pathName}/$id';
    return type.pathName;
  }
}

class CharacterParam extends PathParameter {
  const CharacterParam([int? id]) : super(PathType.character, id);
}

class LocationParam extends PathParameter {
  const LocationParam([int? id]) : super(PathType.location, id);
}

class EpisodeParam extends PathParameter {
  const EpisodeParam([int? id]) : super(PathType.episode, id);
}

enum QueryParameters {
  page('page'),
  name('name'),
  status('status'),
  species('species'),
  type('type');

  final String paramName;
  const QueryParameters(this.paramName);
}

class EndpointInfo {
  static const apiHost = "https://rickandmortyapi.com/api/";
}
