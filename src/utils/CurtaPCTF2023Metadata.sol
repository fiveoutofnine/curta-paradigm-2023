// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/// @title Curta ^ Paradigm CTF 2023 commemorative NFT metadata
/// @notice A library for generating HTML output for {CurtaPCTF2023}.
library CurtaPCTF2023Metadata {
    // -------------------------------------------------------------------------
    // Constants
    // -------------------------------------------------------------------------

    address constant SUDOLABEL = 0x655aF72e1500EB8A8d1c90856Ae3B8f148A78471; // sudolabel.eth
    address constant KALZAK = 0xd4057e08B9d484d70C5977784fC1f6D82d45ff67; // kalzak.eth
    address constant SEEN = address(0);
    address constant IGORLINE = address(0);
    address constant POGO = 0x6E82554d7C496baCcc8d0bCB104A50B772d22a1F; // minimooger.eth
    address constant POPULAR = 0x0Fc363b52E49074a395B075a6814Cb8F37E8F8BE; // p0pular.eth
    address constant ORENYOMTOV = address(0);
    address constant ZERO_X_796 = address(0);
    address constant PLOTCHY = 0x97735C60c5E3C2788b7EE570306775e687095D19; // plotchy.eth
    address constant FORAGER = 0x286cD2FF7Ad1337BaA783C345080e5Af9bBa0b6e; // forager.eth
    address constant HORSEFACTS = 0x79d31bFcA5Fda7A4F15b36763d2e44C99D811a6C; // horsefacts.eth
    address constant DATADANNE = address(0);
    address constant BROCKE = 0x230d31EEC85F4063a405B0F95bdE509C0d0A8b5D; // brocke.eth

    // -------------------------------------------------------------------------
    // Errors
    // -------------------------------------------------------------------------

    /// @notice Emitted when a player wasn't a member of the Curta team.
    /// @param _player The nonexistant player.
    error NonexistantPlayer(address _player);

    /// @notice Emitted when ID doesn't map to a player.
    /// @param _id The nonexistant ID.
    error NonexistantPlayerID(uint256 _id);

    // -------------------------------------------------------------------------
    // Functions
    // -------------------------------------------------------------------------

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

    function getPlayerName(
        address _player
    ) internal pure returns (string memory) {
        if (_player == SUDOLABEL) return "sudolabel";
        else if (_player == KALZAK) return "Kalzak";
        else if (_player == SEEN) return "seen";
        else if (_player == IGORLINE) return "igorline";
        else if (_player == POGO) return "pogo";
        else if (_player == POPULAR) return "popular";
        else if (_player == ORENYOMTOV) return "orenyomtov";
        else if (_player == ZERO_X_796) return "0x796";
        else if (_player == PLOTCHY) return "plotchy";
        else if (_player == FORAGER) return "forager";
        else if (_player == HORSEFACTS) return "horsefacts";
        else if (_player == DATADANNE) return "datadanne";
        else if (_player == BROCKE) return "brocke";
        revert NonexistantPlayer(_player);
    }

    function getPlayerNameFromID(uint256 _id) internal pure returns (uint256) {
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
