Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEABCC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A9E20FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1iBMUU3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgG2Ptd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Ptd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:49:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE392C061794;
        Wed, 29 Jul 2020 08:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=+nJHAC0hRre2fPtZmeqPR+IfHQYOVOmegMZZdTbLWdo=; b=1iBMUU3gWhqIVFifZ+fx5AMf6i
        J1GkLR1STxoS69tlldAnrIwCE8m30IRgKT5bsamv/A4mU/mP7tZMX+n47pv6L+I1O1ciNtl2KeUry
        tRREARBZ1AaY5aLJUvgFmmnaLTlgb98X5FPD/NbjwboVABr0gLQLKjmKPK+Dzc6pgIF1o3Ak6AP3r
        S6S3uLT8GeplNRnmKKVAJOB/BZaOHVHhgrg6Zw/S9YQZCyiwQmLgw9c3gxx5ftcq8vwDAb80ng86X
        R0X6/CFQLkaidGyx/vbcHvCFjxVP14iyKVAKblah+hYYMPBXXPScPcId3HLIKmb/R97wg2M8SWzRR
        cZlBSWMQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0oKe-0003hl-GR; Wed, 29 Jul 2020 15:49:28 +0000
Subject: Re: [PATCH V7 1/6] clk: imx6sl: Use BIT(x) to avoid shifting signed
 32-bit value by 31 bits
To:     Anson Huang <Anson.Huang@nxp.com>, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        arnd@arndb.de, peng.fan@nxp.com, abel.vesa@nxp.com,
        fugang.duan@nxp.com, daniel.baluta@nxp.com, yuehaibing@huawei.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
References: <1596034117-24246-1-git-send-email-Anson.Huang@nxp.com>
 <1596034117-24246-2-git-send-email-Anson.Huang@nxp.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <86ae1d4e-27c9-07e4-73be-37d490cb0063@infradead.org>
Date:   Wed, 29 Jul 2020 08:49:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596034117-24246-2-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/20 7:48 AM, Anson Huang wrote:
> Use readl_relaxed() instead of __raw_readl(), and use BIT(x)
> instead of (1 << X) to fix below build warning reported by kernel
> test robot:
> 
> drivers/clk/imx/clk-imx6sl.c:149:49: warning: Shifting signed 32-bit
> value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
>      while (!(__raw_readl(anatop_base + PLL_ARM) & BM_PLL_ARM_LOCK))
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> Changes since V6:
> 	- improve the subject.
> ---
>  drivers/clk/imx/clk-imx6sl.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
> index 0f647d1..e69dba1 100644
> --- a/drivers/clk/imx/clk-imx6sl.c
> +++ b/drivers/clk/imx/clk-imx6sl.c
> @@ -3,6 +3,7 @@
>   * Copyright 2013-2014 Freescale Semiconductor, Inc.
>   */
>  
> +#include <linux/bitfield.h>

Hi,
I think you want
#include <linux/bits.h>

for BIT() usage.

>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
>  #include <linux/err.h>
> @@ -14,19 +15,19 @@
>  #include "clk.h"
>  
>  #define CCSR			0xc
> -#define BM_CCSR_PLL1_SW_CLK_SEL	(1 << 2)
> +#define BM_CCSR_PLL1_SW_CLK_SEL	BIT(2)
>  #define CACRR			0x10
>  #define CDHIPR			0x48
> -#define BM_CDHIPR_ARM_PODF_BUSY	(1 << 16)
> +#define BM_CDHIPR_ARM_PODF_BUSY	BIT(16)
>  #define ARM_WAIT_DIV_396M	2
>  #define ARM_WAIT_DIV_792M	4
>  #define ARM_WAIT_DIV_996M	6
>  
>  #define PLL_ARM			0x0
> -#define BM_PLL_ARM_DIV_SELECT	(0x7f << 0)
> -#define BM_PLL_ARM_POWERDOWN	(1 << 12)
> -#define BM_PLL_ARM_ENABLE	(1 << 13)
> -#define BM_PLL_ARM_LOCK		(1 << 31)
> +#define BM_PLL_ARM_DIV_SELECT	0x7f
> +#define BM_PLL_ARM_POWERDOWN	BIT(12)
> +#define BM_PLL_ARM_ENABLE	BIT(13)
> +#define BM_PLL_ARM_LOCK		BIT(31)
>  #define PLL_ARM_DIV_792M	66
>  
>  static const char *step_sels[]		= { "osc", "pll2_pfd2", };


thanks.
-- 
~Randy

