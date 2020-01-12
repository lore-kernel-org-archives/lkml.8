Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4287FC33CA8
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 02:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108A620866
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 02:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578796861;
	bh=/IIGU/qgpqqRTXW8bMohqvTwPewVuB6W2G42p3yc9HE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XY9kiY0ZxeLCNjYX1/c++I7PjaQGb0GE28rxxhY+cRID1uM5TtJEKXZRDKf1wn2gO
	 yh0DuWAYdnG7SqlBC8rlKehIay+4OkdXrLsr+sepwKNTNISPAetMFD7TBe2wcEpesI
	 wZjUhQgXD7LmRkl+UEvdayWyumdoBKkD094Y1S+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbgALClA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 21:41:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731986AbgALCk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 21:40:59 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5380C2084D;
        Sun, 12 Jan 2020 02:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578796858;
        bh=/IIGU/qgpqqRTXW8bMohqvTwPewVuB6W2G42p3yc9HE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ImEJwUTEMXWvenNIqnbvhqnBQZTjX3B2m84HwCyMPCThfYeDfZcKPhf5Ad1ba/AGu
         3jUgo70nCH90gVas+ybFyBfGoQ6IH50MOlI9oC3FUlmnda/OMf6m0Tn/YnQ/tMYwSq
         2U2c4xFwQS/G9z1C/+zgJZGiNu5kQQ126qwJYp+0=
Date:   Sun, 12 Jan 2020 10:40:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH 3/3] clk: imx: imx8m: use imx_clk_hw_pll14xx_flags for
 dram pll
Message-ID: <20200112024046.GZ4456@T480>
References: <1577696903-27870-1-git-send-email-peng.fan@nxp.com>
 <1577696903-27870-4-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577696903-27870-4-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 09:13:10AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use imx_clk_hw_pll14xx_flags for dram pll.
> Modify imx_1443x_dram_pll to imx_1443x_dram_readonly, because dram pll
> is not expected to be modified from Linux.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mm.c  | 2 +-
>  drivers/clk/imx/clk-imx8mn.c  | 2 +-
>  drivers/clk/imx/clk-pll14xx.c | 3 +--
>  drivers/clk/imx/clk.h         | 2 +-
>  4 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index 2ed93fc25087..55862652b19f 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -337,7 +337,7 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
>  	hws[IMX8MM_AUDIO_PLL1] = imx_clk_hw_pll14xx("audio_pll1", "audio_pll1_ref_sel", base, &imx_1443x_pll);
>  	hws[IMX8MM_AUDIO_PLL2] = imx_clk_hw_pll14xx("audio_pll2", "audio_pll2_ref_sel", base + 0x14, &imx_1443x_pll);
>  	hws[IMX8MM_VIDEO_PLL1] = imx_clk_hw_pll14xx("video_pll1", "video_pll1_ref_sel", base + 0x28, &imx_1443x_pll);
> -	hws[IMX8MM_DRAM_PLL] = imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx_1443x_dram_pll);
> +	hws[IMX8MM_DRAM_PLL] = imx_clk_hw_pll14xx_flags("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx_1443x_pll_readonly, CLK_GET_RATE_NOCACHE);
>  	hws[IMX8MM_GPU_PLL] = imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", base + 0x64, &imx_1416x_pll);
>  	hws[IMX8MM_VPU_PLL] = imx_clk_hw_pll14xx("vpu_pll", "vpu_pll_ref_sel", base + 0x74, &imx_1416x_pll);
>  	hws[IMX8MM_ARM_PLL] = imx_clk_hw_pll14xx("arm_pll", "arm_pll_ref_sel", base + 0x84, &imx_1416x_pll);
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index c5e7316b4c66..e4710d3cf3e0 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -334,7 +334,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>  	hws[IMX8MN_AUDIO_PLL1] = imx_clk_hw_pll14xx("audio_pll1", "audio_pll1_ref_sel", base, &imx_1443x_pll);
>  	hws[IMX8MN_AUDIO_PLL2] = imx_clk_hw_pll14xx("audio_pll2", "audio_pll2_ref_sel", base + 0x14, &imx_1443x_pll);
>  	hws[IMX8MN_VIDEO_PLL1] = imx_clk_hw_pll14xx("video_pll1", "video_pll1_ref_sel", base + 0x28, &imx_1443x_pll);
> -	hws[IMX8MN_DRAM_PLL] = imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx_1443x_dram_pll);
> +	hws[IMX8MN_DRAM_PLL] = imx_clk_hw_pll14xx_flags("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx_1443x_pll_readonly, CLK_GET_RATE_NOCACHE);
>  	hws[IMX8MN_GPU_PLL] = imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", base + 0x64, &imx_1416x_pll);
>  	hws[IMX8MN_VPU_PLL] = imx_clk_hw_pll14xx("vpu_pll", "vpu_pll_ref_sel", base + 0x74, &imx_1416x_pll);
>  	hws[IMX8MN_ARM_PLL] = imx_clk_hw_pll14xx("arm_pll", "arm_pll_ref_sel", base + 0x84, &imx_1416x_pll);
> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
> index 030159dc4884..33236d8580a6 100644
> --- a/drivers/clk/imx/clk-pll14xx.c
> +++ b/drivers/clk/imx/clk-pll14xx.c
> @@ -67,9 +67,8 @@ struct imx_pll14xx_clk imx_1443x_pll = {
>  	.rate_count = ARRAY_SIZE(imx_pll1443x_tbl),
>  };
>  
> -struct imx_pll14xx_clk imx_1443x_dram_pll = {
> +struct imx_pll14xx_clk imx_1443x_pll_readonly = {
>  	.type = PLL_1443X,
> -	.flags = CLK_GET_RATE_NOCACHE,

Not really sure what we gain from creating a new function and moving the
flag from here to there.  I'm personally not fond of it.

Shawn

>  };
>  
>  struct imx_pll14xx_clk imx_1416x_pll = {
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index 35a9d294b6df..ea84d2993b57 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -53,7 +53,7 @@ struct imx_pll14xx_clk {
>  
>  extern struct imx_pll14xx_clk imx_1416x_pll;
>  extern struct imx_pll14xx_clk imx_1443x_pll;
> -extern struct imx_pll14xx_clk imx_1443x_dram_pll;
> +extern struct imx_pll14xx_clk imx_1443x_pll_readonly;
>  
>  #define imx_clk_cpu(name, parent_name, div, mux, pll, step) \
>  	to_clk(imx_clk_hw_cpu(name, parent_name, div, mux, pll, step))
> -- 
> 2.16.4
> 
