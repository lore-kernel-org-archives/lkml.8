Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7D7C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA54320773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgIBQDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:03:37 -0400
Received: from foss.arm.com ([217.140.110.172]:41518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgIBQDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:03:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 494FD101E;
        Wed,  2 Sep 2020 09:03:35 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99D0F3F66F;
        Wed,  2 Sep 2020 09:03:33 -0700 (PDT)
Subject: Re: [PATCH v1 6/6] clk: rockchip: rk3399: Support module build
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     huangtao@rock-chips.com, xf@rock-chips.com, sboyd@kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, kever.yang@rock-chips.com,
        linux-rockchip@lists.infradead.org, xxx@rock-chips.com
References: <20200902064847.18881-1-zhangqing@rock-chips.com>
 <20200902065000.18996-1-zhangqing@rock-chips.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6568dae9-4910-6525-d424-98a3fec2cae3@arm.com>
Date:   Wed, 2 Sep 2020 17:03:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200902065000.18996-1-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-02 07:50, Elaine Zhang wrote:
> support CLK_OF_DECLARE and builtin_platform_driver_probe
> double clk init method.
> add module author, description and license to support building
> Soc Rk3399 clock driver as module.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>   drivers/clk/rockchip/clk-rk3399.c | 40 +++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
> index ce1d2446f142..a1d5704b9ba2 100644
> --- a/drivers/clk/rockchip/clk-rk3399.c
> +++ b/drivers/clk/rockchip/clk-rk3399.c
> @@ -5,9 +5,11 @@
>    */
>   
>   #include <linux/clk-provider.h>
> +#include <linux/module.h>
>   #include <linux/io.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
> +#include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
>   #include <dt-bindings/clock/rk3399-cru.h>
> @@ -1600,3 +1602,41 @@ static void __init rk3399_pmu_clk_init(struct device_node *np)
>   	rockchip_clk_of_add_provider(np, ctx);
>   }
>   CLK_OF_DECLARE(rk3399_cru_pmu, "rockchip,rk3399-pmucru", rk3399_pmu_clk_init);
> +
> +static int __init clk_rk3399_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	unsigned long data;
> +
> +	data = (unsigned long)of_device_get_match_data(&pdev->dev);
> +	if (data)
> +		rk3399_pmu_clk_init(np);
> +	else
> +		rk3399_clk_init(np);

It might be clearer and simpler to just store a function pointer in the 
match data directly - there's already precedent for that elsewhere.

Robin.

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id clk_rk3399_match_table[] = {
> +	{
> +		.compatible = "rockchip,rk3399-cru",
> +		.data = (void *)0
> +	},  {
> +		.compatible = "rockchip,rk3399-pmucru",
> +		.data = (void *)1,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, clk_rk3399_match_table);
> +
> +static struct platform_driver clk_rk3399_driver = {
> +	.driver		= {
> +		.name	= "clk-rk3399",
> +		.of_match_table = clk_rk3399_match_table,
> +	},
> +};
> +builtin_platform_driver_probe(clk_rk3399_driver, clk_rk3399_probe);
> +
> +MODULE_DESCRIPTION("Rockchip RK3399 Clock Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:clk-rk3399");
> 
