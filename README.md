

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

## avec Node version 20, et la configuration par défaut du serveur ezs.

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





## avec Node version 24, et la configuration par défaut du serveur ezs.

| Date           | Heure        | Documents | Requetes | Script | Statement                             | NodeJS      | Temps      | CPU (sys) | CPU (usr) |
| -------------- | ------------ | --------- | -------- | ------ | ------------------------------------- | ----------- | ---------- | --------- | --------- |
| **2025-09-01** | **11:03:40** | **1**     | **1**    | **en** | **delegate**                          | **v24.6.0** | **0,876**  | 0,003     | 0,01      |
| 2025-09-01     | 11:03:44     | 1         | 1        | en     | detach?encoder=concat&decoder=transit | v24.6.0     | 1,192      | 0,008     | 0,007     |
| 2025-09-01     | 11:04:17     | 1         | 1        | sp     | delegate                              | v24.6.0     | 1,24       | 0,009     | 0,005     |
| 2025-09-01     | 11:04:08     | 1         | 1        | px     | delegate                              | v24.6.0     | 1,244      | 0,009     | 0,005     |
| 2025-09-01     | 11:03:59     | 1         | 1        | pd     | delegate                              | v24.6.0     | 1,506      | 0,009     | 0,005     |
| 2025-09-01     | 11:04:21     | 1         | 1        | sp     | detach?encoder=concat&decoder=transit | v24.6.0     | 1,536      | 0,008     | 0,006     |
| 2025-09-01     | 11:04:13     | 1         | 1        | px     | detach?encoder=concat&decoder=transit | v24.6.0     | 1,549      | 0,009     | 0,005     |
| **2025-09-01** | **11:04:52** | **10**    | **1**    | **pd** | **delegate**                          | **v24.6.0** | **1,695**  | 0,01      | 0,006     |
| 2025-09-01     | 11:04:04     | 1         | 1        | pd     | detach?encoder=concat&decoder=transit | v24.6.0     | 1,711      | 0,007     | 0,01      |
| 2025-09-01     | 11:04:57     | 10        | 1        | pd     | detach?encoder=concat&decoder=transit | v24.6.0     | 2,049      | 0,004     | 0,011     |
| 2025-09-01     | 11:03:49     | 1         | 1        | pl     | delegate                              | v24.6.0     | 2,087      | 0,008     | 0,007     |
| **2025-09-01** | **11:06:02** | **20**    | **1**    | **pd** | **delegate**                          | **v24.6.0** | **2,118**  | 0,003     | 0,011     |
| 2025-09-01     | 11:03:54     | 1         | 1        | pl     | detach?encoder=concat&decoder=transit | v24.6.0     | 2,417      | 0,009     | 0,005     |
| 2025-09-01     | 11:06:07     | 20        | 1        | pd     | detach?encoder=concat&decoder=transit | v24.6.0     | 2,51       | 0,008     | 0,006     |
| 2025-09-01     | 11:04:26     | 10        | 1        | en     | delegate                              | v24.6.0     | 2,63       | 0,008     | 0,008     |
| **2025-09-01** | **11:14:32** | **1**     | **10**   | **en** | **delegate**                          | **v24.6.0** | **2,659**  | 0,057     | 0,04      |
| 2025-09-01     | 11:04:32     | 10        | 1        | en     | detach?encoder=concat&decoder=transit | v24.6.0     | 2,987      | 0,009     | 0,009     |
| 2025-09-01     | 11:05:23     | 10        | 1        | sp     | detach?encoder=concat&decoder=transit | v24.6.0     | 3,375      | 0,014     | 0,001     |
| 2025-09-01     | 11:05:17     | 10        | 1        | sp     | delegate                              | v24.6.0     | 3,46       | 0,002     | 0,012     |
| 2025-09-01     | 11:14:38     | 1         | 10       | en     | detach?encoder=concat&decoder=transit | v24.6.0     | 3,852      | 0,079     | 0,027     |
| 2025-09-01     | 11:04:38     | 10        | 1        | pl     | delegate                              | v24.6.0     | 4,087      | 0,009     | 0,013     |
| 2025-09-01     | 11:15:26     | 1         | 10       | px     | delegate                              | v24.6.0     | 4,189      | 0,05      | 0,055     |
| 2025-09-01     | 11:15:41     | 1         | 10       | sp     | delegate                              | v24.6.0     | 4,198      | 0,049     | 0,034     |
| 2025-09-01     | 11:05:30     | 20        | 1        | en     | delegate                              | v24.6.0     | 4,215      | 0,013     | 0,003     |
| 2025-09-01     | 11:05:02     | 10        | 1        | px     | delegate                              | v24.6.0     | 4,253      | 0,006     | 0,009     |
| 2025-09-01     | 11:04:45     | 10        | 1        | pl     | detach?encoder=concat&decoder=transit | v24.6.0     | 4,422      | 0,01      | 0,006     |
| 2025-09-01     | 11:05:37     | 20        | 1        | en     | detach?encoder=concat&decoder=transit | v24.6.0     | 4,546      | 0,009     | 0,006     |
| 2025-09-01     | 11:05:09     | 10        | 1        | px     | detach?encoder=concat&decoder=transit | v24.6.0     | 4,6        | 0,007     | 0,01      |
| 2025-09-01     | 11:06:36     | 20        | 1        | sp     | delegate                              | v24.6.0     | 4,649      | 0,012     | 0,007     |
| 2025-09-01     | 11:06:44     | 20        | 1        | sp     | detach?encoder=concat&decoder=transit | v24.6.0     | 4,977      | 0,018     | 0         |
| 2025-09-01     | 11:15:33     | 1         | 10       | px     | detach?encoder=concat&decoder=transit | v24.6.0     | 5,078      | 0,078     | 0,014     |
| 2025-09-01     | 11:15:48     | 1         | 10       | sp     | detach?encoder=concat&decoder=transit | v24.6.0     | 5,132      | 0,066     | 0,023     |
| 2025-09-01     | 11:05:44     | 20        | 1        | pl     | delegate                              | v24.6.0     | 5,702      | 0,009     | 0,008     |
| 2025-09-01     | 11:05:53     | 20        | 1        | pl     | detach?encoder=concat&decoder=transit | v24.6.0     | 6,09       | 0,008     | 0,005     |
| 2025-09-01     | 11:15:06     | 1         | 10       | pd     | delegate                              | v24.6.0     | 6,426      | 0,059     | 0,03      |
| 2025-09-01     | 11:14:45     | 1         | 10       | pl     | delegate                              | v24.6.0     | 6,623      | 0,067     | 0,023     |
| 2025-09-01     | 11:15:15     | 1         | 10       | pd     | detach?encoder=concat&decoder=transit | v24.6.0     | 7,694      | 0,061     | 0,032     |
| 2025-09-01     | 11:14:55     | 1         | 10       | pl     | detach?encoder=concat&decoder=transit | v24.6.0     | 7,955      | 0,075     | 0,013     |
| **2025-09-01** | **11:15:56** | **10**    | **10**   | **en** | **delegate**                          | **v24.6.0** | **8,253**  | 0,047     | 0,049     |
| 2025-09-01     | 11:06:25     | 20        | 1        | px     | detach?encoder=concat&decoder=transit | v24.6.0     | 8,485      | 0,003     | 0,011     |
| 2025-09-01     | 11:06:13     | 20        | 1        | px     | delegate                              | v24.6.0     | 8,744      | 0,008     | 0,008     |
| 2025-09-01     | 11:16:08     | 10        | 10       | en     | detach?encoder=concat&decoder=transit | v24.6.0     | 9,37       | 0,063     | 0,034     |
| 2025-09-01     | 11:16:53     | 10        | 10       | pd     | delegate                              | v24.6.0     | 9,496      | 0,061     | 0,044     |
| 2025-09-01     | 11:17:52     | 10        | 10       | sp     | delegate                              | v24.6.0     | 9,577      | 0,064     | 0,033     |
| 2025-09-01     | 11:18:04     | 10        | 10       | sp     | detach?encoder=concat&decoder=transit | v24.6.0     | 10,747     | 0,07      | 0,03      |
| 2025-09-01     | 11:17:05     | 10        | 10       | pd     | detach?encoder=concat&decoder=transit | v24.6.0     | 11,06      | 0,072     | 0,032     |
| 2025-09-01     | 11:17:19     | 10        | 10       | px     | delegate                              | v24.6.0     | 12,684     | 0,051     | 0,051     |
| 2025-09-01     | 11:16:20     | 10        | 10       | pl     | delegate                              | v24.6.0     | 12,705     | 0,054     | 0,047     |
| **2025-09-01** | **11:18:18** | **20**    | **10**   | **en** | **delegate**                          | **v24.6.0** | **12,871** | 0,047     | 0,066     |
| 2025-09-01     | 11:17:35     | 10        | 10       | px     | detach?encoder=concat&decoder=transit | v24.6.0     | 13,487     | 0,064     | 0,042     |
| 2025-09-01     | 11:16:36     | 10        | 10       | pl     | detach?encoder=concat&decoder=transit | v24.6.0     | 14,054     | 0,062     | 0,039     |
| 2025-09-01     | 11:21:04     | 20        | 10       | sp     | delegate                              | v24.6.0     | 14,211     | 0,062     | 0,049     |
| 2025-09-01     | 11:18:34     | 20        | 10       | en     | detach?encoder=concat&decoder=transit | v24.6.0     | 14,253     | 0,058     | 0,046     |
| 2025-09-01     | 11:19:34     | 20        | 10       | pd     | delegate                              | v24.6.0     | 14,483     | 0,054     | 0,065     |
| 2025-09-01     | 11:21:21     | 20        | 10       | sp     | detach?encoder=concat&decoder=transit | v24.6.0     | 15,422     | 0,07      | 0,036     |
| 2025-09-01     | 11:19:51     | 20        | 10       | pd     | detach?encoder=concat&decoder=transit | v24.6.0     | 16,253     | 0,053     | 0,047     |
| 2025-09-01     | 11:18:51     | 20        | 10       | pl     | delegate                              | v24.6.0     | 17,661     | 0,061     | 0,049     |
| 2025-09-01     | 11:19:12     | 20        | 10       | pl     | detach?encoder=concat&decoder=transit | v24.6.0     | 18,871     | 0,062     | 0,05      |
| 2025-09-01     | 11:20:10     | 20        | 10       | px     | delegate                              | v24.6.0     | 23,285     | 0,074     | 0,032     |
| 2025-09-01     | 11:20:37     | 20        | 10       | px     | detach?encoder=concat&decoder=transit | v24.6.0     | 23,852     | 0,064     | 0,045     |
| **2025-09-01** | **11:09:55** | **100**   | **1**    | **pd** | **delegate**                          | **v24.6.0** | **24,752** | 0,006     | 0,024     |
| 2025-09-01     | 11:10:22     | 100       | 1        | pd     | detach?encoder=concat&decoder=transit | v24.6.0     | 25,345     | 0,018     | 0,004     |
| 2025-09-01     | 11:06:52     | 100       | 1        | en     | delegate                              | v24.6.0     | 40,515     | 0,008     | 0,021     |
| 2025-09-01     | 11:07:35     | 100       | 1        | en     | detach?encoder=concat&decoder=transit | v24.6.0     | 40,667     | 0,023     | 0         |
| 2025-09-01     | 11:13:48     | 100       | 1        | sp     | detach?encoder=concat&decoder=transit | v24.6.0     | 41,51      | 0,022     | 0,009     |
| 2025-09-01     | 11:13:03     | 100       | 1        | sp     | delegate                              | v24.6.0     | 41,939     | 0,014     | 0,014     |
| 2025-09-01     | 11:09:08     | 100       | 1        | pl     | detach?encoder=concat&decoder=transit | v24.6.0     | 43,729     | 0,017     | 0,007     |
| 2025-09-01     | 11:08:19     | 100       | 1        | pl     | delegate                              | v24.6.0     | 45,759     | 0,018     | 0,01      |
| 2025-09-01     | 11:11:57     | 100       | 1        | px     | detach?encoder=concat&decoder=transit | v24.6.0     | 62,865     | 0,019     | 0,005     |
| 2025-09-01     | 11:10:51     | 100       | 1        | px     | delegate                              | v24.6.0     | 63,383     | 0,007     | 0,022     |
| **2025-09-01** | **11:31:16** | **100**   | **10**   | **pd** | **delegate**                          | **v24.6.0** | **94,55**  | 0,133     | 0,121     |
| 2025-09-01     | 11:32:54     | 100       | 10       | pd     | detach?encoder=concat&decoder=transit | v24.6.0     | 96,228     | 0,085     | 0,116     |
| 2025-09-01     | 11:24:05     | 100       | 10       | en     | detach?encoder=concat&decoder=transit | v24.6.0     | 132,77     | 0,101     | 0,097     |
| 2025-09-01     | 11:40:47     | 100       | 10       | sp     | delegate                              | v24.6.0     | 133,156    | 0,097     | 0,131     |
| 2025-09-01     | 11:43:03     | 100       | 10       | sp     | detach?encoder=concat&decoder=transit | v24.6.0     | 134,993    | 0,125     | 0,073     |
| 2025-09-01     | 11:21:39     | 100       | 10       | en     | delegate                              | v24.6.0     | 142,591    | 0,123     | 0,132     |
| 2025-09-01     | 11:28:50     | 100       | 10       | pl     | detach?encoder=concat&decoder=transit | v24.6.0     | 143,303    | 0,122     | 0,102     |
| 2025-09-01     | 11:26:21     | 100       | 10       | pl     | delegate                              | v24.6.0     | 146,302    | 0,171     | 0,078     |
| 2025-09-01     | 11:34:33     | 100       | 10       | px     | delegate                              | v24.6.0     | 183,371    | 0,116     | 0,122     |
| 2025-09-01     | 11:37:39     | 100       | 10       | px     | detach?encoder=concat&decoder=transit | v24.6.0     | 184,177    | 0,119     | 0,096     |

