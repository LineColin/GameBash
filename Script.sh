#!/bin/bash

# Définir une fonction qui simule une session bash limitée

function bash_simulator {
    local cmd
    while true; do
        echo -n "$PWD> "
        read cmd
        case $cmd in
	    touch*)
                # Extraire le nom du fichier à créer
                filename=$(echo $cmd | cut -d' ' -f2)
                touch $filename 2>/dev/null
                if [ $? -ne 0 ]; then
                    echo "Erreur lors de la création du fichier."
                fi
                ;;
            vi*)
                # Lancer vi (ou vim) pour éditer le fichier spécifié
                filename=$(echo $cmd | cut -d' ' -f2)
                vi $filename
                ;;
            ls*)
                if [[ $cmd == "ls -a" ]]; then
                    ls -a
                else
                    ls
                fi
                ;;
            pwd)
                pwd
                ;;
            cd*)
                path=$(echo $cmd | cut -d' ' -f2)
                cd $path 2>/dev/null
                if [ $? -ne 0 ]; then
                    echo "Répertoire non trouvé."
                fi
                ;;
            mkdir*)
                dir_name=$(echo $cmd | cut -d' ' -f2)
                mkdir $dir_name 2>/dev/null
                if [ $? -ne 0 ]; then
                    echo "Erreur lors de la création du répertoire."
                fi
                ;;
            cp*|mv*)
                # Détecter l'opération (cp ou mv)
                operation=$(echo $cmd | awk '{print $1}')
                src=$(echo $cmd | awk '{print $2}')
                dest=$(echo $cmd | awk '{print $3}')
                $operation "$src" "$dest" 2>/dev/null
                if [ $? -ne 0 ]; then
                    echo "Erreur lors de la tentative de $operation du fichier."
                fi
                ;;
            "check")
                break
                ;;
            *)
                echo "Commande non reconnue. Seules les commandes 'ls', 'cd', 'pwd', 'mkdir', 'cp', et 'mv' sont autorisées."
                ;;
        esac
    done
}


score=0

cat Legend.txt

cd Monde

mission_reussie=false

while [ "$mission_reussie" != true ]; do
    bash_simulator

    # Vérifier si le joueur est dans le bon répertoire
    if [ -e epreuve.txt ]; then
        echo "Félicitations! Vous avez réussi la mission."
        cat epreuve.txt
        mission_reussie=true
    else
        echo "Mission échouée. Essayez à nouveau."
    fi
done

mission_reussie=false


while [ "$mission_reussie" != true ]; do
    bash_simulator

    # Vérifier si le joueur est dans le bon répertoire
    if [ -e epee_legendaire.txt ]; then
        cat monstre.txt
        read reponse

        # Vérifie la réponse
        if [ "$reponse" == "rm" ]; then
            # Si la réponse est correcte et que le fichier cible existe
            # (Ici, j'ai supposé que vous vouliez vérifier l'existence de epee_legendaire.txt comme fichier cible)
            if [ -e epee_legendaire.txt ]; then
		
               cat epee_legendaire.txt
	       mission_reussie=true
            else
                echo "L'épée a disparu de la forêt. Un.e héros.ine est passé avant vous..."
            fi
        else
            echo "Mauvaise réponse. Retentez votre chance héros.ine."
        fi
    else
        echo "Mission échouée. Essayez à nouveau."
    fi
done

mission_reussie=false

while [ "$mission_reussie" != true ]; do
    bash_simulator

    # Vérifier si le joueur est dans le bon répertoire
    if [ -e epee_legendaire.txt ] && [ -e garde.txt ]; then
        cat garde.txt
        mission_reussie=true
    else
        echo "Mission échouée. Essayez à nouveau."
    fi
done

mission_reussie=false

while [ "$mission_reussie" != true ]; do
    bash_simulator

    # Vérifier si le joueur est dans le bon répertoire
    if [ -e tresor.txt ]; then
        cat tresor.txt
        mission_reussie=true
    else
        echo "Mission échouée. Essayez à nouveau."
    fi
done


mission_reussie=false

while [ "$mission_reussie" != true ]; do
    bash_simulator
    # Vérifier si le joueur est dans le bon répertoire
    if [ -e legende.txt  ]; then
        cat herosines.txt
        mission_reussie=true
    else
        echo "Mission échouée. Essayez à nouveau."
    fi
done

mission_reussie=false

while [ "$mission_reussie" != true ]; do
    bash_simulator
    # Vérifier si le joueur est dans le bon répertoire
    if [ -d "./Porte" ]; then
        cat door.txt
        mission_reussie=true
    else
        echo "Mission échouée. Essayez à nouveau."
    fi
done



