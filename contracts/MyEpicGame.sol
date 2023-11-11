// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

import "hardhat/console.sol";

contract MyEpicGame is ERC721 {

    // character model
    struct CharacterAttributes {
        uint characterIndex;
        string name;
        string imageURI;
        uint hp;
        uint maxHp;
        uint attackDamage;
        uint memePower;
    }

    // list of default characters
    CharacterAttributes[] defaultCharacters;

    // create a counter for NFT ids starting at 1
    uint256 private _tokenIds = 1;

    // map to store individual character's current attributes
    mapping(uint256 => CharacterAttributes) public nftHolderAttributes;

    // map to store NFT owner addresses
    mapping(address => uint256) public nftHolders;

    // default character data passed into the contract on deployment
    constructor(
        string[] memory characterNames,
        string[] memory characterImageURI,
        uint[] memory characterHp,
        uint[] memory characterAttackDmg,
        uint[] memory characterMemePower
    )
        ERC721("Heroes", "HERO")
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

    function mintCharacterNFT(uint _characterIndex) external {
        uint newItemId = _tokenIds;
        _safeMint(msg.sender, newItemId);

        // create a new instance of the character in the map
        nftHolderAttributes[newItemId] = CharacterAttributes({
            characterIndex: _characterIndex,
            name: defaultCharacters[_characterIndex].name,
            imageURI: defaultCharacters[_characterIndex].imageURI,
            hp: defaultCharacters[_characterIndex].hp,
            maxHp: defaultCharacters[_characterIndex].maxHp,
            attackDamage: defaultCharacters[_characterIndex].attackDamage,
            memePower: defaultCharacters[_characterIndex].memePower
        });

        console.log("Minted NFT w/ tokenId %s and characterIndex %s", newItemId, _characterIndex);

        // keep track of minter address
        nftHolders[msg.sender] = newItemId;
        // increment token id
        _tokenIds++;
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        CharacterAttributes memory charAttributes = nftHolderAttributes[_tokenId];

        string memory strHp = Strings.toString(charAttributes.hp);
        string memory strMaxHp = Strings.toString(charAttributes.maxHp);
        string memory strAttackDamage = Strings.toString(charAttributes.attackDamage);
        string memory strMemePower = Strings.toString(charAttributes.memePower);

        string memory json = Base64.encode(
            abi.encodePacked(
            '{"name": "',
            charAttributes.name,
            ' -- NFT #: ',
            Strings.toString(_tokenId),
            '", "description": "This is an NFT that lets people play in the game Metaverse Slayer!", "image": "',
            charAttributes.imageURI,
            '", "attributes": [ { "trait_type": "Health Points", "value": ',strHp,', "max_value":',strMaxHp,'}, { "trait_type": "Attack Damage", "value": ',
            strAttackDamage,'}, { "trait_type": "Meme Power", "value":', strMemePower, '}]}'
            )
        );

        string memory output = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        return output;
    }
}