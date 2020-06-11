Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FA5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710E62072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgFKHyK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:54:10 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43243 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFKHyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:54:09 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 11A6D20015;
        Thu, 11 Jun 2020 07:53:59 +0000 (UTC)
Date:   Thu, 11 Jun 2020 09:53:58 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308,
 RK2928 and others
Message-ID: <20200611095358.7fceea83@xps13>
In-Reply-To: <20200609074020.23860-3-yifeng.zhao@rock-chips.com>
References: <20200609074020.23860-1-yifeng.zhao@rock-chips.com>
        <20200609074020.23860-3-yifeng.zhao@rock-chips.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yifeng,


[...]

> +static void rk_nfc_disable_clk(struct rk_nfc_clk *clk)
> +{
> +	if (!IS_ERR(clk->nfc_clk))
> +		clk_disable_unprepare(clk->nfc_clk);
> +	clk_disable_unprepare(clk->ahb_clk);
> +}
> +
> +static int rk_nfc_ooblayout_free(struct mtd_info *mtd, int section,
> +				 struct mtd_oob_region *oob_region)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (section >= chip->ecc.steps)
> +		return -ERANGE;
> +
> +	if (!section) {
> +		/* The first byte is bad block mask flag. */
> +		oob_region->length = NFC_SYS_DATA_SIZE - 1;
> +		oob_region->offset = 1;
> +	} else {
> +		oob_region->length = NFC_SYS_DATA_SIZE;
> +		oob_region->offset = section * NFC_SYS_DATA_SIZE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rk_nfc_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				struct mtd_oob_region *oob_region)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (section)
> +		return -ERANGE;
> +
> +	oob_region->offset = NFC_SYS_DATA_SIZE * chip->ecc.steps;
> +	oob_region->length = mtd->oobsize - oob_region->offset;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops rk_nfc_ooblayout_ops = {
> +	.free = rk_nfc_ooblayout_free,
> +	.ecc = rk_nfc_ooblayout_ecc,
> +};

This looks like a copy of the core's nand_lp_ooblayout, better use the
generic one than creation your own.

