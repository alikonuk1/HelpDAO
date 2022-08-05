source .env

export HelpDaoNft=0xA6F43A8BbE5D463CaCc8e06594FD99aCC4666CE5

cast send --value 0.01ether --private-key=$PRIVATE_KEY $HelpDaoNft "mint()" --rpc-url $GOERLI_RPC_URL