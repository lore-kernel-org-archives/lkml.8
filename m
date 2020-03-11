Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2830C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAC921D56
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583908816;
	bh=pmJS1KPAVu0tCjnfh13UknbuRkIWI610a6eXK2eKvFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zml6awGaytIs+tdboLqY2Q+DNRUd12/55+bxSNjdb2UG3DfAZFZ99u3qTZJp7UBkB
	 wvVzX5VdTupetnTL8ffVDbA5vpCyN60PEsgqsfXVLa0DeDniSRHPXb8FRXRyg0TKFN
	 42EsJkN0z8DuRv8jXanZtyO9XH9JL8ZfVU5GyLCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgCKGkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 02:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgCKGkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:40:15 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E2DB2192A;
        Wed, 11 Mar 2020 06:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583908814;
        bh=pmJS1KPAVu0tCjnfh13UknbuRkIWI610a6eXK2eKvFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=din59zveAKkT42o8gjyMV9c31EJn1iJ/B75t1hHffEOkhU4QFIcVZ6M7l40ltYyD0
         4/axfTn//VT63Z/66gWFkte+SDZP2uiUoQdnywhYphWU3+2O7XRmpKd7YKwfnpVSew
         hrKlx4q9/mJ8sfF1bHt4Mo7YHXlN+82wH0w214Wg=
Date:   Wed, 11 Mar 2020 14:40:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com,
        fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/4] clk: imx8mn: A53 core clock no need to be critical
Message-ID: <20200311064005.GE29269@dragon>
References: <1582620554-32689-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582620554-32689-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 04:49:11PM +0800, Anson Huang wrote:
> 'A53_CORE' is just a mux and no need to be critical, being critical
> will cause its parent clock always ON which does NOT make sense,

I do not quite understand what problem this patch is trying to fix.  In
the end, all the ancestor clocks of "arm", including "arm_a53_core" will
still be ON, as "arm" has CLK_IS_CRITICAL flag.  What is the difference
you are trying to make here?

Shawn

> to make sure CPU's hardware clock source NOT being disabled during
> clock tree setup, need to move the 'A53_SRC'/'A53_CORE' reparent
> operations to after critical clock 'ARM_CLK' setup finished.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mn.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index 83618af..0bc7070 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -428,7 +428,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>  	hws[IMX8MN_CLK_GPU_SHADER_DIV] = hws[IMX8MN_CLK_GPU_SHADER];
>  
>  	/* CORE SEL */
> -	hws[IMX8MN_CLK_A53_CORE] = imx_clk_hw_mux2_flags("arm_a53_core", base + 0x9880, 24, 1, imx8mn_a53_core_sels, ARRAY_SIZE(imx8mn_a53_core_sels), CLK_IS_CRITICAL);
> +	hws[IMX8MN_CLK_A53_CORE] = imx_clk_hw_mux2("arm_a53_core", base + 0x9880, 24, 1, imx8mn_a53_core_sels, ARRAY_SIZE(imx8mn_a53_core_sels));
>  
>  	/* BUS */
>  	hws[IMX8MN_CLK_MAIN_AXI] = imx8m_clk_hw_composite_critical("main_axi", imx8mn_main_axi_sels, base + 0x8800);
> @@ -559,15 +559,15 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>  
>  	hws[IMX8MN_CLK_DRAM_ALT_ROOT] = imx_clk_hw_fixed_factor("dram_alt_root", "dram_alt", 1, 4);
>  
> -	clk_hw_set_parent(hws[IMX8MN_CLK_A53_SRC], hws[IMX8MN_SYS_PLL1_800M]);
> -	clk_hw_set_parent(hws[IMX8MN_CLK_A53_CORE], hws[IMX8MN_ARM_PLL_OUT]);
> -
>  	hws[IMX8MN_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
>  					   hws[IMX8MN_CLK_A53_CORE]->clk,
>  					   hws[IMX8MN_CLK_A53_CORE]->clk,
>  					   hws[IMX8MN_ARM_PLL_OUT]->clk,
>  					   hws[IMX8MN_CLK_A53_DIV]->clk);
>  
> +	clk_hw_set_parent(hws[IMX8MN_CLK_A53_SRC], hws[IMX8MN_SYS_PLL1_800M]);
> +	clk_hw_set_parent(hws[IMX8MN_CLK_A53_CORE], hws[IMX8MN_ARM_PLL_OUT]);
> +
>  	imx_check_clk_hws(hws, IMX8MN_CLK_END);
>  
>  	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
> -- 
> 2.7.4
> 
