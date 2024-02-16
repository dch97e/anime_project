import 'package:anime_database/presentation/view/about/about_page.dart';
import 'package:anime_database/presentation/view/artist/artist_list_page.dart';
import 'package:anime_database/presentation/view/auth/login_page.dart';
import 'package:anime_database/presentation/view/home/home_page.dart';
import 'package:anime_database/presentation/view/splash/splash_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract class NavigationRoutes {
  // Route paths (for subroutes) - private access
  static const String _artistDetailPath = 'detail';

  // Route names
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String artistsRoute = '/artists';
  static const String artistDetailRoute = '$artistsRoute/$_artistDetailPath';
  static const String aboutRoute = '/about';
}

// Nav keys
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _artistsNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _aboutNavigatorKey =
    GlobalKey<NavigatorState>();

final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: NavigationRoutes.initialRoute,
    routes: [
      // Routes
      GoRoute(
          path: NavigationRoutes.initialRoute,
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const SplashPage()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => HomePage(navigationShell: shell),
        branches: [
          StatefulShellBranch(navigatorKey: _artistsNavigatorKey, routes: [
            GoRoute(
                path: NavigationRoutes.artistsRoute,
                parentNavigatorKey: _artistsNavigatorKey,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ArtistListPage()),
                routes: const []),
          ]),
          StatefulShellBranch(navigatorKey: _aboutNavigatorKey, routes: [
            GoRoute(
                path: NavigationRoutes.aboutRoute,
                parentNavigatorKey: _aboutNavigatorKey,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: AboutPage())),
          ])
        ],
      ),
      GoRoute(
          path: NavigationRoutes.loginRoute,
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const LoginPage()),
    ]);
