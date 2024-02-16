import 'package:anime_database/di/app_modules.dart';
import 'package:anime_database/model/artist.dart';
import 'package:anime_database/presentation/common/base/resource_state.dart';
import 'package:anime_database/presentation/common/localization/app_localizations.dart';
import 'package:anime_database/presentation/common/widget/error/error_overlay.dart';
import 'package:anime_database/presentation/common/widget/loading/loading_overlay.dart';
import 'package:anime_database/presentation/navigation/navigation_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'viewmodel/artist_view_model.dart';

class ArtistListPage extends StatefulWidget {
  const ArtistListPage({Key? key}) : super(key: key);

  @override
  State<ArtistListPage> createState() => _ArtistListPageState();
}

class _ArtistListPageState extends State<ArtistListPage>
    with AutomaticKeepAliveClientMixin {
  final _artistViewModel = inject<ArtistViewModel>();
  List<Artist> _artistList = List.empty();

  @override
  void initState() {
    super.initState();

    _artistViewModel.artistListState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingOverlay.show(context);
          break;
        case Status.COMPLETED:
          LoadingOverlay.hide();
          setState(() {
            _artistList = state.data;
          });
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          ErrorOverlay.of(context).show(state.error, onRetry: () {
            _artistViewModel.fetchArtists();
          });
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });

    _artistViewModel.fetchArtists();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.artists_title),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        child: ListView.builder(
          itemCount: _artistList.length,
          itemBuilder: (context, index) {
            final artist = _artistList[index];

            return ListTile(
              title: Text(artist.name),
              subtitle: Text(artist.title),
              leading: Hero(
                tag: artist.id,
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(artist.avatar),
                ),
              ),
              onTap: (() => context.go(NavigationRoutes.artistDetailRoute,
                  extra: artist.toJson())),
            );
          },
        ),
        onRefresh: () async {
          _artistViewModel.fetchArtists();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _artistViewModel.dispose(); // Avoid memory leaks
  }

  @override
  bool get wantKeepAlive => true;
}
