Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21D1C3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E19D20575
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583937777;
	bh=eovpXTvyVWEK9XWNC0b/YZgHbmJESrWMQgqo7YJfDec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0RHW1t1RFYvEL2qsc327qRCqKW6HKJ+ViYCuzAhQO8kXrta6Gs2W0CEr+G0LkfzFA
	 Zj/taJUjRqADmwXYR2d8+HIi590mQac3L134sjJxm+iS4rgW9AjbFzUhnimyv1KQrC
	 DpCwd6LFL9AEBljBhxGAjpw70KdVur8Tqq6ss00s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgCKOm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:42:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43443 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbgCKOm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:42:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id dc19so3133763edb.10;
        Wed, 11 Mar 2020 07:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gKDUe9P2YUubturUxI0TRyVNid6URk2e+Ed9FtxvxKk=;
        b=EMKmZ/MrgEuNGsTb/Ze9rt1U9+lWeztu9hI+HH0of+sRAzH/ExlqFbOIRZFSxC4ADK
         5X/26f6R0Z/iTcCYTGKuGtP2nlbh4uQE27kLyGUwGHCD3jgSs3vXN7JQHlOpGJ8PvKBK
         WfPgkD8gcbIKMi9IN3+NCDIBuDyPVbjA9c0GIzrV/aMUB6I/1ri7oKrc75+WBo6cr0wI
         o5ID2MMultN8P9BStIBS4wxYgcFg9edOD1Rdv1sM6CUM5bZXJ46B7Xjs1ZdBbUyY/orQ
         vAyryO2dUh1BIfRe/cIKRLd1XpjnA0BhOkuZTP3IfrsMvh+uB+boHC0YO6AFo69jRXBx
         VZBg==
X-Gm-Message-State: ANhLgQ2P/ulINIycY42dj86NuoBy33Ie2susWmo+v93rpw6wYCUPbnls
        j3LiPI1ua4HqGDo/+cPH7QA=
X-Google-Smtp-Source: ADFU+vuaPy05McHUkVwSVh+g/+/nj6uRC/r0ZhsuPI7+uwkM3c7CJcwerQSzNIOD7sx8YKwslv43/w==
X-Received: by 2002:aa7:d45a:: with SMTP id q26mr3263099edr.350.1583937774579;
        Wed, 11 Mar 2020 07:42:54 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id p4sm607572eju.57.2020.03.11.07.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Mar 2020 07:42:51 -0700 (PDT)
Date:   Wed, 11 Mar 2020 15:42:48 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCHv3 5/5] clk: samsung: exynos542x: Move FSYS subsystem
 clocks to its sub-CMU
Message-ID: <20200311144248.GA4455@kozik-lap>
References: <20200310194854.831-1-linux.amoon@gmail.com>
 <20200310194854.831-6-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200310194854.831-6-linux.amoon@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 07:48:54PM +0000, Anand Moon wrote:
