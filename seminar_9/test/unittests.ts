import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("RockPaperScissors", function(){

    async function players() {
        const [firstPlayer, secondPlayer] = await ethers.getSigners();
        return {firstPlayer, secondPlayer};
    }

    async function RPSFacade() {
        const RPSFacade = await ethers.getContractFactory("RockPaperScissorsFacade");
        return await RPSFacade.deploy();
    }


    async function RPS() {
        const _RPS = await ethers.getContractFactory("RockPaperScissors");
        return await _RPS.deploy();
    }


    describe("Registration", function() {
        it("Should register first user as the first player", async function () {
            const rps = await loadFixture(RPS);
            const {firstPlayer} = await loadFixture(players);


            await rps.connect(firstPlayer).register();

            expect(await rps.firstPlayer()).is.eq(firstPlayer.address);
        })

        it("Should not register first player twice", async function () {
            const rps = await loadFixture(RPS);
            const {firstPlayer} = await loadFixture(players);

            await rps.connect(firstPlayer).register();
            await expect(rps.connect(firstPlayer).register()).to.be.revertedWithoutReason();

            expect(await rps.firstPlayer()).is.eq(firstPlayer.address);
            expect(+await rps.secondPlayer()).is.eq(0);
        })

        it("Should register both players", async function () {
            const rps = await loadFixture(RPS);
            const {firstPlayer, secondPlayer} = await loadFixture(players);

            await rps.connect(firstPlayer).register();
            await rps.connect(secondPlayer).register();

            expect(await rps.firstPlayer()).is.eq(firstPlayer.address);
            expect(await rps.secondPlayer()).is.eq(secondPlayer.address);
        })

        it("Should reset players as reset is called", async function () {
            const rps = await loadFixture(RPS);
            const {firstPlayer, secondPlayer} = await loadFixture(players);

            await rps.connect(firstPlayer).register();
            await rps.connect(secondPlayer).register();

            expect(await rps.firstPlayer()).is.eq(firstPlayer.address);
            expect(await rps.secondPlayer()).is.eq(secondPlayer.address);

            await rps.reset();

            expect(+await rps.firstPlayer()).is.eq(0);
            expect(+await rps.secondPlayer()).is.eq(0);
        })
    })

    describe("Integration", function() {

        it("Should return error because contract address is not set", async function () {
            const rpsFacade = await loadFixture(RPSFacade);
            await expect(rpsFacade.register()).to.be.revertedWithoutReason();
        })

        it("Should register the first player via facade", async function () {
            const rps = await loadFixture(RPS);
            const rpsFacade = await loadFixture(RPSFacade);
            
            await rpsFacade.setRpsAddress(rps.address);
            await rpsFacade.register();

            expect(await rps.firstPlayer()).is.eq(rpsFacade.address);
        })
    })

})