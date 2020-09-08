Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFA6C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5294920C09
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgIHKTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:19:17 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47652 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729285AbgIHKTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:19:01 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8C889201599;
        Tue,  8 Sep 2020 12:18:59 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 41D7620158D;
        Tue,  8 Sep 2020 12:18:59 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 78C302036D;
        Tue,  8 Sep 2020 12:18:58 +0200 (CEST)
Date:   Tue, 8 Sep 2020 13:18:58 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     peng.fan@nxp.com
Cc:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com
Subject: Re: [PATCH] clk: imx: lpcg-scu: SW workaround for errata (e10858)
Message-ID: <20200908101858.kiuzcnc6rolbbyma@fsr-ub1664-175>
References: <1599556487-31364-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599556487-31364-1-git-send-email-peng.fan@nxp.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-08 17:14:47, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Back-to-back LPCG writes can be ignored by the LPCG register due to
> a HW bug. The writes need to be separated by at least 4 cycles of
> the gated clock.
> 
> The workaround is implemented as follows:
> 1. For clocks running greater than or equal to 24MHz, a read
> followed by the write will provide sufficient delay.
> 2. For clocks running below 24MHz, add a delay of 4 clock cylces
> after the write to the LPCG register.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-lpcg-scu.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
> index 1f0e44f921ae..6ee9d2caedf2 100644
> --- a/drivers/clk/imx/clk-lpcg-scu.c
> +++ b/drivers/clk/imx/clk-lpcg-scu.c
> @@ -6,6 +6,7 @@
>  
>  #include <linux/bits.h>
>  #include <linux/clk-provider.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> @@ -38,6 +39,31 @@ struct clk_lpcg_scu {
>  
>  #define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu, hw)
>  
> +/* e10858 -LPCG clock gating register synchronization errata */
> +static void do_lpcg_workaround(u32 rate, void __iomem *reg, u32 val)
> +{
> +	writel(val, reg);
> +
> +	if (rate >= 24000000 || rate == 0) {
> +		u32 reg1;
> +
> +		/*
> +		 * The time taken to access the LPCG registers from the AP core
> +		 * through the interconnect is longer than the minimum delay
> +		 * of 4 clock cycles required by the errata.
> +		 * Adding a readl will provide sufficient delay to prevent
> +		 * back-to-back writes.
> +		 */
> +		reg1 = readl(reg);
> +	} else {
> +		/*
> +		 * For clocks running below 24MHz, wait a minimum of
> +		 * 4 clock cycles.
> +		 */
> +		ndelay(4 * (DIV_ROUND_UP(1000000000, rate)));
> +	}

Just to make sure this is totally understood, if the lpcg consumer
needs to two enables/disables in less than 4 multiplied by the clock
period, the second enable/disable will be delayed.

If we're fine with this, then here is my R-b.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> +}
> +
>  static int clk_lpcg_scu_enable(struct clk_hw *hw)
>  {
>  	struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
> @@ -54,7 +80,8 @@ static int clk_lpcg_scu_enable(struct clk_hw *hw)
>  		val |= CLK_GATE_SCU_LPCG_HW_SEL;
>  
>  	reg |= val << clk->bit_idx;
> -	writel(reg, clk->reg);
> +
> +	do_lpcg_workaround(clk_hw_get_rate(hw), clk->reg, reg);
>  
>  	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
>  
> @@ -71,7 +98,7 @@ static void clk_lpcg_scu_disable(struct clk_hw *hw)
>  
>  	reg = readl_relaxed(clk->reg);
>  	reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
> -	writel(reg, clk->reg);
> +	do_lpcg_workaround(clk_hw_get_rate(hw), clk->reg, reg);
>  
>  	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
>  }
> -- 
> 2.28.0
> 
