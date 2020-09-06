Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7C1C2D0A8
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 22:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 097D620C09
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 22:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgIFWtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 18:49:35 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38472 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgIFWtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 18:49:32 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kF3TU-0002fd-Ag; Mon, 07 Sep 2020 00:49:28 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: Re: [PATCH v3 6/6] clk: rockchip: rk3399: Support module build
Date:   Mon, 07 Sep 2020 00:49:27 +0200
Message-ID: <3524790.GmC4BGDxql@diego>
In-Reply-To: <20200904074505.24917-1-zhangqing@rock-chips.com>
References: <20200904074405.24439-1-zhangqing@rock-chips.com> <20200904074505.24917-1-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 4. September 2020, 09:45:05 CEST schrieb Elaine Zhang:
> support CLK_OF_DECLARE and builtin_platform_driver_probe
> double clk init method.
> add module author, description and license to support building
> Soc Rk3399 clock driver as module.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>  drivers/clk/rockchip/clk-rk3399.c | 55 +++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
> index ce1d2446f142..40ff17aee5b6 100644
> --- a/drivers/clk/rockchip/clk-rk3399.c
> +++ b/drivers/clk/rockchip/clk-rk3399.c
> @@ -5,9 +5,11 @@
>   */
>  
>  #include <linux/clk-provider.h>
> +#include <linux/module.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <dt-bindings/clock/rk3399-cru.h>
> @@ -1600,3 +1602,56 @@ static void __init rk3399_pmu_clk_init(struct device_node *np)
>  	rockchip_clk_of_add_provider(np, ctx);
>  }
>  CLK_OF_DECLARE(rk3399_cru_pmu, "rockchip,rk3399-pmucru", rk3399_pmu_clk_init);
> +
> +struct clk_rk3399_inits {
> +		void (*inits)(struct device_node *np);
> +};
> +
> +static const struct clk_rk3399_inits clk_rk3399_pmucru_init = {
> +	.inits = rk3399_pmu_clk_init,
> +};
> +
> +static const struct clk_rk3399_inits clk_rk3399_cru_init = {
> +	.inits = rk3399_clk_init,
> +};
> +
> +static const struct of_device_id clk_rk3399_match_table[] = {
> +	{
> +		.compatible = "rockchip,rk3399-cru",
> +		.data = &clk_rk3399_cru_init,
> +	},  {
> +		.compatible = "rockchip,rk3399-pmucru",
> +		.data = &clk_rk3399_pmucru_init,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, clk_rk3399_match_table);
> +
> +static int __init clk_rk3399_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	const struct of_device_id *match;
> +	const struct clk_rk3399_inits *init_data;
> +
> +	match = of_match_device(clk_rk3399_match_table, &pdev->dev);
> +	if (!match || !match->data)
> +		return -EINVAL;
> +
> +	init_data = match->data;
> +	if (init_data->inits)
> +		init_data->inits(np);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver clk_rk3399_driver = {
> +	.driver		= {
> +		.name	= "clk-rk3399",
> +		.of_match_table = clk_rk3399_match_table,

I guess we probably want
		.suppress_bind_attrs = true,

here, because there is no unloading.
Also what happens when you try to rmmod the module?

Heiko


