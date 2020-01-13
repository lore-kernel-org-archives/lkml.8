Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EFFC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D85820661
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgAMOPm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:15:42 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47305 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgAMOPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:15:38 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 5D4F31BF20B;
        Mon, 13 Jan 2020 14:15:30 +0000 (UTC)
Date:   Mon, 13 Jan 2020 15:15:29 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 02/10] mtd: nand: raw: add rockchip nand
 controller driver
Message-ID: <20200113151529.1ecba50e@xps13>
In-Reply-To: <7a477af0-1448-4f26-4004-9331978e824c@gmail.com>
References: <20200108205338.11369-1-jbx6244@gmail.com>
        <20200108205338.11369-3-jbx6244@gmail.com>
        <20200110120534.1b4026b0@xps13>
        <7a477af0-1448-4f26-4004-9331978e824c@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Johan Jonker <jbx6244@gmail.com> wrote on Sun, 12 Jan 2020 18:26:20
+0100:

> Hi Miquel,
> 
> Thank you for your detailed and useful review.
> 
> Without manufacturer support I must scrape my information
> from all over the internet, together with slow interpretation of
> Rockchip drivers.
> So please have some patience with my updates and new versions.

There is absolutely no hurry, it is great that you work on this!

> 
> Below are some comments and questions in random order.
> 
> /////////////////////////////
> 
> To prevent guessing games could you confirm the following names:
> 
> driver file name:   rockchip-nand-controller.c

Fine

> document file name: rockchip-nand-controller.yaml

I think rockchip,nand-controller.yaml is preferred.

> 
> compatible: "rockchip,nandc-v6"

rockchip,nand-controller-v6

> compatible: "rockchip,nandc-v9"

same as above with -v9 as suffix.


[...]

> Jan  1 00:02:27 mk808 kernel: [  147.053388] nand: 8192 MiB, MLC,
erase

Just to be clear, MLC is not yet supported in mainline. There is a
patch series that aims at supporting MLC in pseudo-SLC mode but do not
use MLC as a reliable storage medium.

> size: 2048 KiB, page size: 8192, OOB size: 640
> Jan  1 00:02:27 mk808 kernel: [  147.054050] rockchip-nandc
> 10500000.nand-controller: nand->numchips = 1
> Jan  1 00:02:27 mk808 kernel: [  147.054740] rockchip-nandc
> 10500000.nand-controller: nand->chipsize = 8589934592
> Jan  1 00:02:27 mk808 kernel: [  147.055380] rockchip-nandc
> 10500000.nand-controller: nand->pagemask =    fffff
> Jan  1 00:02:27 mk808 kernel: [  147.055994] rockchip-nandc
> 10500000.nand-controller: nand->badblockpos = 0
> Jan  1 00:02:27 mk808 kernel: [  147.056591] rockchip-nandc
> 10500000.nand-controller: nand->chip_shift = 33
> Jan  1 00:02:27 mk808 kernel: [  147.057174] rockchip-nandc
> 10500000.nand-controller: nand->page_shift = 13
> Jan  1 00:02:27 mk808 kernel: [  147.057751] rockchip-nandc
> 10500000.nand-controller: nand->phys_erase_shift = 21
> Jan  1 00:02:27 mk808 kernel: [  147.058366] rockchip-nandc
> 10500000.nand-controller: nand->ecc.mode = 3
> Jan  1 00:02:27 mk808 kernel: [  147.058920] rockchip-nandc
> 10500000.nand-controller: nand->ecc.steps = 8
> Jan  1 00:02:27 mk808 kernel: [  147.059481] rockchip-nandc
> 10500000.nand-controller: nand->ecc.bytes = 70
> Jan  1 00:02:27 mk808 kernel: [  147.060049] rockchip-nandc
> 10500000.nand-controller: nand->ecc.total = 0
> Jan  1 00:02:27 mk808 kernel: [  147.060607] rockchip-nandc
> 10500000.nand-controller: nand->ecc.prepad = 4
> Jan  1 00:02:27 mk808 kernel: [  147.061175] rockchip-nandc
> 10500000.nand-controller: nand->ecc.size = 1024
> Jan  1 00:02:27 mk808 kernel: [  147.061748] rockchip-nandc
> 10500000.nand-controller: nand->ecc.strength = 40
> Jan  1 00:02:27 mk808 kernel: [  147.062341] rockchip-nandc
> 10500000.nand-controller: mtd->ooblayout = 91ce9ce2
> Jan  1 00:02:27 mk808 kernel: [  147.062943] rockchip-nandc
> 10500000.nand-controller: mtd->flags = 00000000
> Jan  1 00:02:27 mk808 kernel: [  147.063518] rockchip-nandc
> 10500000.nand-controller: mtd->size = 8589934592
> Jan  1 00:02:27 mk808 kernel: [  147.064098] rockchip-nandc
> 10500000.nand-controller: mtd->erasesize = 2097152
> Jan  1 00:02:27 mk808 kernel: [  147.064815] rockchip-nandc
> 10500000.nand-controller: mtd->writesize = 8192
> Jan  1 00:02:27 mk808 kernel: [  147.065413] rockchip-nandc
> 10500000.nand-controller: mtd->oobsize = 640
> Jan  1 00:02:27 mk808 kernel: [  147.068985] 1 fixed-partitions
> partitions found on MTD device 10500000.nand-controller.0
> Jan  1 00:02:27 mk808 kernel: [  147.069190] Creating 1 MTD partitions
> on "10500000.nand-controller.0":
> Jan  1 00:02:27 mk808 kernel: [  147.072375]
> 0x000000000000-0x000000400000 : "parameter"
> 
> 
> Jan  1 00:02:27 mk808 kernel: [  147.075649] rockchip-nandc
> 10500000.nand-controller: R:0x00ff cs:0
> Jan  1 00:02:27 mk808 kernel: [  147.079423] rockchip-nandc
> 10500000.nand-controller: R:0x01ff cs:0
> 
> 
> Despite nand->options = NAND_SKIP_BBTSCAN.
> 
> What is the reason for these 2 rk_nandc_hw_syndrome_ecc_read_page()
> commands at page R:0x00ff and R:0x01ff right after creating
> partitions.
> 
> When enabled BBTSCAN MTD starts to store at all kind of places. Can
> you state

Please do not mix the two concepts:
- on chip bbt: the last blocks will be used to store the BB, without,
  the BBT must be reconstructed by reading all the blocks.
- SKIP_BBT_SCAN: do not construct the BBT in RAM.

Please trace the calls (dump_stack() might help you) to see what
function actually calls the ->read_page() helpers.

> there page address logic, ie. Would that damage the excisting Rockchip
> layout?

I don't know about the existing Rockchip layout.

