Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D179C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323772467C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583820606;
	bh=lmofL6zPOTUwW96AcgEjrGHpaVnxI5v52+JtS/JQTNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F6pZv6uBZFXPmB6cLUzcPYceLQdDDZPZxr3hmRFfEkEtPSEWmxs8EIpS9uip7Bffl
	 4aupuCb/I8TN7ob0tsWNJHYnWALy60VbqFsdT9FiGlfUHzBnabm/V0reH43qyQkaLD
	 0J4OumrV0HXtWGqdGu6v/cljcvKoxRM4807GTeJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgCJGKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgCJGKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 02:10:05 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F9AA24679;
        Tue, 10 Mar 2020 06:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583820603;
        bh=lmofL6zPOTUwW96AcgEjrGHpaVnxI5v52+JtS/JQTNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBRbs6BB1k1h6caHA4WGw4wD6FbTVztn/TNZK4Vt6hYEuE+Cvk+y/f4euXdZ5PATb
         lnsTozuhbGsL2u0noyToPDFTRZvx0k9LTDxGDKor7LPwp+iyG1dW+vUI2JNAJem/aR
         ekzbRxk6lEKmnLF+soelrVZA5iue/mxlru1hx3pk=
Date:   Tue, 10 Mar 2020 14:09:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, sboyd@kernel.org, robh+dt@kernel.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        abel.vesa@nxp.com
Subject: Re: [PATCH v2 07/14] clk: imx7ulp: make it easy to change ARM core
 clk
Message-ID: <20200310060956.GJ15729@dragon>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
 <1582099197-20327-8-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582099197-20327-8-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 03:59:50PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> ARM clk could only source from divcore or hsrun_divcore.
> 
> However when ARM core is running normaly, whether divcore or
> hwrun_divcore will finally source from SPLL_PFD0. However SPLL_PFD0
> is marked with CLK_SET_GATE, so we need to disable SPLL_PFD0, when
> configure the rate. So add CORE and HSRUN_CORE virtual clk to make it
> easy to configure the clk using imx_clk_hw_cpu API.

It sounds a bit hackish, so would like to hear an ACK from Stephen on
it.

Shawn

> 
> Since CORE and HSRUN_CORE already marked with CLK_IS_CRITICAL, no
> need to set ARM as CLK_IS_CRITICAL. And when set the rate of ARM clk,
> prograting it the parent with CLK_SET_RATE_PARENT will finally set
> the SPLL_PFD0 clk.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx7ulp.c             | 6 ++++--
>  include/dt-bindings/clock/imx7ulp-clock.h | 5 ++++-
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
> index 3710aa0dee9b..634c0b6636b0 100644
> --- a/drivers/clk/imx/clk-imx7ulp.c
> +++ b/drivers/clk/imx/clk-imx7ulp.c
> @@ -29,7 +29,7 @@ static const char * const ddr_sels[]		= { "apll_pfd_sel", "dummy", "dummy", "dum
>  static const char * const nic_sels[]		= { "firc", "ddr_clk", };
>  static const char * const periph_plat_sels[]	= { "dummy", "nic1_bus_clk", "nic1_clk", "ddr_clk", "apll_pfd2", "apll_pfd1", "apll_pfd0", "upll", };
>  static const char * const periph_bus_sels[]	= { "dummy", "sosc_bus_clk", "dummy", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_clk", };
> -static const char * const arm_sels[]		= { "divcore", "dummy", "dummy", "hsrun_divcore", };
> +static const char * const arm_sels[]		= { "core", "dummy", "dummy", "hsrun_core", };
>  
>  /* used by sosc/sirc/firc/ddr/spll/apll dividers */
>  static const struct clk_div_table ulp_div_table[] = {
> @@ -121,7 +121,9 @@ static void __init imx7ulp_clk_scg1_init(struct device_node *np)
>  	hws[IMX7ULP_CLK_DDR_SEL]	= imx_clk_hw_mux_flags("ddr_sel", base + 0x30, 24, 2, ddr_sels, ARRAY_SIZE(ddr_sels), CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
>  
>  	hws[IMX7ULP_CLK_CORE_DIV]	= imx_clk_hw_divider_flags("divcore",	"scs_sel",  base + 0x14, 16, 4, CLK_SET_RATE_PARENT);
> +	hws[IMX7ULP_CLK_CORE]		= imx_clk_hw_cpu("core", "divcore", hws[IMX7ULP_CLK_CORE_DIV]->clk, hws[IMX7ULP_CLK_SYS_SEL]->clk, hws[IMX7ULP_CLK_SPLL_SEL]->clk, hws[IMX7ULP_CLK_FIRC]->clk);
>  	hws[IMX7ULP_CLK_HSRUN_CORE_DIV] = imx_clk_hw_divider_flags("hsrun_divcore", "hsrun_scs_sel", base + 0x1c, 16, 4, CLK_SET_RATE_PARENT);
> +	hws[IMX7ULP_CLK_HSRUN_CORE] = imx_clk_hw_cpu("hsrun_core", "hsrun_divcore", hws[IMX7ULP_CLK_HSRUN_CORE_DIV]->clk, hws[IMX7ULP_CLK_HSRUN_SYS_SEL]->clk, hws[IMX7ULP_CLK_SPLL_SEL]->clk, hws[IMX7ULP_CLK_FIRC]->clk);
>  
>  	hws[IMX7ULP_CLK_DDR_DIV]	= imx_clk_hw_divider_gate("ddr_clk", "ddr_sel", CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, base + 0x30, 0, 3,
>  							       0, ulp_div_table, &imx_ccm_lock);
> @@ -270,7 +272,7 @@ static void __init imx7ulp_clk_smc1_init(struct device_node *np)
>  	base = of_iomap(np, 0);
>  	WARN_ON(!base);
>  
> -	hws[IMX7ULP_CLK_ARM] = imx_clk_hw_mux_flags("arm", base + 0x10, 8, 2, arm_sels, ARRAY_SIZE(arm_sels), CLK_IS_CRITICAL);
> +	hws[IMX7ULP_CLK_ARM] = imx_clk_hw_mux_flags("arm", base + 0x10, 8, 2, arm_sels, ARRAY_SIZE(arm_sels), CLK_SET_RATE_PARENT);
>  
>  	imx_check_clk_hws(hws, clk_data->num);
>  
> diff --git a/include/dt-bindings/clock/imx7ulp-clock.h b/include/dt-bindings/clock/imx7ulp-clock.h
> index 38145bdcd975..b58370d146e2 100644
> --- a/include/dt-bindings/clock/imx7ulp-clock.h
> +++ b/include/dt-bindings/clock/imx7ulp-clock.h
> @@ -58,7 +58,10 @@
>  #define IMX7ULP_CLK_HSRUN_SYS_SEL	44
>  #define IMX7ULP_CLK_HSRUN_CORE_DIV	45
>  
> -#define IMX7ULP_CLK_SCG1_END		46
> +#define IMX7ULP_CLK_CORE		46
> +#define IMX7ULP_CLK_HSRUN_CORE		47
> +
> +#define IMX7ULP_CLK_SCG1_END		48
>  
>  /* PCC2 */
>  #define IMX7ULP_CLK_DMA1		0
> -- 
> 2.16.4
> 
