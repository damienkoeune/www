---
title: Mitra Migration Odoo 17 à 19
password: mitra-yoga
unlisted: true
---

# MITRA — Migration Odoo Enterprise 17 → 19 (Odoo Online)

Note de préparation. Recensement de l'existant, réponse à la question de l'API, analyse du problème de sessions portail rencontré lors de la migration précédente, plan de tests et procédure recommandée.

## 1. Ce qui a été constaté sur la base de production

Relevé effectué le 02/08/2026 depuis le navigateur (session administrateur) via l'ORM web et en HTTP direct.

| Élément | Valeur |
|---|---|
| Version | `17.0+e` (Enterprise), série `17.0` |
| Hébergement | Odoo Online — `www.mitra-yoga.be` est un CNAME vers `mitra.odoo.com`, servi par nginx Odoo, **sans Cloudflare ni proxy tiers devant** |
| Sociétés | Mitra, Viniyoga International AISBL |
| Sites web | 3 : Mitra Formation Yoga (`mitra-yoga.be`), khyf-intl (`viniyogainternational.org`), PhilipRigo.com |
| Modules installés | 211 |
| Utilisateurs internes | 4 |
| Utilisateurs portail (élèves) | 258 |

### Applications réellement utilisées

| App | Module | Volume en base |
|---|---|---|
| eLearning | `website_slides` | 27 canaux (dont **5 payants**), 863 contenus, 515 inscriptions |
| Site web | `website` | 3 sites, 425 vues spécifiques à un site, 174 vues/snippets personnalisés |
| eCommerce | `website_sale` | 242 modèles d'articles, 159 publiés |
| Ventes | `sale_management` | 1 005 commandes |
| Facturation / Comptabilité | `account`, `account_accountant` | **20 267 pièces comptables**, Peppol, SEPA, domiciliations, CODA/SODA belges |
| Membres | `membership` + `website_membership` | annuaire en ligne des membres |
| Abonnements | `sale_subscription` | — |
| Événements | `website_event` | 119 événements, 993 inscriptions |
| Email Marketing / SMS | `mass_mailing`, `mass_mailing_sms` | 1 296 mailings, 2 260 contacts |
| Documents | `documents` | 4 259 documents (23 698 pièces jointes au total) |
| Signature | `sign` | 12 demandes |
| Rendez-vous | `appointment` | 2 types |
| Employés, Contacts, Calendrier, Discussion, To-do, Tableaux de bord | `hr`, `contacts`, `calendar`, `mail`, `project_todo`, `spreadsheet_dashboard` | 1 255 contacts |
| Studio | `web_studio` | voir ci-dessous |

### Personnalisations (le vrai sujet d'une migration)

- Module `studio_customization` (auteur : MITRA asbl) : **5 modèles créés de toutes pièces** — `x_travail_assoc` (3 enr.), `x_travail_assoc_line_173b1` (12), `x_frais_sejour` (12), `x_group` (17), `x_food_pref` (2).
- **79 champs `x_studio_*`** répartis notamment sur `product.product` (22), `product.template` (10), `res.users` (9), `res.partner` (6), `event.event` (2), `sale.order` (1), plus les champs des modèles custom.
- 25 vues contenant des champs Studio, 124 actions serveur, 66 modèles d'e-mail, 37 rapports QWeb, 49 actions planifiées actives.
- Modules non-Odoo : `l10n_be_coda` (Noviat), `saas_website` (spécifique Odoo Online).
- Paiement : seul **Wire Transfer (virement)** est actif. Stripe et PayPal sont installés mais désactivés.

## 2. L'API en version 17 : elle existe déjà

**Il y a bien une API externe en Odoo 17**, et elle répond sur ton instance — j'ai interrogé `https://www.mitra-yoga.be/xmlrpc/2/common` (méthode `version`, sans authentification) et elle renvoie `17.0+e`. `/jsonrpc` répond aussi.

