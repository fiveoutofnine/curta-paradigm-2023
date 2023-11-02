# Config
OWNER="0x5dd2083A0D68C4EB8fEd93EF010D1b0D68B3880F" # fiveoutofnine.eth

BYTECODE=$(forge inspect src/CurtaPCTF2023.sol:CurtaPCTF2023 bytecode)
ARGS=$(cast abi-encode "constructor(address)" $OWNER)
CALLDATA=$(cast --concat-hex "$BYTECODE" "$ARGS")
echo $CALLDATA > bytecode-with-constructor.txt
