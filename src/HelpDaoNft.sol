// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "solmate/tokens/ERC721.sol";
import "./utils/Strings.sol";

error MintPriceNotPaid();
error NonExistentTokenURI();
error WithdrawTransfer();

contract HelpDaoNft is ERC721 {
    
    string public baseURI;
    uint256 public currentTokenId;
    address public owner;
    uint256 public constant MINT_PRICE = 0.01 ether;

    using Strings for uint256;
    
    constructor(
        string memory _name,
        string memory _symbol,
        string memory _baseURI,
        address _owner
    ) ERC721(_name, _symbol) {
        baseURI = _baseURI;
        owner = _owner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can mint!");
        _;
    }

    function mint() public payable returns (uint256) {
        if (msg.value != MINT_PRICE) {
            revert MintPriceNotPaid();
        }
        uint256 newTokenId = ++currentTokenId;
        _safeMint(msg.sender, newTokenId);
        return newTokenId;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        if (ownerOf(tokenId) == address(0)) {
            revert NonExistentTokenURI();
        }
        return
            bytes(baseURI).length > 0
                ? string(abi.encodePacked(baseURI, tokenId.toString()))
                : "";
    }

    function withdrawPayments(address payable payee) external onlyOwner {
        uint256 balance = address(this).balance;
        (bool transferTx, ) = payee.call{value: balance}("");
        if (!transferTx) {
            revert WithdrawTransfer();
        }
    }
}