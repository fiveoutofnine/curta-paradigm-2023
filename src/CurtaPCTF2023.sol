// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {LibString} from "solady/utils/LibString.sol";
import {Owned} from "solmate/auth/Owned.sol";
import {ERC721} from "solmate/tokens/ERC721.sol";
import {ICurtaPCTF2023} from "./interfaces/ICurtaPCTF2023.sol";
import {Base64} from "./utils/Base64.sol";
import {CurtaPCTF2023Art} from "./utils/CurtaPCTF2023Art.sol";
import {CurtaPCTF2023Metadata} from "./utils/CurtaPCTF2023Metadata.sol";

/// @title Curta ^ Paradigm CTF 2023 commemorative NFTs
/// @author fiveoutofnine
/// @notice An NFT collection to commemorate players of the Curta team for their
/// participation and performance in the 2023 Paradigm CTF.
contract CurtaPCTF2023 is ICurtaPCTF2023, ERC721, Owned {
    using LibString for uint256;

    // -------------------------------------------------------------------------
    // Constants
    // -------------------------------------------------------------------------

    /// @notice Description of the collection.
    string constant COLLECTION_DESCRIPTION = "TODO";

    // -------------------------------------------------------------------------
    // Storage
    // -------------------------------------------------------------------------

    /// @inheritdoc ICurtaPCTF2023
    string public override baseURI;

    // -------------------------------------------------------------------------
    // Constructor + functions
    // -------------------------------------------------------------------------

    /// @param _owner Initial owner of the contract.
    constructor(
        address _owner
    )
        ERC721("Curta ^ Paradigm CTF 2023 Player NFTs", "PCTF{CUR74_2023}")
        Owned(_owner)
    {}

    /// @inheritdoc ICurtaPCTF2023
    function mint() external {
        // Get the token ID to mint for the player. The helper function will
        // revert if the player was not part of the team.
        uint256 tokenId = CurtaPCTF2023Metadata.getPlayerId(msg.sender);

        // Mint token.
        _mint(msg.sender, tokenId);
    }

    /// @inheritdoc ICurtaPCTF2023
    function setBaseURI(string calldata _baseURI) external override onlyOwner {
        // Set new base URI.
        baseURI = _baseURI;

        // Emit event.
        emit SetBaseURI(_baseURI);
    }

    // -------------------------------------------------------------------------
    // ERC721Metadata
    // -------------------------------------------------------------------------

    /// @notice Returns the adjusted URI for a given token ID.
    /// @dev Reverts if the token ID does not exist. Additionally, if `baseURI`
    /// is unset, `tokenURI` will directly return the URI generated onchain via
    /// {_tokenURI(uint256)}. Otherwise, it will return `baseURI + tokenId`.
    /// @param _id The token ID.
    /// @return The adjusted URI for the given token ID.
    function tokenURI(
        uint256 _id
    ) public view override returns (string memory) {
        // Revert if the token hasn't been minted.
        if (_ownerOf[_id] == address(0)) revert TokenUnminted();

        return
            bytes(baseURI).length == 0
                ? _tokenURI(_id)
                : string.concat(baseURI, _id.toString());
    }

    /// @notice Returns the URI for a given token ID, as generated onchain.
    /// @param _id The token ID.
    /// @return The URI for the given token ID.
    function _tokenURI(uint256 _id) internal pure returns (string memory) {
        // Get name of the player the token is attributed to.
        string memory name = CurtaPCTF2023Metadata.getPlayerNameFromID(_id);

        return
            string.concat(
                "data:application/json;base64,",
                Base64.encode(
                    abi.encodePacked(
                        '{"name":"',
                        name,
                        unicode' ∈ Curta ^ Paradigm CTF 2023","description":"',
                        COLLECTION_DESCRIPTION,
                        '","animation_url":"data:text/html;charset=utf-8;base64'
                        ",",
                        Base64.encode(
                            abi.encodePacked(CurtaPCTF2023Art.render(_id))
                        ),
                        '","attributes":[{"trait_type":"Player","value":"',
                        name,
                        '"},{"trait_type":"Year","value":2023}]}'
                    )
                )
            );
    }

    // -------------------------------------------------------------------------
    // Contract metadata
    // -------------------------------------------------------------------------

    /// @inheritdoc ICurtaPCTF2023
    function contractURI() external pure override returns (string memory) {
        return
            string.concat(
                "data:application/json;base64,",
                Base64.encode(
                    abi.encodePacked(
                        '{"name":"Curta ^ Paradigm CTF 2023 Player NFTs","descr'
                        'iption":"',
                        COLLECTION_DESCRIPTION
                    )
                )
            );
    }
}