> 
> /////////////////////////////
> 
> No bad block support
> 
> Based on:
> drivers: mtd: nand: rockchip nandc add bad block detect api
> https://github.com/rockchip-linux/u-boot/commit/
> 7aec704a4e9d9322f1102bcf61ee5c3cf6ec794d
> 
> rockchip: drivers: mtd: nand: modify the bad block detection process
> https://github.com/rockchip-linux/u-boot/commit/
> d6d708d1a329a6369143e8dd34cf4e2c81d5d92f
> 
> BCH      |      oob size
> ------------------------
> 16: bytes: 28 + 4 = 32
> 24: bytes: 42 + 4 = 46
> 40: bytes: 70 + 4 = 74
> 60: bytes: 106 + 4 = 110
> 
> The data layout that is written by an internal Rockchip nandc dma is:
>     1024 bytes data + 32 obb + 1024 data + 32 obb ...
> 
> The MTD system however tries to detect bad block flags located at:
>     2048, 4096, 8192...

Bad block flags (so called bad block markers, abreviated BBM) are the
first two bytes of the OOB. A page is always:

	<X in-band bytes (data)><Y out-of-band bytes (OOB)>

No matter the way this is stored on the NAND chip, the user is
expecting all the data bytes together and all the OOB bytes together.
You must reconstruct this.

> The system checks for bad blocks and looks at the wrong bad block
> marker location.
> Yifeng Zhao proposes to add a bad block detecting strategy by doing
> a read with rk_nandc_hw_syndrome_ecc_read_page() first,
> if failure then assume it's still raw unwritten NAND and test bytes
> are at the position MTD normaly would check for right from the
> factory. When this function is used on a FTL controlled NAND it
> creates an awful lot of errors in the kernel log, because it uses the
> BB marker for dirty tag tricks for there data storage.
> So what is good for a raw empty NAND without FTL
> does not work for the majority of Rockchip devices I think.
> 
> Please advise for other options.

That's sad that Rockchip BSP does not follow standard rules, but IMHO
this kind of research logic is way too much error prone and this is not
somehting we want to play with: if you start a mainline kernel with a
wrong logic, then later you fix the logic in mainline, you must support
the broken logic forever.

This means you cannot boot a vendor kernel and a mainline kernel on the
same platform anymore. This is sad but we cannot fight against it.
Unless, as I am pointing it out above, you can simply reconstruct the
page to offer a linear data+OOB layout.