- **Odoo 17** : XML-RPC (`/xmlrpc/2/common`, `/xmlrpc/2/object`) et JSON-RPC (`/jsonrpc`). Authentification par login + **clé API** (disponible depuis la v14, dans *Préférences → Sécurité du compte → Nouvelle clé API*).
- **Plan tarifaire** : l'accès aux données par l'API externe est réservé aux plans **Custom** (pas *One App Free* ni *Standard*). ✅ Confirmé par Damien le 02/08/2026 : l'abonnement MITRA est bien en Custom.
- **Ce qui est nouveau en 19** : l'API **JSON-2** (`/json/2`), avec authentification par *bearer token*, vrais codes HTTP et documentation auto-générée. XML-RPC et JSON-RPC y sont **dépréciés**, avec suppression annoncée pour Odoo 22 (automne 2028) et Odoo Online 21.1 (hiver 2027).
- Une clé API porte **tous les droits de l'utilisateur qui l'a créée** — il n'y a pas de clé « lecture seule ». D'où la recommandation ci-dessous.

**Ce que je recommande concrètement** : ne crée pas de clé sur la production. Crée-la sur les bases de **test**, avec un utilisateur dédié. Et crée-la sur **deux** bases : une copie de la prod restée en 17 (référence) et la base de test migrée en 19. C'est ce qui permet le test le plus utile de toute l'opération : comparer automatiquement, enregistrement par enregistrement, l'avant et l'après.

## 3. Une ou deux migrations ?

Une seule demande. Le service d'upgrade d'Odoo accepte une demande 17 → 19 directe et enchaîne lui-même 17 → 18 → 19 en interne. Tu n'as pas à commander deux migrations ni à exploiter une base intermédiaire en 18. Pour Odoo Online, la demande de base de test se fait depuis le *database manager* (`/web/database/manager` ou le bouton « Je veux d'abord tester »).

À surveiller côté facturation : à partir d'avril 2026, Odoo applique une surcharge de 25 % aux abonnements en retard de plus de trois versions. La 17 est aujourd'hui à trois versions de la 19/19.x — à vérifier sur la prochaine facture, ça peut peser dans le calendrier.

## 4. Points chauds identifiés pour ce passage 17 → 19

J'ai comparé la liste des modules installés avec l'arbre des addons Odoo 19 sur GitHub. Ce qui disparaît et vous concerne :

- **`membership` et `website_membership` sont supprimés en Odoo 19** (ils existent encore en 18). Odoo les remplace par un module *Membership / Partnership* et annonce que **les données d'adhésion existantes ne sont pas cassées** par la migration. En revanche l'ergonomie change, l'intégration passe par Ventes/Abonnements, et l'**annuaire des membres publié sur le site** est à revérifier page par page. C'est, à mes yeux, le premier point fonctionnel à tester.
- **`website_form_project`** (soumission de tâche en ligne) supprimé.
- `account_payment_term`, `sale_async_emails`, `web_editor` : supprimés aussi, mais ce sont des refontes internes absorbées par d'autres modules — sans impact attendu, à confirmer par les tests.
- **`l10n_be_coda` (Noviat)** : à vérifier explicitement, c'est de l'import bancaire belge et il n'est pas dans les addons communautaires. Si l'import CODA casse, c'est la compta qui s'arrête.
- **Le site web est le poste de risque n° 1 en volume** : 425 vues spécifiques + 174 snippets personnalisés, sur 3 sites. Le *website builder* a beaucoup changé en 18 puis en 19. Attends-toi à du travail de reprise visuelle, pas à une casse fonctionnelle.
- **Studio** : 5 modèles et 79 champs personnalisés. Odoo migre les personnalisations Studio, mais c'est justement le domaine où les régressions se logent (vues qui refusent de s'ouvrir, champs calculés, actions serveur).

## 5. Le problème des sessions portail de la migration précédente

### Ce qui est établi

J'ai vérifié le comportement actuel des cookies en HTTP direct : **chaque réponse**, y compris sur une page publique et pour un visiteur anonyme, pose un cookie `session_id` (`HttpOnly`, `Path=/`, 7 jours) — **sans attribut `Secure` ni `SameSite`**. C'est le comportement normal d'Odoo 17, mais c'est aussi ce qui rend le mécanisme de panne possible.

