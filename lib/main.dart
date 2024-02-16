import 'package:anime_database/presentation/common/localization/app_localizations.dart';
import 'package:anime_database/presentation/common/localization/localization_manager.dart';
import 'package:anime_database/presentation/navigation/navigation_routes.dart';
import 'package:flutter/material.dart';

import 'di/app_modules.dart';
import 'presentation/common/resources/app_styles.dart';

void main() {
  AppModules().setup(); // Setup dependency injection
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Anime Database',
      theme: AppStyles.appTheme,
      darkTheme: AppStyles.appDarkTheme,
      themeMode: ThemeMode.system, // Enable automatic dark theme support
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) {
        LocalizationManager.init(context: context);
        return AppLocalizations.of(context)!.app_title;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