> FSYS power domain support usbdrd3, pdma and usb2 power gaiting,
> hence move FSYS clk setting to sub-CMU block to support power domain
> on/off sequences for device nodes.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> New patch in the series
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 45 +++++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index c9e5a1fb6653..6c4c47dfcdce 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -859,12 +859,6 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>  	DIV(0, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
>  	DIV(0, "dout_maupcm0", "dout_maudio0", DIV_MAU, 24, 8),
>  
> -	/* USB3.0 */
> -	DIV(0, "dout_usbphy301", "mout_usbd301", DIV_FSYS0, 12, 4),
> -	DIV(0, "dout_usbphy300", "mout_usbd300", DIV_FSYS0, 16, 4),
> -	DIV(0, "dout_usbd301", "mout_usbd301", DIV_FSYS0, 20, 4),
> -	DIV(0, "dout_usbd300", "mout_usbd300", DIV_FSYS0, 24, 4),

According to clock diagram these are still in CMU TOP, not FSYS.

> -
>  	/* MMC */
>  	DIV(0, "dout_mmc0", "mout_mmc0", DIV_FSYS1, 0, 10),
>  	DIV(0, "dout_mmc1", "mout_mmc1", DIV_FSYS1, 10, 10),
> @@ -1031,8 +1025,6 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
/>  
>  	/* FSYS Block */
>  	GATE(CLK_TSI, "tsi", "aclk200_fsys", GATE_BUS_FSYS0, 0, 0, 0),
> -	GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
> -	GATE(CLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
>  	GATE(CLK_UFS, "ufs", "aclk200_fsys2", GATE_BUS_FSYS0, 3, 0, 0),
>  	GATE(CLK_RTIC, "rtic", "aclk200_fsys", GATE_IP_FSYS, 9, 0, 0),
>  	GATE(CLK_MMC0, "mmc0", "aclk200_fsys2", GATE_IP_FSYS, 12, 0, 0),
> @@ -1040,9 +1032,6 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
>  	GATE(CLK_MMC2, "mmc2", "aclk200_fsys2", GATE_IP_FSYS, 14, 0, 0),
>  	GATE(CLK_SROMC, "sromc", "aclk200_fsys2",
>  			GATE_IP_FSYS, 17, CLK_IGNORE_UNUSED, 0),
> -	GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_IP_FSYS, 18, 0, 0),
> -	GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_IP_FSYS, 19, 0, 0),
> -	GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_IP_FSYS, 20, 0, 0),
>  	GATE(CLK_SCLK_UNIPRO, "sclk_unipro", "dout_unipro",
>  			SRC_MASK_FSYS, 24, CLK_SET_RATE_PARENT, 0),
>  
> @@ -1258,6 +1247,28 @@ static struct exynos5_subcmu_reg_dump exynos5x_gsc_suspend_regs[] = {
>  	{ DIV2_RATIO0, 0, 0x30 },	/* DIV dout_gscl_blk_300 */
>  };
>  
> +/* USB3.0 */
> +static const struct samsung_div_clock exynos5x_fsys_div_clks[] __initconst = {
> +	DIV(0, "dout_usbphy301", "mout_usbd301", DIV_FSYS0, 12, 4),
> +	DIV(0, "dout_usbphy300", "mout_usbd300", DIV_FSYS0, 16, 4),
> +	DIV(0, "dout_usbd301", "mout_usbd301", DIV_FSYS0, 20, 4),
> +	DIV(0, "dout_usbd300", "mout_usbd300", DIV_FSYS0, 24, 4),
> +};
> +
> +static const struct samsung_gate_clock exynos5x_fsys_gate_clks[] __initconst = {
> +	GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
> +	GATE(CLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
> +	GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_IP_FSYS, 18, 0, 0),
> +	GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_IP_FSYS, 19, 0, 0),
> +	GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_IP_FSYS, 20, 0, 0),
> +};
> +
> +static struct exynos5_subcmu_reg_dump exynos5x_fsys_suspend_regs[] = {
> +	{ GATE_IP_FSYS, 0xffffffff, 0xffffffff }, /* FSYS gates */

This looks wrong. GATE_IP_FSYS has fields also for FSYS2 clocks which
you are not suspending. They do not belong to this CMU.

Don't you need to save also parts of GATE_BUS_FSYS0?

> +	{ SRC_TOP3, 0, BIT(24) },                 /* SW_MUX_PCLK_200_FSYS_SEL */
> +	{ SRC_TOP3, 0, BIT(28) },                 /* SW_MUX_ACLK_200_FSYS_SEL */

Name of clocks from the driver please, not from datasheet. Look at other
examples.

Best regards,
Krzysztof


> +};
> +
>  static const struct samsung_gate_clock exynos5x_g3d_gate_clks[] __initconst = {
>  	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9,
>  	     CLK_SET_RATE_PARENT, 0),
> @@ -1376,12 +1387,23 @@ static const struct exynos5_subcmu_info exynos5800_mau_subcmu = {
>  	.pd_name	= "MAU",
>  };
>  
> +static const struct exynos5_subcmu_info exynos5x_fsys_subcmu = {
> +	.div_clks       = exynos5x_fsys_div_clks,
> +	.nr_div_clks    = ARRAY_SIZE(exynos5x_fsys_div_clks),
> +	.gate_clks	= exynos5x_fsys_gate_clks,
> +	.nr_gate_clks	= ARRAY_SIZE(exynos5x_fsys_gate_clks),
> +	.suspend_regs	= exynos5x_fsys_suspend_regs,
> +	.nr_suspend_regs = ARRAY_SIZE(exynos5x_fsys_suspend_regs),
> +	.pd_name	= "FSYS",
> +};
> +
>  static const struct exynos5_subcmu_info *exynos5x_subcmus[] = {
>  	&exynos5x_disp_subcmu,
>  	&exynos5x_gsc_subcmu,
>  	&exynos5x_g3d_subcmu,
>  	&exynos5x_mfc_subcmu,
>  	&exynos5x_mscl_subcmu,
> +	&exynos5x_fsys_subcmu,
>  };
>  
>  static const struct exynos5_subcmu_info *exynos5800_subcmus[] = {
> @@ -1391,6 +1413,7 @@ static const struct exynos5_subcmu_info *exynos5800_subcmus[] = {
>  	&exynos5x_mfc_subcmu,
>  	&exynos5x_mscl_subcmu,
>  	&exynos5800_mau_subcmu,
> +	&exynos5x_fsys_subcmu,
>  };
>  
>  static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __initconst = {
> -- 
> 2.25.1
> 
