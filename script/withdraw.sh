source .env

export HelpDaoNft=0xA6F43A8BbE5D463CaCc8e06594FD99aCC4666CE5

cast send --private-key=$PRIVATE_KEY $HelpDaoNft "withdrawPayments(address)" 0x2B68407d77B044237aE7f99369AA0347Ca44B129 --rpc-url $GOERLI_RPC_URL