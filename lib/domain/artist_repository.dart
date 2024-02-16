import 'package:anime_database/model/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> getArtists();
}