Pour qu'un utilisateur arrive dans le compte d'un autre, il faut qu'un `session_id` déjà authentifié soit remis à un tiers. Il n'y a essentiellement que deux façons : soit un **cache HTTP partagé** (CDN, proxy d'entreprise ou de FAI, règle de cache mal réglée) a mémorisé une réponse **avec son en-tête `Set-Cookie`** et la ressert à d'autres visiteurs, soit le cookie a été partagé côté client (poste partagé, navigateur partagé).

### Est-ce connu, reconnu ?

**La classe de problème est parfaitement connue et documentée ; le bug précis, non.** Il n'existe aucun avis de sécurité ni CVE Odoo sur un mélange d'utilisateurs portail. Ce qui existe :

- des rapports d'utilisateurs décrivant exactement ton symptôme — connexion avec les identifiants de A, arrivée dans le compte de B — sur des instances avec le module Website et beaucoup d'utilisateurs ([issue #34438](https://github.com/odoo/odoo/issues/34438), [forum « User session bug. Odoo mixing up users »](https://www.odoo.com/forum/help-1/user-session-bug-odoo-mixing-up-users-144653)). Ces tickets ont été fermés **sans cause racine publiée**.
- des bugs Odoo réels et corrigés autour du couple cache/`Set-Cookie` : le contrôleur `/web/image` renvoyant un `Set-Cookie` qui empêche toute mise en cache publique ([issue #17084](https://github.com/odoo/odoo/issues/17084)), et la **page de login mise en cache par Cloudflare**, corrigée début 2025 par l'ajout d'en-têtes anti-cache ([PR #191453](https://github.com/odoo/odoo/pull/191453), rétroportée en 16, 17, 18).
- la documentation Cloudflare elle-même, qui décrit le scénario : une règle de cache forcée fait mettre en cache une réponse porteuse de `Set-Cookie` et casse les connexions ([Dynamic content and login issues](https://developers.cloudflare.com/cache/troubleshooting/dynamic-content-and-login-issues/)).
- les attributs `SameSite`/`Secure` manquants sur `session_id` et `frontend_lang`, signalés de longue date ([issue #63226](https://github.com/odoo/odoo/issues/63226), [issue #24518](https://github.com/odoo/odoo/issues/24518)).

Autrement dit : **le mécanisme est reconnu, mais il n'est presque jamais imputable à la version d'Odoo elle-même** — il est imputable à ce qui se trouve devant Odoo, ou à des cookies périmés conservés par les navigateurs au moment d'une bascule.

### Est-ce que ça peut revenir en 19 ?

Risque **faible à modéré**, et surtout **peu lié au numéro de version**.

Éléments plutôt rassurants :

- Aujourd'hui il n'y a **aucun CDN ni proxy tiers devant `mitra-yoga.be`** : la réponse vient directement du nginx d'Odoo Online, sans `cf-ray` ni en-tête de cache tiers. Si un proxy était en cause lors de la migration précédente (changement de domaine, période de bascule DNS), la cause est aujourd'hui absente.
- **Odoo 19 durcit nettement la gestion des sessions.** Le code de `odoo/http.py` en 19 introduit une **rotation automatique de session toutes les 3 heures** (`SESSION_ROTATION_INTERVAL`), avec un identifiant de session coupé en deux — 42 octets stables qui identifient la session et servent au jeton CSRF, le reste renouvelé — et un délai de grâce de 120 s pour les requêtes concurrentes. La connexion, elle, provoque une rotation « dure » qui change tout l'identifiant. Conséquence pratique : un `session_id` capté ou mis en cache devient périmé beaucoup plus vite qu'en 17.
- Odoo 19 expose aussi une vraie gestion des **appareils connectés** par utilisateur (révocation ciblée), là où la 17 n'offre qu'un « déconnecter tous les appareils » global.

Éléments de vigilance :

- La rotation toutes les 3 h est **nouvelle** : c'est en soi une zone à tester, en particulier sur les parcours longs (visionnage d'un cours, tunnel de paiement, formulaire d'inscription à un événement).
- Le cookie `session_id` reste **partagé entre les 3 sites web** de la base. Ce n'est pas un mélange d'utilisateurs, mais ça mérite un test croisé mitra-yoga.be ↔ viniyogainternational.org.
- Le vrai facteur déclenchant d'un incident de ce type, c'est **la bascule elle-même** : 258 élèves portent des cookies `session_id` émis par la base v17 au moment où la base v19 prend le relais. Ce sont ces cookies-là qu'il faut neutraliser (voir § 7).

## 6. Situations de test que je peux mener

Une fois la base de test v19 disponible (et, idéalement, une copie v17 de référence), voici ce que je propose. L'ordre est celui du risque décroissant.

### A. Sessions et authentification portail — priorité absolue

1. **Trois identités simultanées** : trois profils de navigateur isolés, trois élèves différents, connexion en parallèle, puis contrôle de l'identité renvoyée sur `/my`, `/my/courses` et `/slides` — répété une vingtaine de fois.
2. **Connexion / déconnexion en boucle**, avec relevé du `session_id` à chaque étape : vérifier qu'il change bien à chaque connexion (rotation dure) et qu'aucun identifiant n'est réémis.
3. **Audit des en-têtes** sur les URL authentifiées (`/my`, `/my/courses`, `/shop/cart`, `/web/image`, `/slides/…`) : présence de `Cache-Control: private` (ou `no-store`), et surtout **aucune réponse porteuse d'un `Set-Cookie` qui serait cachable**.
4. **Test du cookie périmé** — celui qui reproduit ton incident : on se connecte sur la base de test v17, on garde le cookie, on bascule sur la base v19, on rejoue le cookie. Le résultat attendu est une redirection vers la page de connexion. Tout autre résultat — a fortiori une autre identité — est bloquant.
5. **Rotation à 3 h** : session maintenue ouverte au-delà de 3 h pendant la lecture d'un contenu eLearning et pendant un tunnel de commande, pour vérifier qu'aucune déconnexion ni perte de panier ne survient.
6. **Parcours d'entrée** : inscription libre, invitation, réinitialisation de mot de passe, lien de partage de cours — vérifier qu'aucun de ces liens n'ouvre une session préexistante.
7. **Croisement inter-sites** : connexion sur un site, navigation sur les deux autres.
8. **Concurrence scriptée** : via l'API, N connexions simultanées avec contrôle croisé de l'`uid` renvoyé — c'est le test qui a le plus de chances de faire ressortir un mélange de sessions, précisément parce qu'il concentre en quelques minutes ce que 258 élèves produisent en plusieurs jours.

### B. Comparaison de données v17 ↔ v19 (par API)

Script de comptage et de somme de contrôle sur les modèles clés — contacts, utilisateurs portail, `slide.channel.partner`, commandes, factures, écritures, adhésions, inscriptions événements — exécuté sur les deux bases, puis diff. C'est ce qui détecte les pertes silencieuses, celles qu'aucun test manuel ne verra.

### C. Métier

- **eLearning** : inscription à un canal gratuit, achat d'un canal payant, progression, reprise de lecture, quiz, accès après paiement, e-mails automatiques.
- **Membres** : bascule `membership` → *Membership / Partnership*, contrôle des effectifs et des états, annuaire en ligne.
- **eCommerce** : panier, virement, confirmation, facture, portail client.
- **Comptabilité** : mêmes rapports (balance, TVA, grand livre, âge des créances) sur les mêmes périodes dans les deux bases, comparés ligne à ligne. Import CODA. Peppol. Domiciliations SEPA.
- **Événements** : inscription en ligne, billets, e-mails.
- **Studio** : ouverture de chaque vue, création/modification/suppression sur les 5 modèles custom, exécution des actions serveur.
- **Site web** : parcours visuel des pages clés des 3 sites, formulaires, snippets personnalisés.
- **Mailings** : rendu d'un modèle, désinscription, listes.
- **Documents et Sign** : ouverture d'un échantillon, aperçus, signatures en cours.
- **Rapports PDF** : les 37 rapports, en particulier ceux qui ont été retouchés.

## 7. Procédure recommandée

1. **Vérifier le plan d'abonnement** (Custom ?) pour confirmer l'accès à l'API externe. Sans ça, tout le volet comparaison automatique tombe et on retombe sur du test manuel.
2. **Demander une base de test v19** depuis le *database manager* d'Odoo Online, et en parallèle **dupliquer la prod en v17** comme base de référence.
3. **Créer un utilisateur dédié + clé API** sur ces deux bases de test — jamais sur la production.
4. **Geler les modifications Studio** et les modifications de site pendant la fenêtre de test : toute évolution faite en prod après la copie devra être refaite à la main après la bascule.
5. **Dérouler les tests**, consigner les écarts dans une liste unique, corriger, puis **redemander une base de test fraîche** — la bascule finale doit être précédée d'un test sur une copie récente, pas sur celle d'il y a six semaines.
6. **Choisir une fenêtre de bascule hors période de cours**, prévenir les élèves à l'avance.
7. **Au moment de la bascule, neutraliser les anciennes sessions** : c'est la mesure la plus directement liée à ton incident précédent. Sur Odoo Online on n'a pas accès au *filestore*, mais on peut révoquer les appareils/sessions côté utilisateurs, et il faut de toute façon communiquer aux élèves la consigne « si quelque chose vous paraît anormal, déconnectez-vous et videz les cookies du site ». Ce point mérite d'être posé explicitement au support Odoo avant la bascule.
8. **Ouvrir un canal de signalement immédiat** pendant les 72 h qui suivent, et faire un contrôle par échantillon des identités portail à J+1. Un mélange d'utilisateurs qui n'est pas détecté dans les heures qui suivent devient très difficile à reconstituer après coup.
9. **Documenter la version d'arrivée** : 19.0 ou une version *Online* plus récente (19.x) — les bases Odoo Online sont ensuite mises à jour en continu, ce qui change le rythme de test à prévoir pour la suite.

## 8. Où créer une clé API (et où elle n'est pas)

La section *Clés API* ne figure **pas** sur la fiche utilisateur vue par l'administrateur (*Paramètres → Utilisateurs et sociétés → Utilisateurs*, vue `view_users_form`). Elle est uniquement dans **ses propres préférences** (vue `view_users_form_simple_modif`) : **avatar en haut à droite → Préférences → onglet Sécurité du compte → Clés API → Nouvelle clé API**. Odoo demande le mot de passe (contrôle d'identité) avant d'afficher la clé, une seule fois.

Conséquences pratiques : une clé est liée à **l'utilisateur qui la crée** et à **la base sur laquelle il est connecté** — on ne peut pas générer une clé pour quelqu'un d'autre depuis l'administration. Pour une clé « robot », il faut donc se connecter avec cet utilisateur-là. Sur Odoo Online, un utilisateur qui s'authentifie via odoo.com (SSO) n'a pas forcément de mot de passe local : il faut lui en définir un (*Paramètres → Utilisateurs → Changer le mot de passe*) avant de pouvoir créer une clé.

En mode développeur, *Paramètres → Technique* expose une action **API Keys Listing** (`base.action_apikeys_admin`) qui permet de **voir et supprimer** les clés de tous les utilisateurs — mais pas d'en créer.

Attention à ne pas confondre : la liste **« Appareils de confiance »** visible sur la fiche utilisateur, avec son bouton **« Révoquer tout »**, vient du module `auth_totp`. Elle ne concerne **que** le « se souvenir de cet appareil » de l'authentification à deux facteurs — **pas les sessions**.

## 9. Révoquer les sessions des élèves — le mécanisme réel

### Comment Odoo valide une session

Le cookie `session_id` ne suffit pas à lui seul. À chaque requête, Odoo recalcule un `session_token` : un HMAC de l'identifiant de session dont la **clé** est composée des champs `id`, `login`, `password` (le hash) et `active` de l'utilisateur, **plus le paramètre système `database.secret`** (`odoo/addons/base/models/res_users.py`, méthode `_compute_session_token`). Si l'un de ces éléments change, la session ne se valide plus et l'utilisateur retombe sur la page de connexion.

### Les leviers disponibles en 17

| Levier | Portée | Verdict |
|---|---|---|
| Changer `database.secret` (*Paramètres → Technique → Paramètres système*, mode développeur) | **Toutes** les sessions de tous les utilisateurs, immédiatement | Le **seul** levier de masse en 17 — mais avec des effets collatéraux, voir ci-dessous |
| Écrire sur `login`, `password` ou `active` d'un utilisateur | Les sessions de ce seul utilisateur | C'est ce que fait le bouton « Se déconnecter de tous les appareils » (`revoke_all_devices` réécrit le hash du mot de passe) — mais il ne s'applique **qu'à son propre compte**, donc inutilisable pour 258 élèves |
| Ne rien faire | — | Cookie valable 7 jours, purge serveur des sessions inactives à 7 jours également |

**Effet collatéral de `database.secret`** : ce paramètre est aussi la clé de `tools.hmac()`, qui signe tous les liens à jeton d'Odoo. En le changeant, on casse d'un coup les liens **déjà envoyés** : désinscription des mailings (1 296 campagnes ici), invitations eLearning (`slide.channel`), liens de suivi `mail_thread`, jetons de transactions de paiement en cours. Ce n'est pas une opération anodine : elle se fait dans une fenêtre de maintenance, pas au milieu d'une campagne.

### En 19, c'est propre

Odoo 19 introduit le modèle **`res.device`** (une vue SQL sur `res.device.log`), qui représente les **vraies sessions** avec leur `session_identifier`. La méthode `_revoke()` supprime le fichier de session côté serveur. Et surtout, une règle d'enregistrement (`base.user_device_admin`, domaine `[(1,'=',1)]`) donne au groupe **Administrateur/Paramètres la lecture de tous les appareils**, tandis que `action_revoke_all_devices` accepte un utilisateur autre que soi-même. Autrement dit : en 19, un administrateur peut lister toutes les sessions de la base, les sélectionner et les révoquer — ou boucler dessus via une action serveur. Plus besoin de toucher à `database.secret`.

Nuance à connaître : `res.device.log` est alimenté par `_update_device(request)` à chaque requête. Une session héritée de la 17 n'apparaîtra donc dans la liste qu'**après** sa première requête en 19 — révoquer « tout » juste après la bascule n'attrape pas ce qui n'est pas encore revenu.

### Procédure retenue pour la bascule

1. **Au tout début de la fenêtre de maintenance, sur la production encore en 17 : changer `database.secret`.** Tout le monde est déconnecté, aucun cookie antérieur ne reste valide. Noter l'ancienne valeur avant de la remplacer.
2. Lancer la migration finale dans la foulée. Le nouveau secret est une donnée : il est migré tel quel en 19.
3. Résultat : quand la 19 s'ouvre au public, il n'existe **aucune** session héritée de la 17 — la cause de l'incident précédent est structurellement éliminée, quelle qu'elle ait été.
4. Prévenir que les liens de désinscription des anciens mailings et les invitations eLearning déjà envoyées ne fonctionneront plus, et regénérer celles qui sont encore en cours.
5. Ensuite, en régime 19, la révocation ciblée par `res.device` suffit pour tous les cas courants.

Tout ceci est à répéter d'abord **sur la base de test** : c'est là qu'on mesurera précisément ce que la rotation du secret casse.

## 10. Ce dont j'ai besoin de ta part

- Confirmation du plan d'abonnement (accès API externe).
- La base de test migrée, et la clé API sur cette base + sur une copie v17 de référence.
- La fenêtre de bascule envisagée, et la période creuse côté cours.
- Un détail sur l'incident précédent, s'il te reste des traces : **y avait-il un CDN, un proxy ou un changement de nom de domaine au moment de cette migration ?** C'est la seule information qui permettrait de trancher entre « cause externe désormais disparue » et « à surveiller de près ».

---

*Mis à jour via Claude le 02/08/2026 à 11:30*