> +
> +static int rk_nfc_ecc_init(struct device *dev, struct mtd_info *mtd)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> +	const u8 *strengths = nfc->cfg->ecc_strengths;
> +	u8 max_strength, nfc_max_strength;
> +	int i;
> +
> +	nfc_max_strength = nfc->cfg->ecc_strengths[0];
> +	/* If optional dt settings not present. */
> +	if (!ecc->size || !ecc->strength ||
> +	    ecc->strength > nfc_max_strength) {
> +		/* Use datasheet requirements. */
> +		ecc->strength = chip->base.eccreq.strength;
> +		ecc->size = chip->base.eccreq.step_size;
> +
> +		/*
> +		 * Align eccstrength and eccsize.
> +		 * This controller only supports 512 and 1024 sizes.
> +		 */
> +		if (chip->ecc.size < 1024) {
> +			if (mtd->writesize > 512) {
> +				chip->ecc.size = 1024;
> +				chip->ecc.strength <<= 1;
> +			} else {
> +				dev_err(dev, "ecc.size not supported\n");
> +				return -EINVAL;
> +			}
> +		} else {
> +			chip->ecc.size = 1024;
> +		}
> +
> +		ecc->steps = mtd->writesize / ecc->size;
> +
> +		/*
> +		 * HW ECC always request ECC bytes for 1024 bytes blocks.
> +		 * 4 Bytes is oob for sys data.
> +		 */
> +		max_strength = ((mtd->oobsize / ecc->steps) - 4) * 8 /
> +				 fls(8 * 1024);
> +		if (max_strength > nfc_max_strength)
> +			max_strength = nfc_max_strength;
> +
> +		for (i = 0; i < 4; i++) {
> +			if (max_strength >= strengths[i])
> +				break;
> +		}
> +
> +		if (i >= 4) {
> +			dev_err(nfc->dev, "unsupported strength\n");
> +			return -ENOTSUPP;
> +		}
> +
> +		ecc->strength = strengths[i];
> +	}
> +	ecc->steps = mtd->writesize / ecc->size;
> +	ecc->bytes = DIV_ROUND_UP(ecc->strength * fls(8 * 1024), 8);
> +	/* HW ECC always work with even numbers of ECC bytes. */
> +	ecc->bytes = ALIGN(ecc->bytes, 2);
> +
> +	rk_nfc_hw_ecc_setup(chip, ecc, ecc->strength);
> +
> +	return 0;
> +}
> +
> +static int rk_nfc_attach_chip(struct nand_chip *chip)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct device *dev = mtd->dev.parent;
> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> +	struct rk_nfc_nand_chip *rk_nand = to_rk_nand(chip);
> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> +	int len;
> +	int ret;
> +
> +	if (chip->options & NAND_BUSWIDTH_16) {
> +		dev_err(dev, "16 bits bus width not supported");
> +		return -EINVAL;
> +	}
> +
> +	if (ecc->mode != NAND_ECC_HW)
> +		return 0;
> +
> +	ret = rk_nfc_ecc_init(dev, mtd);
> +	if (ret)
> +		return ret;
> +	rk_nand->spare_per_sector = ecc->bytes + NFC_SYS_DATA_SIZE;
> +
> +	/* Check buffer first, avoid duplicate alloc buffer. */
> +	if (nfc->buffer)
> +		return 0;
> +
> +	len = mtd->writesize + mtd->oobsize;
> +	nfc->buffer = devm_kzalloc(dev, len, GFP_KERNEL | GFP_DMA);
> +	if (!nfc->buffer)
> +		return -ENOMEM;
> +
> +	nfc->page_buf = nfc->buffer;
> +	len = ecc->steps * NFC_MAX_OOB_PER_STEP;
> +	nfc->oob_buf = devm_kzalloc(dev, len, GFP_KERNEL | GFP_DMA);
> +	if (!nfc->oob_buf) {
> +		devm_kfree(dev, nfc->buffer);

This is not needed I suppose and you should probably just return the
error.

> +		nfc->buffer = NULL;
> +		nfc->oob_buf = NULL;
> +		return -ENOMEM;
> +	}
> +
> +	chip->ecc.write_page_raw = rk_nfc_write_page_raw;
> +	chip->ecc.write_page = rk_nfc_write_page_hwecc;
> +	chip->ecc.write_oob_raw = rk_nfc_write_oob_std;
> +	chip->ecc.write_oob = rk_nfc_write_oob_std;
> +
> +	chip->ecc.read_page_raw = rk_nfc_read_page_raw;
> +	chip->ecc.read_page = rk_nfc_read_page_hwecc;
> +	chip->ecc.read_oob_raw = rk_nfc_read_oob_std;
> +	chip->ecc.read_oob = rk_nfc_read_oob_std;
> +
> +	return 0;
> +}
> +
> +static const struct nand_controller_ops rk_nfc_controller_ops = {
> +	.attach_chip = rk_nfc_attach_chip,
> +	.exec_op = rk_nfc_exec_op,
> +	.setup_data_interface = rk_nfc_setup_data_interface,
> +};
> +
> +static int rk_nfc_nand_chip_init(struct device *dev, struct rk_nfc *nfc,
> +				 struct device_node *np)
> +{
> +	struct rk_nfc_nand_chip *nand;

Could you call it rknand or something similar, just so that it is easy
to get the difference with the nand_chip structure.

> +	struct nand_chip *chip;
> +	struct mtd_info *mtd;
> +	int nsels;
> +	u32 tmp;
> +	int ret;
> +	int i;
> +
> +	if (!of_get_property(np, "reg", &nsels))
> +		return -ENODEV;
> +	nsels /= sizeof(u32);
> +	if (!nsels || nsels > NFC_MAX_NSELS) {
> +		dev_err(dev, "invalid reg property size %d\n", nsels);
> +		return -EINVAL;
> +	}
> +
> +	nand = devm_kzalloc(dev, sizeof(*nand) + nsels * sizeof(u8),
> +			    GFP_KERNEL);
> +	if (!nand)
> +		return -ENOMEM;
> +
> +	nand->nsels = nsels;
> +	for (i = 0; i < nsels; i++) {
> +		ret = of_property_read_u32_index(np, "reg", i, &tmp);
> +		if (ret) {
> +			dev_err(dev, "reg property failure : %d\n", ret);
> +			return ret;
> +		}
> +
> +		if (tmp >= NFC_MAX_NSELS) {
> +			dev_err(dev, "invalid CS: %u\n", tmp);
> +			return -EINVAL;
> +		}
> +
> +		if (test_and_set_bit(tmp, &nfc->assigned_cs)) {
> +			dev_err(dev, "CS %u already assigned\n", tmp);
> +			return -EINVAL;
> +		}
> +
> +		nand->sels[i] = tmp;
> +	}
> +
> +	chip = &nand->chip;
> +	chip->controller = &nfc->controller;
> +
> +	nand_set_flash_node(chip, np);
> +
> +	nand_set_controller_data(chip, nfc);
> +
> +	chip->options |= NAND_USE_BOUNCE_BUFFER | NAND_NO_SUBPAGE_WRITE;
> +	chip->bbt_options = NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
> +
> +	/* Set default mode in case dt entry is missing. */
> +	chip->ecc.mode = NAND_ECC_HW;
> +
> +	mtd = nand_to_mtd(chip);
> +	mtd->owner = THIS_MODULE;
> +	mtd->dev.parent = dev;
> +
> +	if (!mtd->name) {
> +		dev_err(nfc->dev, "NAND label property is mandatory\n");
> +		return -EINVAL;
> +	}
> +
> +	mtd_set_ooblayout(mtd, &rk_nfc_ooblayout_ops);
> +	rk_nfc_hw_init(nfc);
> +	ret = nand_scan(chip, nsels);
> +	if (ret)
> +		return ret;
> +
> +	if (chip->options & NAND_IS_BOOT_MEDIUM) {
> +		ret = of_property_read_u32(np, "rockchip,boot-blks", &tmp);
> +		nand->boot_blks = ret ? 0 : tmp;
> +
> +		ret = of_property_read_u32(np, "rockchip,boot-ecc-strength",
> +					   &tmp);
> +		nand->boot_ecc = ret ? chip->ecc.strength : tmp;
> +	}
> +
> +	ret = mtd_device_register(mtd, NULL, 0);
> +	if (ret) {
> +		dev_err(dev, "mtd parse partition error\n");
> +		nand_release(chip);

nand_cleanup() here

> +		return ret;
> +	}
> +
> +	list_add_tail(&nand->node, &nfc->chips);
> +
> +	return 0;
> +}
> +
> +static int rk_nfc_nand_chips_init(struct device *dev, struct rk_nfc *nfc)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct device_node *nand_np;
> +	int ret = -EINVAL;
> +	int tmp;
> +
> +	for_each_child_of_node(np, nand_np) {
> +		tmp = rk_nfc_nand_chip_init(dev, nfc, nand_np);
> +		if (tmp) {
> +			of_node_put(nand_np);
> +			return ret;
> +		}
> +		/* At least one nand chip is initialized. */
> +		ret = 0;

I think it's more readable if you count up the number of devices
initialized by browsing the list of chips handled by the controller
(list_is_empty() would work just fine).

> +	}
> +
> +	return ret;
> +}
> +
> +static struct nfc_cfg nfc_v6_cfg = {
> +		.type			= NFC_V6,
> +		.ecc_strengths		= {60, 40, 24, 16},
> +		.ecc_cfgs		= {
> +			0x00040011, 0x00040001, 0x00000011, 0x00000001,
> +		},
> +		.flctl_off		= 0x08,
> +		.bchctl_off		= 0x0C,
> +		.dma_cfg_off		= 0x10,
> +		.dma_data_buf_off	= 0x14,
> +		.dma_oob_buf_off	= 0x18,
> +		.dma_st_off		= 0x1C,
> +		.bch_st_off		= 0x20,
> +		.randmz_off		= 0x150,
> +		.int_en_off		= 0x16C,
> +		.int_clr_off		= 0x170,
> +		.int_st_off		= 0x174,
> +		.oob0_off		= 0x200,
> +		.oob1_off		= 0x230,
> +		.ecc0			= {
> +			.err_flag_bit	= 2,
> +			.low		= 3,
> +			.low_mask	= 0x1F,
> +			.low_bn		= 5,
> +			.high		= 27,
> +			.high_mask	= 0x1,
> +		},
> +		.ecc1			= {
> +			.err_flag_bit	= 15,
> +			.low		= 16,
> +			.low_mask	= 0x1F,
> +			.low_bn		= 5,
> +			.high		= 29,
> +			.high_mask	= 0x1,
> +		},
> +};
> +
> +static struct nfc_cfg nfc_v8_cfg = {
> +		.type			= NFC_V8,
> +		.ecc_strengths		= {16, 16, 16, 16},
> +		.ecc_cfgs		= {
> +			0x00000001, 0x00000001, 0x00000001, 0x00000001,
> +		},
> +		.flctl_off		= 0x08,
> +		.bchctl_off		= 0x0C,
> +		.dma_cfg_off		= 0x10,
> +		.dma_data_buf_off	= 0x14,
> +		.dma_oob_buf_off	= 0x18,
> +		.dma_st_off		= 0x1C,
> +		.bch_st_off		= 0x20,
> +		.bch_st_off		= 0x20,
> +		.randmz_off		= 0x150,
> +		.int_en_off		= 0x16C,
> +		.int_clr_off		= 0x170,
> +		.int_st_off		= 0x174,
> +		.oob0_off		= 0x200,
> +		.oob1_off		= 0x230,
> +		.ecc0			= {
> +			.err_flag_bit	= 2,
> +			.low		= 3,
> +			.low_mask	= 0x1F,
> +			.low_bn		= 5,
> +			.high		= 27,
> +			.high_mask	= 0x1,
> +		},
> +		.ecc1			= {
> +			.err_flag_bit	= 15,
> +			.low		= 16,
> +			.low_mask	= 0x1F,
> +			.low_bn		= 5,
> +			.high		= 29,
> +			.high_mask	= 0x1,
> +		},
> +};
> +
> +static struct nfc_cfg nfc_v9_cfg = {
> +		.type			= NFC_V9,
> +		.ecc_strengths		= {70, 60, 40, 16},
> +		.ecc_cfgs		= {
> +			0x00000001, 0x06000001, 0x04000001, 0x02000001,
> +		},
> +		.flctl_off		= 0x10,
> +		.bchctl_off		= 0x20,
> +		.dma_cfg_off		= 0x30,
> +		.dma_data_buf_off	= 0x34,
> +		.dma_oob_buf_off	= 0x38,
> +		.dma_st_off		= 0x3C,
> +		.bch_st_off		= 0x150,
> +		.randmz_off		= 0x208,
> +		.int_en_off		= 0x120,
> +		.int_clr_off		= 0x124,
> +		.int_st_off		= 0x128,
> +		.oob0_off		= 0x200,
> +		.oob1_off		= 0x204,
> +		.ecc0			= {
> +			.err_flag_bit	= 2,
> +			.low		= 3,
> +			.low_mask	= 0x7F,
> +			.low_bn		= 7,
> +			.high		= 0,
> +			.high_mask	= 0x0,
> +		},
> +		.ecc1			= {
> +			.err_flag_bit	= 18,
> +			.low		= 19,
> +			.low_mask	= 0x7F,
> +			.low_bn		= 7,
> +			.high		= 0,
> +			.high_mask	= 0x0,
> +		},
> +};
> +
> +static const struct of_device_id rk_nfc_id_table[] = {
> +	{.compatible = "rockchip,px30-nfc",
> +		.data = &nfc_v9_cfg },
> +	{.compatible = "rockchip,rk2928-nfc",
> +		.data = &nfc_v6_cfg },
> +	{.compatible = "rockchip,rv1108-nfc",
> +		.data = &nfc_v8_cfg },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rk_nfc_id_table);
> +
> +static int rk_nfc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rk_nfc *nfc;
> +	struct resource *res;
> +	int ret, irq;
> +
> +	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
> +	if (!nfc)
> +		return -ENOMEM;
> +
> +	nand_controller_init(&nfc->controller);
> +	INIT_LIST_HEAD(&nfc->chips);
> +	nfc->controller.ops = &rk_nfc_controller_ops;
> +
> +	nfc->cfg = of_device_get_match_data(dev);
> +	nfc->dev = dev;
> +
> +	init_completion(&nfc->done);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	nfc->regs = devm_ioremap_resource(dev, res);

