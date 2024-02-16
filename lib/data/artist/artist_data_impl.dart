import 'package:anime_database/data/artist/remote/artist_remote_impl.dart';
import 'package:anime_database/domain/artist_repository.dart';
import 'package:anime_database/model/artist.dart';

class ArtistDataImpl implements ArtistRepository {
  final ArtistRemoteImpl _remoteImpl;
  ArtistDataImpl(this._remoteImpl);

  @override
  Future<List<Artist>> getArtists() {
    return _remoteImpl.getArtists();
  }
}
