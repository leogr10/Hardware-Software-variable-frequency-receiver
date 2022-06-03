## FPGA-FREQ_IN

## PRESENTATION

Bonjour à tous !

Dans le cadre du cours de 'Hardware-Software Platform', nous avons dû réaliser un projet consistant en la programmation d'une FPGA via le logiciel Quartus.
L'objectif était de lire la fréquence d'un signal d'entrée sur une PIN et d'écrire cette valeur dans un registre de 8 bits. Par la suite, nous affichions cette valeur via un terminal.

La partie Hardware du projet a été réalisée via un fichier VHDL et testée via Test Bench. Le langage VHDL est un langage de description de matériel destiné à représenter le comportement ainsi que l'architecture d’un système électronique numérique. Son principal atout réside dans son caractère exécutable : une spécification décrite en VHDL peut être vérifiée par simulation (Test Bench), avant que la conception détaillée ne soit terminée.

La partie Software consiste en 1 fichier C (main.c) et son en-tête/header (hps_0.h) qui se charge d'afficher la valeur codée sur 8 bits à l'écran.

## MATERIEL

* Un tuto vidéo, pour montrer comment connecter la carte, comment programmer la FPGA, pour lire et écrire la valeur d'une fréquence dans un registre + résultats.
* Codes sources utilisés pendant le projet.

## VIDEO

Ce projet a été réalisé à la faculté d'ingénierie de l'UMONS (F.P.Ms) en avril-mai 2022 dans le cadre du cours Hardware-Software Platforms avec le professeur C. Valderamma.

## AUTEURS

Jules Bourgeois : Hardware et Scribe
Léo Grugeon : Software
