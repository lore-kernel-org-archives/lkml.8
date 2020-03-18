Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3023FC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066F62076F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgCRLOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:14:02 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41134 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727764AbgCRLOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:14:02 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E43852003C6;
        Wed, 18 Mar 2020 12:14:00 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D4F96201205;
        Wed, 18 Mar 2020 12:14:00 +0100 (CET)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id BA35820506;
        Wed, 18 Mar 2020 12:14:00 +0100 (CET)
Date:   Wed, 18 Mar 2020 13:14:00 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        allison@lohutok.net, gustavo@embeddedor.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] clk: imx: clk-pllv3: Use readl_poll_timeout() for PLL
 lock wait
Message-ID: <20200318111400.ynpazqpzmeyhuyy3@fsr-ub1664-175>
References: <1584502004-11349-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584502004-11349-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-18 11:26:44, Anson Huang wrote:
> Use readl_poll_timeout() for PLL lock wait which can simplify the
> code a lot.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/clk/imx/clk-pllv3.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> index df91a82..3dfa9c3 100644
> --- a/drivers/clk/imx/clk-pllv3.c
> +++ b/drivers/clk/imx/clk-pllv3.c
> @@ -7,6 +7,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/slab.h>
>  #include <linux/jiffies.h>
>  #include <linux/err.h>
> @@ -25,6 +26,8 @@
>  #define IMX7_ENET_PLL_POWER	(0x1 << 5)
>  #define IMX7_DDR_PLL_POWER	(0x1 << 20)
>  
> +#define PLL_LOCK_TIMEOUT	10000
> +
>  /**
>   * struct clk_pllv3 - IMX PLL clock version 3
>   * @clk_hw:	 clock source
> @@ -53,23 +56,14 @@ struct clk_pllv3 {
>  
>  static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
>  {
> -	unsigned long timeout = jiffies + msecs_to_jiffies(10);
>  	u32 val = readl_relaxed(pll->base) & pll->power_bit;
>  
>  	/* No need to wait for lock when pll is not powered up */
>  	if ((pll->powerup_set && !val) || (!pll->powerup_set && val))
>  		return 0;
>  
> -	/* Wait for PLL to lock */
> -	do {
> -		if (readl_relaxed(pll->base) & BM_PLL_LOCK)
> -			break;
> -		if (time_after(jiffies, timeout))
> -			break;
> -		usleep_range(50, 500);
> -	} while (1);
> -
> -	return readl_relaxed(pll->base) & BM_PLL_LOCK ? 0 : -ETIMEDOUT;
> +	return readl_poll_timeout(pll->base, val, val & BM_PLL_LOCK, 500,
> +				  PLL_LOCK_TIMEOUT);
>  }
>  
>  static int clk_pllv3_prepare(struct clk_hw *hw)
> -- 
> 2.7.4
> 
