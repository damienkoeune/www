---
title: "De l'IA qui conseille à l'IA qui exécute"
date: 2026-08-06
description: "Vous utilisez déjà une IA dans une fenêtre de navigateur : vous posez une question, elle répond, vous recopiez. Il existe une autre façon de s'en servir, où elle travaille directement dans vos dossiers — vos budgets, vos procès-verbaux, votre site internet. Voici ce que ça change, comment le mettre en place commande par commande, et où sont les garde-fous."
tags:
  - becoop
  - numérique
---

*Publié le 6 août 2026 · 20 minutes de lecture · Damien Koeune · [version en ligne](https://www.becoop.be/ressources/ia-qui-execute)*

Vous utilisez déjà une IA dans une fenêtre de navigateur : vous posez une question, elle répond, vous recopiez. Il existe une autre façon de s'en servir, où elle travaille directement dans vos dossiers — vos budgets, vos procès-verbaux, votre site internet. Voici ce que ça change, comment le mettre en place commande par commande, et où sont les garde-fous.

![Une fenêtre de notes et un terminal reliés au même dossier, les échanges allant dans les deux sens](https://www.becoop.be/web/image/3878-9f1b26aa70a30bbfab345b7b440558531ae4c18f/article-ia-qui-execute.svg)

> [!tip] À retenir
> - Un logiciel de notes et une IA qui partagent le même dossier : elle n'écrit plus des réponses à recopier, elle travaille dans vos fichiers.
> - Le format Markdown d'Obsidian est du texte pur : stocké chez vous, lisible dans quinze ans, et le moins coûteux à faire lire par une IA.
> - Le fichier de règles relu à chaque conversation est ce qui distingue un gadget d'un outil de travail — et il se dicte au fil de l'eau.
> - Trois garde-fous non négociables : un historique de versions, aucune donnée sensible dans le dossier, une vérification du résultat final.

Le scénario est toujours le même. Vous ouvrez une IA dans votre navigateur, vous décrivez votre problème, elle produit un beau paragraphe. Vous le sélectionnez, vous le copiez, vous ouvrez votre document, vous collez, vous reformatez. Le lendemain, même conversation depuis zéro : elle ne se souvient ni de votre structure, ni de vos habitudes, ni de ce qu'elle a écrit hier. **Elle conseille, vous exécutez.** Le travail que vous économisez en rédaction, vous le repayez en manutention.

Le basculement tient à une idée simple : **donner à l'IA et à votre logiciel de notes le même dossier**. Pas une intégration, pas un abonnement supplémentaire — le même dossier sur votre disque dur. Ce que l'IA écrit apparaît dans vos notes. Ce que vous écrivez dans vos notes, l'IA le lit. C'est ainsi que travaille BeCoop, et cet article décrit l'installation exacte.

## La première moitié : Obsidian, ou pourquoi le logiciel de notes n'est pas un détail

**Obsidian** est un logiciel de prise de notes gratuit — y compris pour un usage professionnel ou associatif, ce qui mérite d'être signalé par les temps qui courent. Il existe sur Windows, macOS, Linux, iPhone et Android. On pourrait le décrire comme « un Word pour les notes », mais ce serait passer à côté de ce qui compte : **ses notes ne sont pas enfermées dans un logiciel ni dans un service en ligne.** Ce sont des fichiers texte ordinaires, dans un dossier ordinaire, sur votre machine. Toute la suite découle de là.

### Le Markdown : de la mise en forme sans quitter le clavier

Ces fichiers portent l'extension `.md` et sont écrits en **Markdown**, une façon de mettre en forme du texte avec quelques signes de ponctuation. On écrit `## Budget 2027` pour un titre, `**important**` pour du gras, un tiret en début de ligne pour une puce. Obsidian affiche le résultat mis en forme pendant que vous tapez.

Le gain n'est pas cosmétique. Il n'y a plus de barre d'outils, plus de souris, plus de style « Titre 2 » qu'on a oublié d'appliquer et qui casse le sommaire. La demi-heure d'apprentissage se rembourse dans la semaine, et le même texte se retrouve ensuite en page web, en PDF, en document imprimé, sans jamais être ressaisi.

**Astuce** — vous n'avez rien à ressaisir pour commencer. Dans Google Docs, **Fichier → Télécharger → Markdown (.md)** convertit un document existant en une note prête à déposer dans votre dossier, titres et listes conservés. De quoi transformer en une après-midi le contenu d'un Drive en matière exploitable.

### Le format le moins cher à faire lire par une IA

C'est l'avantage le moins connu et probablement le plus décisif. Une IA facture — en argent ou en capacité d'attention — le volume de texte qu'elle avale, compté en *tokens*, des morceaux de mots. Or elle n'a pas de fenêtre infinie : au-delà d'un certain volume, elle oublie le début de ce qu'elle a lu.

Un fichier `.md` est du texte pur : dix pages de notes coûtent dix pages. Le même contenu en Word est une archive compressée bourrée de balises de mise en forme, en PDF c'est la position de chaque caractère sur la feuille. Il faut d'abord les convertir, la conversion perd la structure, et ce qui reste occupe plusieurs fois la place. À budget égal, **l'IA lit donc bien plus de vos documents s'ils sont en Markdown**, et elle les lit tels que vous les avez écrits.

Second effet, encore plus utile au quotidien : sur un fichier texte, elle peut modifier **trois lignes au milieu d'un document de quarante pages** sans toucher au reste ni le réécrire. Sur un fichier Word, l'opération équivalente consiste à tout régénérer — avec le risque d'y perdre au passage la mise en page que vous aviez soignée.

### Une arborescence, des liens, et rien dans le nuage

Le reste tient en trois points, et chacun résout un agacement bien connu :

- **Une arborescence de dossiers, la vôtre.** Un dossier par activité, par projet, par exercice comptable. Rien à apprendre : c'est votre explorateur de fichiers. Et c'est ce rangement, lisible par vous, qui permet à l'IA de savoir où déposer ce qu'elle produit.
- **Des liens entre notes.** Écrire `[[Budget 2027]]` dans un compte rendu crée un lien vers cette note. Depuis le budget, vous voyez ensuite *toutes* les réunions qui en ont parlé, sans les avoir listées. Le procès-verbal d'un conseil d'administration renvoie aux décisions qu'il applique ; le dossier de subside renvoie aux pièces qui le composent. Un classement qui se construit tout seul, en écrivant.
- **Tout est stocké chez vous.** Pas de compte, pas de serveur, aucune obligation de connexion. Vos données personnelles restent sur votre disque — argument sérieux quand on manipule des dossiers de travailleurs. Corollaire tout aussi appréciable : vos notes resteront lisibles dans quinze ans avec n'importe quel éditeur de texte, même si Obsidian disparaît.

« Stocké chez vous » ne veut pas dire « prisonnier d'une seule machine ». Comme ce sont des fichiers, il suffit de placer le dossier dans votre **OneDrive, iCloud, Dropbox ou Google Drive** pour qu'il se synchronise entre l'ordinateur du bureau, celui de la maison et le téléphone — gratuitement, avec ce que vous avez déjà. Obsidian propose aussi son propre service de synchronisation chiffré, payant, pour qui ne veut dépendre d'aucun de ces géants. Et la version la plus solide, celle que nous utilisons, est de **versionner le dossier** : chaque modification est datée et réversible, ce qui sert de sauvegarde *et* de filet de sécurité. Nul besoin d'y être informaticien : une **extension gratuite d'Obsidian** — on en trouve plusieurs sous le nom de Git dans le catalogue intégré — enregistre le dossier sur un compte GitHub gratuit et le sauvegarde à intervalle régulier, d'un clic ou toute seule.

## L'autre moitié : une IA qui se lance depuis un dossier

**Claude Code** est la version « en ligne de commande » de l'IA Claude. Elle ne s'utilise pas dans un navigateur mais dans le Terminal de votre ordinateur, et surtout : on la lance *depuis un dossier*. Ce dossier devient son terrain de travail. Elle y lit les fichiers, en crée, en modifie, lance des programmes, fabrique des PDF, interroge des sites internet.

Pointez Obsidian et Claude Code sur le même dossier et vous obtenez ceci : une fenêtre où vous voyez et rangez vos notes à la souris, et à côté un interlocuteur qui travaille dans les mêmes fichiers pendant que vous les regardez. Ce n'est plus un assistant qui vous dicte quoi faire — c'est un collègue qui a accès au classeur.

Un mot sur l'**extension Chrome**, qui complète le tableau et que peu de gens installent. Elle donne à l'IA l'usage de *votre* navigateur, avec vos sessions déjà ouvertes. Concrètement : elle consulte un portail administratif qui exige une connexion, relève un chiffre sur un site qui ne s'affiche qu'après exécution de scripts — les portails publics en sont friands, et ils sont illisibles autrement — ou vérifie de ses propres yeux le rendu d'une page que vous venez de modifier. Sans elle, une IA ne voit du web que ce qui est public et statique.

## Ce que ça donne concrètement, dans une association

Les exemples qui suivent sont ceux qui reviennent le plus dans une petite structure, là où la même personne fait la coordination, les subsides et la communication.

### Le procès-verbal, écrit pendant la réunion

Vous prenez des notes au vol, en style télégraphique, dans une note Obsidian : qui dit quoi, ce qui est décidé, ce qui reste en suspens. La réunion finie, vous demandez le procès-verbal dans la forme habituelle de la maison — ordre du jour, présents et excusés, décisions numérotées, tableau des actions avec un responsable et une échéance. Il sort structuré, dans le bon dossier, lié au PV précédent. Il vous reste à le relire et à le corriger, ce qui est le seul travail qui exigeait vraiment votre présence.

### Le budget, ses variantes et ce qu'elles impliquent

C'est l'usage qui surprend le plus. Un budget vit dans un tableau, et un tableau en Markdown se lit et se modifie très bien. Vous posez alors les questions que vous vous posez de toute façon : *et si on engage un mi-temps en septembre plutôt qu'en janvier ? Et si le subside régional est reconduit à l'identique au lieu d'être indexé ? Que devient le résultat si le taux d'occupation descend de 85 à 78 % ?*

Chaque variante devient une note à côté de l'originale, avec les chiffres recalculés et les hypothèses écrites noir sur blanc — cette dernière partie étant précisément celle qu'on omet dans un tableur, et celle qu'on regrette six mois plus tard quand plus personne ne sait d'où sortait la colonne C. Vous arrivez au conseil d'administration avec trois scénarios comparables au lieu d'un seul, et la discussion porte enfin sur le choix plutôt que sur l'arithmétique.

### Le contrôle des comptes et la mise à jour de ce qui en dépend

Deuxième temps du même mouvement : vous déposez la balance ou l'extraction comptable du trimestre dans le dossier et vous demandez la comparaison avec le budget voté. Vous obtenez les écarts, classés du plus gros au plus petit, avec les questions à poser — un poste consommé à 90 % en juin, une recette qui n'est jamais tombée, une charge apparue nulle part dans le budget.

Et surtout : les documents qui dépendent de ces chiffres se mettent à jour **dans la foulée et de manière cohérente**. Le rapport annuel, la note d'accompagnement du budget, le tableau de bord du conseil, le justificatif du pouvoir subsidiant. Là où l'on reportait le même montant à la main dans quatre documents — en en oubliant toujours un —, il n'y a plus qu'une consigne : « les comptes du deuxième trimestre viennent d'arriver, répercute-les partout où ils figurent, et dis-moi ce qui a bougé ».

### Le site internet, piloté à la voix

La plupart des sites d'association reposent aujourd'hui sur un outil qui expose une **interface de programmation**, ou **API** : une porte d'entrée technique par laquelle un programme peut modifier les pages, au lieu de cliquer dans un éditeur. C'est le cas d'Odoo, de WordPress et de la plupart des autres.

Cette porte s'ouvre avec une **clé API** : un long mot de passe que vous générez vous-même dans les réglages de votre site — dans Odoo, par votre avatar, puis Mon profil et Sécurité du compte — et que vous confiez à l'IA. Retenez le mot : c'est lui qu'il faudra chercher le jour venu, et une clé se révoque aussi facilement qu'elle se crée, ce qui referme la porte en une manipulation. Une fois cette porte ouverte, vous ne modifiez plus votre site : vous le *décrivez*. « Ajoute une page pour l'appel à projets, reprends le ton des autres pages, mets-la dans le menu Actualités et laisse-la en brouillon le temps que je la relise. » C'est exactement ainsi qu'ont été produites les pages de www.becoop.be, y compris celle que vous lisez : écrite dans le dossier de notes, envoyée vers le site par une commande, publiée après relecture. Les illustrations ont été dessinées de la même façon, à la demande — 5 Ko chacune, contre 240 Ko pour les images génériques du thème qu'elles remplacent, ce qui se voit sur la vitesse d'affichage.

Le point commun de ces quatre exemples n'est pas la rédaction. C'est que **personne n'a copié-collé quoi que ce soit**, et que les chiffres n'ont été saisis qu'une fois.

## L'installation, pas à pas

Comptez une bonne soirée. Ce n'est pas long parce que les téléchargements sont lents, mais parce que vous allez traverser deux ou trois choses inconnues : ouvrir un Terminal, comprendre où se trouve votre dossier, autoriser une application. Prenez-la comme telle, une soirée, et non comme un intermède de dix minutes entre deux réunions.

**1. Choisir le dossier.** Un seul, à la racine de votre espace personnel — appelons-le *Travail*. C'est lui qu'ouvriront Obsidian et l'IA. S'il contient déjà vos notes, tant mieux.

**2. Installer Obsidian** depuis obsidian.md, puis, au premier lancement, choisir « Ouvrir un dossier comme coffre » et désigner *Travail*.

**3. Installer Claude Code.** Ouvrez le Terminal — *Terminal* sur Mac, *Windows Terminal* ou *PowerShell* sur Windows — et collez la ligne correspondant à votre système :

```
# macOS et Linux
curl -fsSL https://claude.ai/install.sh | bash

# Windows (PowerShell)
irm https://claude.ai/install.ps1 | iex
```

Vérifiez ensuite que tout est en place, toujours dans le Terminal :

```
claude --version
claude doctor
```

**4. Lancer l'IA depuis votre dossier.** C'est *le* geste à retenir, celui qui définit tout le reste : Claude Code s'attache au dossier dans lequel vous vous trouvez au moment du lancement.

```
cd ~/Travail        # se placer dans le dossier
claude              # démarrer — l'authentification se fait dans le navigateur
```

Il faut un abonnement Claude payant ; l'authentification n'est demandée qu'une fois. Ensuite, quelques commandes suffisent au quotidien. Depuis le Terminal, pour démarrer ou reprendre :

```
claude              # démarrer une conversation dans le dossier courant
claude -c           # continuer la dernière conversation de CE dossier
claude --resume     # choisir dans la liste des conversations passées
claude --model opus # démarrer avec un modèle précis
```

Et pendant la conversation, en tapant simplement la commande à la place d'une phrase :

```
/init       faire écrire un premier fichier de règles
/memory     ouvrir et modifier ces règles
/plan       faire proposer un plan avant toute modification
/resume     reprendre une conversation antérieure sans quitter
/rename     nommer la conversation en cours pour la retrouver plus tard
/context    voir ce qu'il reste de mémoire de travail
/compact    résumer la conversation pour continuer plus léger
/clear      repartir à zéro, pour changer complètement de sujet
/rewind     revenir en arrière, fichiers et conversation compris
/status     l'état de la session : compte, modèle, connexions, consommation
/exit       quitter
```

Deux réflexes valent tous les autres : **Échap** interrompt l'IA en pleine action quand elle part dans la mauvaise direction, et `/rewind` défait ce qu'elle vient de faire. Tapez une barre oblique seule pour voir la liste complète des commandes disponibles.

**5. Poser le filet.** Avant de laisser l'IA écrire dans un dossier qui compte, mettez en place l'historique des modifications — c'est le rôle de *git*, un outil gratuit qui garde une copie datée de chaque version et permet de revenir en arrière. Demandez-le-lui : « installe git dans ce dossier et explique-moi comment revenir à hier ». Tant que ce n'est pas fait, faites-la travailler sur une copie.

**6. Brancher le reste, plus tard.** Messagerie, agenda, espace de fichiers en ligne, extension Chrome : chaque accès s'ajoute séparément et s'autorise explicitement. Commencez sans aucun. Ajoutez-en un le jour où un besoin réel se présente, pas avant.

## Les règles de la maison

C'est l'étape que tout le monde saute, et c'est de loin la plus rentable. Dans votre dossier, un fichier nommé `CLAUDE.md` est relu automatiquement au début de **chaque** conversation. On y écrit ce qu'on répéterait sinon dix fois par semaine : où ranger tel type de document, comment nommer les fichiers, quel ton adopter dans les courriers, ce qu'il ne faut jamais faire.

Les nôtres contiennent par exemple : « tout fichier relatif aux comptes va dans ce dossier-ci, quelle que soit la discussion », ou « terminer chaque note par la date et l'heure de dernière modification ». Écrit une fois, appliqué toujours, dans toutes les conversations à venir. C'est très exactement la différence entre une IA qui redémarre à zéro chaque matin et une collaboratrice qui connaît la maison.

Et il n'est pas nécessaire de l'écrire soi-même. `/init` en produit une première version en observant votre dossier. Surtout, **la règle se dicte au fil de l'eau** : quand une consigne revient pour la troisième fois, il suffit de dire « ajoute cette règle à tes instructions » — le fichier est modifié séance tenante, et vous pouvez toujours l'ouvrir dans Obsidian pour le relire, puisque c'est une note comme les autres. Nos règles n'ont jamais été rédigées d'un bloc : elles se sont accumulées, une phrase à la fois, chacune née d'un agacement.

## Plusieurs chantiers en même temps

Vient un moment où l'on s'aperçoit qu'on attend devant l'écran pendant que l'IA travaille. La réponse est d'en faire tourner plusieurs côte à côte, dans des volets séparés du même Terminal : l'une prépare l'envoi aux membres, l'autre corrige une page du site, la troisième dépouille un appel à projets.

Sur Mac, **CMUX** est un terminal gratuit et libre conçu exactement pour cela : volets, sessions multiples, et une notification quand l'un des agents a terminé. Sous Windows il n'existe pas d'équivalent aussi spécialisé, mais deux outils solides font le travail : **Windows Terminal**, gratuit, libre, publié par Microsoft et déjà présent sur les installations récentes, qui découpe une fenêtre en volets ; et **WezTerm**, libre et disponible sur les trois systèmes, plus configurable.

Étape facultative, à garder pour plus tard : tant que vous menez un chantier à la fois, un seul Terminal suffit.

## Trois garde-fous, appris en se cognant

**Un filet avant tout le reste.** Une IA qui peut écrire dans vos fichiers peut aussi en écraser un. D'où l'étape 5 ci-dessus, qui n'est pas décorative. Ce n'est pas de la méfiance mal placée : c'est la prudence qu'on aurait avec un stagiaire compétent à qui l'on confie les clés du bureau.

**Ce qui entre dans le dossier devient lisible.** Fiches de paie, dossiers médicaux, coordonnées bancaires : hors du dossier partagé, ou dans un sous-dossier que vos règles déclarent interdit. Et si vous publiez une partie de vos notes en ligne, souvenez-vous qu'un historique de versions est permanent — une note retirée reste lisible dans l'historique. Nous tenons pour cette raison un dossier « publiable » strictement séparé du reste.

**Elle se trompe, et il faut vérifier là où ça compte.** Un exemple parlant : sur une page de ce site, un caractère mal encodé s'est répété seize fois — invisible dans le fichier, bien visible à l'écran. La règle qui en découle vaut au-delà de l'informatique : *vérifier au rendu, pas dans la source*. Une IA vous dira volontiers que c'est fait. Regardez le résultat. Et sur des chiffres, refaites une addition au hasard.

## À qui cela s'adresse — et à qui non

Soyons honnêtes sur le seuil d'entrée. Cette façon de travailler suppose d'ouvrir un Terminal sans en être effrayé, d'accepter une soirée d'installation, et de tenir un minimum de rangement dans ses dossiers. Ce n'est pas hors de portée d'une personne motivée qui n'est pas informaticienne — c'est simplement plus exigeant que de taper dans une fenêtre de navigateur.

En contrepartie, elle rend un service qu'aucun abonnement ne remplace : elle absorbe la part mécanique du travail administratif. Les documents qui se ressemblent, les chiffres reportés d'un fichier à l'autre, les mises en forme, les comptes rendus, les mises à jour du site. Dans une association où une seule personne porte la coordination, les subsides et la communication, c'est précisément là que le temps disparaît — et il ne disparaît pas dans le travail intéressant.

Si le sujet vous intéresse mais que l'installation vous arrête, c'est l'objet même de nos [ateliers intelligence artificielle](https://www.becoop.be/ateliers-ia) : le niveau avancé consiste à monter ce dispositif sur votre machine, avec vos dossiers, vos règles et vos documents, et à repartir avec quelque chose qui tourne.

*Mis à jour via Claude le 11/08/2026 à 11:17*
