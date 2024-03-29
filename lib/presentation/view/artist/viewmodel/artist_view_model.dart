import 'dart:async';

import 'package:anime_database/domain/artist_repository.dart';
import 'package:anime_database/presentation/common/base/base_view_model.dart';
import 'package:anime_database/presentation/common/base/resource_state.dart';
import 'package:anime_database/presentation/common/errorhandling/app_action.dart';
import 'package:anime_database/presentation/view/artist/viewmodel/artist_error_builder.dart';

class ArtistViewModel extends BaseViewModel {
  final ArtistRepository _artistRepository;

  ArtistViewModel(this._artistRepository);

  StreamController<ResourceState> artistListState =
      StreamController<ResourceState>();

  Future<void> fetchArtists() async {
    artistListState.add(ResourceState.loading());

    _artistRepository
        .getArtists()
        .then((value) => artistListState.add(ResourceState.completed(value)))
        .catchError((e) {
      artistListState.add(ResourceState.error(
          ArtistErrorBuilder.create(e, AppAction.GET_ARTISTS).build()));
    });
  }

  @override
  void dispose() {
    artistListState.close();
  }
}
