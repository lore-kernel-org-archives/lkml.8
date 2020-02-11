Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C844C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8116320708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBKGkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 01:40:37 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39889 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgBKGkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 01:40:36 -0500
Received: by mail-ed1-f67.google.com with SMTP id m13so3382561edb.6;
        Mon, 10 Feb 2020 22:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fv/t2lPvzd/c6evGoFWSGvw45Jr9b11uQzUTPkD838A=;
        b=RRzzjkO/C29FTF/Q8WPbI00QO1rZPXzgTYiE3/7oandYtsneBihu48cBXSEB7A3uHU
         wiXvKbaJEHGXmfJGdy4EkgNVBnh9TpSPu5vxvMfU1DglWUVQEbEKpm9qvmZCgRLDo6lm
         FnL382n0MyR5T+9xW1v1+rc6c+n41xkbccXjeiEvahDCGywB4FR1I3dnch3iS3brHtgJ
         DV+sy9xEYngthwxQfUyZwyS28GGAI8c5cC1hsgJTqJInWWBcJIepIcVUUsYfI/oKiHzH
         y5XfN4JBIiJ4F9r0VVmIELDEpPcZi4oA0f+/NshpVIWKR4sA5/PV1Q6d3JZ5x0p7unQA
         ++ng==
X-Gm-Message-State: APjAAAUOZBUryZiu4BZq1mPZ1pW79osqzOYdIzF5RcxvwjV0VZqwPtmR
        aC+46glxiIr6/HynCi1FBpRL161ANgM=
X-Google-Smtp-Source: APXvYqxUVcgiaYVbXFggyoLcst+lBYXmgHMnitvc+9lgq9orN9mfbjSqtKR5YLfal/Tr2woClqcG6w==
X-Received: by 2002:a17:906:7f02:: with SMTP id d2mr4460011ejr.261.1581403233883;
        Mon, 10 Feb 2020 22:40:33 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id n10sm265402ejc.58.2020.02.10.22.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 22:40:33 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id t3so10773046wru.7;
        Mon, 10 Feb 2020 22:40:33 -0800 (PST)
X-Received: by 2002:a5d:6805:: with SMTP id w5mr6896277wru.64.1581403233013;
 Mon, 10 Feb 2020 22:40:33 -0800 (PST)
MIME-Version: 1.0
References: <20200210222807.206426-1-jernej.skrabec@siol.net> <20200210222807.206426-2-jernej.skrabec@siol.net>
In-Reply-To: <20200210222807.206426-2-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 11 Feb 2020 14:40:22 +0800
X-Gmail-Original-Message-ID: <CAGb2v659Znu1E74Ph8w4Un_cC8qovWmmLfOEDW0ax4jrLVs7GQ@mail.gmail.com>
Message-ID: <CAGb2v659Znu1E74Ph8w4Un_cC8qovWmmLfOEDW0ax4jrLVs7GQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] clk: sunxi-ng: sun8i-de2: Sort structures
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 6:28 AM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> Current structures are not sorted by family first and then
> alphabetically. Let's do that now.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

I would do this at the end of the patch series for a couple of reasons.
First of all, moving code around before the fixes make the fixes less
likely to directly apply to stable kernels, and second, the H6 clks
and resets lists disappear after all the changes.

ChenYu

> ---
>  drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 56 ++++++++++++++--------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> index d9668493c3f9..a928e0c32222 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> @@ -51,24 +51,6 @@ static SUNXI_CCU_M(mixer1_div_a83_clk, "mixer1-div", "pll-de", 0x0c, 4, 4,
>  static SUNXI_CCU_M(wb_div_a83_clk, "wb-div", "pll-de", 0x0c, 8, 4,
>                    CLK_SET_RATE_PARENT);
>
> -static struct ccu_common *sun50i_h6_de3_clks[] = {
> -       &mixer0_clk.common,
> -       &mixer1_clk.common,
> -       &wb_clk.common,
> -
> -       &bus_mixer0_clk.common,
> -       &bus_mixer1_clk.common,
> -       &bus_wb_clk.common,
> -
> -       &mixer0_div_clk.common,
> -       &mixer1_div_clk.common,
> -       &wb_div_clk.common,
> -
> -       &bus_rot_clk.common,
> -       &rot_clk.common,
> -       &rot_div_clk.common,
> -};
> -
>  static struct ccu_common *sun8i_a83t_de2_clks[] = {
>         &mixer0_clk.common,
>         &mixer1_clk.common,
> @@ -108,6 +90,24 @@ static struct ccu_common *sun8i_v3s_de2_clks[] = {
>         &wb_div_clk.common,
>  };
>
> +static struct ccu_common *sun50i_h6_de3_clks[] = {
> +       &mixer0_clk.common,
> +       &mixer1_clk.common,
> +       &wb_clk.common,
> +
> +       &bus_mixer0_clk.common,
> +       &bus_mixer1_clk.common,
> +       &bus_wb_clk.common,
> +
> +       &mixer0_div_clk.common,
> +       &mixer1_div_clk.common,
> +       &wb_div_clk.common,
> +
> +       &bus_rot_clk.common,
> +       &rot_clk.common,
> +       &rot_div_clk.common,
> +};
> +
>  static struct clk_hw_onecell_data sun8i_a83t_de2_hw_clks = {
>         .hws    = {
>                 [CLK_MIXER0]            = &mixer0_clk.common.hw,
> @@ -219,6 +219,16 @@ static const struct sunxi_ccu_desc sun8i_h3_de2_clk_desc = {
>         .num_resets     = ARRAY_SIZE(sun8i_a83t_de2_resets),
>  };
>
> +static const struct sunxi_ccu_desc sun8i_v3s_de2_clk_desc = {
> +       .ccu_clks       = sun8i_v3s_de2_clks,
> +       .num_ccu_clks   = ARRAY_SIZE(sun8i_v3s_de2_clks),
> +
> +       .hw_clks        = &sun8i_v3s_de2_hw_clks,
> +
> +       .resets         = sun8i_a83t_de2_resets,
> +       .num_resets     = ARRAY_SIZE(sun8i_a83t_de2_resets),
> +};
> +
>  static const struct sunxi_ccu_desc sun50i_a64_de2_clk_desc = {
>         .ccu_clks       = sun8i_h3_de2_clks,
>         .num_ccu_clks   = ARRAY_SIZE(sun8i_h3_de2_clks),
> @@ -239,16 +249,6 @@ static const struct sunxi_ccu_desc sun50i_h6_de3_clk_desc = {
>         .num_resets     = ARRAY_SIZE(sun50i_h6_de3_resets),
>  };
>
> -static const struct sunxi_ccu_desc sun8i_v3s_de2_clk_desc = {
> -       .ccu_clks       = sun8i_v3s_de2_clks,
> -       .num_ccu_clks   = ARRAY_SIZE(sun8i_v3s_de2_clks),
> -
> -       .hw_clks        = &sun8i_v3s_de2_hw_clks,
> -
> -       .resets         = sun8i_a83t_de2_resets,
> -       .num_resets     = ARRAY_SIZE(sun8i_a83t_de2_resets),
> -};
> -
>  static int sunxi_de2_clk_probe(struct platform_device *pdev)
>  {
>         struct resource *res;
> --
> 2.25.0
>
