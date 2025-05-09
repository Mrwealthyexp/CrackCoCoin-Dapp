// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CrackNFT is ERC721URIStorage {
    address public owner;
    IERC20 public cccToken;
    uint256 public tokenCounter;
    uint256 public mintCost = 100 * 10**18;

    constructor(address _cccTokenAddress) ERC721("Crack NFT", "CRACKNFT") {
        cccToken = IERC20(_cccTokenAddress);
        owner = msg.sender;
        tokenCounter = 0;
    }

    function mintNFT(string memory _tokenURI) public {
        require(cccToken.transferFrom(msg.sender, owner, mintCost), "Payment failed");

        uint256 newItemId = tokenCounter;
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, _tokenURI);
        tokenCounter++;
    }
}
