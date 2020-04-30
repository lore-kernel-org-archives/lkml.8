Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56142C8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3309020757
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="H25phI8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgD3LKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:10:41 -0400
Received: from plaes.org ([188.166.43.21]:36818 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgD3LKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:10:40 -0400
Received: from plaes.org (localhost [127.0.0.1])
        by plaes.org (Postfix) with ESMTPSA id E3AAB40020;
        Thu, 30 Apr 2020 11:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1588245037; bh=wGwTZHV5v8qKni061zMNTsjG2rEXMiZAla90C3apllk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=H25phI8N7ycVJKywAOIeqjmSrnuFDp4mPDmCjwY7WXtyFgcZWLOYxR4dIt8Pbj+oh
         Nscjifko/voYP2DVEfa314VVn53IBysTYElbzpqYYrJlXUJJrl3WEfsMr1syB87sqv
         vdysgYyw9e2GKyZ2NgQ09dbJGN2b2B/ghF8wqbC5/6GdxRNuUx+7OGEw+oT0vYfy62
         T/G99P6ZevIvy0nYR/gH/VLmTATGsoR/MPgGl1O476EjMyOIvjFqWwBQEsASz51vEw
         llk3ipdBIw4yYYMHjVpZIg40Tq9VRKEC7/nI1PNGofwDkRNmLQwuQqdXFv6qqYhUeN
         0wAQIe2+w1LbQ==
Date:   Thu, 30 Apr 2020 11:10:36 +0000
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 2/6] clk: sunxi-ng: a31: Register regmap for sun6i CCU
Message-ID: <20200430111036.GB32281@plaes.org>
References: <20200429204612.31883-1-plaes@plaes.org>
 <20200429204612.31883-3-plaes@plaes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429204612.31883-3-plaes@plaes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 11:46:08PM +0300, Priit Laes wrote:

I somehow messed up this patch when preparing the patchset,
so I'll resend the fixed patch with v3.

> On sun6i, the gmac clock is handled by the dwmac-sunxi driver, but
> its configuration register is located in the CCU register range,
> requiring proper regmap setup.
> 
> In order to do that, we use CLK_OF_DECLARE_DRIVER to initialize
> sun7i ccu, which clears the OF_POPULATED flag, allowing the
> platform device to probe the same resource with device node.
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 60 +++++++++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
> index 9b40d53266a3..086eb93a4efd 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
> @@ -1262,5 +1262,61 @@ static void __init sun6i_a31_ccu_setup(struct device_node *node)
>  	ccu_mux_notifier_register(pll_cpu_clk.common.hw.clk,
>  				  &sun6i_a31_cpu_nb);
>  }
> -CLK_OF_DECLARE(sun6i_a31_ccu, "allwinner,sun6i-a31-ccu",
> -	       sun6i_a31_ccu_setup);
> +CLK_OF_DECLARE_DRIVER(sun6i_a31_ccu, "allwinner,sun6i-a31-ccu",
> +		      sun6i_a31_ccu_setup);
> +
> +/*
> + * Regmap for the GMAC driver (dwmac-sunxi) to allow access to
> + * GMAC configuration register.
> + */
> +#define SUN6I_A31_GMAC_CFG_REG 0xD0
> +static bool sun6i_a31_ccu_regmap_accessible_reg(struct device *dev,
> +						unsigned int reg)
> +{
> +	if (reg == SUN6I_A31_GMAC_CFG_REG)
> +		return true;
> +	return false;
> +}
> +
> +static struct regmap_config sun6i_a31_ccu_regmap_config = {
> +	.reg_bits	= 32,
> +	.val_bits	= 32,
> +	.reg_stride	= 4,
> +	.max_register	= 0x308, /* clk_out_b */
> +
> +	.readable_reg	= sun6i_a31_ccu_regmap_accessible_reg,
> +	.writeable_reg	= sun6i_a31_ccu_regmap_accessible_reg,
> +};
> +
> +static int sun6i_a31_ccu_probe_regmap(struct platform_device *pdev)
> +{
> +	void __iomem *reg;
> +	struct resource *res;
> +	struct regmap *regmap;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	reg = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (IS_ERR(reg))
> +		return PTR_ERR(reg);
> +
> +	regmap = devm_regmap_init_mmio(&pdev->dev, reg,
> +				       &sun6i_a31_ccu_regmap_accessible_reg);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sun6i_a31_ccu_ids[] = {
> +	{ .compatible = "allwinner,sun6i-a31-ccu"},
> +	{ }
> +};
> +
> +static struct platform_driver sun6i_a31_ccu_driver = {
> +	.probe = sun6i_a31_ccu_probe_regmap,
> +	.driver = {
> +		.name = "sun6i-a31-ccu",
> +		.of_match_table = sun6i_a31_ccu_ids,
> +	},
> +};
> +builtin_platform_driver(sun6i_a31_ccu_driver);
> -- 
> 2.26.2
> 
