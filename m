Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A676C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 03:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F522465A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 03:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583811920;
	bh=XU1iaEoFKeDSPhyM0B1RGxdNirA5m5Riwf4RccYZs6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kkwW14tYDrIpt/GuuLOX5j3YxCxOZtVhKHytyd/UnD15qGt+IzE/fR0eOFYLUz4zu
	 EzYDhgqXdq9Ue6mEEEWM5ZnMevZdksWuJiJhMMRmksbYhsC1hC68hiP/0Hu+Oi1n9z
	 DVBc9OFKcLNqgfv3v48+WqmCn9l+OWUq5H0e/0EU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCJDpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 23:45:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgCJDpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 23:45:19 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 125CD24649;
        Tue, 10 Mar 2020 03:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583811918;
        bh=XU1iaEoFKeDSPhyM0B1RGxdNirA5m5Riwf4RccYZs6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKO1iKnqIswkp3yypbOocsMQQtQU0I5BoVoL1ifXV41HcmVT9Fb4uan7rt2pnwRjN
         IhkYcgq7H/J3yZ1aRGsAPoDEDc3HjX40OjfskfPCsh7VAQU4C4lEvxJPG6LGwuIBW7
         32PC/s4h03GSYz415BKZpbDLos6SNn0Ti/rLvSvc=
Date:   Tue, 10 Mar 2020 11:45:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, aisheng.dong@nxp.com, peng.fan@nxp.com,
        fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] clk: imx: imx8qxp: Enable SCU and LPCG clocks for
 I2C in CM40 SS
Message-ID: <20200310034506.GC15729@dragon>
References: <1581909561-12058-1-git-send-email-qiangqing.zhang@nxp.com>
 <1581909561-12058-5-git-send-email-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581909561-12058-5-git-send-email-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 11:19:18AM +0800, Joakim Zhang wrote:
> Enable SCU and LPCG clocks for I2C in CM40 SS.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

So you decided to stop waiting for Aisheng's new imx8qxp clock driver?

Shawn

> ---
>  drivers/clk/imx/clk-imx8qxp-lpcg.c | 12 ++++++++++++
>  drivers/clk/imx/clk-imx8qxp-lpcg.h |  3 +++
>  drivers/clk/imx/clk-imx8qxp.c      |  4 ++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> index 04c8ee35e14c..795909ecfba6 100644
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> @@ -151,6 +151,17 @@ static const struct imx8qxp_lpcg_data imx8qxp_lpcg_lsio[] = {
>  	{ IMX_LSIO_LPCG_PWM6_IPG_MSTR_CLK, "pwm6_lpcg_ipg_mstr_clk", "pwm6_clk", 0, LSIO_PWM_6_LPCG, 24, 0, },
>  };
>  
> +static const struct imx8qxp_lpcg_data imx8qxp_lpcg_cm40[] = {
> +	{ IMX_CM40_LPCG_I2C_CLK, "cm40_lpcg_i2c_clk", "cm40_i2c_clk", 0, CM40_I2C_LPCG, 0, 0, },
> +	{ IMX_CM40_LPCG_I2C_IPG_CLK, "cm40_lpcg_i2c_ipg_clk", "cm40_ipg_clk_root", 0, CM40_I2C_LPCG, 16, 0, },
> +};
> +
> +static const struct imx8qxp_ss_lpcg imx8qxp_ss_cm40 = {
> +	.lpcg = imx8qxp_lpcg_cm40,
> +	.num_lpcg = ARRAY_SIZE(imx8qxp_lpcg_cm40),
> +	.num_max = IMX_CM40_LPCG_CLK_END,
> +};
> +
>  static const struct imx8qxp_ss_lpcg imx8qxp_ss_lsio = {
>  	.lpcg = imx8qxp_lpcg_lsio,
>  	.num_lpcg = ARRAY_SIZE(imx8qxp_lpcg_lsio),
> @@ -219,6 +230,7 @@ static const struct of_device_id imx8qxp_lpcg_match[] = {
>  	{ .compatible = "fsl,imx8qxp-lpcg-adma", &imx8qxp_ss_adma, },
>  	{ .compatible = "fsl,imx8qxp-lpcg-conn", &imx8qxp_ss_conn, },
>  	{ .compatible = "fsl,imx8qxp-lpcg-lsio", &imx8qxp_ss_lsio, },
> +	{ .compatible = "fsl,imx8qxp-lpcg-cm40", &imx8qxp_ss_cm40, },
>  	{ /* sentinel */ }
>  };
>  
> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.h b/drivers/clk/imx/clk-imx8qxp-lpcg.h
> index 2a37ce57c500..28ca730dd135 100644
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.h
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.h
> @@ -99,4 +99,7 @@
>  #define ADMA_FLEXCAN_1_LPCG		0x1ce0000
>  #define ADMA_FLEXCAN_2_LPCG		0x1cf0000
>  
> +/* CM40 SS */
> +#define CM40_I2C_LPCG			0x60000
> +
>  #endif /* _IMX8QXP_LPCG_H */
> diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
> index 5e2903efc488..d051073ff042 100644
> --- a/drivers/clk/imx/clk-imx8qxp.c
> +++ b/drivers/clk/imx/clk-imx8qxp.c
> @@ -53,6 +53,7 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
>  	clks[IMX_HSIO_PER_CLK]		= clk_hw_register_fixed_rate(NULL, "hsio_per_clk_root", NULL, 0, 133333333);
>  	clks[IMX_LSIO_MEM_CLK]		= clk_hw_register_fixed_rate(NULL, "lsio_mem_clk_root", NULL, 0, 200000000);
>  	clks[IMX_LSIO_BUS_CLK]		= clk_hw_register_fixed_rate(NULL, "lsio_bus_clk_root", NULL, 0, 100000000);
> +	clks[IMX_CM40_IPG_CLK]		= clk_hw_register_fixed_rate(NULL, "cm40_ipg_clk_root", NULL, 0, 132000000);
>  
>  	/* ARM core */
>  	clks[IMX_A35_CLK]		= imx_clk_scu("a35_clk", IMX_SC_R_A35, IMX_SC_PM_CLK_CPU);
> @@ -128,6 +129,9 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
>  	clks[IMX_GPU0_CORE_CLK]		= imx_clk_scu("gpu_core0_clk",	 IMX_SC_R_GPU_0_PID0, IMX_SC_PM_CLK_PER);
>  	clks[IMX_GPU0_SHADER_CLK]	= imx_clk_scu("gpu_shader0_clk", IMX_SC_R_GPU_0_PID0, IMX_SC_PM_CLK_MISC);
>  
> +	/* CM40 SS */
> +	clks[IMX_CM40_I2C_CLK]		= imx_clk_scu("cm40_i2c_clk", IMX_SC_R_M4_0_I2C, IMX_SC_PM_CLK_PER);
> +
>  	for (i = 0; i < clk_data->num; i++) {
>  		if (IS_ERR(clks[i]))
>  			pr_warn("i.MX clk %u: register failed with %ld\n",
> -- 
> 2.17.1
> 
