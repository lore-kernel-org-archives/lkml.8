Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296DCC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10FE520720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgEKJTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:19:02 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:34897 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgEKJTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:19:02 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D6943FF80B;
        Mon, 11 May 2020 09:18:57 +0000 (UTC)
Date:   Mon, 11 May 2020 11:18:55 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>
Subject: Re: [PATCH v4 10/10] mtd: rawnand: stm32_fmc2: get resources from
 parent node
Message-ID: <20200511111855.48216940@xps13>
In-Reply-To: <1588756279-17289-11-git-send-email-christophe.kerello@st.com>
References: <1588756279-17289-1-git-send-email-christophe.kerello@st.com>
        <1588756279-17289-11-git-send-email-christophe.kerello@st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 6 May 2020
11:11:19 +0200:

> FMC2 EBI support has been added. Common resources (registers base
> and clock) are now shared between the 2 drivers. It means that the
> common resources should now be found in the parent device when EBI
> node is available.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> ---

[...]

> +
> +static bool stm32_fmc2_nfc_check_for_parent(struct platform_device *pdev)
> +{
> +	u32 i;
> +	int nb_resources = 0;
> +
> +	/* Count the number of resources in reg property */
> +	for (i = 0; i < pdev->num_resources; i++) {
> +		struct resource *res = &pdev->resource[i];
> +
> +		if (resource_type(res) == IORESOURCE_MEM)
> +			nb_resources++;
> +	}
> +
> +	/* Each CS needs 3 resources defined (data, cmd and addr) */
> +	if (nb_resources % 3)
> +		return false;
> +
> +	return true;
> +}

This function looks fragile. Why not just checking the compatible
string of the parent node?

> +
>  static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1824,8 +1865,8 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	struct mtd_info *mtd;
>  	struct nand_chip *chip;
> -	void __iomem *mmio;
>  	int chip_cs, mem_region, ret, irq;
> +	int num_region = 1;
>  
>  	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
>  	if (!nfc)
> @@ -1834,23 +1875,19 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
>  	nfc->dev = dev;
>  	nand_controller_init(&nfc->base);
>  	nfc->base.ops = &stm32_fmc2_nfc_controller_ops;
> +	nfc->has_parent = stm32_fmc2_nfc_check_for_parent(pdev);
> +	if (nfc->has_parent)
> +		num_region = 0;
>  
>  	ret = stm32_fmc2_nfc_parse_dt(nfc);
>  	if (ret)
>  		return ret;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	mmio = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(mmio))
> -		return PTR_ERR(mmio);
> -
> -	nfc->regmap = devm_regmap_init_mmio(dev, mmio, &stm32_fmc2_regmap_cfg);
> -	if (IS_ERR(nfc->regmap))
> -		return PTR_ERR(nfc->regmap);
> -
> -	nfc->io_phys_addr = res->start;
> +	ret = stm32_fmc2_nfc_set_regmap_clk(pdev, nfc);
> +	if (ret)
> +		return ret;

Are you sure this driver sill works without the EBI block?

This change looks suspect.

>  
> -	for (chip_cs = 0, mem_region = 1; chip_cs < FMC2_MAX_CE;
> +	for (chip_cs = 0, mem_region = num_region; chip_cs < FMC2_MAX_CE;
>  	     chip_cs++, mem_region += 3) {
>  		if (!(nfc->cs_assigned & BIT(chip_cs)))
>  			continue;
> @@ -1888,10 +1925,6 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
>  
>  	init_completion(&nfc->complete);
>  
> -	nfc->clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(nfc->clk))
> -		return PTR_ERR(nfc->clk);
> -

Same here

>  	ret = clk_prepare_enable(nfc->clk);
>  	if (ret) {
>  		dev_err(dev, "can not enable the clock\n");

