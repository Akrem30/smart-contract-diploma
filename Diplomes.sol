// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "./Owner.sol";

contract DiplomeContract is Owner {

    struct Diplome {
        string preNom;
        string nom;
        string dateNaissance;
        string numeroTelephone;
        string email;
        string anneeObtention;
        string universite;
        string titre;
    }

    uint256 idDiplome;

    mapping(uint256 => Diplome) Diplomes;

    function addDiplome(
        string memory _preNom,
        string memory _nom,
        string memory _dateNaissance,
        string memory _numeroTelephone,
        string memory _email,
        string memory _anneeObtention,
        string memory _universite,
        string memory _titre
    ) public isOwner  {
        require(msg.sender == owner, "Not the Owner");
        for (uint256 i = 0; i < idDiplome; i++) {
            require(
                !(keccak256(abi.encodePacked(Diplomes[i].preNom)) == keccak256(abi.encodePacked(_preNom)) &&
                  keccak256(abi.encodePacked(Diplomes[i].nom)) == keccak256(abi.encodePacked(_nom)) &&
                  keccak256(abi.encodePacked(Diplomes[i].titre)) == keccak256(abi.encodePacked(_titre))),
                "L'etudiant a deja ce titre"
            );
        }

        Diplomes[idDiplome].preNom = _preNom;
        Diplomes[idDiplome].nom = _nom;
        Diplomes[idDiplome].dateNaissance = _dateNaissance;
        Diplomes[idDiplome].numeroTelephone = _numeroTelephone;
        Diplomes[idDiplome].email = _email;
        Diplomes[idDiplome].anneeObtention = _anneeObtention;
        Diplomes[idDiplome].universite = _universite;
        Diplomes[idDiplome].titre = _titre;

        idDiplome++;        
    }

    function getDiplome(
        string memory _preNom,
        string memory _nom,
        string memory _dateDiplome
    ) public view isOwner returns (Diplome memory) {
        Diplome memory diplome = Diplome({
            preNom: _preNom,
            nom: _nom,
            dateNaissance: "",
            numeroTelephone: "",
            email: "",
            anneeObtention: "",
            universite: "",
            titre: ""
        });

        
        for (uint256 i = 0; i <= idDiplome; i++) {
            if (
                keccak256(abi.encodePacked(Diplomes[i].preNom)) ==
                keccak256(abi.encodePacked(_preNom)) &&
                keccak256(abi.encodePacked(Diplomes[i].nom)) ==
                keccak256(abi.encodePacked(_nom)) &&
                keccak256(abi.encodePacked(Diplomes[i].anneeObtention)) ==
                keccak256(abi.encodePacked(_dateDiplome))
            ) {
                return Diplomes[i];
            }            
        }

        return diplome;
    }

}