> static uint8_t rk_nand_read_byte(struct nand_chip *nand)
> {
> 	uint8_t ret;
> 
> 	rk_nand_read_buf(nand, &ret, 1);
> 
> 	return ret;
> }
> 
> static int rk_nand_block_bad(struct nand_chip *nand, loff_t ofs)
> {
> 	struct mtd_info *mtd = nand_to_mtd(nand);
> 	int page, res = 0;
> 	u16 bad = 0xff;
> 	u8 *buf = nand_get_data_buf(nand);
> 	int chipnr = (int)(ofs >> nand->chip_shift);
> 
> 	page = (int)(ofs >> nand->page_shift) & nand->pagemask;
> 	rk_nand_select_chip(nand, chipnr);
> 	if (rk_nand_hw_syndrome_ecc_read_page(nand, buf, false, page)
> == -1) { /* first page of a block*/
> 		nand_read_page_op(nand, page, nand->badblockpos,
> NULL, 0); bad = rk_nand_read_byte(nand);
> 		if (bad != 0xFF)
> 			res = 1;
> 		/* second page of a block*/
> 		nand_read_page_op(nand, page + 1, nand->badblockpos,
> NULL, 0); bad = rk_nand_read_byte(nand);
> 		if (bad != 0xFF)
> 			res = 1;
> 		/* last page of a block */
> 		page += ((mtd->erasesize - mtd->writesize) >>
> nand->chip_shift); page--;
> 		nand_read_page_op(nand, page, nand->badblockpos,
> NULL, 0); bad = rk_nand_read_byte(nand);
> 		if (bad != 0xFF)
> 			res = 1;
> 	}
> 	rk_nand_select_chip(nand, -1);
> 	return res;
> }
> 
> This also requires a patch for nand_bbt.c
> As I try to get to get some shape in the rest of this driver,
> I have left it out for version 1 and as I wait for our respons first.
> 
> drivers/mtd/nand/nand_bbt.c
> @@ -487,8 +487,10 @@ static int create_bbt(struct mtd_info *mtd,
> uint8_t *buf,
> 		int ret;
> 
> 		BUG_ON(bd->options & NAND_BBT_NO_OOB);
> 
> 		ret = scan_block_fast(mtd, bd, from, buf, numpages);
> 		if (this->block_bad)
> 			ret = this->block_bad(mtd, from);
> 		else
> 			ret = scan_block_fast(mtd, bd, from, buf,
> numpages);
> 
> /////////////////////////////
> 
> Data structures/Partitions
> 
> The majority of Rockchip devices use a closed source FTL driver,
> so when we want to read or write we must deal with it.
> 
> Example MTD string:
> mtdparts=rk29xxnand:
> 0x00002000@0x00002000(misc),
> 0x00008000@0x00004000(kernel),
> 0x00008000@0x0000C000(boot),
> 0x00008000@0x00014000(recovery),
> 0x000C0000@0x0001C000(backup),
> 0x00040000@0x000DC000(cache),
> 0x00300000@0x0011C000(userdata),
> 0x00002000@0x0041C000(kpanic),
> 0x00200000@0x0041E000(system),
> -@0x0063E000(user)"
> 
> When Rockchip mentions a string like this it has nothing to do
> with the real position on NAND. FTL write where wants,
> so reading there is not useful.
> All sizes have to be multiplied by 512 and casted to (u64)!
> All partitions need to contain at least 2 erase blocks.
> One for normal use and one spare.

I don't think trying to mimic Rockchip FTL is wise. We will not use the
FTL in a mainline kernel but very likely: UBI/UBIFS.

> --------------------
> FlashSavePhyInfo
> RawIdbData
> --------------------
> ...
> FTL data
> ...
> --------------------
> Map blocks:
> + L2pMapInfo
> + VendorBlkInfo
> 
> Sys info:
> + sys_save_data
> 
> Vendor partition:
> + sys_ext_data    0
> + ect_tbl_info   64
> + vendor        256 + ?
> + BootConfig    512 + 0
> + DrmKeyInfo    512 + 1
> + Vendor0Info   512 + 2
> + Vendor1Info   512 + 3
> + sys           512 + ?
> + public key    520
> --------------------
> Bad Block Map Tbl(not compatible with MTD)
> --------------------
> reserved: last NAND block - n
> --------------------
> 
> From the above diagram only RawIdbData has to be located in the first
> erase block.
> Boot ROM searches for the tag ID_IDRW = 0xFCDC8C3B.
> Only the first 4 sections (4*1024) of a page are used.
> When writing multiple pages extra spaces in the data
> for between the sections are required.
> Older cpu's (RK3066) might need extra RC4 coding.
> 
> FTL uses that RawIdbData area unfortunately also to save struct
> FlashSavePhyInfo.
> For a bare basic application only RawIdbData is needed.
> 
> For users that might consider MTD as a option to do something on a
> Rockchip NAND
> see the source code below to get an indication of what is needed for a
> useful
> setup to just read and write a bootloader alone. Writing of any user
> partition
> is not even included.
> Having a basic MTD driver is just not enough.
> Please advise if such a overhead can interface with MTD?
> Have fun!
> 
> /////////////////////////////
> 

[...]

> >> +#define NANDC_ID_V600			0x56363030
> >> +#define NANDC_ID_V622			0x56363232
> >> +#define NANDC_ID_V701			0x701
> >> +#define NANDC_ID_V800			0x56383030
> >> +#define NANDC_ID_V801			0x801
> >> +#define NANDC_ID_V900			0x56393030  
> >  
> 
> > I would prefer prefixing everything RK_NANDC_ or RK_  
> 
> Will change define list above and below to RK_NANDC_
> It takes more space though. Already difficult to stay below 80
> char/line.

Do your best, if it hurts readability you may break the 80 chars rule.
Or try to write it down differently.


[...]

> >> +struct rk_nand_controller {
> >> +	void __iomem *regs;
> >> +	int irq;
> >> +	struct clk *hclk;
> >> +	struct clk *clk;
> >> +	struct list_head chips;
> >> +	struct completion complete;
> >> +	struct nand_controller controller;
> >> +	int banks[NANDC_NUM_BANKS];  
> >  
> >> +	bool bootromblocks;
> >> +	int ecc_mode;
> >> +	uint32_t ecc_strength;
> >> +	int max_ecc_strength;  
> >  
> 
> > I have not read yet the entire driver but I believe the above 4
> > parameters should probably be moved in rk_nand_chip, right? Anything
> > that is NAND chip related should not be in the controller
> > structure. It depends if you can change ECC requirements on the fly
> > or not.  
> 
> Short answer:
> The reason that it is the most convenience place to have them for now.
> With one pointer from nand_get_controller_data() I have all data
> available.
> 
> struct rk_nand_controller *ctrl = nand_get_controller_data(nand);
> 
> The ECC is now sort of fixed to 24 and 40 for legacy reasons.
> The older rk3066 bootrom apparently only works for ecc 24.
> See info based on older work by Paweł Jarosz for Uboot.
> 
> I'm not too familiar with all inner working of MTD, so please advise.
> Can the users get access to struct rk_nand_chip?
> Would you like to give users control over what ecc to use?

It is already the case: DT properties in the NAND node (see the
bindings). But this is a static information, you cannot change it at
run time of course.

> What program can we use for that? Can't use dd then any more.

You should not use dd at all. dd is for block devices or char devices,
not MTD devices. There is an mtd-utils package out there that covers
pretty much all the actions you want to.

> How do we regain ecc control if we really have to for example rk3066?
> Or remove that bootrom check and always set ECC with every
> rk_nandc_hw_syndrome_ecc_read_page and
> rk_nandc_hw_syndrome_ecc_write_page with whatever passed along?

I don't understand your question.


[...]

> >> +static int rk_nandc_hw_ecc_setup(struct nand_chip *nand,
> >> +				 uint32_t strength)
> >> +{
> >> +	struct rk_nand_controller *ctrl =
> >> nand_get_controller_data(nand);
> >> +	uint32_t reg;
> >> +
> >> +	nand->ecc.strength = strength;  
> 
> Should I add this comment below?
> 
> /* HW ECC always request ECC bytes for 1024 bytes blocks */
> 
> >> +	nand->ecc.bytes = DIV_ROUND_UP(nand->ecc.strength * 14,
> >> 8);  
> >  
> 
> > What do 14 and 8 mean?  
> 
> fls - find last (most-significant) bit set
> 
> int fls(unsigned int x)
> {
> 	int r = 32;
> 
> 	if (!x)
> 		return 0;
> 	if (!(x & 0xffff0000u)) {
> 		x <<= 16;
> 		r -= 16;
> 	}
> 	if (!(x & 0xff000000u)) {
> 		x <<= 8;
> 		r -= 8;
> 	}
> 	if (!(x & 0xf0000000u)) {
> 		x <<= 4;
> 		r -= 4;
> 	}
> 	if (!(x & 0xc0000000u)) {
> 		x <<= 2;
> 		r -= 2;
> 	}
> 	if (!(x & 0x80000000u)) {
> 		x <<= 1;
> 		r -= 1;
> 	}
> 	return r;
> }
> 
> 	nand->ecc.bytes = DIV_ROUND_UP(ecc->strength * fls(8 * 1024),
> 8);
> 
> formule is used to translate strength in bit/1024 BCH/ECC
> to MTD ECC bytes for 1024 bytes blocks in nand->ecc.bytes
> 
> 14 is replacement for fls(8 * 1024)

This is absolutely forbidden :) You should never hide your first
intention, 14 here is a very bad placeholder because we cannot know
what it means. I suppose your intention was to optimize things. fls()
already exist in the kernel, 8 and 1024 are constants so GCC (or
whatever compiler you use) will optimize things as much as it can.
Plus, it is run only once in a lifetime so there is not so much gain
anyway.

> 8 bits in a byte

I think there is a macro for that (otherwise it is not important)

> 
> >  
> >> +	/* HW ECC only works with an even number of ECC bytes */
> >> +	nand->ecc.bytes = ALIGN(nand->ecc.bytes, 2);
> >> +
> >> +	if (ctrl->version == VERSION_9) {
> >> +		switch (nand->ecc.strength) {
> >> +		case 70:
> >> +			reg = NANDC_V9_ECC_70;
> >> +			break;
> >> +		case 60:
> >> +			reg = NANDC_V9_ECC_60;
> >> +			break;
> >> +		case 40:
> >> +			reg = NANDC_V9_ECC_40;
> >> +			break;
> >> +		case 16:
> >> +			reg = NANDC_V9_ECC_16;
> >> +			break;
> >> +		default:
> >> +			return -EINVAL;
> >> +		}
> >> +		writel(reg, ctrl->regs + NANDC_REG_V9_BCHCTL);
> >> +	} else {
> >> +		switch (nand->ecc.strength) {
> >> +		case 60:
> >> +			reg = NANDC_V6_ECC_60;
> >> +			break;
> >> +		case 40:
> >> +			reg = NANDC_V6_ECC_40;
> >> +			break;
> >> +		case 24:
> >> +			reg = NANDC_V6_ECC_24;
> >> +			break;
> >> +		case 16:
> >> +			reg = NANDC_V6_ECC_16;
> >> +			break;
> >> +		default:
> >> +			return -EINVAL;
> >> +		}
> >> +		writel(reg, ctrl->regs + NANDC_REG_V6_BCHCTL);
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static void rk_nandc_xfer_start(struct rk_nand_controller *ctrl,
> >> +				uint8_t dir, uint8_t n_KB,
> >> +				dma_addr_t dma_data, dma_addr_t
> >> dma_oob) +{
> >> +	uint32_t reg;
> >> +
> >> +	if (ctrl->version == VERSION_9) {
> >> +		reg = NANDC_V9_DMA_CFG_WR_ST |
> >> +		      NANDC_V9_DMA_CFG_WR(dir) |
> >> +		      NANDC_V9_DMA_CFG_BUS_MODE |
> >> +		      NANDC_V9_DMA_CFG_HSIZE_32 |
> >> +		      NANDC_V9_DMA_CFG_BURST_16 |
> >> +		      NANDC_V9_DMA_CFG_INCR_NUM(16);
> >> +		writel(reg, ctrl->regs + NANDC_REG_V9_DMA_CFG);
> >> +		writel((uint32_t)dma_data, ctrl->regs +
> >> NANDC_REG_V9_DMA_BUF0);
> >> +		writel((uint32_t)dma_oob, ctrl->regs +
> >> NANDC_REG_V9_DMA_BUF1);  
> >
> > I'm pretty sure most of these writel could be turned into
> > writel_relaxed.  
> 
> writel()       -- write to the little-endian hardware register with
> compiler memory barrier,
> writel_relaxed -- as above, without barrier,
> __raw_writel() -- as above (writel_relaxed()) without endianess
> conversion (CPU ordering will be used).
> Architecture-dependent.
> I don't know.

In most of the cases you don't need an explicit barrier (unless, for
instance, you are waiting for something to happen with a short timeout).

Please try with writel_relaxed in most of the cases.

> 
> >
> > Also I am not a big fan of these casts, maybe you should change
> > dma_data and dma_oob types (be careful: you enabled COMPILE_TEST in
> > Kconfig, you must support 32-bit and 64-bit pointers, please try to
> > compile this driver with different toolchains).  
> 
> Driver is used for both ARM as arm64.
> These registers are 32 bit. Please advise what happens
> when writel gets dma_addr_t and dma_data as 64 bit.
> Don't have the hardware to find out.

You don't need hardware, just a 32-bit and a 64-bit toolchain. We just
want to avoid casts and build warnings.

> 
> >  
> >> +
> >> +		reg = NANDC_V9_FL_DIR(dir) |
> >> +		      NANDC_V9_FL_XFER_EN |
> >> +		      NANDC_V9_FL_XFER_COUNT |
> >> +		      NANDC_V9_FL_ACORRECT |
> >> +		      NANDC_V9_FL_PAGE_NUM(n_KB) |
> >> +		      NANDC_V9_FL_ASYNC_TOG_MIX;
> >> +		writel(reg, ctrl->regs + NANDC_REG_V9_FLCTL);
> >> +		reg |= NANDC_V9_FL_XFER_START;
> >> +		writel(reg, ctrl->regs + NANDC_REG_V9_FLCTL);
> >> +	} else {
> >> +		reg = readl(ctrl->regs + NANDC_REG_V6_BCHCTL);
> >> +		reg = (reg & (~(NAND_V6_BCH_REGION_M <<
> >> +				NAND_V6_BCH_REGION_S))) |
> >> +		      (ctrl->selected_bank <<
> >> NAND_V6_BCH_REGION_S);
> >> +		writel(reg, ctrl->regs + NANDC_REG_V6_BCHCTL);
> >> +
> >> +		reg = NANDC_V6_DMA_CFG_WR_ST |
> >> +		      NANDC_V6_DMA_CFG_WR(dir) |
> >> +		      NANDC_V6_DMA_CFG_BUS_MODE |
> >> +		      NANDC_V6_DMA_CFG_HSIZE_32 |
> >> +		      NANDC_V6_DMA_CFG_BURST_16 |
> >> +		      NANDC_V6_DMA_CFG_INCR_NUM(16);
> >> +		writel(reg, ctrl->regs + NANDC_REG_V6_DMA_CFG);
> >> +		writel(dma_data, ctrl->regs +
> >> NANDC_REG_V6_DMA_BUF0);
> >> +		writel(dma_oob, ctrl->regs +
> >> NANDC_REG_V6_DMA_BUF1);  
> 
> Same here.
> 
> >> +
> >> +		reg = NANDC_V6_FL_DIR(dir) |
> >> +		      NANDC_V6_FL_XFER_EN |
> >> +		      NANDC_V6_FL_XFER_COUNT |
> >> +		      NANDC_V6_FL_ACORRECT |
> >> +		      NANDC_V6_FL_PAGE_NUM(n_KB) |
> >> +		      NANDC_V6_FL_ASYNC_TOG_MIX;
> >> +		writel(reg, ctrl->regs + NANDC_REG_V6_FLCTL);
> >> +		reg |= NANDC_V6_FL_XFER_START;
> >> +		writel(reg, ctrl->regs + NANDC_REG_V6_FLCTL);
> >> +	}
> >> +}
> >> +
> >> +static int rk_nandc_wait_for_xfer_done(struct rk_nand_controller
> >> *ctrl) +{
> >> +	uint32_t reg;
> >> +	int ret;
> >> +
> >> +	if (ctrl->version == VERSION_9) {
> >> +		void __iomem *ptr = ctrl->regs +
> >> NANDC_REG_V9_FLCTL; +
> >> +		ret = readl_poll_timeout_atomic(ptr, reg,
> >> +						reg &
> >> NANDC_V9_FL_XFER_READY,
> >> +						1,
> >> NANDC_DEF_TIMEOUT);
> >> +	} else {
> >> +		void __iomem *ptr = ctrl->regs +
> >> NANDC_REG_V6_FLCTL; +
> >> +		ret = readl_poll_timeout_atomic(ptr, reg,
> >> +						reg &
> >> NANDC_V6_FL_XFER_READY,
> >> +						1,
> >> NANDC_DEF_TIMEOUT);
> >> +	}  
> >
> > Space
> >  
> >> +	if (ret)
> >> +		pr_err("timeout reg=%x\n", reg);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static unsigned long rk_nandc_dma_map_single(struct device *dev,
> >> +		void *ptr, int size, int dir)  
> >  
> 
> > Unaligned parameters  
> 
> To restyle I use:
> astyle -T8 --max-code-length=80 --style=linux rockchip_nandc.c
> 
> Please advise for a better solution.

I don't know astyle, but this would certainly trigger a checkpatch.pl
warning. Just check them and correct them by hand.

> 
> >  
> >> +{
> >> +#ifdef CONFIG_ARM64
> >> +	__dma_map_area((void *)ptr, size, dir);
> >> +	return ((unsigned long)virt_to_phys((void *)ptr));
> >> +#else
> >> +	return dma_map_single(dev, (void *)ptr, size, dir);
> >> +#endif  
> >  
> 
> > Please try to remove these #ifdefs, I don't know why would you need
> > the former block?  
> 
> This driver is used both for ARM as arm64.
> Original from Rockchip: arm64 doesn't have dma_map_single() as I
> remember. Don't know what to use instead.
> Please advise.

I am not aware of such a limitation. Please check again.

> 
> >  
> >> +}
> >> +
> >> +static void rk_nandc_dma_unmap_single(struct device *dev,
> >> +				      unsigned long ptr, int
> >> size, int dir) +{
> >> +#ifdef CONFIG_ARM64
> >> +	__dma_unmap_area(phys_to_virt(ptr), size, dir);
> >> +#else
> >> +	dma_unmap_single(dev, (dma_addr_t)ptr, size, dir);
> >> +#endif  
> >
> > Same
> >  
> >> +}
> >> +
> >> +static int rk_nandc_hw_syndrome_ecc_read_page(struct nand_chip
> >> *nand,
> >> +		uint8_t *buf,
> >> +		int oob_required, int page)  
> >  
> 
> > Unaligned parameters (please check all of them).  
> 
> Again blame astyle ...
> After correcting it manually a few time I just left it as it is.
> 
> >  
> >> +{
> >> +	struct mtd_info *mtd = nand_to_mtd(nand);
> >> +	struct rk_nand_controller *ctrl =
> >> nand_get_controller_data(nand);
> >> +	struct nand_ecc_ctrl *ecc = &nand->ecc;
> >> +	int max_bitflips = 0;
> >> +	dma_addr_t dma_data, dma_oob;
> >> +	int ret, i;
> >> +	int bch_st;
> >> +	int dma_oob_size = ecc->steps * 128;
> >> +	int pages_per_blk = mtd->erasesize / mtd->writesize;
> >> +
> >> +	rk_nandc_select_chip(nand, ctrl->selected_bank);
> >> +
> >> +	if ((page < pages_per_blk * NANDC_IDBResBlkNum) &&  
> >  
> 
> > Camel case is usually not welcome  
> 
> Any suggestions for a beter replace for NANDC_IDBResBlkNum are
> welcome.

SOMETHING_LikeThis -> SOMETHING_LIKE_THIS

> 
> >  
> >> +	    ctrl->bootromblocks)  
> >
> > This would probably deserve a helper
> >  
> >> +		rk_nandc_hw_ecc_setup(nand, NANDC_IDBEccBits);
> >> +
> >> +	nand_read_page_op(nand, page, 0, NULL, 0);
> >> +
> >> +	dma_data = rk_nandc_dma_map_single(mtd->dev.parent,
> >> +					   ctrl->page_buf,
> >> mtd->writesize,
> >> +					   DMA_FROM_DEVICE);
> >> +	dma_oob = rk_nandc_dma_map_single(mtd->dev.parent,
> >> +					  ctrl->oob_buf,
> >> dma_oob_size,
> >> +					  DMA_FROM_DEVICE);
> >> +
> >> +	init_completion(&ctrl->complete);  
> >  
> 
> > One init_completion is needed (in the probe, probably) then please
> > use reinit_completion().  
> 
> Must study this later.
> 
> >  
> >> +	if (ctrl->version == VERSION_9)
> >> +		writel(NANDC_V9_INT_DMA, ctrl->regs +
> >> NANDC_REG_V9_INTEN);
> >> +	else
> >> +		writel(NANDC_V6_INT_DMA, ctrl->regs +
> >> NANDC_REG_V6_INTEN);
> >> +	rk_nandc_xfer_start(ctrl, 0, ecc->steps, dma_data,
> >> dma_oob);  
> 
> >> +	wait_for_completion_timeout(&ctrl->complete,
> >> msecs_to_jiffies(5));
> >> +	rk_nandc_wait_for_xfer_done(ctrl);  
> >
> > Yous should check the return status of almost all the functions
> > here.  
> 
> Please advise what ERROR code should be returned here
> that is compatible with MTD.

As a general rule, please check the drivers which have been updated
recently with git log --one-line -- drivers/mtd/nand/raw/

-> marvell, atmel, fsmc, sunxi, stm, cadence, etc

In this case, you can return the error code of the failing function
with a simple:

	ret = func();
	if (ret)
		return ret;

I expect the rk_nandc_wiat_for_xfer_done() helper to return -ETIMEDOUT
in case of timeout.

> 
> >  
> >> +	rk_nandc_dma_unmap_single(mtd->dev.parent, dma_data,
> >> mtd->writesize,
> >> +				  DMA_FROM_DEVICE);
> >> +	rk_nandc_dma_unmap_single(mtd->dev.parent, dma_oob,
> >> dma_oob_size,
> >> +				  DMA_FROM_DEVICE);
> >> +
> >> +	memcpy(buf, ctrl->page_buf, mtd->writesize);
> >> +
> >> +	if (oob_required) {
> >> +		uint8_t *oob;
> >> +		uint32_t tmp;  
> >  
> 
> > Please use u8, u16 and u32 types.  
> 
> Should this be changed for the entire source?

Yes, checkpatch.pl will warn you about this too. uint<x>_t types are
deprecated.

> 
> >  
> >> +
> >> +		for (i = 0; i < ecc->steps; i++) {
> >> +			oob = nand->oob_poi +
> >> +			      i * (ecc->bytes + nand->ecc.prepad);
> >> +			if (ctrl->version == VERSION_9) {
> >> +				tmp = ctrl->oob_buf[i];
> >> +			} else {
> >> +				uint8_t oob_step =
> >> (ctrl->ecc_mode <= 24) ?
> >> +						   64 : 128;
> >> +				tmp = ctrl->oob_buf[i * oob_step
> >> / 4];
> >> +			}
> >> +			*oob++ = (uint8_t)tmp;
> >> +			*oob++ = (uint8_t)(tmp >> 8);
> >> +			*oob++ = (uint8_t)(tmp >> 16);
> >> +			*oob++ = (uint8_t)(tmp >> 24);
> >> +		}
> >> +	}
> >> +
> >> +	if (ctrl->version == VERSION_9) {
> >> +		for (i = 0; i < ecc->steps / 2; i++) {
> >> +			bch_st = readl(ctrl->regs +
> >> NANDC_REG_V9_BCHST + i * 4);
> >> +			if (bch_st & NANDC_V9_BCH0_ST_ERR ||
> >> +			    bch_st & NANDC_V9_BCH1_ST_ERR) {
> >> +				mtd->ecc_stats.failed++;
> >> +				max_bitflips = -1;
> >> +			} else {
> >> +				ret =
> >> NANDC_V9_ECC_ERR_CNT0(bch_st);
> >> +				mtd->ecc_stats.corrected += ret;
> >> +				max_bitflips = max_t(unsigned int,
> >> +
> >> max_bitflips, ret); +
> >> +				ret =
> >> NANDC_V9_ECC_ERR_CNT1(bch_st);
> >> +				mtd->ecc_stats.corrected += ret;
> >> +				max_bitflips = max_t(unsigned int,
> >> +
> >> max_bitflips, ret);
> >> +			}
> >> +		}
> >> +	} else {
> >> +		for (i = 0; i < ecc->steps / 2; i++) {
> >> +			bch_st = readl(ctrl->regs +
> >> NANDC_REG_V6_BCHST + i * 4);
> >> +			if (bch_st & NANDC_V6_BCH0_ST_ERR ||
> >> +			    bch_st & NANDC_V6_BCH1_ST_ERR) {
> >> +				mtd->ecc_stats.failed++;
> >> +				max_bitflips = -1;  
> >  
> 
> > Why not using ret = $(real error) instead of using max_bitflips
> > here?
> >
> > Then:
> >
> > 	if (ret) {  
> 
> > 		dev_err();  
> 
> Do you really want to litter the kernel log with each time you hit a
> bad block,
> in case you use this function in a search bad block loop?
> Don't thinks so ...
> Please advise.

Actually I think that I was simplifying your code but you are right that
this dev_err has to be removed.

> 
> > 		return ret;
> > 	}
> >
> > 	return max_bitflips;  
> 
> rk_nandc_hw_syndrome_ecc_read_page() is used in a bad block search
> strategy. I think max_bitflips = -1 was chosen as a saver value to
> return. Please advise what number range MTD interprets as
> max_bitflips or as fault. Also consider some uncontrolled status
> return value, it would be better if we
> are in control of what goes return.

max_bitflip is a local variable, I'm just saying that using max_bitflip
to save an error code is bad.

You can check what other drivers do.

> 
> >  
> >> +			} else {
> >> +				ret =
> >> NANDC_V6_ECC_ERR_CNT0(bch_st);
> >> +				mtd->ecc_stats.corrected += ret;
> >> +				max_bitflips = max_t(unsigned int,
> >> +
> >> max_bitflips, ret); +
> >> +				ret =
> >> NANDC_V6_ECC_ERR_CNT1(bch_st);
> >> +				mtd->ecc_stats.corrected += ret;
> >> +				max_bitflips = max_t(unsigned int,
> >> +
> >> max_bitflips, ret);
> >> +			}
> >> +		}
> >> +	}
> >> +
> >> +	if (max_bitflips == -1) {
> >> +		dev_err(mtd->dev.parent,
> >> +			"read_page %x %x %x %x %x %p %x\n",
> >> +			page,
> >> +			max_bitflips,
> >> +			bch_st,
> >> +			((uint32_t *)buf)[0],
> >> +			((uint32_t *)buf)[1],
> >> +			buf,
> >> +			(uint32_t)dma_data);  
> >  

[...]

> >> +
> >> +	for (offs = 0; offs < len; offs++)
> >> +		buf[offs] = readb(bank_base);
> >> +}
> >> +
> >> +static void rk_nandc_write_buf(struct nand_chip *nand,
> >> +			       const uint8_t *buf, int len)
> >> +{
> >> +	struct rk_nand_controller *ctrl =
> >> nand_get_controller_data(nand);
> >> +	int offs = 0;
> >> +	void __iomem *bank_base = ctrl->regs + NANDC_REG_BANK0 +
> >> +				  ctrl->selected_bank * 0x100;
> >> +
> >> +	for (offs = 0; offs < len; offs++)
> >> +		writeb(buf[offs], bank_base);
> >> +}
> >> +
> >> +static void rk_nandc_write_cmd(struct nand_chip *nand, uint8_t
> >> cmd) +{
> >> +	struct rk_nand_controller *ctrl =
> >> nand_get_controller_data(nand); +
> >> +	void __iomem *bank_base = ctrl->regs + NANDC_REG_BANK0 +
> >> +				  ctrl->selected_bank * 0x100 +
> >> +				  NANDC_REG_CMD;  
> >  
> 
> > You might want to write an helper to calculate bank_base, to avoid
> > repeating these lines.  
> 
> Even with a separate define or helper function I still have to supply
> my reg, selected_bank and offset. It doesn't make things cleaner
> pumping date
> to and from a helper or neither doesn't it shorten my source with a
> define. Tend to keep it as it is for now. If you agree of course.

#define RK_REG(ctrl, off) \
	(ctrl)->regs + \
	NANDC_REG_BANK0 + \
	(ctrl)->selected_bank * BANK_SIZE + \
	(off)

#define RK_REG_CMD(ctrl) RK_REG(ctrl, NANDC_REG_CMD)

> 
> >  
> >> +
> >> +	writeb(cmd, bank_base);
> >> +}
> >> +
> >> +static void rk_nandc_write_addr(struct nand_chip *nand, uint8_t
> >> addr) +{
> >> +	struct rk_nand_controller *ctrl =
> >> nand_get_controller_data(nand); +
> >> +	void __iomem *bank_base = ctrl->regs + NANDC_REG_BANK0 +
> >> +				  ctrl->selected_bank * 0x100 +
> >> +				  NANDC_REG_ADDR;
> >> +
> >> +	writeb(addr, bank_base);
> >> +}
> >> +
> >> +static int rk_nandc_dev_ready(struct nand_chip *nand)
> >> +{
> >> +	struct rk_nand_controller *ctrl =
> >> nand_get_controller_data(nand); +
> >> +	if (readl(ctrl->regs + NANDC_REG_V6_FMCTL) &
> >> NANDC_V6_FM_FREADY)
> >> +		return 1;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int rk_nandc_ooblayout_ecc(struct mtd_info *mtd, int
> >> section,
> >> +				  struct mtd_oob_region
> >> *oobregion) +{
> >> +	struct nand_chip *nand = mtd_to_nand(mtd);
> >> +
> >> +	if (section >= nand->ecc.steps)
> >> +		return -ERANGE;
> >> +
> >> +	oobregion->offset = (nand->ecc.bytes + nand->ecc.prepad)
> >> * section +
> >> +			    nand->ecc.prepad;
> >> +	oobregion->length = nand->ecc.steps * nand->ecc.bytes;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int rk_nandc_ooblayout_free(struct mtd_info *mtd, int
> >> section,
> >> +				   struct mtd_oob_region
> >> *oobregion) +{
> >> +	struct nand_chip *nand = mtd_to_nand(mtd);
> >> +
> >> +	if (section >= nand->ecc.steps)
> >> +		return -ERANGE;
> >> +
> >> +	oobregion->offset = (nand->ecc.bytes + nand->ecc.prepad)
> >> * section;
> >> +	oobregion->length = nand->ecc.steps * nand->ecc.prepad;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct mtd_ooblayout_ops rk_nandc_oob_ops = {
> >> +	.ecc = rk_nandc_ooblayout_ecc,
> >> +	.free = rk_nandc_ooblayout_free,
> >> +};
> >> +
> >> +static void rk_nandc_free_buffer(struct nand_chip *nand)
> >> +{
> >> +	struct rk_nand_controller *ctrl =
> >> nand_get_controller_data(nand); +
> >> +	kfree(ctrl->page_buf);
> >> +	kfree(ctrl->oob_buf);
> >> +}
> >> +
> >> +static int rk_nandc_buffer_init(struct nand_chip *nand)
> >> +{
> >> +	struct mtd_info *mtd = nand_to_mtd(nand);
> >> +	struct rk_nand_controller *ctrl =
> >> nand_get_controller_data(nand); +
> >> +	ctrl->page_buf = kmalloc(mtd->writesize, GFP_KERNEL |
> >> GFP_DMA);  
> >  
> 
> > device managed allocations (devm_...) would be nice  
> 
> devm_kzalloc() needs an extra struct device.
> Does MTD safe-gard the correct order to detach from struct
> rk_nand_controller
> without rk_nandc_free_buffer()?

&pdev->dev is fine, you can save it your own nand controller structure.

I think accessing mtd->dev is not allowed before the registration of
the MTD device though.

> 
> >  
> >> +	if (!ctrl->page_buf)
> >> +		return -ENOMEM;
> >> +
> >> +	ctrl->oob_buf = kmalloc(nand->ecc.steps * 128, GFP_KERNEL
> >> | GFP_DMA);
> >> +	if (!ctrl->oob_buf) {
> >> +		kfree(ctrl->page_buf);
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int rk_nandc_hw_ecc_ctrl_init(struct nand_chip *nand)
> >> +{
> >> +	uint8_t strengths_v6[] = {60, 40, 24, 16};
> >> +	uint8_t strengths_v9[] = {70, 60, 40, 16};
> >> +	struct mtd_info *mtd = nand_to_mtd(nand);
> >> +	struct rk_nand_controller *ctrl =
> >> nand_get_controller_data(nand);
> >> +	int max_strength;
> >> +	uint32_t i, ver;
> >> +
> >> +	if (nand->options & NAND_IS_BOOT_MEDIUM)
> >> +		ctrl->bootromblocks = true;
> >> +	else
> >> +		ctrl->bootromblocks = false;
> >> +
> >> +	nand->ecc.prepad = 4;
> >> +	nand->ecc.steps = mtd->writesize / nand->ecc.size;
> >> +
> >> +	max_strength = ((mtd->oobsize / nand->ecc.steps) - 4) * 8
> >> / 14;
> >> +	if (ctrl->version == VERSION_9) {
> >> +		ctrl->max_ecc_strength = 70;
> >> +		ver = readl(ctrl->regs + NANDC_REG_V9_VER);
> >> +		if (ver != NANDC_ID_V900)
> >> +			dev_err(mtd->dev.parent,
> >> +				"unsupported nandc version %x\n",
> >> ver); +
> >> +		if (max_strength > ctrl->max_ecc_strength)
> >> +			max_strength = ctrl->max_ecc_strength;
> >> +
> >> +		for (i = 0; i < ARRAY_SIZE(strengths_v9); i++) {
> >> +			if (max_strength >= strengths_v9[i])
> >> +				break;
> >> +		}
> >> +
> >> +		if (i >= ARRAY_SIZE(strengths_v9)) {
> >> +			dev_err(mtd->dev.parent,
> >> +				"unsupported strength\n");
> >> +			return -ENOTSUPP;
> >> +		}
> >> +
> >> +		ctrl->ecc_mode = strengths_v9[i];
> >> +	} else {
> >> +		ctrl->max_ecc_strength = 60;
> >> +
> >> +		ver = readl(ctrl->regs + NANDC_REG_V6_VER);
> >> +		if (ver == NANDC_ID_V801)
> >> +			ctrl->max_ecc_strength = 16;
> >> +		else if (ver == NANDC_ID_V600 ||
> >> +			 ver == NANDC_ID_V622 ||  
> 
> >> +			 ver == NANDC_ID_V701 ||  
> 
> Added version 7 for RK3228A/RK3228B. Can someone with insider info
> confirm if this works or not.
> 
> >> +			 ver == NANDC_ID_V800)
> >> +			ctrl->max_ecc_strength = 60;
> >> +		else
> >> +			dev_err(mtd->dev.parent,
> >> +				"unsupported nandc version %x\n",
> >> ver); +
> >> +		if (max_strength > ctrl->max_ecc_strength)
> >> +			max_strength = ctrl->max_ecc_strength;
> >> +
> >> +		for (i = 0; i < ARRAY_SIZE(strengths_v6); i++) {
> >> +			if (max_strength >= strengths_v6[i])
> >> +				break;
> >> +		}
> >> +
> >> +		if (i >= ARRAY_SIZE(strengths_v6)) {
> >> +			dev_err(mtd->dev.parent,
> >> +				"unsupported strength\n");
> >> +			return -ENOTSUPP;
> >> +		}
> >> +
> >> +		ctrl->ecc_mode = strengths_v6[i];
> >> +	}
> >> +	rk_nandc_hw_ecc_setup(nand, ctrl->ecc_mode);
> >> +
> >> +	mtd_set_ooblayout(mtd, &rk_nandc_oob_ops);
> >> +
> >> +	if (mtd->oobsize < ((nand->ecc.bytes + nand->ecc.prepad) *
> >> +			    nand->ecc.steps)) {
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static void rk_nandc_detach_chip(struct nand_chip *nand)
> >> +{
> >> +	switch (nand->ecc.mode) {
> >> +	case NAND_ECC_HW_SYNDROME:
> >> +		rk_nandc_free_buffer(nand);
> >> +		break;
> >> +	default:
> >> +		break;
> >> +	}
> >> +}
> >> +
> >> +static int rk_nandc_attach_chip(struct nand_chip *nand)
> >> +{
> >> +	struct mtd_info *mtd = nand_to_mtd(nand);
> >> +	int ret;
> >> +
> >> +	switch (nand->ecc.mode) {
> >> +	case NAND_ECC_HW_SYNDROME:
> >> +		ret = rk_nandc_hw_ecc_ctrl_init(nand);
> >> +		if (ret)
> >> +			return ret;
> >> +		ret = rk_nandc_buffer_init(nand);
> >> +		if (ret)
> >> +			return -ENOMEM;
> >> +		nand->ecc.read_page =
> >> rk_nandc_hw_syndrome_ecc_read_page;
> >> +		nand->ecc.write_page =
> >> rk_nandc_hw_syndrome_ecc_write_page;
> >> +		nand->ecc.read_oob = rk_nandc_hw_ecc_read_oob;
> >> +		nand->ecc.write_oob = rk_nandc_hw_ecc_write_oob;
> >> +		break;
> >> +	case NAND_ECC_HW:  
> >
> > I would either refuse ECC_HW or put it besides HW_SYNDROME.  
> 
> Is there a fundamental difference in handling ECC_HW and HW_SYNDROME
> from the MTD point of view? Other then a indication how it's done on
> the driver side?

I don't think so..

> Will drop it.
> 
> >  
> >> +	case NAND_ECC_NONE:
> >> +	case NAND_ECC_SOFT:  
> >  
> 
> > Have you tested with SW BCH?  
> 
> Short answer: No
> Just copied it from the original.
> Please advise a tool to do a test between the individual ecc read
> options. Or do I have to write the tool my self with mtd-utils?

All the tools are already available. nand_test, flash_speed,
nandbiterrs -i, etc

> 
> >  
> >> +		break;
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int rk_nandc_exec_op(struct nand_chip *nand,
> >> +			    const struct nand_operation *op,
> >> +			    bool check_only)
> >> +{
> >> +	int i;
> >> +	unsigned int op_id;
> >> +	const struct nand_op_instr *instr = NULL;
> >> +
> >> +	rk_nandc_select_chip(nand, op->cs);
> >> +
> >> +	if (check_only)
> >> +		return 0;
> >> +
> >> +	for (op_id = 0; op_id < op->ninstrs; op_id++) {
> >> +		instr = &op->instrs[op_id];
> >> +
> >> +		switch (instr->type) {
> >> +		case NAND_OP_CMD_INSTR:
> >> +			rk_nandc_write_cmd(nand,
> >> instr->ctx.cmd.opcode);
> >> +			break;
> >> +		case NAND_OP_ADDR_INSTR:
> >> +			for (i = 0; i < instr->ctx.addr.naddrs;
> >> i++)
> >> +				rk_nandc_write_addr(nand,
> >> +
> >> instr->ctx.addr.addrs[i]);
> >> +			break;
> >> +		case NAND_OP_DATA_IN_INSTR:
> >> +			rk_nandc_read_buf(nand,
> >> instr->ctx.data.buf.in,
> >> +					  instr->ctx.data.len);
> >> +			break;
> >> +		case NAND_OP_DATA_OUT_INSTR:
> >> +			rk_nandc_write_buf(nand,
> >> instr->ctx.data.buf.out,
> >> +					   instr->ctx.data.len);
> >> +			break;
> >> +		case NAND_OP_WAITRDY_INSTR:
> >> +			rk_nandc_dev_ready(nand);
> >> +			break;
> >> +		}
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct nand_controller_ops rk_nand_controller_ops = {
> >> +	.attach_chip = rk_nandc_attach_chip,
> >> +	.detach_chip = rk_nandc_detach_chip,
> >> +	.exec_op = rk_nandc_exec_op,
> >> +};
> >> +
> >> +static int rk_nandc_chip_init(struct device *dev,
> >> +			      struct rk_nand_controller *ctrl,
> >> +			      struct device_node *np, unsigned
> >> int chipnr) +{
> >> +	struct rk_nand_chip *node;
> >> +	struct nand_chip *nand;
> >> +	struct mtd_info *mtd;
> >> +	const __be32 *reg;
> >> +	int ret;
> >> +
> >> +	reg = of_get_property(np, "reg", NULL);
> >> +	if (!reg)
> >> +		return -EINVAL;
> >> +
> >> +	ctrl->banks[chipnr] = be32_to_cpu(*reg);
> >> +
> >> +	if (ctrl->banks[chipnr] < 0)
> >> +		return -EINVAL;
> >> +
> >> +	node = devm_kzalloc(dev, sizeof(*node), GFP_KERNEL);
> >> +	if (!node)
> >> +		return -ENOMEM;
> >> +
> >> +	nand = &node->nand;
> >> +
> >> +	nand_set_flash_node(nand, np);
> >> +	nand_set_controller_data(nand, ctrl);
> >> +
> >> +	nand->controller = &ctrl->controller;
> >> +	nand->controller->ops = &rk_nand_controller_ops;
> >> +
> >> +	nand->ecc.mode = NAND_ECC_HW_SYNDROME;
> >> +	nand->ecc.size = 1024;
> >> +	nand->ecc.strength = 40;
> >> +
> >> +	nand->options = NAND_SKIP_BBTSCAN | NAND_NO_SUBPAGE_WRITE;
> >> +
> >> +	mtd = nand_to_mtd(nand);
> >> +	mtd->dev.parent = dev;
> >> +	mtd->name = devm_kasprintf(dev, GFP_KERNEL, "%s.%d",
> >> dev_name(dev),
> >> +				   ctrl->banks[chipnr]);
> >> +
> >> +	ret = nand_scan(nand, 1);  
> >
> > Why 1 here?  
> 
> TODO for version 2.
> A little misunderstanding on how for_each_child_of_node works.
> All chips should be scanned.
> /////
> Derive chipnr
> Example from sunxi_nand.c
> 
> 	if (!of_get_property(np, "reg", &nsels))
> 		return -EINVAL;
> 
> 	nsels /= sizeof(u32);
> 	if (!nsels) {
> 		dev_err(dev, "invalid reg property size\n");
> 		return -EINVAL;
> 	}
> /////
> From rk_nandc_chips_init()
> 
> 	for_each_child_of_node(np, nand_np) {
> 		ret = rk_nandc_chip_init(dev, ctrl, nand_np, i);
> 
> Why does sunxi_nand.c need this extra for_each_child_of_node?

for_each_child_of_node will loop over all the NAND chips that are
connected to the NAND controller.

You may have -depending on the NAND controller- more than one CS per
chip.


[...]

> >> +	node = pdev->dev.of_node;
> >> +
> >> +	id = of_alias_get_id(node, "nandc");
> >> +	if (id < 0)
> >> +		id = g_id_counter;
> >> +	if ((id >= ARRAY_SIZE(g_nandc_info) ||
> >> g_nandc_info[id].regs)) {
> >> +		dev_err(
> >> +			&pdev->dev,
> >> +			"failed to get id for nandc node
> >> '%pOFn'\n",
> >> +			node);
> >> +		of_node_put(node);
> >> +		return -ENODEV;
> >> +	}
> >> +	++g_id_counter;  
> 
> See comments above about Rk3288. Keeping track node alias for nandc0.
> To remove or not?

You may keep a static variable to point to an array or have a static
counter that you increment, but definitely not static structures that
would be shared. If there are two distinct NAND controllers, you must
have distinct path/structures.

->probe() will be run once for each NAND controller.


Thanks,
Miquèl
