Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CAAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D8420734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgFAUJg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:09:36 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33986 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbgFAUJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:09:35 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jfqkQ-0004eb-4t; Mon, 01 Jun 2020 22:09:26 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     =?ISO-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, geert@linux-m68k.org,
        kernel@collabora.com
Subject: Re: [PATCH v3 1/1] clk: rockchip: rk3288: Handle clock tree for rk3288w
Date:   Mon, 01 Jun 2020 22:09:25 +0200
Message-ID: <8288442.SvGebX2C5V@diego>
In-Reply-To: <20200601151442.156184-2-mylene.josserand@collabora.com>
References: <20200601151442.156184-1-mylene.josserand@collabora.com> <20200601151442.156184-2-mylene.josserand@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mylène,

Am Montag, 1. Juni 2020, 17:14:42 CEST schrieb Mylène Josserand:
> The revision rk3288w has a different clock tree about "hclk_vio"
> clock, according to the BSP kernel code.
> 
> This patch handles this difference by detecting which device-tree
> we are using. If it is a "rockchip,rk3288-cru", let's register
> the clock tree as it was before. If the compatible is
> "rockchip,rk3288w-cru", we will apply the difference according to this
> version of this SoC.
> 
> Noticed that this new device-tree compatible must be handled by
> bootloader.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@collabora.com>

approach looks good, but you should also update the clock-controller
dt-binding for the new compatible.

Style nits below.


> ---
>  drivers/clk/rockchip/clk-rk3288.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> index cc2a177bbdbf..5018d2f1e54c 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -425,8 +425,6 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
>  	COMPOSITE(0, "aclk_vio0", mux_pll_src_cpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
>  			RK3288_CLKSEL_CON(31), 6, 2, MFLAGS, 0, 5, DFLAGS,
>  			RK3288_CLKGATE_CON(3), 0, GFLAGS),
> -	DIV(0, "hclk_vio", "aclk_vio0", 0,
> -			RK3288_CLKSEL_CON(28), 8, 5, DFLAGS),
>  	COMPOSITE(0, "aclk_vio1", mux_pll_src_cpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
>  			RK3288_CLKSEL_CON(31), 14, 2, MFLAGS, 8, 5, DFLAGS,
>  			RK3288_CLKGATE_CON(3), 2, GFLAGS),
> @@ -819,6 +817,16 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
>  	INVERTER(0, "pclk_isp", "pclk_isp_in", RK3288_CLKSEL_CON(29), 3, IFLAGS),
>  };
>  
> +static struct rockchip_clk_branch rk3288w_hclkvio_branch[] __initdata = {
> +	DIV(0, "hclk_vio", "aclk_vio1", 0,
> +	    RK3288_CLKSEL_CON(28), 8, 5, DFLAGS),

please keep indentations as they were, the sub-lines starting where they
are is actually intentional :-)


> +};
> +
> +static struct rockchip_clk_branch rk3288_hclkvio_branch[] __initdata = {
> +	DIV(0, "hclk_vio", "aclk_vio0", 0,
> +	    RK3288_CLKSEL_CON(28), 8, 5, DFLAGS),

same here

> +};
> +
>  static const char *const rk3288_critical_clocks[] __initconst = {
>  	"aclk_cpu",
>  	"aclk_peri",
> @@ -936,6 +944,14 @@ static void __init rk3288_clk_init(struct device_node *np)
>  				   RK3288_GRF_SOC_STATUS1);
>  	rockchip_clk_register_branches(ctx, rk3288_clk_branches,
>  				  ARRAY_SIZE(rk3288_clk_branches));
> +
> +	if (of_device_is_compatible(np, "rockchip,rk3288w-cru"))
> +		rockchip_clk_register_branches(ctx, rk3288w_hclkvio_branch,
> +					       ARRAY_SIZE(rk3288w_hclkvio_branch));
> +	else
> +		rockchip_clk_register_branches(ctx, rk3288_hclkvio_branch,
> +					       ARRAY_SIZE(rk3288_hclkvio_branch));
> +
>  	rockchip_clk_protect_critical(rk3288_critical_clocks,
>  				      ARRAY_SIZE(rk3288_critical_clocks));
>  
> 




