Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DEEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F0AA2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597846205;
	bh=In5ktcVArsKzAgL094eAzOG9AV78RIA0HS0QwxilghY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cBA6LkqCyUX+YYbARb1ezKXWeP/Q4gFLCt5gBUNIMR3dKh6b/x2ORaPRYeNvfleD0
	 TvbIq8Mdch/2nJKpRjMLsQ2RskJ2KZgfItLF/NnIPfXKDAShQjJn2Ega7skfmODW3+
	 j5B9c7FgxSj7BpeP1kai7mRmncLTT9r/GvoxmzwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgHSOKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgHSOJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:09:59 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28E45204FD;
        Wed, 19 Aug 2020 14:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597846199;
        bh=In5ktcVArsKzAgL094eAzOG9AV78RIA0HS0QwxilghY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vxuxv61vOKbl4FMNhYbl9exlmUtZMi3X2eawLCShnhs9vzDfwgzlJ8tWZjw8BxFyH
         +cTpUlRdHCu/7n5igw1bC/0pb134Au/9eSSoeaMtuXhvJAdMb7A2I6t0aV14FBNOr4
         HFXA0sXDCrRihMZH2Gu4mBVGfVBwZmx7sn+lgMJQ=
Date:   Wed, 19 Aug 2020 22:09:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     sboyd@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, kernel@pengutronix.de, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: imx: imx8m: avoid memory leak
Message-ID: <20200819140939.GG7114@dragon>
References: <1595926999-14934-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595926999-14934-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 05:03:18PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use devm_kzalloc() to avoid memory leak when probe fail.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Add () to functions in commit log
> 
>  drivers/clk/imx/clk-imx8mm.c |  3 +--
>  drivers/clk/imx/clk-imx8mn.c | 15 +++++----------
>  drivers/clk/imx/clk-imx8mp.c |  2 +-
>  drivers/clk/imx/clk-imx8mq.c |  3 +--
>  4 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index b793264c21c6..b43dbe305e7a 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -306,8 +306,7 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
>  	void __iomem *base;
>  	int ret, i;
>  
> -	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
> -					  IMX8MM_CLK_END), GFP_KERNEL);
> +	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, IMX8MM_CLK_END), GFP_KERNEL);
>  	if (WARN_ON(!clk_hw_data))
>  		return -ENOMEM;
>  
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index 213cc37b3173..4189f7f6980e 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -299,8 +299,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>  	void __iomem *base;
>  	int ret, i;
>  
> -	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
> -					  IMX8MN_CLK_END), GFP_KERNEL);
> +	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, IMX8MN_CLK_END), GFP_KERNEL);
>  	if (WARN_ON(!clk_hw_data))
>  		return -ENOMEM;
>  
> @@ -318,10 +317,8 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mn-anatop");
>  	base = of_iomap(np, 0);
>  	of_node_put(np);
> -	if (WARN_ON(!base)) {
> -		ret = -ENOMEM;
> -		goto unregister_hws;
> -	}
> +	if (WARN_ON(!base))
> +		return -ENOMEM;
>  
>  	hws[IMX8MN_AUDIO_PLL1_REF_SEL] = imx_clk_hw_mux("audio_pll1_ref_sel", base + 0x0, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>  	hws[IMX8MN_AUDIO_PLL2_REF_SEL] = imx_clk_hw_mux("audio_pll2_ref_sel", base + 0x14, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> @@ -407,10 +404,8 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>  
>  	np = dev->of_node;
>  	base = devm_platform_ioremap_resource(pdev, 0);
> -	if (WARN_ON(IS_ERR(base))) {
> -		ret = PTR_ERR(base);
> -		goto unregister_hws;
> -	}
> +	if (WARN_ON(IS_ERR(base)))
> +		return PTR_ERR(base);

How is this related to devm_kzalloc() change?

Shawn

>  
>  	/* CORE */
>  	hws[IMX8MN_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mn_a53_sels, base + 0x8000);
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index ca747712400f..f6ec7b2b8038 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -447,7 +447,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>  		return PTR_ERR(ccm_base);
>  	}
>  
> -	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws, IMX8MP_CLK_END), GFP_KERNEL);
> +	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, IMX8MP_CLK_END), GFP_KERNEL);
>  	if (WARN_ON(!clk_hw_data)) {
>  		iounmap(anatop_base);
>  		return -ENOMEM;
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index a64aace213c2..0106a33c24a4 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -288,8 +288,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
>  	void __iomem *base;
>  	int err, i;
>  
> -	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
> -					  IMX8MQ_CLK_END), GFP_KERNEL);
> +	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, IMX8MQ_CLK_END), GFP_KERNEL);
>  	if (WARN_ON(!clk_hw_data))
>  		return -ENOMEM;
>  
> -- 
> 2.16.4
> 
