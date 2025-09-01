

# Usage



Ce benchmark consiste à mesurer l'impact en temps de réponse et de traitement es en fonction de deux éléments. D'un côté la manière d'opérer son traitement et de l'autre les paramètres choisis pour configurer son exécution.

Le programme `stress.sh` permet de lancer et mesurer  la rapidité d'un traitement sur un script donné (paramètre 3)  en fonction d'un nombre de documents à traiter (paramètre 1) et d'un nombre de répétitions en parallèle  (paramètre 2). Le paramètre 4 permet de modifier la configuration du serveur et notamment, la manière dont celui-ci va exécuter le script donné (paramètre 3).

Il est également possible de faire varier d'autres paramètres de configuration du serveur, mais ces changements seront à faire en modifiant les variables d'environnements avant de lancer le programme `stress.sh`.

C'est également le cas, pour évaluer les résultats avec une version différente de Node.js. À noter que contrairement à d'autres variables d'environnement, la sortie contiendra toujours la version de Node.js utilisée.



Le programme `bench.sh` permet de lancer plusieurs fois le programme précédent avec différents paramètres.



Le programme `test.sh` permet de tester un seul script (paramètre 1) en faisant varier le nombre de document (paramètre 2).



## Paramètres testables

### Scripts

Si le traitement réalisé est toujours le même `shared.ini` la manière de la faire peut-être écrite de différentes manières.

### Nombre de documents

LE volume de données testable est 1 document, 10 documents, 20 documents et 100 documents

### Nombre d'exécutions parallèles

Permet de multiplier le volume de documents à traiter en sachant que le programme lancera simultanément jusqu'à 4 requêtes.

### Version de NodeJS

L'usage de nvm permet de choisir avant le lancement du script la version de nodeJS

### Configuration Server EZS

Le serveur EZS peut être configuré en ligne de commandes ou avec des variables d’environnement. Les paramètres disponibles sont :

#### EZS_MAIN_STATEMENT 

Permet de modifier l'instruction qui sera utilisée pour exécuter le script demandé. Par défaut,  [delegate] est utilisé 

#### EZS_NSHARDS

Permet de modifier le nombre de documents en mémoire tampon.

Ce paramètre à peu d'influence.

#### EZS_CONCURRENCY

Règle plusieurs traitements, dont la taille de file d'attente des documents à traiter, qui est ensuite traitée en parallèle.

Ce paramètre a peu d'influence, sauf dans le cas de l’usage de l’instruction [exec] et la gestion de processus parallèles.

#### EZS_ENCODING

Permet de modifier l'encodage des données lors d'un échange externe (requête http client/serveur & serveur/client) et interne échange entre threads ou en entre process. Par défaut, Gzip est utilisé pour encoder les données

# Résultats

avec Node version 20, et la configuration par défaut du serveur ezs.

