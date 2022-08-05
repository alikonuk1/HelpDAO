source .env

forge create --rpc-url $GOERLI_RPC_URL \
    --constructor-args "Help Dao Nft" "HELP" "https://dweb.link/ipfs/bafybeih6wm3cva3xtodn7ywesk4b5sr5gxkspka6hf5uzmpmrt27wzgipa" 0x2B68407d77B044237aE7f99369AA0347Ca44B129 \
    --private-key $PRIVATE_KEY src/HelpDaoNft.sol:HelpDaoNft \
    --etherscan-api-key $ETHERSCAN_KEY \
    --verify