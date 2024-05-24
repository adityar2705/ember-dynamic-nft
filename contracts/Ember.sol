// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.24;

import '@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol';
import '@openzeppelin/contracts/utils/Base64.sol';
import '@openzeppelin/contracts/utils/Strings.sol';

contract Ember is ERC721URIStorage{
    using Strings for uint256;
    uint private _tokenIds = 0;

    mapping(uint256 => uint256) public tokenIdtoLevels;

    //constructor for the NFT
    constructor() ERC721("Ember","EMB"){}

    //generating our dynamic character NFT
    function generateCharacter(uint tokenId) public view returns(string memory){
        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
            '<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>',
            '<rect width="100%" height="100%" fill="black" />',
            '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">',"Ember Warrior",'</text>',
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">',"Levels:", getLevels(tokenId),'</text>',
            '</svg>'
        );

        return string(
            abi.encodePacked(
                "data:image/svg+xml;base64,",
                Base64.encode(svg)
            )
        );
    }

    //function to get the levels using tokenId
    function getLevels(uint tokenId) public view returns(string memory){
        uint256 levels = tokenIdtoLevels[tokenId];
        return levels.toString();
    }

    //function to get the token uri
    function getTokenURI(uint256 tokenId) public view returns (string memory){
        bytes memory dataURI = abi.encodePacked(
            '{',
                '"name": "Ember Wars #', tokenId.toString(), '",',
                '"description": "Dynamic Ember wars on Chain",',
                '"image": "', generateCharacter(tokenId), '"',
            '}'
        );
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(dataURI)
            )
        );
    }

    //function to mint our dynamic Ember NFT
    function mint() public{
        _tokenIds++;
        uint256 newItemId = _tokenIds;

        //ERC721 function to actually safely mint using new token id
        _safeMint(msg.sender,newItemId);
        tokenIdtoLevels[newItemId] = 0;

        //setting the token uri using our function
        _setTokenURI(newItemId, getTokenURI(newItemId));
    }

    //logic to make our Ember NFT dynamic
    function train(uint256 tokenId) public{
        require(ownerOf(tokenId) == msg.sender,"Must own this Ember token.");
        uint currentLevel = tokenIdtoLevels[tokenId];
        tokenIdtoLevels[tokenId] = currentLevel + 1;
        _setTokenURI(tokenId,getTokenURI(tokenId));
    }
}