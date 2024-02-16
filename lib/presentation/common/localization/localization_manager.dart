import 'package:anime_database/presentation/common/localization/app_localizations.dart';
import 'package:flutter/material.dart';

AppLocalizations get localizations => _localizations!;
AppLocalizations? _localizations;

class LocalizationManager {
  static void init({required BuildContext context}) =>
      _localizations ??= AppLocalizations.of(context);
}
