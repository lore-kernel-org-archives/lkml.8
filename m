Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F783C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 03:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0893D2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 03:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582513505;
	bh=lBP3sLiTdE3mK2nNhYHVOrpOPMuKGWVZqzVUSARmOQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WFJB7SOzDX1dBbSxiJKZ+Vp6LcIEGA/CUJFNoONusp+GPHB2MlFEo7971SY+n8xvT
	 DXXcpjWFiCwSOv0tlaMycZhC3vD/2MDlyeovSaBEhxOK1vrnSTf0gsMiIqlmHfdhCK
	 A9RbiiAqtv+RhsmdYasCiSo7kCAsroW8j31ADoZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgBXDFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 22:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:37608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbgBXDFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 22:05:03 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58C9A20658;
        Mon, 24 Feb 2020 03:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582513502;
        bh=lBP3sLiTdE3mK2nNhYHVOrpOPMuKGWVZqzVUSARmOQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LyOMw9JJ7RmFgbAhf5K9kXqji7z86MdXF9Aru7jF0ubHaQAAUUdHqWnWrtC9IUJhi
         NFqfqFuWFHoHb0jHKr9z6MiGVOtY5wOx41yY4V0XpG2rGMLM0hjnVMrwouex3YD4DJ
         c0zfOo/Qy8cuxrfTKfXFuEe4B3IxNkj7e67IqTLM=
Date:   Mon, 24 Feb 2020 11:04:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, abel.vesa@nxp.com, peng.fan@nxp.com,
        fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 3/3] clk: imx8mp: Correct the enet_qos parent clock
Message-ID: <20200224030453.GG27688@dragon>
References: <1582092251-19222-1-git-send-email-Anson.Huang@nxp.com>
 <1582092251-19222-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582092251-19222-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 02:04:11PM +0800, Anson Huang wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
> 
> enet_qos is for eqos tsn AXI bus clock whose clock source is from
> ccm_enet_axi_clk_root, and controlled by CCM_CCGR59(offset 0x43b0)
> and CCM_CCGR64(offset 0x4400), so correct enet_qos root clock's
> parent clock to sim_enet.
> 
> Fixes: 9c140d992676 ("clk: imx: Add support for i.MX8MP clock driver")
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>

When you forward a patch from someone, you need to add your SoB.

I fixed it up and applied all.

Shawn

> ---
>  drivers/clk/imx/clk-imx8mp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 1a9d7a0..cb58fb8 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -688,7 +688,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>  	hws[IMX8MP_CLK_CAN1_ROOT] = imx_clk_hw_gate2("can1_root_clk", "can1", ccm_base + 0x4350, 0);
>  	hws[IMX8MP_CLK_CAN2_ROOT] = imx_clk_hw_gate2("can2_root_clk", "can2", ccm_base + 0x4360, 0);
>  	hws[IMX8MP_CLK_SDMA1_ROOT] = imx_clk_hw_gate4("sdma1_root_clk", "ipg_root", ccm_base + 0x43a0, 0);
> -	hws[IMX8MP_CLK_ENET_QOS_ROOT] = imx_clk_hw_gate4("enet_qos_root_clk", "enet_axi", ccm_base + 0x43b0, 0);
> +	hws[IMX8MP_CLK_ENET_QOS_ROOT] = imx_clk_hw_gate4("enet_qos_root_clk", "sim_enet_root_clk", ccm_base + 0x43b0, 0);
>  	hws[IMX8MP_CLK_SIM_ENET_ROOT] = imx_clk_hw_gate4("sim_enet_root_clk", "enet_axi", ccm_base + 0x4400, 0);
>  	hws[IMX8MP_CLK_GPU2D_ROOT] = imx_clk_hw_gate4("gpu2d_root_clk", "gpu2d_div", ccm_base + 0x4450, 0);
>  	hws[IMX8MP_CLK_GPU3D_ROOT] = imx_clk_hw_gate4("gpu3d_root_clk", "gpu3d_core_div", ccm_base + 0x4460, 0);
> -- 
> 2.7.4
> 