| Date           | Heure        | Documents | Requetes | Script | Statement                                 | NodeJS       | Temps     | CPU (sys) | CPU (usr) |
| -------------- | ------------ | --------- | -------- | ------ | ----------------------------------------- | ------------ | --------- | --------- | --------- |
| **2025-08-31** | **10:06:32** | **1**     | **1**    | **en** | **delegate**                              | **v20.18.2** | **0,92**  | 0,01      | 0,01      |
| *2025-08-31*   | *10:06:49*   | *1*       | *1*      | *pd*   | *delegate*                                | *v20.18.2*   | *1,04*    | 0,01      | 0,01      |
| 2025-08-31     | 10:07:10     | 1         | 1        | sp     | detach?encoder=concat&decoder=transit     | v20.18.2     | 1,05      | 0,01      | 0,00      |
| 2025-08-31     | 10:06:36     | 1         | 1        | en     | detach?encoder=concat&decoder=transit     | v20.18.2     | 1,14      | 0,01      | 0,01      |
| 2025-08-31     | 10:07:06     | 1         | 1        | sp     | delegate                                  | v20.18.2     | 1,16      | 0,01      | 0,00      |
| 2025-08-31     | 10:06:58     | 1         | 1        | px     | delegate                                  | v20.18.2     | 1,18      | 0,01      | 0,00      |
| 2025-08-31     | 10:06:40     | 1         | 1        | pl     | delegate                                  | v20.18.2     | 1,18      | 0,00      | 0,01      |
| **2025-08-31** | **10:07:35** | **10**    | **1**    | **pd** | **delegate**                              | **v20.18.2** | **1,25**  | 0,01      | 0,00      |
| 2025-08-31     | 10:07:02     | 1         | 1        | px     | detach?encoder=concat&decoder=transit     | v20.18.2     | 1,39      | 0,00      | 0,01      |
| **2025-08-31** | **10:08:30** | **20**    | **1**    | **pd** | **delegate**                              | **v20.18.2** | **1,47**  | 0,01      | 0,00      |
| 2025-08-31     | 10:06:53     | 1         | 1        | pd     | detach?encoder=concat&decoder=transit     | v20.18.2     | 1,49      | 0,01      | 0,01      |
| 2025-08-31     | 10:07:14     | 10        | 1        | en     | delegate                                  | v20.18.2     | 1,51      | 0,01      | 0,01      |
| **2025-08-31** | **10:13:49** | **1**     | **10**   | **en** | **delegate**                              | **v20.18.2** | **1,59**  | 0,05      | 0,01      |
| 2025-08-31     | 10:07:39     | 10        | 1        | pd     | detach?encoder=concat&decoder=transit     | v20.18.2     | 1,76      | 0,02      | 0,00      |
| 2025-08-31     | 10:06:44     | 1         | 1        | pl     | detach?encoder=concat&decoder=transit     | v20.18.2     | 1,79      | 0,01      | 0,00      |
| 2025-08-31     | 10:08:35     | 20        | 1        | pd     | detach?encoder=concat&decoder=transit     | v20.18.2     | 2,00      | 0,01      | 0,01      |
| 2025-08-31     | 10:07:19     | 10        | 1        | en     | detach?encoder=concat&decoder=transit     | v20.18.2     | 2,10      | 0,01      | 0,01      |
| 2025-08-31     | 10:07:24     | 10        | 1        | pl     | delegate                                  | v20.18.2     | 2,13      | 0,00      | 0,01      |
| 2025-08-31     | 10:07:56     | 10        | 1        | sp     | delegate                                  | v20.18.2     | 2,17      | 0,01      | 0,01      |
| 2025-08-31     | 10:13:53     | 1         | 10       | en     | detach?encoder=concat&decoder=transit     | v20.18.2     | 2,25      | 0,04      | 0,03      |
| 2025-08-31     | 10:08:07     | 20        | 1        | en     | delegate                                  | v20.18.2     | 2,30      | 0,01      | 0,01      |
| 2025-08-31     | 10:08:01     | 10        | 1        | sp     | detach?encoder=concat&decoder=transit     | v20.18.2     | 2,35      | 0,01      | 0,01      |
| 2025-08-31     | 10:14:29     | 1         | 10       | px     | delegate                                  | v20.18.2     | 2,36      | 0,05      | 0,03      |
| 2025-08-31     | 10:14:41     | 1         | 10       | sp     | delegate                                  | v20.18.2     | 2,43      | 0,05      | 0,03      |
| 2025-08-31     | 10:07:50     | 10        | 1        | px     | detach?encoder=concat&decoder=transit     | v20.18.2     | 2,78      | 0,01      | 0,00      |
| 2025-08-31     | 10:14:35     | 1         | 10       | px     | detach?encoder=concat&decoder=transit     | v20.18.2     | 2,85      | 0,05      | 0,03      |
| 2025-08-31     | 10:14:46     | 1         | 10       | sp     | detach?encoder=concat&decoder=transit     | v20.18.2     | 2,87      | 0,05      | 0,02      |
| 2025-08-31     | 10:07:29     | 10        | 1        | pl     | detach?encoder=concat&decoder=transit     | v20.18.2     | 2,92      | 0,01      | 0,00      |
| 2025-08-31     | 10:08:12     | 20        | 1        | en     | detach?encoder=concat&decoder=transit     | v20.18.2     | 2,94      | 0,01      | 0,01      |
| 2025-08-31     | 10:08:18     | 20        | 1        | pl     | delegate                                  | v20.18.2     | 2,99      | 0,01      | 0,01      |
| 2025-08-31     | 10:08:57     | 20        | 1        | sp     | delegate                                  | v20.18.2     | 2,99      | 0,01      | 0,01      |
| 2025-08-31     | 10:07:44     | 10        | 1        | px     | delegate                                  | v20.18.2     | 3,02      | 0,01      | 0,00      |
| 2025-08-31     | 10:09:03     | 20        | 1        | sp     | detach?encoder=concat&decoder=transit     | v20.18.2     | 3,15      | 0,01      | 0,00      |
| 2025-08-31     | 10:08:24     | 20        | 1        | pl     | detach?encoder=concat&decoder=transit     | v20.18.2     | 3,68      | 0,01      | 0,01      |
| 2025-08-31     | 10:13:59     | 1         | 10       | pl     | delegate                                  | v20.18.2     | 4,07      | 0,03      | 0,03      |
| 2025-08-31     | 10:14:14     | 1         | 10       | pd     | delegate                                  | v20.18.2     | 4,10      | 0,04      | 0,03      |
| 2025-08-31     | 10:14:52     | 10        | 10       | en     | delegate                                  | v20.18.2     | 4,80      | 0,04      | 0,03      |
| 2025-08-31     | 10:14:06     | 1         | 10       | pl     | detach?encoder=concat&decoder=transit     | v20.18.2     | 5,29      | 0,04      | 0,02      |
| 2025-08-31     | 10:14:21     | 1         | 10       | pd     | detach?encoder=concat&decoder=transit     | v20.18.2     | 5,31      | 0,05      | 0,02      |
| 2025-08-31     | 10:08:49     | 20        | 1        | px     | detach?encoder=concat&decoder=transit     | v20.18.2     | 5,31      | 0,01      | 0,00      |
| 2025-08-31     | 10:08:40     | 20        | 1        | px     | delegate                                  | v20.18.2     | 5,67      | 0,00      | 0,01      |
| **2025-08-31** | **10:15:00** | **10**    | **10**   | **en** | **detach?encoder=concat&decoder=transit** | **v20.18.2** | **5,90**  | 0,04      | 0,03      |
| 2025-08-31     | 10:16:21     | 10        | 10       | sp     | delegate                                  | v20.18.2     | 6,34      | 0,04      | 0,03      |
| 2025-08-31     | 10:16:30     | 10        | 10       | sp     | detach?encoder=concat&decoder=transit     | v20.18.2     | 7,10      | 0,05      | 0,03      |
| 2025-08-31     | 10:15:09     | 10        | 10       | pl     | delegate                                  | v20.18.2     | 8,32      | 0,04      | 0,03      |
| 2025-08-31     | 10:15:57     | 10        | 10       | px     | delegate                                  | v20.18.2     | 8,60      | 0,05      | 0,02      |
| **2025-08-31** | **10:16:40** | **20**    | **10**   | **en** | **delegate**                              | **v20.18.2** | **8,67**  | 0,04      | 0,04      |
| 2025-08-31     | 10:15:33     | 10        | 10       | pd     | delegate                                  | v20.18.2     | 8,77      | 0,04      | 0,06      |
| 2025-08-31     | 10:16:09     | 10        | 10       | px     | detach?encoder=concat&decoder=transit     | v20.18.2     | 9,12      | 0,04      | 0,04      |
| 2025-08-31     | 10:15:20     | 10        | 10       | pl     | detach?encoder=concat&decoder=transit     | v20.18.2     | 9,50      | 0,05      | 0,02      |
| 2025-08-31     | 10:16:52     | 20        | 10       | en     | detach?encoder=concat&decoder=transit     | v20.18.2     | 9,55      | 0,05      | 0,03      |
| 2025-08-31     | 10:18:45     | 20        | 10       | sp     | delegate                                  | v20.18.2     | 9,75      | 0,04      | 0,04      |
| 2025-08-31     | 10:15:44     | 10        | 10       | pd     | detach?encoder=concat&decoder=transit     | v20.18.2     | 9,78      | 0,06      | 0,03      |
| 2025-08-31     | 10:18:57     | 20        | 10       | sp     | detach?encoder=concat&decoder=transit     | v20.18.2     | 10,53     | 0,03      | 0,04      |
| 2025-08-31     | 10:17:36     | 20        | 10       | pd     | delegate                                  | v20.18.2     | 11,00     | 0,05      | 0,06      |
| 2025-08-31     | 10:17:05     | 20        | 10       | pl     | delegate                                  | v20.18.2     | 12,03     | 0,06      | 0,03      |
| 2025-08-31     | 10:17:50     | 20        | 10       | pd     | detach?encoder=concat&decoder=transit     | v20.18.2     | 12,07     | 0,06      | 0,03      |
| 2025-08-31     | 10:17:20     | 20        | 10       | pl     | detach?encoder=concat&decoder=transit     | v20.18.2     | 12,93     | 0,06      | 0,02      |
| **2025-08-31** | **10:11:13** | **100**   | **1**    | **pd** | **detach?encoder=concat&decoder=transit** | **v20.18.2** | **15,29** | 0,01      | 0,01      |
| *2025-08-31*   | *10:10:54*   | *100*     | *1*      | *pd*   | *delegate*                                | *v20.18.2*   | *15,43*   | 0,01      | 0,02      |
| 2025-08-31     | 10:18:05     | 20        | 10       | px     | delegate                                  | v20.18.2     | 16,69     | 0,05      | 0,04      |
| 2025-08-31     | 10:18:24     | 20        | 10       | px     | detach?encoder=concat&decoder=transit     | v20.18.2     | 17,10     | 0,04      | 0,06      |
| 2025-08-31     | 10:09:09     | 100       | 1        | en     | delegate                                  | v20.18.2     | 22,66     | 0,01      | 0,03      |
| 2025-08-31     | 10:09:35     | 100       | 1        | en     | detach?encoder=concat&decoder=transit     | v20.18.2     | 22,95     | 0,01      | 0,01      |
| 2025-08-31     | 10:12:56     | 100       | 1        | sp     | delegate                                  | v20.18.2     | 22,98     | 0,01      | 0,01      |
| 2025-08-31     | 10:13:22     | 100       | 1        | sp     | detach?encoder=concat&decoder=transit     | v20.18.2     | 23,32     | 0,01      | 0,02      |
| 2025-08-31     | 10:10:01     | 100       | 1        | pl     | delegate                                  | v20.18.2     | 23,39     | 0,01      | 0,01      |
| 2025-08-31     | 10:10:27     | 100       | 1        | pl     | detach?encoder=concat&decoder=transit     | v20.18.2     | 23,96     | 0,01      | 0,01      |
| 2025-08-31     | 10:12:14     | 100       | 1        | px     | detach?encoder=concat&decoder=transit     | v20.18.2     | 39,74     | 0,01      | 0,01      |
| 2025-08-31     | 10:11:31     | 100       | 1        | px     | delegate                                  | v20.18.2     | 39,81     | 0,01      | 0,01      |
| **2025-08-31** | **10:28:55** | **100**   | **10**   | **pd** | **detach?encoder=concat&decoder=transit** | **v20.18.2** | **89,37** | 0,09      | 0,06      |
| 2025-08-31     | 10:19:11     | 100       | 10       | en     | delegate                                  | v20.18.2     | 99,23     | 0,11      | 0,08      |
| 2025-08-31     | 10:22:57     | 100       | 10       | pl     | delegate                                  | v20.18.2     | 109,17    | 0,07      | 0,12      |
| 2025-08-31     | 10:27:01     | 100       | 10       | pd     | delegate                                  | v20.18.2     | 110,66    | 0,19      | 0,14      |
| 2025-08-31     | 10:20:53     | 100       | 10       | en     | detach?encoder=concat&decoder=transit     | v20.18.2     | 121,03    | 0,07      | 0,08      |
| 2025-08-31     | 10:36:01     | 100       | 10       | sp     | delegate                                  | v20.18.2     | 123,60    | 0,16      | 0,21      |
| 2025-08-31     | 10:38:08     | 100       | 10       | sp     | detach?encoder=concat&decoder=transit     | v20.18.2     | 125,24    | 0,05      | 0,11      |
| 2025-08-31     | 10:24:49     | 100       | 10       | pl     | detach?encoder=concat&decoder=transit     | v20.18.2     | 128,55    | 0,10      | 0,09      |
| 2025-08-31     | 10:30:27     | 100       | 10       | px     | delegate                                  | v20.18.2     | 163,52    | 0,09      | 0,10      |
| 2025-08-31     | 10:33:13     | 100       | 10       | px     | detach?encoder=concat&decoder=transit     | v20.18.2     | 164,62    | 0,09      | 0,07      |





avec Node version 24, et la configuration par défaut du serveur ezs.



...
