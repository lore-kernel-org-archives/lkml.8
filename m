Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A89AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A2620823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iw7Yvp/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgESNMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgESNMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:12:35 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112CFC08C5C1;
        Tue, 19 May 2020 06:12:35 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v16so9609576ljc.8;
        Tue, 19 May 2020 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNjx9E4L84Rs/lSF6ocaxMnVGmTTxZ1+/o5Yt5fcl2U=;
        b=iw7Yvp/F9oKwqOokLlksaqSUJwWnsp/Ah/TQH1FKVmevQ3PojWBhwAzebDCQ99gqpS
         NHtS/aR3g9/4lw+lWDLDvlyI1uMgFDxQYRl6CMawSckWg108nmR8D4Eb2blS0YX/B+in
         aHMEjFv4KcCFc2D8btP/yZtl9ZMNnnrv9kSr+uU8fPDmVx6K+1SvnzjhLu3oBZc+ETUZ
         /Yc1Br/QThTpBUdvBZ+RLdsFhq53u4Mzmsh39WtTPpT8OyR3wT+k4m4wxuRE75VArQbu
         hBpc6p2G+zeC4tGJVI4wJA1Rc7cAaVqb0GifHWXbbkgPsmhTwOHGEOxLgxFgVLMH+8W5
         LYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNjx9E4L84Rs/lSF6ocaxMnVGmTTxZ1+/o5Yt5fcl2U=;
        b=tEmQw6VB9K2gLfi9nnlWpIbXyTWnmyiykiLeGkWLdvkN3Urn3OrH0VOVuDyMnhsyQs
         cPHFtpNHTEmL7efSCbqJhHTBse9znvwax6n4YpiZWvqtPRAAMOyG+l/XWd5F7mYs+jcw
         E4valmKbPT58EPjS3YHfEm0/iEM2qCaeBWE8rbME8ZUdr+9WNhut9Wj1+6LxXJv7BuUN
         be61aqJ0D3PPXSlflKKEPxjsOpAT4pNH/mNwDW2IQwH7G52Cw89J/HC7o0XwO4mb21j4
         g1yETpyXI4VEqgaxB8JDKIrId3e5rAv9UIBpSCMpmxfmELe8vzznJ/8G5XySPCxmVYew
         +0BA==
X-Gm-Message-State: AOAM53362HTImTEmQY3Uc+mrkAdlZ/slDAb0cqEgJvuALO5HqGt8dj2J
        G382ZmHE8rIiQTkqL9BWfD48lcQ0h7DKlam38xw=
X-Google-Smtp-Source: ABdhPJzl/UhbhNWg6Hj8ZwS9CHEcguHzAL89jkjLrh/kvMftgW36E0vCQy2q+ffcr27qloL2tP6HYIm2JUyI0VU7TxE=
X-Received: by 2002:a2e:878b:: with SMTP id n11mr13623551lji.196.1589893953567;
 Tue, 19 May 2020 06:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200519030036.1785-1-zhang.lyra@gmail.com>
In-Reply-To: <20200519030036.1785-1-zhang.lyra@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 19 May 2020 21:12:22 +0800
Message-ID: <CADBw62oewy=9GK3jet4Y2=JmHqBMmDQ7XMADD8uOiiwxHOEGbg@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: sprd: mark the local clock symbols static
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:00 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> There's a few pll gate clocks which were not marked with static, and
> those clock are used only in the current file, so add static key word
> for them.
>
> Fixes: 0e4b8a2349f3 ("clk: sprd: add clocks support for SC9863A")
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/clk/sprd/sc9863a-clk.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/clk/sprd/sc9863a-clk.c b/drivers/clk/sprd/sc9863a-clk.c
> index 9568ec956ee4..ad2e0f9f8563 100644
> --- a/drivers/clk/sprd/sc9863a-clk.c
> +++ b/drivers/clk/sprd/sc9863a-clk.c
> @@ -23,22 +23,22 @@
>  #include "pll.h"
>
>  /* mpll*_gate clocks control cpu cores, they were enabled by default */
> -SPRD_PLL_SC_GATE_CLK_FW_NAME(mpll0_gate, "mpll0-gate", "ext-26m", 0x94,
> -                            0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240);
> -SPRD_PLL_SC_GATE_CLK_FW_NAME(dpll0_gate, "dpll0-gate", "ext-26m", 0x98,
> -                            0x1000, BIT(0), 0, 0, 240);
> -SPRD_PLL_SC_GATE_CLK_FW_NAME(lpll_gate, "lpll-gate", "ext-26m", 0x9c,
> -                            0x1000, BIT(0), 0, 0, 240);
> -SPRD_PLL_SC_GATE_CLK_FW_NAME(gpll_gate, "gpll-gate", "ext-26m", 0xa8,
> -                            0x1000, BIT(0), 0, 0, 240);
> -SPRD_PLL_SC_GATE_CLK_FW_NAME(dpll1_gate, "dpll1-gate", "ext-26m", 0x1dc,
> -                            0x1000, BIT(0), 0, 0, 240);
> -SPRD_PLL_SC_GATE_CLK_FW_NAME(mpll1_gate, "mpll1-gate", "ext-26m", 0x1e0,
> -                            0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240);
> -SPRD_PLL_SC_GATE_CLK_FW_NAME(mpll2_gate, "mpll2-gate", "ext-26m", 0x1e4,
> -                            0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240);
> -SPRD_PLL_SC_GATE_CLK_FW_NAME(isppll_gate, "isppll-gate", "ext-26m", 0x1e8,
> -                            0x1000, BIT(0), 0, 0, 240);
> +static SPRD_PLL_SC_GATE_CLK_FW_NAME(mpll0_gate, "mpll0-gate", "ext-26m", 0x94,
> +                                   0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240);
> +static SPRD_PLL_SC_GATE_CLK_FW_NAME(dpll0_gate, "dpll0-gate", "ext-26m", 0x98,
> +                                   0x1000, BIT(0), 0, 0, 240);
> +static SPRD_PLL_SC_GATE_CLK_FW_NAME(lpll_gate, "lpll-gate", "ext-26m", 0x9c,
> +                                   0x1000, BIT(0), 0, 0, 240);
> +static SPRD_PLL_SC_GATE_CLK_FW_NAME(gpll_gate, "gpll-gate", "ext-26m", 0xa8,
> +                                   0x1000, BIT(0), 0, 0, 240);
> +static SPRD_PLL_SC_GATE_CLK_FW_NAME(dpll1_gate, "dpll1-gate", "ext-26m", 0x1dc,
> +                                   0x1000, BIT(0), 0, 0, 240);
> +static SPRD_PLL_SC_GATE_CLK_FW_NAME(mpll1_gate, "mpll1-gate", "ext-26m", 0x1e0,
> +                                   0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240);
> +static SPRD_PLL_SC_GATE_CLK_FW_NAME(mpll2_gate, "mpll2-gate", "ext-26m", 0x1e4,
> +                                   0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240);
> +static SPRD_PLL_SC_GATE_CLK_FW_NAME(isppll_gate, "isppll-gate", "ext-26m",
> +                                   0x1e8, 0x1000, BIT(0), 0, 0, 240);
>
>  static struct sprd_clk_common *sc9863a_pmu_gate_clks[] = {
>         /* address base is 0x402b0000 */
> --
> 2.20.1
>


-- 
Baolin Wang
