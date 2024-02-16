import 'package:anime_database/di/app_modules.dart';
import 'package:anime_database/presentation/common/localization/app_localizations.dart';
import 'package:anime_database/presentation/common/resources/app_dimens.dart';
import 'package:anime_database/presentation/navigation/navigation_routes.dart';
import 'package:anime_database/presentation/view/auth/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with AutomaticKeepAliveClientMixin {
  final _authViewModel = inject<AuthViewModel>();

  @override
  void initState() {
    super.initState();

    _authViewModel.signOutState.stream.listen((state) {
      switch (state) {
        case true:
          context.go(NavigationRoutes.initialRoute);
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.about_title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimens.mediumMargin),
            child: Text(
                AppLocalizations.of(context)!
                    .about_description('Clean Architecture', 'Dart'),
                textAlign: TextAlign.center),
          ),
          ElevatedButton(
            onPressed: () {
              _authViewModel.signOut();
            },
            child: Text(AppLocalizations.of(context)!.sign_out),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _authViewModel.dispose(); // Avoid memory leaks
  }

  @override
  bool get wantKeepAlive => true;
}
