Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB3CC33CA9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 02:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E715C2146E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 02:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578796382;
	bh=YRjvlsgTQuj3u/TvrEuaCjHvc+8K0Fs4QuWe6tKRScc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hVEq1f87KuR60I+i+dw1J2INX6xypKdVo4scB5OHsgk3NrFBebvcSzWA/KGxPNWa1
	 oMzX6HyA+fbj7NgNlNSL2t/XbnQNvJLjXC9sI70f76c3MgRW+2uoGNNEbEttkU5zNk
	 /WZDt6yMVnItVYNpv68RQXmiZpdLg2OdHQWnxvs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbgALCdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 21:33:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731968AbgALCdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 21:33:00 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 645F020848;
        Sun, 12 Jan 2020 02:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578796380;
        bh=YRjvlsgTQuj3u/TvrEuaCjHvc+8K0Fs4QuWe6tKRScc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l6g4ajT4+0Mr+WYNrKFrvvSJJNJvYkHNG0j9MSzzXTtNPmBFoqpQR4MOkTSIhcuLk
         F/MC8iFih1/iDbLj1m7bHlBuGzm84duo4vQoLt6B2IRW6ktcMWr4gtM+y9VSYaqXp8
         J3UIhN+oAHG0CI70PyjrR2yFE20OakC10FSx24BE=
Date:   Sun, 12 Jan 2020 10:32:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH 1/3] clk: imx: pll14xx: avoid modify dram pll
Message-ID: <20200112023248.GY4456@T480>
References: <1577696903-27870-1-git-send-email-peng.fan@nxp.com>
 <1577696903-27870-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577696903-27870-2-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 09:13:00AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The dram pll is only expected to be modified in firmware,
> so we should only support read clk frequency in Linux Kernel.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

@Leonard, do you agree?

Shawn

> ---
>  drivers/clk/imx/clk-pll14xx.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
> index 5b0519a81a7a..9288b21d4d59 100644
> --- a/drivers/clk/imx/clk-pll14xx.c
> +++ b/drivers/clk/imx/clk-pll14xx.c
> @@ -69,8 +69,6 @@ struct imx_pll14xx_clk imx_1443x_pll = {
>  
>  struct imx_pll14xx_clk imx_1443x_dram_pll = {
>  	.type = PLL_1443X,
> -	.rate_table = imx_pll1443x_tbl,
> -	.rate_count = ARRAY_SIZE(imx_pll1443x_tbl),
>  	.flags = CLK_GET_RATE_NOCACHE,
>  };
>  
> @@ -376,6 +374,10 @@ static const struct clk_ops clk_pll1443x_ops = {
>  	.set_rate	= clk_pll1443x_set_rate,
>  };
>  
> +static const struct clk_ops clk_pll1443x_min_ops = {
> +	.recalc_rate	= clk_pll1443x_recalc_rate,
> +};
> +
>  struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char *parent_name,
>  				  void __iomem *base,
>  				  const struct imx_pll14xx_clk *pll_clk)
> @@ -403,7 +405,10 @@ struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char *parent_name,
>  			init.ops = &clk_pll1416x_ops;
>  		break;
>  	case PLL_1443X:
> -		init.ops = &clk_pll1443x_ops;
> +		if (!pll_clk->rate_table)
> +			init.ops = &clk_pll1443x_min_ops;
> +		else
> +			init.ops = &clk_pll1443x_ops;
>  		break;
>  	default:
>  		pr_err("%s: Unknown pll type for pll clk %s\n",
> -- 
> 2.16.4
> 
