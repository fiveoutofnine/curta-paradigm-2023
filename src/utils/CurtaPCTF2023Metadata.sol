// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/// @title Curta ^ Paradigm CTF 2023 commemorative NFT metadata
/// @notice A library for returning the metadata associated with players of the
/// Curta ^ Paradigm CTF 2023 team.
/// @dev Players have predetermined IDs (equal to the ID of the token they can
/// mint), names, and addresses (the addresses they can claim from). If a player
/// is not part of the team (i.e. there's no associated ID/address associated),
/// the functions will revert.
library CurtaPCTF2023Metadata {
    // -------------------------------------------------------------------------
    // Constants
    // -------------------------------------------------------------------------

    /// @notice The address of sudolabel (sudolabel.eth).
    address constant SUDOLABEL = 0x655aF72e1500EB8A8d1c90856Ae3B8f148A78471;

    /// @notice The address of Kalzak (kalzak.eth).
    address constant KALZAK = 0xd4057e08B9d484d70C5977784fC1f6D82d45ff67;

    /// @notice The address of seen (eoa.sina.eth).
    address constant SEEN = 0x2de14DB256Db2597fe3c8Eed46eF5b20bA390823;

    /// @notice The address of igorline (igorline.eth).
    address constant IGORLINE = 0x14869c6bF40BBc73e45821F7c28FD792151b3f9A;

    /// @notice The address of pogo (minimooger.eth).
    address constant POGO = 0x6E82554d7C496baCcc8d0bCB104A50B772d22a1F;

    /// @notice The address of popular (p0pular.eth).
    address constant POPULAR = 0x0Fc363b52E49074a395B075a6814Cb8F37E8F8BE;

    /// @notice The address of orenyomtov (orenyomtov.eth).
    address constant ORENYOMTOV = 0xD04Dd74d0a905E857278ac3A8bDaFadcD8BF8e87;

    /// @notice The address of 0x796 (vicnaum.eth).
    address constant ZERO_X_796 = 0x79635b386B9bd6636Cd701879C32E6dd181C853F;

    /// @notice The address of plotchy (plotchy.eth).
    address constant PLOTCHY = 0x97735C60c5E3C2788b7EE570306775e687095D19;

    /// @notice The address of forager (forager.eth).
    address constant FORAGER = 0x286cD2FF7Ad1337BaA783C345080e5Af9bBa0b6e;

    /// @notice The address of horsefacts (horsefacts.eth).
    address constant HORSEFACTS = 0x79d31bFcA5Fda7A4F15b36763d2e44C99D811a6C;

    /// @notice The address of datadanne (datadanne.eth).
    address constant DATADANNE = 0xBDfeB5439f5daecb78A17Ff846645A8bDBbF5725;

    /// @notice The address of brocke (brocke.eth).
    address constant BROCKE = 0x230d31EEC85F4063a405B0F95bdE509C0d0A8b5D;

    // -------------------------------------------------------------------------
    // Errors
    // -------------------------------------------------------------------------

    /// @notice Emitted when a player wasn't part of the Curta ^ Paradigm CTF
    /// 2023 team.
    /// @param _player The nonexistant player.
    error NonexistantPlayer(address _player);

    /// @notice Emitted when ID doesn't map to a player.
    /// @param _id The nonexistant ID.
    error NonexistantPlayerID(uint256 _id);

    // -------------------------------------------------------------------------
    // Functions
    // -------------------------------------------------------------------------

    /// @notice Returns the address of the player the token is attributed to.
    /// @dev Reverts if the token ID does not exist.
    /// @param _id The token ID.
    /// @return The address of the player the token is attributed to.
    function getPlayerAddress(uint256 _id) internal pure returns (address) {
        if (_id == 0) return SUDOLABEL;
        else if (_id == 1) return KALZAK;
        else if (_id == 2) return SEEN;
        else if (_id == 3) return IGORLINE;
        else if (_id == 4) return POGO;
        else if (_id == 5) return POPULAR;
        else if (_id == 6) return ORENYOMTOV;
        else if (_id == 7) return ZERO_X_796;
        else if (_id == 8) return PLOTCHY;
        else if (_id == 9) return FORAGER;
        else if (_id == 10) return HORSEFACTS;
        else if (_id == 11) return DATADANNE;
        else if (_id == 12) return BROCKE;
        revert NonexistantPlayerID(_id);
    }

    /// @notice Returns the ID of the player the token is attributed to.
    /// @dev Reverts if the player was not part of the Curta ^ Paradigm CTF 2023
    /// team.
    /// @param _player The player's address.
    /// @return The ID of the player the token is attributed to.
    function getPlayerId(address _player) internal pure returns (uint256) {
        if (_player == SUDOLABEL) return 0;
        else if (_player == KALZAK) return 1;
        else if (_player == SEEN) return 2;
        else if (_player == IGORLINE) return 3;
        else if (_player == POGO) return 4;
        else if (_player == POPULAR) return 5;
        else if (_player == ORENYOMTOV) return 6;
        else if (_player == ZERO_X_796) return 7;
        else if (_player == PLOTCHY) return 8;
        else if (_player == FORAGER) return 9;
        else if (_player == HORSEFACTS) return 10;
        else if (_player == DATADANNE) return 11;
        else if (_player == BROCKE) return 12;
        revert NonexistantPlayer(_player);
    }

    /// @notice Returns the name of the player the token is attributed to.
    /// @dev Reverts if the token ID does not exist.
    /// @param _id The token ID.
    /// @return The name of the player the token is attributed to.
    function getPlayerNameFromID(
        uint256 _id
    ) internal pure returns (string memory) {
        if (_id == 0) return "sudolabel";
        else if (_id == 1) return "Kalzak";
        else if (_id == 2) return "seen";
        else if (_id == 3) return "igorline";
        else if (_id == 4) return "pogo";
        else if (_id == 5) return "popular";
        else if (_id == 6) return "orenyomtov";
        else if (_id == 7) return "0x796";
        else if (_id == 8) return "plotchy";
        else if (_id == 9) return "forager";
        else if (_id == 10) return "horsefacts";
        else if (_id == 11) return "datadanne";
        else if (_id == 12) return "brocke";
        revert NonexistantPlayerID(_id);
    }
}
