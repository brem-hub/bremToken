# BremToken

BremToken is implementation of ERC20.

BremToken is used in educational purposes only as a part of homework for the "Crytosystems and Smart contracts" course.


## Run project

In order to run project, you have to obtain 2 tokens and save them to environment variables.

- `ALCHEMY_API_KEY` can be obtained at https://www.alchemy.com/
- `GOERLI_PRIVATE_TOKEN` can be obtained at your MetaMask client. Account details -> Get private token.

For additional information see HardHat docs: https://hardhat.org/tutorial/deploying-to-a-live-network

```shell
ALCHEMY_API_KEY=<your_key> \
GOERLI_PRIVATE_TOKEN=<your_token> \
hpx hardhat run scripts/deploy.ts --network goerli
```
