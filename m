Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AA7C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 07:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB212078D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 07:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599291766;
	bh=aE/NOhFxqVdLILAny7qv4J/hsZCDiNF+XqbkJ74DkqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bZ7mJn95P0LWSrCUIvaOOxwD/IhC6ADoH5h907aIoBr8afXlB6A0yo09NqkUBCVXn
	 gZ4ycP0pqSqU14QbsDUdbatcVpXaTQn+oKYvV3Wgag+ADuYGITvFH9eyKQyizhB5Mc
	 2NFCvzVMPTLukklcels2FkSWTAmIXLHpMZt465ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgIEHmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 03:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgIEHmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 03:42:43 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77FF320760;
        Sat,  5 Sep 2020 07:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599291762;
        bh=aE/NOhFxqVdLILAny7qv4J/hsZCDiNF+XqbkJ74DkqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N5RUvhkv9uIDJKzjJHyVIrUFQfyy9pvwE0Hvo2X+O1UQDAq4m3pclG1NkX7vRhTzc
         J/N9AiFISYBtNAyH6jfmuNmBhwF1h8seTDraz2YW0Wg+v6zS6glPjrOBl6MjUXzm6p
         D0rsGJIKd6Z/4e72/Ctap8AFaiWdIY94WWiGDoC4=
Date:   Sat, 5 Sep 2020 15:42:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/3] clk: imx: Declare clock init functions in header
 acessible from mach
Message-ID: <20200905074235.GL9261@dragon>
References: <20200902150244.14347-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902150244.14347-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 05:02:42PM +0200, Krzysztof Kozlowski wrote:
> Multiple files from arch/arm/mach-imx/ use clock init functions which
> are defined in the IMX clock drivers.  Declare them in globally
> accessible header to fix GCC warnings:
> 
>   drivers/clk/imx/clk-imx21.c:122:74: warning: no previous prototype for 'mx21_clocks_init' [-Wmissing-prototypes]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Fabio is working on converting these platforms to DT only, so we will be
able to use CLK_OF_DECLARE() for calling these clock init functions
soon.

Shawn

> ---
>  drivers/clk/imx/clk-imx21.c |  1 +
>  drivers/clk/imx/clk-imx27.c |  1 +
>  drivers/clk/imx/clk-imx31.c |  1 +
>  drivers/clk/imx/clk-imx35.c |  1 +
>  include/linux/clk/imx.h     | 11 +++++++++++
>  5 files changed, 15 insertions(+)
>  create mode 100644 include/linux/clk/imx.h
> 
> diff --git a/drivers/clk/imx/clk-imx21.c b/drivers/clk/imx/clk-imx21.c
> index 077b4a7123ce..2105ef57b6bc 100644
> --- a/drivers/clk/imx/clk-imx21.c
> +++ b/drivers/clk/imx/clk-imx21.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/clk-provider.h>
>  #include <linux/clkdev.h>
> +#include <linux/clk/imx.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> diff --git a/drivers/clk/imx/clk-imx27.c b/drivers/clk/imx/clk-imx27.c
> index a3753067fc12..c0d8bcdf0719 100644
> --- a/drivers/clk/imx/clk-imx27.c
> +++ b/drivers/clk/imx/clk-imx27.c
> @@ -2,6 +2,7 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/clkdev.h>
> +#include <linux/clk/imx.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
> index 4bb05e440cdd..25be4c292e44 100644
> --- a/drivers/clk/imx/clk-imx31.c
> +++ b/drivers/clk/imx/clk-imx31.c
> @@ -6,6 +6,7 @@
>  #include <linux/module.h>
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
> +#include <linux/clk/imx.h>
>  #include <linux/io.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
> index e595f559907f..baf8d236d6ef 100644
> --- a/drivers/clk/imx/clk-imx35.c
> +++ b/drivers/clk/imx/clk-imx35.c
> @@ -5,6 +5,7 @@
>  #include <linux/mm.h>
>  #include <linux/delay.h>
>  #include <linux/clk.h>
> +#include <linux/clk/imx.h>
>  #include <linux/io.h>
>  #include <linux/clkdev.h>
>  #include <linux/of.h>
> diff --git a/include/linux/clk/imx.h b/include/linux/clk/imx.h
> new file mode 100644
> index 000000000000..f6394d1b0a94
> --- /dev/null
> +++ b/include/linux/clk/imx.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __LINUX_CLK_IMX_H
> +#define __LINUX_CLK_IMX_H
> +
> +int mx21_clocks_init(unsigned long lref, unsigned long href);
> +int mx27_clocks_init(unsigned long fref);
> +int mx31_clocks_init(unsigned long fref);
> +int mx35_clocks_init(void);
> +
> +#endif /* __LINUX_CLK_IMX_H */
> -- 
> 2.17.1
> 