## avec Node version 24, et une configuration spécifique du serveur ezs.

EZS_ENCODING=none

| Date           | Heure        | Documents | Requetes | Script | Statement                             | NodeJS      | Temps      | CPU (sys) | CPU (usr) |
| -------------- | ------------ | --------- | -------- | ------ | ------------------------------------- | ----------- | ---------- | --------- | --------- |
| **2025-09-01** | **12:28:07** | **1**     | **1**    | **en** | **delegate**                          | **v24.6.0** | **0,52**   | 0,004     | 0,007     |
| 2025-09-01     | 12:28:10     | 1         | 1        | en     | detach?encoder=concat&decoder=transit | v24.6.0     | 0,694      | 0,009     | 0,005     |
| 2025-09-01     | 12:28:23     | 1         | 1        | pd     | delegate                              | v24.6.0     | 0,913      | 0,007     | 0,007     |
| **2025-09-01** | **12:29:09** | **10**    | **1**    | **pd** | **delegate**                          | **v24.6.0** | **1,129**  | 0,011     | 0,002     |
| 2025-09-01     | 12:28:14     | 1         | 1        | pl     | delegate                              | v24.6.0     | 1,16       | 0,011     | 0         |
| 2025-09-01     | 12:28:40     | 1         | 1        | sp     | delegate                              | v24.6.0     | 1,168      | 0,012     | 0,002     |
| 2025-09-01     | 12:28:31     | 1         | 1        | px     | delegate                              | v24.6.0     | 1,171      | 0,002     | 0,01      |
| 2025-09-01     | 12:28:44     | 1         | 1        | sp     | detach?encoder=concat&decoder=transit | v24.6.0     | 1,319      | 0,007     | 0,007     |
| 2025-09-01     | 12:28:35     | 1         | 1        | px     | detach?encoder=concat&decoder=transit | v24.6.0     | 1,358      | 0,007     | 0,005     |
| **2025-09-01** | **12:30:03** | **20**    | **1**    | **pd** | **delegate**                          | **v24.6.0** | **1,362**  | 0,004     | 0,009     |
| 2025-09-01     | 12:28:27     | 1         | 1        | pd     | detach?encoder=concat&decoder=transit | v24.6.0     | 1,43       | 0,01      | 0,005     |
| 2025-09-01     | 12:28:48     | 10        | 1        | en     | delegate                              | v24.6.0     | 1,493      | 0,012     | 0,002     |
| **2025-09-01** | **12:35:01** | **1**     | **10**   | **en** | **delegate**                          | **v24.6.0** | **1,61**   | 0,046     | 0,037     |
| 2025-09-01     | 12:29:13     | 10        | 1        | pd     | detach?encoder=concat&decoder=transit | v24.6.0     | 1,689      | 0,012     | 0         |
| 2025-09-01     | 12:28:18     | 1         | 1        | pl     | detach?encoder=concat&decoder=transit | v24.6.0     | 1,769      | 0,008     | 0,004     |
| 2025-09-01     | 12:30:07     | 20        | 1        | pd     | detach?encoder=concat&decoder=transit | v24.6.0     | 1,925      | 0,008     | 0,007     |
| 2025-09-01     | 12:28:53     | 10        | 1        | en     | detach?encoder=concat&decoder=transit | v24.6.0     | 2,016      | 0,01      | 0,003     |
| 2025-09-01     | 12:29:29     | 10        | 1        | sp     | delegate                              | v24.6.0     | 2,085      | 0,013     | 0         |
| 2025-09-01     | 12:28:58     | 10        | 1        | pl     | delegate                              | v24.6.0     | 2,111      | 0,009     | 0,005     |
| 2025-09-01     | 12:29:39     | 20        | 1        | en     | delegate                              | v24.6.0     | 2,198      | 0,015     | 0         |
| 2025-09-01     | 12:29:23     | 10        | 1        | px     | detach?encoder=concat&decoder=transit | v24.6.0     | 2,274      | 0,004     | 0,009     |
| 2025-09-01     | 12:29:34     | 10        | 1        | sp     | detach?encoder=concat&decoder=transit | v24.6.0     | 2,28       | 0,015     | 0,002     |
| 2025-09-01     | 12:35:05     | 1         | 10       | en     | detach?encoder=concat&decoder=transit | v24.6.0     | 2,287      | 0,062     | 0,03      |
| 2025-09-01     | 12:35:56     | 1         | 10       | sp     | delegate                              | v24.6.0     | 2,471      | 0,064     | 0,012     |
| 2025-09-01     | 12:35:44     | 1         | 10       | px     | delegate                              | v24.6.0     | 2,476      | 0,033     | 0,035     |
| 2025-09-01     | 12:30:33     | 20        | 1        | sp     | detach?encoder=concat&decoder=transit | v24.6.0     | 2,531      | 0,011     | 0,003     |
| 2025-09-01     | 12:29:44     | 20        | 1        | en     | detach?encoder=concat&decoder=transit | v24.6.0     | 2,758      | 0,009     | 0,006     |
| 2025-09-01     | 12:29:03     | 10        | 1        | pl     | detach?encoder=concat&decoder=transit | v24.6.0     | 2,771      | 0,012     | 0,004     |
| 2025-09-01     | 12:30:27     | 20        | 1        | sp     | delegate                              | v24.6.0     | 2,828      | 0,002     | 0,011     |
| 2025-09-01     | 12:29:18     | 10        | 1        | px     | delegate                              | v24.6.0     | 2,875      | 0,004     | 0,004     |
| 2025-09-01     | 12:35:50     | 1         | 10       | px     | detach?encoder=concat&decoder=transit | v24.6.0     | 2,965      | 0,076     | 0,023     |
| 2025-09-01     | 12:29:50     | 20        | 1        | pl     | delegate                              | v24.6.0     | 2,98       | 0,003     | 0,011     |
| 2025-09-01     | 12:36:01     | 1         | 10       | sp     | detach?encoder=concat&decoder=transit | v24.6.0     | 3,286      | 0,044     | 0,049     |
| 2025-09-01     | 12:29:56     | 20        | 1        | pl     | detach?encoder=concat&decoder=transit | v24.6.0     | 3,582      | 0,01      | 0,007     |
| 2025-09-01     | 12:30:20     | 20        | 1        | px     | detach?encoder=concat&decoder=transit | v24.6.0     | 3,852      | 0,004     | 0,005     |
| 2025-09-01     | 12:35:11     | 1         | 10       | pl     | delegate                              | v24.6.0     | 3,967      | 0,021     | 0,041     |
| 2025-09-01     | 12:35:18     | 1         | 10       | pl     | detach?encoder=concat&decoder=transit | v24.6.0     | 4,857      | 0,036     | 0,02      |
| 2025-09-01     | 12:30:12     | 20        | 1        | px     | delegate                              | v24.6.0     | 5,29       | 0,007     | 0,007     |
| 2025-09-01     | 12:35:26     | 1         | 10       | pd     | delegate                              | v24.6.0     | 5,504      | 0,045     | 0,026     |
| **2025-09-01** | **12:36:08** | **10**    | **10**   | **en** | **delegate**                          | **v24.6.0** | **5,873**  | 0,038     | 0,028     |
| 2025-09-01     | 12:36:16     | 10        | 10       | en     | detach?encoder=concat&decoder=transit | v24.6.0     | 6,26       | 0,051     | 0,044     |
| 2025-09-01     | 12:37:41     | 10        | 10       | sp     | delegate                              | v24.6.0     | 6,383      | 0,059     | 0,013     |
| 2025-09-01     | 12:37:51     | 10        | 10       | sp     | detach?encoder=concat&decoder=transit | v24.6.0     | 7,082      | 0,058     | 0,026     |
| 2025-09-01     | 12:35:34     | 1         | 10       | pd     | detach?encoder=concat&decoder=transit | v24.6.0     | 7,255      | 0,043     | 0,035     |
| 2025-09-01     | 12:36:26     | 10        | 10       | pl     | delegate                              | v24.6.0     | 8,47       | 0,029     | 0,049     |
| 2025-09-01     | 12:37:17     | 10        | 10       | px     | delegate                              | v24.6.0     | 8,614      | 0,047     | 0,027     |
| **2025-09-01** | **12:38:01** | **20**    | **10**   | **en** | **delegate**                          | **v24.6.0** | **9,414**  | 0,057     | 0,032     |
| 2025-09-01     | 12:40:08     | 20        | 10       | sp     | delegate                              | v24.6.0     | 9,422      | 0,052     | 0,029     |
| 2025-09-01     | 12:38:13     | 20        | 10       | en     | detach?encoder=concat&decoder=transit | v24.6.0     | 9,745      | 0,071     | 0,033     |
| 2025-09-01     | 12:36:51     | 10        | 10       | pd     | delegate                              | v24.6.0     | 9,954      | 0,064     | 0,053     |
| 2025-09-01     | 12:37:28     | 10        | 10       | px     | detach?encoder=concat&decoder=transit | v24.6.0     | 10,021     | 0,046     | 0,044     |
| 2025-09-01     | 12:40:21     | 20        | 10       | sp     | detach?encoder=concat&decoder=transit | v24.6.0     | 10,189     | 0,053     | 0,028     |
| 2025-09-01     | 12:37:04     | 10        | 10       | pd     | detach?encoder=concat&decoder=transit | v24.6.0     | 10,24      | 0,055     | 0,033     |
| 2025-09-01     | 12:36:37     | 10        | 10       | pl     | detach?encoder=concat&decoder=transit | v24.6.0     | 10,315     | 0,045     | 0,039     |
| 2025-09-01     | 12:38:26     | 20        | 10       | pl     | delegate                              | v24.6.0     | 11,908     | 0,048     | 0,038     |
| 2025-09-01     | 12:38:58     | 20        | 10       | pd     | delegate                              | v24.6.0     | 12,695     | 0,068     | 0,053     |
| 2025-09-01     | 12:39:13     | 20        | 10       | pd     | detach?encoder=concat&decoder=transit | v24.6.0     | 12,778     | 0,052     | 0,044     |
| **2025-09-01** | **12:32:20** | **100**   | **1**    | **pd** | **delegate**                          | **v24.6.0** | **12,889** | 0,02      | 0,006     |
| 2025-09-01     | 12:32:36     | 100       | 1        | pd     | detach?encoder=concat&decoder=transit | v24.6.0     | 13,389     | 0,01      | 0,013     |
| 2025-09-01     | 12:38:41     | 20        | 10       | pl     | detach?encoder=concat&decoder=transit | v24.6.0     | 13,567     | 0,05      | 0,034     |
| 2025-09-01     | 12:39:49     | 20        | 10       | px     | detach?encoder=concat&decoder=transit | v24.6.0     | 16,437     | 0,068     | 0,03      |
| 2025-09-01     | 12:39:29     | 20        | 10       | px     | delegate                              | v24.6.0     | 16,746     | 0,05      | 0,037     |
| 2025-09-01     | 12:30:39     | 100       | 1        | en     | delegate                              | v24.6.0     | 20,555     | 0,02      | 0         |
| 2025-09-01     | 12:31:02     | 100       | 1        | en     | detach?encoder=concat&decoder=transit | v24.6.0     | 20,983     | 0,007     | 0,01      |
| 2025-09-01     | 12:34:10     | 100       | 1        | sp     | delegate                              | v24.6.0     | 21,31      | 0,009     | 0,011     |
| 2025-09-01     | 12:34:35     | 100       | 1        | sp     | detach?encoder=concat&decoder=transit | v24.6.0     | 22,899     | 0,011     | 0,007     |
| 2025-09-01     | 12:31:26     | 100       | 1        | pl     | delegate                              | v24.6.0     | 23,583     | 0,012     | 0,011     |
| 2025-09-01     | 12:31:53     | 100       | 1        | pl     | detach?encoder=concat&decoder=transit | v24.6.0     | 24,095     | 0,011     | 0,011     |
| 2025-09-01     | 12:33:32     | 100       | 1        | px     | detach?encoder=concat&decoder=transit | v24.6.0     | 34,972     | 0,017     | 0,009     |
| 2025-09-01     | 12:32:52     | 100       | 1        | px     | delegate                              | v24.6.0     | 37,352     | 0,002     | 0,015     |
| **2025-09-01** | **12:47:08** | **100**   | **10**   | **pd** | **delegate**                          | **v24.6.0** | **78,244** | 0,105     | 0,126     |
| 2025-09-01     | 12:48:29     | 100       | 10       | pd     | detach?encoder=concat&decoder=transit | v24.6.0     | 80,557     | 0,071     | 0,116     |
| 2025-09-01     | 12:40:34     | 100       | 10       | en     | delegate                              | v24.6.0     | 88,768     | 0,108     | 0,108     |
| 2025-09-01     | 12:54:17     | 100       | 10       | sp     | delegate                              | v24.6.0     | 91,963     | 0,089     | 0,123     |
| 2025-09-01     | 12:42:06     | 100       | 10       | en     | detach?encoder=concat&decoder=transit | v24.6.0     | 92,867     | 0,06      | 0,087     |
| 2025-09-01     | 12:55:52     | 100       | 10       | sp     | detach?encoder=concat&decoder=transit | v24.6.0     | 95,079     | 0,097     | 0,088     |
| 2025-09-01     | 12:43:42     | 100       | 10       | pl     | delegate                              | v24.6.0     | 99,893     | 0,112     | 0,113     |
| 2025-09-01     | 12:45:25     | 100       | 10       | pl     | detach?encoder=concat&decoder=transit | v24.6.0     | 100,074    | 0,087     | 0,067     |
| 2025-09-01     | 12:49:52     | 100       | 10       | px     | delegate                              | v24.6.0     | 127,749    | 0,084     | 0,074     |
| 2025-09-01     | 12:52:03     | 100       | 10       | px     | detach?encoder=concat&decoder=transit | v24.6.0     | 130,44     | 0,065     | 0,094     |
