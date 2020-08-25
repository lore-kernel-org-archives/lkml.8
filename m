Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DACC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A8F2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgHYOqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:46:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45054 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgHYOqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:46:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id g6so14086470ljn.11;
        Tue, 25 Aug 2020 07:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzIv0eWRqW17P5KtXr4y5sGRDVtxCepXAZ7i4vqsn6s=;
        b=K/oWaTrjT5h30wgTcCdXSEI73oYfWrwplwBf4oy09U4a68CLk76kY3AMwhEEX1bUeS
         +KStA5V7pv6Q9Dr0IJPGOIbWH+M6QSiK1s0qzBlqXegXTqJIQYoj4kGSVcYdZkQdfg6h
         MBL9yi92S31m6A0zN45tUZjzL59nocCYWt9hYGOLt2rVmp1IjdM+r1AnaczJQ04z75zs
         LvA7nIIT3jCtgLHuuKzKbW3/jV0RJV2N2JPJH8QGSm4SpZJIDzHQEuLxYzhr47nw454Z
         mvZbP2NDFYXyJDs47mZ4M60rO5juhxBoEUOywn8QV+7lnBSnshH0GZemey0Xc+cDIP9d
         iumw==
X-Gm-Message-State: AOAM530rN8hJlaqXTxfLLn/JlgKIvls3H34dT5EqQoa5CUgAMTkBIWbg
        TZhoWcN0aoEXbT9reFxILMsy59eveE07Ng==
X-Google-Smtp-Source: ABdhPJwQFZ3rb/Sms9gUpHOZYc+JvqXDBhDueufT0/XJWT45uiHnJBmZfD7pLiiJAJAVcnjALBALAA==
X-Received: by 2002:a2e:8901:: with SMTP id d1mr796399lji.426.1598366804862;
        Tue, 25 Aug 2020 07:46:44 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id t19sm2872013ljc.137.2020.08.25.07.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 07:46:44 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id g6so14086407ljn.11;
        Tue, 25 Aug 2020 07:46:44 -0700 (PDT)
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr5149410lji.47.1598366804084;
 Tue, 25 Aug 2020 07:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200825131049.1277596-1-jernej.skrabec@siol.net>
In-Reply-To: <20200825131049.1277596-1-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 25 Aug 2020 22:46:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v66q15syd5g-9RUocmEwJyvpbJniTmwLJL4QH5s==fCi2Q@mail.gmail.com>
Message-ID: <CAGb2v66q15syd5g-9RUocmEwJyvpbJniTmwLJL4QH5s==fCi2Q@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] clk: sunxi-ng: sun8i: r40: Use sigma delta
 modulation for audio PLL
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 9:11 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> Audio cores need specific clock rates which can't be simply obtained by
> adjusting integer multipliers and dividers. HW for such cases supports
> delta-sigma modulation which enables fractional multipliers.
>
> Port H3 delta-sigma table to R40. They have identical audio PLLs.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/clk/sunxi-ng/ccu-sun8i-r40.c | 37 ++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
> index 23bfe1d12f21..84153418453f 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
> @@ -45,18 +45,29 @@ static struct ccu_nkmp pll_cpu_clk = {
>   * the base (2x, 4x and 8x), and one variable divider (the one true
>   * pll audio).
>   *
> - * We don't have any need for the variable divider for now, so we just
> - * hardcode it to match with the clock names
> + * With sigma-delta modulation for fractional-N on the audio PLL,
> + * we have to use specific dividers. This means the variable divider
> + * can no longer be used, as the audio codec requests the exact clock
> + * rates we support through this mechanism. So we now hard code the
> + * variable divider to 1. This means the clock rates will no longer
> + * match the clock names.
>   */
>  #define SUN8I_R40_PLL_AUDIO_REG        0x008
>
> -static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
> -                                  "osc24M", 0x008,
> -                                  8, 7,        /* N */
> -                                  0, 5,        /* M */
> -                                  BIT(31),     /* gate */
> -                                  BIT(28),     /* lock */
> -                                  CLK_SET_RATE_UNGATE);
> +static struct ccu_sdm_setting pll_audio_sdm_table[] = {
> +       { .rate = 22579200, .pattern = 0xc0010d84, .m = 8, .n = 7 },
> +       { .rate = 24576000, .pattern = 0xc000ac02, .m = 14, .n = 14 },

The user manual has an additional requirement: 3 <= N/M <= 21.
Though it then says 72 <= 24*N/P <= 504. Not sure which one is
right...

Did you run into any glitches or audio distortions?

ChenYu
