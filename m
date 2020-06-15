Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BE6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BDE1206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgFOKSz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:18:55 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:37549 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbgFOKSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:18:52 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B6BCCC000C;
        Mon, 15 Jun 2020 10:18:44 +0000 (UTC)
Date:   Mon, 15 Jun 2020 12:18:41 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?6LW15Luq5bOw?= <yifeng.zhao@rock-chips.com>
Cc:     "Johan Jonker" <jbx6244@gmail.com>, richard <richard@nod.at>,
        vigneshr <vigneshr@ti.com>, robh+dt <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        =?UTF-8?B?SGVpa29TdMO8Ym5lcg==?= <heiko@sntech.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308,
 RK2928 and others
Message-ID: <20200615121841.566b81f5@xps13>
In-Reply-To: <2020061517300662418531@rock-chips.com>
References: <20200609074020.23860-1-yifeng.zhao@rock-chips.com>
        <20200609074020.23860-3-yifeng.zhao@rock-chips.com>
        <7e4ce8b1-73c4-8b9a-5726-b121f53de8df@gmail.com>
        <2020061517300662418531@rock-chips.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 赵仪峰,

赵仪峰 <yifeng.zhao@rock-chips.com> wrote on Mon, 15 Jun 2020 17:34:14
+0800:

> Hi Johan,
> 
> Johan Jonker <jbx6244@gmail.com> wrote on Sat, 13 Jun 2020 15:31:52
> +0200:
> >Hi Yifeng, Miquel,
> >
> >Some more comments about swap();
> >
> >On 6/9/20 9:40 AM, Yifeng Zhao wrote:
> >
> >[..]
> >  
> >> +static int rk_nfc_ooblayout_free(struct mtd_info *mtd, int section,
> >> +	struct mtd_oob_region *oob_region)
> >> +{
> >> +	struct nand_chip *chip = mtd_to_nand(mtd);
> >> +  
> >  
> >> +	if (section >= chip->ecc.steps)
> >> +	return -ERANGE;  
> >
> >Given:
> >
> >NFC_SYS_DATA_SIZE = 4
> >chip->ecc.steps = 8
> >section [0..7]
> >
> >Total free OOB size advertised to the MTD framework is:
> >
> >ecc.steps * NFC_SYS_DATA_SIZE - 1 BBM
> >8 * 4 - 1 = 31 bytes
> >
> >With link address in OOB byte [0..3] this become:
> >31 - 4 = 27 bytes
> >
> >Does that give data lost?
> >Should we limit the number of free OOB bytes by 4 more to be save?
> >Is my calculation correct?
> >See further questions about this below.
> >  
> >> +
> >> +	if (!section) {
> >> +	/* The first byte is bad block mask flag. */
> >> +	oob_region->length = NFC_SYS_DATA_SIZE - 1;
> >> +	oob_region->offset = 1;
> >> +	} else {
> >> +	oob_region->length = NFC_SYS_DATA_SIZE;
> >> +	oob_region->offset = section * NFC_SYS_DATA_SIZE;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int rk_nfc_ooblayout_ecc(struct mtd_info *mtd, int section,
> >> +	struct mtd_oob_region *oob_region)
> >> +{
> >> +	struct nand_chip *chip = mtd_to_nand(mtd);
> >> +  
> >  
> >> +	if (section)
> >> +	return -ERANGE;  
> >
> >With the formule above a section > 0 does not alow ECC.
> >
> >Just a question about the MTD inner working for Miquel:
> >
> >With ooblayout_free using 8 steps and this just 1 does it still generate
> >the correct ECC? Does it calculate ECC over 1024B or over 8*1024B ?
> >
> >Should we move the text that explains the layout closer to these
> >functions and add a little more text to explain why we choose this
> >particular layout?
> >
> >/*
> > * NFC Page Data Layout:
> > *	1024 Bytes Data + 4Bytes sys data + 28Bytes~124Bytes ecc +
> > *	1024 Bytes Data + 4Bytes sys data + 28Bytes~124Bytes ecc +
> > *	......
> > * NAND Page Data Layout:
> > *	1024 * n Data + m Bytes oob
> > * Original Bad Block Mask Location:
> > *	First byte of oob(spare).
> > * nand_chip->oob_poi data layout:
> > *	4Bytes sys data + .... + 4Bytes sys data + ecc data.
> > */
> >
> >We expect now ECC data after n steps * 4 OOB bytes,
> >but are we still using it with HW ECC or only for raw?
> >  
> >> +
> >> +	oob_region->offset = NFC_SYS_DATA_SIZE * chip->ecc.steps;
> >> +	oob_region->length = mtd->oobsize - oob_region->offset;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct mtd_ooblayout_ops rk_nfc_ooblayout_ops = {
> >> +	.free = rk_nfc_ooblayout_free,
> >> +	.ecc = rk_nfc_ooblayout_ecc,
> >> +};  
> >
> >[..]
> >  
> >> +static int rk_nfc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
> >> +	     const u8 *buf, int page, int raw)
> >> +{
> >> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> >> +	struct rk_nfc_nand_chip *rk_nand = to_rk_nand(chip);
> >> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> >> +	int oob_step = (ecc->bytes > 60) ? NFC_MAX_OOB_PER_STEP :
> >> +	NFC_MIN_OOB_PER_STEP;
> >> +	int pages_per_blk = mtd->erasesize / mtd->writesize;
> >> +	int ret = 0, i, boot_rom_mode = 0;
> >> +	dma_addr_t dma_data, dma_oob;
> >> +	u32 reg;
> >> +	u8 *oob;
> >> +
> >> +	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> >> +
> >> +	if (!raw) {
> >> +	memcpy(nfc->page_buf, buf, mtd->writesize);
> >> +	memset(nfc->oob_buf, 0xff, oob_step * ecc->steps);
> >> +
> >> +	/*
> >> +	* The first 8(some devices are 4 or 16) blocks in use by
> >> +	* the boot ROM and the first 32 bits of oob need to link
> >> +	* to the next page address in the same block.
> >> +	* Config the ECC algorithm supported by the boot ROM.
> >> +	*/
> >> +	if (page < pages_per_blk * rk_nand->boot_blks &&
> >> +	    chip->options & NAND_IS_BOOT_MEDIUM) {
> >> +	boot_rom_mode = 1;
> >> +	if (rk_nand->boot_ecc != ecc->strength)
> >> +	rk_nfc_hw_ecc_setup(chip, ecc,
> >> +	    rk_nand->boot_ecc);
> >> +	}
> >> +
> >> +	/*
> >> +	* Swap the first oob with the seventh oob and bad block
> >> +	* mask is saved at the seventh oob.
> >> +	*/
> >> +	swap(chip->oob_poi[0], chip->oob_poi[7]);  
> >
> >Add more info on why this is swapped.
> >
> >LA[0..3] is a link address that the BBM shouldn't over write.
> >For Yifeng: Is there an other reason?  
> 
> No other reason，this swap ops only for the link address.
> 
> >Before swap:
> >
> >BBM  OOB1 OOB2 OOB3, OOB4 OOB5 OOB6 OOB7, OOB8 ....
> >
> >After swap:
> >
> >OOB7 OOB1 OOB2 OOB3, OOB4 OOB5 OOB6 BBM , OOB8 ....
> >
> >If (!i && boot_rom_mode):
> >
> >LA0  LA1  LA2  LA3 , OOB4 OOB5 OOB6 BBM , OOB8 ....
> >
> >Read back after swap again:
> >
> >BBM  LA1  LA2  LA3 , OOB4 OOB5 OOB6 LA0 , OOB8 ....
> >
> >Question:
> >Are data OOB7 OOB1 OOB2 OOB3 lost now?
> >Is this correct?  
> 
> Yes, the data OOB7 OOB1 OOB2 OOB3 will lost in the blocks which used for the boot ROM.
> 
> >#################################################
> >Proposal:
> >Should we reduce the free OOB size by 4
> >and shift everything 4 bytes to recover all bytes?
> >Replace the first 4 bytes with 0XFF or LA[0..3].
> >
> >Normal:
> >0xFF 0XFF 0XFF 0xFF, BBM  OOB1 OOB2 OOB3, OOB4
> >
> >If (!i && boot_rom_mode):
> >LA0  LA1  LA2  LA3 , BBM  OOB1 OOB2 OOB3, OOB4
> >
> >Question for Miquel and Yifeng:
> >Does this work? Could you test?  
> 
> I want to modify the drivers in next version:
> The data swap ops only done for the blocks which used for the boot ROM，In this way,
> the specially processed code will not affect the rest blocks.
> For Miquel and Yifeng:
> Is this OK？

So I guess this linking property is only for the BootROM? I am not sure
what is best but I guess keeping the same layout everywhere is better.
Johan proposal would be good to try.

Thanks,
Miquèl
