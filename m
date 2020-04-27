Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9F0C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DBA4214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgD0SdV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:33:21 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:43633 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgD0SdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:33:20 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 2C647FF806;
        Mon, 27 Apr 2020 18:33:15 +0000 (UTC)
Date:   Mon, 27 Apr 2020 20:33:14 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <tony@atomide.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>
Subject: Re: [PATCH v2 07/12] mtd: rawnand: stm32_fmc2: cleanup
Message-ID: <20200427203314.798b3c4e@xps13>
In-Reply-To: <1586966256-29548-8-git-send-email-christophe.kerello@st.com>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
        <1586966256-29548-8-git-send-email-christophe.kerello@st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 15 Apr
2020 17:57:31 +0200:

> This patch renames functions and local variables to be ready to use
> stm32_fmc2 structure.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> ---

> -static int stm32_fmc2_setup_interface(struct nand_chip *chip, int chipnr,
> -				      const struct nand_data_interface *conf)
> +static int stm32_fmc2_nfc_setup_interface(struct nand_chip *chip, int chipnr,
> +					  const struct nand_data_interface *cf)

I suppose you s/conf/cf/ because of the 80 chars boundary. In this case
I don't mind crossing it, I don't think it is better to rename the
conf parameter for this reason.

>  {
>  	const struct nand_sdr_timings *sdrt;
>  
> -	sdrt = nand_get_sdr_timings(conf);
> +	sdrt = nand_get_sdr_timings(cf);
>  	if (IS_ERR(sdrt))
>  		return PTR_ERR(sdrt);
>  
>  	if (chipnr == NAND_DATA_IFACE_CHECK_ONLY)
>  		return 0;
>  
> -	stm32_fmc2_calc_timings(chip, sdrt);
> -	stm32_fmc2_timings_init(chip);
> +	stm32_fmc2_nfc_calc_timings(chip, sdrt);
> +	stm32_fmc2_nfc_timings_init(chip);
>  
>  	return 0;
>  }
>  

[...]

>  
> -static struct platform_driver stm32_fmc2_driver = {
> -	.probe	= stm32_fmc2_probe,
> -	.remove	= stm32_fmc2_remove,
> +static struct platform_driver stm32_fmc2_nfc_driver = {
> +	.probe	= stm32_fmc2_nfc_probe,
> +	.remove	= stm32_fmc2_nfc_remove,
>  	.driver	= {
> -		.name = "stm32_fmc2_nand",
> -		.of_match_table = stm32_fmc2_match,
> -		.pm = &stm32_fmc2_pm_ops,
> +		.name = "stm32_fmc2_nfc",
> +		.of_match_table = stm32_fmc2_nfc_match,
> +		.pm = &stm32_fmc2_nfc_pm_ops,
>  	},
>  };
> -module_platform_driver(stm32_fmc2_driver);
> +module_platform_driver(stm32_fmc2_nfc_driver);
>  
> -MODULE_ALIAS("platform:stm32_fmc2_nand");
> +MODULE_ALIAS("platform:stm32_fmc2_nfc");
>  MODULE_AUTHOR("Christophe Kerello <christophe.kerello@st.com>");
> -MODULE_DESCRIPTION("STMicroelectronics STM32 FMC2 nand driver");
> +MODULE_DESCRIPTION("STMicroelectronics STM32 FMC2 nfc driver");

I would prefer: s/nfc/NFC/ here please.

>  MODULE_LICENSE("GPL v2");

With these two nits,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
