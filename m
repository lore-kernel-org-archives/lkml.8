Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECC8C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8A4222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="KjiA8IFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgANP4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:56:01 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:52909 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbgANPz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:55:59 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4D29D22F54;
        Tue, 14 Jan 2020 16:55:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1579017356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ct+aRr3TCzgVYVm23SiKR4zjf2kwIVnO+TG3pSdmezY=;
        b=KjiA8IFV8kh9MFDYSMCamYHUdpAMT8W1rARrucZWoMZ/ZsX32xNmVzsBsC6z4Ea+zRZjS7
        yOUENZSRAKYyVxPldWIFsKdaqdiDOqgqD3Ky8TJY3DfAJjRO6xO/Egpg3NQF550qrx8uKd
        sMPt6cOJqVVi530tOVFjbRAsNC0CjVc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Jan 2020 16:55:56 +0100
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 3/3] clk: fsl-sai: new driver
In-Reply-To: <20200102231101.11834-3-michael@walle.cc>
References: <20200102231101.11834-1-michael@walle.cc>
 <20200102231101.11834-3-michael@walle.cc>
Message-ID: <6069b1edf7796f3eff0d68c398eefff2@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 4D29D22F54
X-Spamd-Result: default: False [1.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         NEURAL_HAM(-0.00)[-0.813];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-01-03 00:11, schrieb Michael Walle:
> With this driver it is possible to use the BCLK pin of the SAI module 
> as
> a generic clock output. This is esp. useful if you want to drive a 
> clock
> to an audio codec. Because the output only allows integer divider 
> values
> the audio codec needs an integrated PLL.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Ping :)

> ---
> changes since v2:
>  - convert to platform driver, thus also use devm_ functions
>  - use new style to get the parent clock by using parent_data
>    and the new clk_hw_register_composite_pdata()
> 
> changes since v1:
>  - none
> 
>  drivers/clk/Kconfig       | 12 +++++
>  drivers/clk/Makefile      |  1 +
>  drivers/clk/clk-fsl-sai.c | 92 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+)
>  create mode 100644 drivers/clk/clk-fsl-sai.c
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 45653a0e6ecd..dd1a5abc4ce8 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -174,6 +174,18 @@ config COMMON_CLK_CS2000_CP
>  	help
>  	  If you say yes here you get support for the CS2000 clock 
> multiplier.
> 
> +config COMMON_CLK_FSL_SAI
> +	bool "Clock driver for BCLK of Freescale SAI cores"
> +	depends on ARCH_LAYERSCAPE || COMPILE_TEST
> +	help
> +	  This driver supports the Freescale SAI (Synchronous Audio 
> Interface)
> +	  to be used as a generic clock output. Some SoCs have restrictions
> +	  regarding the possible pin multiplexer settings. Eg. on some SoCs
> +	  two SAI interfaces can only be enabled together. If just one is
> +	  needed, the BCLK pin of the second one can be used as general
> +	  purpose clock output. Ideally, it can be used to drive an audio
> +	  codec (sometimes known as MCLK).
> +
>  config COMMON_CLK_GEMINI
>  	bool "Clock driver for Cortina Systems Gemini SoC"
>  	depends on ARCH_GEMINI || COMPILE_TEST
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 0696a0c1ab58..ec23fd956228 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
>  obj-$(CONFIG_COMMON_CLK_CS2000_CP)	+= clk-cs2000-cp.o
>  obj-$(CONFIG_ARCH_EFM32)		+= clk-efm32gg.o
>  obj-$(CONFIG_COMMON_CLK_FIXED_MMIO)	+= clk-fixed-mmio.o
> +obj-$(CONFIG_COMMON_CLK_FSL_SAI)	+= clk-fsl-sai.o
>  obj-$(CONFIG_COMMON_CLK_GEMINI)		+= clk-gemini.o
>  obj-$(CONFIG_COMMON_CLK_ASPEED)		+= clk-aspeed.o
>  obj-$(CONFIG_MACH_ASPEED_G6)		+= clk-ast2600.o
> diff --git a/drivers/clk/clk-fsl-sai.c b/drivers/clk/clk-fsl-sai.c
> new file mode 100644
> index 000000000000..0221180a4dd7
> --- /dev/null
> +++ b/drivers/clk/clk-fsl-sai.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Freescale SAI BCLK as a generic clock driver
> + *
> + * Copyright 2020 Michael Walle <michael@walle.cc>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +
> +#define I2S_CSR		0x00
> +#define I2S_CR2		0x08
> +#define CSR_BCE_BIT	28
> +#define CR2_BCD		BIT(24)
> +#define CR2_DIV_SHIFT	0
> +#define CR2_DIV_WIDTH	8
> +
> +struct fsl_sai_clk {
> +	struct clk_divider div;
> +	struct clk_gate gate;
> +	spinlock_t lock;
> +};
> +
> +static int fsl_sai_clk_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct fsl_sai_clk *sai_clk;
> +	struct clk_parent_data pdata = { .index = 0 };
> +	void __iomem *base;
> +	struct clk_hw *hw;
> +	struct resource *res;
> +
> +	sai_clk = devm_kzalloc(dev, sizeof(*sai_clk), GFP_KERNEL);
> +	if (!sai_clk)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	spin_lock_init(&sai_clk->lock);
> +
> +	sai_clk->gate.reg = base + I2S_CSR;
> +	sai_clk->gate.bit_idx = CSR_BCE_BIT;
> +	sai_clk->gate.lock = &sai_clk->lock;
> +
> +	sai_clk->div.reg = base + I2S_CR2;
> +	sai_clk->div.shift = CR2_DIV_SHIFT;
> +	sai_clk->div.width = CR2_DIV_WIDTH;
> +	sai_clk->div.lock = &sai_clk->lock;
> +
> +	/* set clock direction, we are the BCLK master */
> +	writel(CR2_BCD, base + I2S_CR2);
> +
> +	hw = clk_hw_register_composite_pdata(dev, dev->of_node->name,
> +					     &pdata, 1, NULL, NULL,
> +					     &sai_clk->div.hw,
> +					     &clk_divider_ops,
> +					     &sai_clk->gate.hw,
> +					     &clk_gate_ops,
> +					     CLK_SET_RATE_GATE);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
> +}
> +
> +static const struct of_device_id of_fsl_sai_clk_ids[] = {
> +	{ .compatible = "fsl,vf610-sai-clock" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, of_fsl_sai_clk_ids);
> +
> +static struct platform_driver fsl_sai_clk_driver = {
> +	.probe = fsl_sai_clk_probe,
> +	.driver		= {
> +		.name	= "fsl-sai-clk",
> +		.of_match_table = of_fsl_sai_clk_ids,
> +	},
> +};
> +module_platform_driver(fsl_sai_clk_driver);
> +
> +MODULE_DESCRIPTION("Freescale SAI bitclock-as-a-clock driver");
> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:fsl-sai-clk");
