# Deploiement Services Docker

## Installation automatique

Fonctionne sous:
* Debian Stretch (Recommandé)
* Debian Jessie
* Fedora 28
* Fedora 27
* Ubuntu

Pour installer automatiquement le stack :
```BASH
bash ./script/launcher.sh
```
*Note: Il faut avoir configuré ses zones DNS avant*

## Configuration DNS 

```
chat.domain.tld	     A	<IP>
git.domain.tld	     A	<IP>
docker.domain.tld    A	<IP>
cloud.domain.tld     A	<IP>
sql.domain.tld	     A	<IP>
blog.domain.tld	     A	<IP>
proxy.domain.tld     A	<IP>
ipa.domain.tld	     A	<IP>
```

## Stack

*Pour l'exemple, le nom de domaine automne.me sera notre domain.tld*

* [Traefik](https://traefik.io/) sur https://proxy.automne.me
* [Portainer](https://www.portainer.io/) sur https://docker.automne.me
* [FreeIPA](https://www.freeipa.org/) sur https://ipa.automne.me
* [RocketChat](https://rocket.chat/) sur https://chat.automne.me
* [OwnCloud](https://owncloud.org/) sur https://cloud.automne.me
* [WordPress](https://fr.wordpress.org/) sur https://blog.automne.me
* [Gitea](https://gitea.io/) sur https://git.automne.me
* [Adminer](https://www.adminer.org/) sur https://sql.automne.me
* [MySQL](https://www.mysql.com)
* [MongoDB](https://www.mongodb.com/)
* [WatchTower](https://github.com/v2tec/watchtower)

## Configuration LDAP

### Configuration générale

| Paramètres  | Valeurs                                 |
|-------------|-----------------------------------------|
| Host        | `ipa`                                   |
| Port        | `389`                                   |
| Chiffrement | `Disable`                               |
| DN          | `cn=users,cn=accounts,dc=automne,dc=me` |
| DN User     | `cn=Directory Manager`                  |
| DN Pass     | `Password IPA .env`                     |
| Champ       | `uid`                                   |


### FreeIPA

1. Connectez vous sur l'IPA.
2. Activez l'authentification par Password.

![Auth par Pasword](https://i.imgur.com/5ejp3FN.png)

3. Sélectionnez le groupe `ipausers`.

![Groupe FreeIPA](https://i.imgur.com/LhRAqgJ.png)

4. Dans les paramètres du groupe définissez-le en groupe POSIX.

![To POSIX](https://i.imgur.com/AG8ZTp6.png)

### WordPress

1. Aller sur le /wp-admin.
2. Cliquer sur Ajouter dans l'onglet Extension.
3. Installer l'extension: [Active Directory Integration / LDAP Integration](https://fr.wordpress.org/plugins/ldap-login-for-intranet-sites/) de miniorange puis activer la.

![MiniOrange](https://i.imgur.com/svdT1hw.png)

4. Dans les paramètres, connecter vous à un compte MiniOrange.
5. Pour la configuration LDAP, remplissez comme ceci:

![enter image description here](https://i.imgur.com/UOWtXh4.png)
![enter image description here](https://i.imgur.com/rqcBOlF.png) 

6. N'oubliez pas d'activer la connexion par LDAP en cochant la première case.

### OwnCloud

1. Connectez vous sur le panel d'administration.
2. Allez dans les extensions désactivées.

![enter image description here](https://i.imgur.com/LfAVxPE.png)

3. Activez `LDAP Integration`.
4. Rafraichissez la page puis cliquer `User Authentification`.
5. Remplissez les champs du LDAP comme ci-dessous.

![LDAP OwnCloud](https://i.imgur.com/rO3SsK5.png)

### RocketChat

1. Dans le panel d'Administration, allez dans la section LDAP.
2. Utilisez les paramètres LDAP de la configuration générale.

### Gitea

1. Connectez vous sur le panel d'administration.
2. Ajouter une nouvelle source d'authentification.

![Gitea Auth](https://i.imgur.com/GioSCro.png)


## Problèmes courants

#### Le compose ne boot pas.

Vérifier que les ports du compose ne sont pas bind.
Liste des ports TCP:
* 80
* 443
* 222
* 53
* 389
* 636
* 88
* 464
* 7389
* 9443
* 9444
* 9445

Liste des ports UDP:
* 53
* 88
* 464
* 123