There is a devm_platform_ioremap_resource for that

> +	if (IS_ERR(nfc->regs)) {
> +		ret = PTR_ERR(nfc->regs);
> +		goto release_nfc;
> +	}
> +
> +	nfc->clk.nfc_clk = devm_clk_get(dev, "nfc");
> +	if (IS_ERR(nfc->clk.nfc_clk)) {
> +		dev_dbg(dev, "no nfc clk\n");
> +		/* Some old device, sush as rk3066, has no nfc clk. */

I would drop the dbg trace and reining nfc_clk to NULL.

Also it might be worth checking the compatible here to ensure this is
allowed.

> +	}
> +
> +	nfc->clk.ahb_clk = devm_clk_get(dev, "ahb");
> +	if (IS_ERR(nfc->clk.ahb_clk)) {
> +		dev_err(dev, "no ahb clk\n");
> +		ret = PTR_ERR(nfc->clk.ahb_clk);
> +		goto release_nfc;
> +	}
> +
> +	ret = rk_nfc_enable_clk(dev, &nfc->clk);
> +	if (ret)
> +		goto release_nfc;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "no nfc irq resource\n");
> +		ret = -EINVAL;
> +		goto clk_disable;
> +	}
> +
> +	writel(0, nfc->regs + nfc->cfg->int_en_off);
> +	ret = devm_request_irq(dev, irq, rk_nfc_irq, 0x0, "rk-nand", nfc);
> +	if (ret) {
> +		dev_err(dev, "failed to request nfc irq\n");
> +		goto clk_disable;
> +	}
> +
> +	platform_set_drvdata(pdev, nfc);
> +
> +	ret = rk_nfc_nand_chips_init(dev, nfc);
> +	if (ret) {
> +		dev_err(dev, "failed to init nand chips\n");
> +		goto clk_disable;
> +	}
> +	return 0;
> +
> +clk_disable:
> +	rk_nfc_disable_clk(&nfc->clk);
> +release_nfc:
> +	return ret;
> +}
> +
> +static int rk_nfc_remove(struct platform_device *pdev)
> +{
> +	struct rk_nfc *nfc = platform_get_drvdata(pdev);
> +	struct rk_nfc_nand_chip *nand;
> +
> +	while (!list_empty(&nfc->chips)) {
> +		nand = list_first_entry(&nfc->chips, struct rk_nfc_nand_chip,
> +					node);
> +		nand_release(&nand->chip);

nand_release has been removed (in Linus' branch since this
week).

> +		list_del(&nand->node);
> +	}
> +
> +	rk_nfc_disable_clk(&nfc->clk);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused rk_nfc_suspend(struct device *dev)
> +{
> +	struct rk_nfc *nfc = dev_get_drvdata(dev);
> +
> +	rk_nfc_disable_clk(&nfc->clk);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused rk_nfc_resume(struct device *dev)
> +{
> +	struct rk_nfc *nfc = dev_get_drvdata(dev);
> +	struct rk_nfc_nand_chip *nand;
> +	struct nand_chip *chip;
> +	int ret;
> +	u32 i;
> +
> +	ret = rk_nfc_enable_clk(dev, &nfc->clk);
> +	if (ret)
> +		return ret;
> +
> +	/* Reset NAND chip if VCC was powered off. */
> +	list_for_each_entry(nand, &nfc->chips, node) {
> +		chip = &nand->chip;
> +		for (i = 0; i < nand->nsels; i++)
> +			nand_reset(chip, i);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops rk_nfc_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(rk_nfc_suspend, rk_nfc_resume)
> +};
> +
> +static struct platform_driver rk_nfc_driver = {
> +	.probe = rk_nfc_probe,
> +	.remove = rk_nfc_remove,
> +	.driver = {
> +		.name = "rockchip-nfc",
> +		.of_match_table = rk_nfc_id_table,
> +		.pm = &rk_nfc_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(rk_nfc_driver);
> +
> +MODULE_LICENSE("Dual MIT/GPL");
> +MODULE_AUTHOR("Yifeng Zhao <yifeng.zhao@rock-chips.com>");
> +MODULE_DESCRIPTION("Rockchip Nand Flash Controller Driver");
> +MODULE_ALIAS("platform:rockchip-nand-controller");




Thanks,
Miquèl
