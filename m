Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B498DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9811A2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgFOHrJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:47:09 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42705 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgFOHrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:47:09 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 928171C0003;
        Mon, 15 Jun 2020 07:47:01 +0000 (UTC)
Date:   Mon, 15 Jun 2020 09:47:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Yifeng Zhao <yifeng.zhao@rock-chips.com>, richard@nod.at,
        vigneshr@ti.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
        heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308,
 RK2928 and others
Message-ID: <20200615094700.69342be1@xps13>
In-Reply-To: <7e4ce8b1-73c4-8b9a-5726-b121f53de8df@gmail.com>
References: <20200609074020.23860-1-yifeng.zhao@rock-chips.com>
        <20200609074020.23860-3-yifeng.zhao@rock-chips.com>
        <7e4ce8b1-73c4-8b9a-5726-b121f53de8df@gmail.com>
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

Johan Jonker <jbx6244@gmail.com> wrote on Sat, 13 Jun 2020 15:31:52
+0200:

> Hi Yifeng, Miquel,
> 
> Some more comments about swap();
> 
> On 6/9/20 9:40 AM, Yifeng Zhao wrote:
> 
> [..]
> 
> > +static int rk_nfc_ooblayout_free(struct mtd_info *mtd, int section,
> > +				 struct mtd_oob_region *oob_region)
> > +{
> > +	struct nand_chip *chip = mtd_to_nand(mtd);
> > +  
> 
> > +	if (section >= chip->ecc.steps)
> > +		return -ERANGE;  
> 
> Given:
> 
> NFC_SYS_DATA_SIZE = 4
> chip->ecc.steps = 8
> section [0..7]
> 
> Total free OOB size advertised to the MTD framework is:
> 
> ecc.steps * NFC_SYS_DATA_SIZE - 1 BBM
> 8 * 4 - 1 = 31 bytes
> 
> With link address in OOB byte [0..3] this become:
> 31 - 4 = 27 bytes
> 
> Does that give data lost?
> Should we limit the number of free OOB bytes by 4 more to be save?
> Is my calculation correct?

I don't know what link address is, but yes if it's an area used by the
controller for whatever reason it should be left alone, neither "free"
nor "ecc".

> 
> See further questions about this below.
> 
> > +
> > +	if (!section) {
> > +		/* The first byte is bad block mask flag. */
> > +		oob_region->length = NFC_SYS_DATA_SIZE - 1;
> > +		oob_region->offset = 1;
> > +	} else {
> > +		oob_region->length = NFC_SYS_DATA_SIZE;
> > +		oob_region->offset = section * NFC_SYS_DATA_SIZE;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int rk_nfc_ooblayout_ecc(struct mtd_info *mtd, int section,
> > +				struct mtd_oob_region *oob_region)
> > +{
> > +	struct nand_chip *chip = mtd_to_nand(mtd);
> > +  
> 
> > +	if (section)
> > +		return -ERANGE;  
> 
> With the formule above a section > 0 does not alow ECC.
> 
> Just a question about the MTD inner working for Miquel:
> 
> With ooblayout_free using 8 steps and this just 1 does it still generate
> the correct ECC? Does it calculate ECC over 1024B or over 8*1024B ?

These functions do not generate anything and it's just a helper to
retrieve the ECC or free bytes, meaning that if you have 4 ECC bytes
per step, all concatenated, you will end with with an unique  ECC
section of 8 * 4 ECC bytes, this is perfectly fine.

> 
> Should we move the text that explains the layout closer to these
> functions and add a little more text to explain why we choose this
> particular layout?

Yes please.

> 
> /*
>  * NFC Page Data Layout:
>  *	1024 Bytes Data + 4Bytes sys data + 28Bytes~124Bytes ecc +
>  *	1024 Bytes Data + 4Bytes sys data + 28Bytes~124Bytes ecc +
>  *	......
>  * NAND Page Data Layout:
>  *	1024 * n Data + m Bytes oob
>  * Original Bad Block Mask Location:
>  *	First byte of oob(spare).
>  * nand_chip->oob_poi data layout:
>  *	4Bytes sys data + .... + 4Bytes sys data + ecc data.
>  */
> 
> We expect now ECC data after n steps * 4 OOB bytes,

fine

> but are we still using it with HW ECC or only for raw?

both, you need to ensure reading a raw pages gives you a regular
data+ecc organization instead of the NFC's layout.

> 
> > +
> > +	oob_region->offset = NFC_SYS_DATA_SIZE * chip->ecc.steps;
> > +	oob_region->length = mtd->oobsize - oob_region->offset;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct mtd_ooblayout_ops rk_nfc_ooblayout_ops = {
> > +	.free = rk_nfc_ooblayout_free,
> > +	.ecc = rk_nfc_ooblayout_ecc,
> > +};  
> 
> [..]
> 
> > +static int rk_nfc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
> > +			     const u8 *buf, int page, int raw)
> > +{
> > +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> > +	struct rk_nfc_nand_chip *rk_nand = to_rk_nand(chip);
> > +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> > +	int oob_step = (ecc->bytes > 60) ? NFC_MAX_OOB_PER_STEP :
> > +			NFC_MIN_OOB_PER_STEP;
> > +	int pages_per_blk = mtd->erasesize / mtd->writesize;
> > +	int ret = 0, i, boot_rom_mode = 0;
> > +	dma_addr_t dma_data, dma_oob;
> > +	u32 reg;
> > +	u8 *oob;
> > +
> > +	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> > +
> > +	if (!raw) {
> > +		memcpy(nfc->page_buf, buf, mtd->writesize);
> > +		memset(nfc->oob_buf, 0xff, oob_step * ecc->steps);
> > +
> > +		/*
> > +		 * The first 8(some devices are 4 or 16) blocks in use by
> > +		 * the boot ROM and the first 32 bits of oob need to link
> > +		 * to the next page address in the same block.
> > +		 * Config the ECC algorithm supported by the boot ROM.
> > +		 */
> > +		if (page < pages_per_blk * rk_nand->boot_blks &&
> > +		    chip->options & NAND_IS_BOOT_MEDIUM) {
> > +			boot_rom_mode = 1;
> > +			if (rk_nand->boot_ecc != ecc->strength)
> > +				rk_nfc_hw_ecc_setup(chip, ecc,
> > +						    rk_nand->boot_ecc);
> > +		}
> > +
> > +		/*
> > +		 * Swap the first oob with the seventh oob and bad block
> > +		 * mask is saved at the seventh oob.
> > +		 */
> > +		swap(chip->oob_poi[0], chip->oob_poi[7]);  
> 
> Add more info on why this is swapped.
> 
> LA[0..3] is a link address that the BBM shouldn't over write.
> For Yifeng: Is there an other reason?
> 
> Before swap:
> 
> BBM  OOB1 OOB2 OOB3, OOB4 OOB5 OOB6 OOB7, OOB8 ....
> 
> After swap:
> 
> OOB7 OOB1 OOB2 OOB3, OOB4 OOB5 OOB6 BBM , OOB8 ....
> 
> If (!i && boot_rom_mode):
> 
> LA0  LA1  LA2  LA3 , OOB4 OOB5 OOB6 BBM , OOB8 ....
> 
> Read back after swap again:
> 
> BBM  LA1  LA2  LA3 , OOB4 OOB5 OOB6 LA0 , OOB8 ....
> 
> Question:
> Are data OOB7 OOB1 OOB2 OOB3 lost now?
> Is this correct?
> 
> #################################################
> Proposal:
> Should we reduce the free OOB size by 4
> and shift everything 4 bytes to recover all bytes?
> Replace the first 4 bytes with 0XFF or LA[0..3].
> 
> Normal:
> 0xFF 0XFF 0XFF 0xFF, BBM  OOB1 OOB2 OOB3, OOB4
> 
> If (!i && boot_rom_mode):
> LA0  LA1  LA2  LA3 , BBM  OOB1 OOB2 OOB3, OOB4
> 
> Question for Miquel and Yifeng:
> Does this work? Could you test?
> 
> > +
> > +		for (i = 0; i < ecc->steps; i++) {  
> 
> Just a proposel:
> 
> 		if (!i && boot_rom_mode)
> 			reg = (page & (pages_per_blk - 1)) * 4;
> 		else if (!i)
> 			reg = 0xFFFFFFFF;
> 		else	
> 			oob = chip->oob_poi + (i-1) * NFC_SYS_DATA_SIZE;
> 			reg = oob[0] | oob[1] << 8 | oob[2] << 16 |
> 			      oob[3] << 24;
> 
> > +
> > +			if (nfc->cfg->type == NFC_V6 ||
> > +			    nfc->cfg->type == NFC_V8)
> > +				nfc->oob_buf[i * oob_step / 4] = reg;
> > +			else
> > +				nfc->oob_buf[i] = reg;
> > +		}
> > +
> > +		dma_data = dma_map_single(nfc->dev, (void *)nfc->page_buf,
> > +					  mtd->writesize, DMA_TO_DEVICE);
> > +		dma_oob = dma_map_single(nfc->dev, nfc->oob_buf,
> > +					 ecc->steps * oob_step,
> > +					 DMA_TO_DEVICE);
> > +
> > +		reinit_completion(&nfc->done);
> > +		writel(INT_DMA, nfc->regs + nfc->cfg->int_en_off);
> > +
> > +		rk_nfc_xfer_start(nfc, NFC_WRITE, ecc->steps, dma_data,
> > +				  dma_oob);
> > +		ret = wait_for_completion_timeout(&nfc->done,
> > +						  msecs_to_jiffies(100));
> > +		if (!ret)
> > +			dev_warn(nfc->dev, "write: wait dma done timeout.\n");
> > +		/*
> > +		 * Whether the DMA transfer is completed or not. The driver
> > +		 * needs to check the NFC`s status register to see if the data
> > +		 * transfer was completed.
> > +		 */
> > +		ret = rk_nfc_wait_for_xfer_done(nfc);
> > +
> > +		dma_unmap_single(nfc->dev, dma_data, mtd->writesize,
> > +				 DMA_TO_DEVICE);
> > +		dma_unmap_single(nfc->dev, dma_oob, ecc->steps * oob_step,
> > +				 DMA_TO_DEVICE);
> > +
> > +		if (boot_rom_mode && rk_nand->boot_ecc != ecc->strength)
> > +			rk_nfc_hw_ecc_setup(chip, ecc, ecc->strength);
> > +
> > +		if (ret) {
> > +			ret = -EIO;
> > +			dev_err(nfc->dev,
> > +				 "write: wait transfer done timeout.\n");
> > +		}
> > +	} else {
> > +		rk_nfc_write_buf(chip, buf, mtd->writesize + + mtd->oobsize);  
> 
> Remove a '+'
> 
> > +	}
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nand_prog_page_end_op(chip);
> > +
> > +	/* Deselect the currently selected target. */
> > +	rk_nfc_select_chip(chip, -1);
> > +
> > +	return ret;
> > +}
> > +
> > +static int rk_nfc_write_page_raw(struct nand_chip *chip, const u8 *buf,
> > +				 int oob_on, int page)
> > +{
> > +	struct mtd_info *mtd = nand_to_mtd(chip);
> > +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> > +	u32 i;
> > +
> > +	memset(nfc->buffer, 0xff, mtd->writesize + mtd->oobsize);
> > +	swap(chip->oob_poi[0], chip->oob_poi[7]);
> > +	for (i = 0; i < chip->ecc.steps; i++) {
> > +		if (buf)
> > +			memcpy(rk_data_ptr(chip, i), data_ptr(chip, buf, i),
> > +			       chip->ecc.size);
> > +
> > +		memcpy(rk_oob_ptr(chip, i), oob_ptr(chip, i),
> > +		       NFC_SYS_DATA_SIZE);
> > +	}
> > +
> > +	return rk_nfc_write_page(mtd, chip, nfc->buffer, page, 1);
> > +}
> > +
> > +static int rk_nfc_write_oob_std(struct nand_chip *chip, int page)
> > +{
> > +	return rk_nfc_write_page_raw(chip, NULL, 1, page);
> > +}
> > +
> > +static int rk_nfc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
> > +			    u32 data_offs, u32 readlen,
> > +			    u8 *buf, int page, int raw)
> > +{
> > +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> > +	struct rk_nfc_nand_chip *rk_nand = to_rk_nand(chip);
> > +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> > +	int oob_step = (ecc->bytes > 60) ? NFC_MAX_OOB_PER_STEP :
> > +			NFC_MIN_OOB_PER_STEP;
> > +	int pages_per_blk = mtd->erasesize / mtd->writesize;
> > +	dma_addr_t dma_data, dma_oob;
> > +	int ret = 0, i, boot_rom_mode = 0;
> > +	int bitflips = 0, bch_st;
> > +	u8 *oob;
> > +	u32 tmp;
> > +
> > +	nand_read_page_op(chip, page, 0, NULL, 0);
> > +	if (!raw) {
> > +		dma_data = dma_map_single(nfc->dev, nfc->page_buf,
> > +					  mtd->writesize,
> > +					  DMA_FROM_DEVICE);
> > +		dma_oob = dma_map_single(nfc->dev, nfc->oob_buf,
> > +					 ecc->steps * oob_step,
> > +					 DMA_FROM_DEVICE);
> > +
> > +		/*
> > +		 * The first 8(some devices are 4 or 16) blocks in use by
> > +		 * the bootrom.
> > +		 * Config the ECC algorithm supported by the boot ROM.
> > +		 */
> > +		if (page < pages_per_blk * rk_nand->boot_blks &&
> > +		    chip->options & NAND_IS_BOOT_MEDIUM) {
> > +			boot_rom_mode = 1;
> > +			if (rk_nand->boot_ecc != ecc->strength)
> > +				rk_nfc_hw_ecc_setup(chip, ecc,
> > +						    rk_nand->boot_ecc);
> > +		}
> > +
> > +		reinit_completion(&nfc->done);
> > +		writel(INT_DMA, nfc->regs + nfc->cfg->int_en_off);
> > +		rk_nfc_xfer_start(nfc, NFC_READ, ecc->steps, dma_data,
> > +				  dma_oob);
> > +		ret = wait_for_completion_timeout(&nfc->done,
> > +						  msecs_to_jiffies(100));
> > +		if (!ret)
> > +			dev_warn(nfc->dev, "read: wait dma done timeout.\n");
> > +		/*
> > +		 * Whether the DMA transfer is completed or not. The driver
> > +		 * needs to check the NFC`s status register to see if the data
> > +		 * transfer was completed.
> > +		 */
> > +		ret = rk_nfc_wait_for_xfer_done(nfc);
> > +		dma_unmap_single(nfc->dev, dma_data, mtd->writesize,
> > +				 DMA_FROM_DEVICE);
> > +		dma_unmap_single(nfc->dev, dma_oob, ecc->steps * oob_step,
> > +				 DMA_FROM_DEVICE);
> > +
> > +		if (ret) {
> > +			bitflips = -EIO;
> > +			dev_err(nfc->dev,
> > +				 "read: wait transfer done timeout.\n");
> > +			goto out;
> > +		}
> > +
> > +		for (i = 0; i < ecc->steps; i++) {
> > +			oob = chip->oob_poi + i * NFC_SYS_DATA_SIZE;
> > +			if (nfc->cfg->type == NFC_V6 ||
> > +			    nfc->cfg->type == NFC_V8)
> > +				tmp = nfc->oob_buf[i * oob_step / 4];
> > +			else
> > +				tmp = nfc->oob_buf[i];
> > +			*oob++ = (u8)tmp;
> > +			*oob++ = (u8)(tmp >> 8);
> > +			*oob++ = (u8)(tmp >> 16);
> > +			*oob++ = (u8)(tmp >> 24);
> > +		}
> > +
> > +		/*
> > +		 * Swap the first oob with the seventh oob and bad block
> > +		 * mask is saved at the seventh oob.
> > +		 */
> > +		swap(chip->oob_poi[0], chip->oob_poi[7]);
> > +
> > +		for (i = 0; i < ecc->steps / 2; i++) {
> > +			bch_st = readl_relaxed(nfc->regs +
> > +					       nfc->cfg->bch_st_off + i * 4);
> > +			if (bch_st & BIT(nfc->cfg->ecc0.err_flag_bit) ||
> > +			    bch_st & BIT(nfc->cfg->ecc1.err_flag_bit)) {
> > +				mtd->ecc_stats.failed++;
> > +				bitflips = -1;
> > +			} else {
> > +				ret = ECC_ERR_CNT(bch_st, nfc->cfg->ecc0);
> > +				mtd->ecc_stats.corrected += ret;
> > +				bitflips = max_t(u32, bitflips, ret);
> > +
> > +				ret = ECC_ERR_CNT(bch_st, nfc->cfg->ecc1);
> > +				mtd->ecc_stats.corrected += ret;
> > +				bitflips = max_t(u32, bitflips, ret);
> > +			}
> > +		}
> > +out:
> > +		memcpy(buf, nfc->page_buf, mtd->writesize);
> > +
> > +		if (boot_rom_mode && rk_nand->boot_ecc != ecc->strength)
> > +			rk_nfc_hw_ecc_setup(chip, ecc, ecc->strength);
> > +
> > +		if (bitflips < 0)
> > +			dev_err(nfc->dev, "read page: %x ecc error!\n", page);
> > +	} else {
> > +		rk_nfc_read_buf(chip, buf, mtd->writesize + mtd->oobsize);
> > +	}
> > +	/* Deselect the currently selected target. */
> > +	rk_nfc_select_chip(chip, -1);
> > +
> > +	return bitflips;
> > +}
> > +
> > +static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
> > +				   int oob_on, int page)
> > +{
> > +	return rk_nfc_write_page(nand_to_mtd(chip), chip, buf, page, 0);
> > +}
> > +
> > +static int rk_nfc_read_page_hwecc(struct nand_chip *chip, u8 *p, int oob_on,
> > +				  int pg)
> > +{
> > +	struct mtd_info *mtd = nand_to_mtd(chip);
> > +
> > +	return rk_nfc_read_page(mtd, chip, 0, mtd->writesize, p, pg, 0);
> > +}
> > +
> > +static int rk_nfc_read_page_raw(struct nand_chip *chip, u8 *buf, int oob_on,
> > +				int page)
> > +{
> > +	struct mtd_info *mtd = nand_to_mtd(chip);
> > +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> > +	int i, ret;
> > +
> > +	ret = rk_nfc_read_page(mtd, chip, 0, mtd->writesize, nfc->buffer,
> > +			       page, 1);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	for (i = 0; i < chip->ecc.steps; i++) {
> > +		memcpy(oob_ptr(chip, i), rk_oob_ptr(chip, i),
> > +		       NFC_SYS_DATA_SIZE);
> > +
> > +		if (buf)
> > +			memcpy(data_ptr(chip, buf, i), rk_data_ptr(chip, i),
> > +			       chip->ecc.size);
> > +	}
> > +	swap(chip->oob_poi[0], chip->oob_poi[7]);
> > +
> > +	return ret;
> > +}  
> 
> [..]




Thanks,
Miquèl
