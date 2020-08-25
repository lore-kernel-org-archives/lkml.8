Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825D7C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6932C20782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgHYQsF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:48:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43891 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHYQsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:48:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id v12so14593074ljc.10;
        Tue, 25 Aug 2020 09:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nTSrXzEAroJk48irekSp56G+4B2v4pPedg0lBTRq2cw=;
        b=S/SsSFAJHnMWHbArNn2dUJvcIoCl8RcC0osg1x07Qww1mxJYk3Y5VRTbTJyejV58s+
         1rnXaxyaD58yu0vNA/fNJdMF0ld+EpqrdMPurbB8pRUjJ/c02Ro80NBv88f4+ZIXSrHl
         uLWRY5mVLbSEuuHOcG770ey2LSDEf95uCUYAtwpdJwnMJF3OIbE7WekpdYmWJw4H/fic
         v7RlOMZyJOgl9EntAiWQaj79JcFx14Wk5YvK4R/tLXDGN9prMVdtDL7VpMEn8BvGXH0F
         vSyVokIzb+DFA3eozT2RvuOWLUdJ8EdolIMHkFkbYwZ5NjFKr6XzpyJ5qeo72vsK7cGj
         s5+Q==
X-Gm-Message-State: AOAM531PqP/PKkJLfUFM+sOw54SsCg5BKUGY1oC76QJZcSCJ/6SNJ4cf
        D1k/DuyTC0wyRdxWnewlUelc4JMDInpErQ==
X-Google-Smtp-Source: ABdhPJy2lLA/znQ/K+nshMqLdx/QxXOO8kZjwQ6kKS1O78uxwfG1QzxA9xoDFZ7aSIafPsJc36N+Lw==
X-Received: by 2002:a2e:b04e:: with SMTP id d14mr5680053ljl.16.1598374081757;
        Tue, 25 Aug 2020 09:48:01 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id d15sm2947454ljl.32.2020.08.25.09.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 09:48:01 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id i14so4731348lfl.12;
        Tue, 25 Aug 2020 09:48:01 -0700 (PDT)
X-Received: by 2002:a19:5046:: with SMTP id z6mr4935334lfj.4.1598374080957;
 Tue, 25 Aug 2020 09:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200825131049.1277596-1-jernej.skrabec@siol.net>
 <CAGb2v66q15syd5g-9RUocmEwJyvpbJniTmwLJL4QH5s==fCi2Q@mail.gmail.com> <21600331.3yVNq0iq4W@jernej-laptop>
In-Reply-To: <21600331.3yVNq0iq4W@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 26 Aug 2020 00:47:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v67Lm43mg-QrHJAV7svLnVJS0We6tiTLbCwi_d48ARRFVg@mail.gmail.com>
Message-ID: <CAGb2v67Lm43mg-QrHJAV7svLnVJS0We6tiTLbCwi_d48ARRFVg@mail.gmail.com>
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
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 12:45 AM Jernej Škrabec <jernej.skrabec@siol.net> wrote:
>
> Dne torek, 25. avgust 2020 ob 16:46:31 CEST je Chen-Yu Tsai napisal(a):
> > On Tue, Aug 25, 2020 at 9:11 PM Jernej Skrabec <jernej.skrabec@siol.net>
> wrote:
> > > Audio cores need specific clock rates which can't be simply obtained by
> > > adjusting integer multipliers and dividers. HW for such cases supports
> > > delta-sigma modulation which enables fractional multipliers.
> > >
> > > Port H3 delta-sigma table to R40. They have identical audio PLLs.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > >
> > >  drivers/clk/sunxi-ng/ccu-sun8i-r40.c | 37 ++++++++++++++++++----------
> > >  1 file changed, 24 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
> > > b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c index 23bfe1d12f21..84153418453f
> > > 100644
> > > --- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
> > > +++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
> > > @@ -45,18 +45,29 @@ static struct ccu_nkmp pll_cpu_clk = {
> > >
> > >   * the base (2x, 4x and 8x), and one variable divider (the one true
> > >   * pll audio).
> > >   *
> > >
> > > - * We don't have any need for the variable divider for now, so we just
> > > - * hardcode it to match with the clock names
> > > + * With sigma-delta modulation for fractional-N on the audio PLL,
> > > + * we have to use specific dividers. This means the variable divider
> > > + * can no longer be used, as the audio codec requests the exact clock
> > > + * rates we support through this mechanism. So we now hard code the
> > > + * variable divider to 1. This means the clock rates will no longer
> > > + * match the clock names.
> > >
> > >   */
> > >
> > >  #define SUN8I_R40_PLL_AUDIO_REG        0x008
> > >
> > > -static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
> > > -                                  "osc24M", 0x008,
> > > -                                  8, 7,        /* N */
> > > -                                  0, 5,        /* M */
> > > -                                  BIT(31),     /* gate */
> > > -                                  BIT(28),     /* lock */
> > > -                                  CLK_SET_RATE_UNGATE);
> > > +static struct ccu_sdm_setting pll_audio_sdm_table[] = {
> > > +       { .rate = 22579200, .pattern = 0xc0010d84, .m = 8, .n = 7 },
> > > +       { .rate = 24576000, .pattern = 0xc000ac02, .m = 14, .n = 14 },
> >
> > The user manual has an additional requirement: 3 <= N/M <= 21.
> > Though it then says 72 <= 24*N/P <= 504. Not sure which one is
> > right...
> >
> > Did you run into any glitches or audio distortions?
>
> No, I tested HDMI audio and it seems to work fine.
>
> BSP driver also uses those values:
> https://github.com/BPI-SINOVOIP/BPI-M2U-bsp/blob/master/linux-sunxi/drivers/
> clk/sunxi/clk-sun8iw11.c#L160

Sounds good. Thanks.
