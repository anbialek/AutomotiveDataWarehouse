# Automotive Production Data Warehouse

## Objectif du projet
Ce projet présente la création d’un Data Warehouse basé sur un jeu de données artificielles générées à l’aide de Python.

Il illustre l’ensemble du cycle de vie d’un pipeline de données, depuis l’extraction et la transformation des données brutes jusqu’à leur chargement dans PostgreSQL.

L’architecture médallion (couches bronze, silver et gold) a été choisie pour structurer les différentes étapes de traitement et assurer une organisation claire et évolutive des données.

## Technologies utilisées
- Python
- Pandas
- Jupyter Notebook
- Docker
- PostgreSQL
- DBeaver

## Description du dataset

Les jeux de données présentent les informations issues de quatre systèmes typiquement utilisés dans l’industrie automobile : ERP, MES, IoT et QMS.

- **ERP** - informations relatives aux produits (BOM – Bill of Materials), ainsi qu’aux clients (OEM).
- **MES** - données concernant les ordres de production, notamment les work orders, les équipes (shifts), les lignes de production ainsi que l’exécution du plan de production.
- **IoT** -  paramètres de processus collectés à partir de capteurs mesurant la température, l’humidité, la pression et le débit (flow rate).
- **QMS** - résultats des inspections qualité ainsi que le catalogue des défauts.

Le processus de génération de ces jeux de données est présenté dans le notebook *01_generate_data*.
Toutes les données sont fictives et représentent des entreprises inexistantes.

## Étapes réalisées

- Création de la base de données (**Automotive Data Warehouse**).
- Définition de l’architecture médallion (couches bronze, silver et gold).
- Chargement initial des données dans la couche bronze.
- Nettoyage, transformation et validation des données dans la couche silver
- Conception et implémentation du schéma en étoile dans la couche gold.

## Instructions pour exécuter le notebook

1. Cloner le repo :
```bash
git clone https://github.com/anbialek/AutomotiveDataWarehouse.git
```
2. Installer les dépendances :
```bash
pip install -r requirements.txt
```
3. Ouvrir les notebooks Jupyter nécessaires :
```bash
jupyter notebook
```

## Instructions pour exécuter les scripts SQL

PostgreSQL est déployé via Docker.
La connexion est réalisée via DBeaver avec les paramètres standard (host, port, database, user, password).


### 🇬🇧 Summary (for non-French readers)

This project simulates an ETL process and data warehouse design based on a simulated automotive production data from the systems such as ERP, MES, IOT, and QMS, covering:
- Artificial data generation using Python in Jupyter Notebook.
- Definition of the Medallion Architecture (bronze, silver, and gold layers).
- Data  Warehouse creation, using PostgreSQL.
- Initial loading of raw data into the bronze layer.
- Data cleaning, transformation and validation in the silver layer.
- Creation of analytical views in the gold layer based on transformed tables.

