// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract MyEpicGame {

    struct CharacterAttributes {
        uint characterIndex;
        string name;
        string imageURI;
        uint hp;
        uint maxHp;
        uint attackDamage;
        uint memePower;
    }

    CharacterAttributes[] defaultCharacters;

    // data passed in to the contract when it's first created initializing the characters.
    constructor(
        string[] memory characterNames,
        string[] memory characterImageURI,
        uint[] memory characterHp,
        uint[] memory characterAttackDmg,
        uint[] memory characterMemePower
    )
    {
        // loop through all the characters, and save their values in our contract.
        for(uint i = 0; i < characterNames.length; i += 1) {
        defaultCharacters.push(CharacterAttributes({
            characterIndex: i,
            name: characterNames[i],
            imageURI: characterImageURI[i],
            hp: characterHp[i],
            maxHp: characterHp[i],
            attackDamage: characterAttackDmg[i],
            memePower: characterMemePower[i]
        }));

        CharacterAttributes memory c = defaultCharacters[i];
        console.log("Done initializing %s:", c.name);
        console.log("HP %s, AP %s, memeP %s", c.hp, c.attackDamage, c.memePower);
        console.log("img %s", c.imageURI);
        }
    }
}