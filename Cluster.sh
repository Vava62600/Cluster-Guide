#!/bin/bash

# Fonction pour afficher le menu
show_menu() {
    echo "======================"
    echo " Cluster Setup Script "
    echo "======================"
    echo "1. Cluster de Calcul"
    echo "2. Cluster de Stockage"
    echo "3. Gestion du Cluster avec UI (Cockpit, Kubernetes Dashboard, Grafana)"
    echo "4. Gestion du Cluster avec CLI (kubectl, ceph, scontrol)"
    echo "5. Quitter"
    echo "======================"
    echo -n "Sélectionnez une option [1-5]: "
}

# Fonction pour installer un cluster de calcul
setup_computing_cluster() {
    echo "Configuration du Cluster de Calcul..."
    sudo apt-get update
    sudo apt-get install -y openmpi-bin openmpi-common libopenmpi-dev
    echo "Cluster de calcul configuré."
}

# Fonction pour installer un cluster de stockage
setup_storage_cluster() {
    echo "Configuration du Cluster de Stockage..."
    sudo apt-get update
    sudo apt-get install -y ceph ceph-mds ceph-mon ceph-osd
    echo "Cluster de stockage configuré."
}

# Fonction pour installer des outils de gestion avec UI
setup_gui_tools() {
    echo "Installation des outils de gestion avec UI..."
    sudo apt-get update
    
    # Installer Cockpit
    sudo apt-get install -y cockpit
    sudo systemctl start cockpit
    echo "Cockpit installé. Accès via http://<IP_du_serveur>:9090"

    # Installer Kubernetes Dashboard
    sudo apt-get install -y kubectl
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
    echo "Kubernetes Dashboard installé. Utilisez 'kubectl proxy' pour y accéder."

    # Installer Grafana
    sudo apt-get install -y grafana
    sudo systemctl start grafana-server
    echo "Grafana installé. Accès via http://<IP_du_serveur>:3000"
}

# Fonction pour installer des outils de gestion avec CLI
setup_cli_tools() {
    echo "Installation des outils de gestion avec CLI..."
    sudo apt-get update
    
    # Installer kubectl
    sudo apt-get install -y kubectl
    echo "kubectl installé. Utilisez 'kubectl' pour gérer les clusters Kubernetes."

    # Installer les outils CLI pour Ceph
    sudo apt-get install -y ceph
    echo "Ceph CLI installé. Utilisez 'ceph' pour gérer les clusters Ceph."

    # Installer les outils CLI pour SLURM
    sudo apt-get install -y slurm-wlm
    echo "SLURM CLI installé. Utilisez 'scontrol' et 'squeue' pour gérer les clusters SLURM."
}

# Boucle principale pour afficher le menu et obtenir le choix de l'utilisateur
while true; do
    show_menu
    read choice
    case $choice in
        1)
            setup_computing_cluster
            ;;
        2)
            setup_storage_cluster
            ;;
        3)
            setup_gui_tools
            ;;
        4)
            setup_cli_tools
            ;;
        5)
            echo "Sortie..."
            exit 0
            ;;
        *)
            echo "Option invalide!"
            ;;
    esac
done
