Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFA6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2359C207BC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgHYQqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:46:05 -0400
Received: from mailoutvs2.siol.net ([185.57.226.193]:50182 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726356AbgHYQp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:45:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id BA8345242A9;
        Tue, 25 Aug 2020 18:45:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JNzuvwHO2mfh; Tue, 25 Aug 2020 18:45:54 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 5F99D52452D;
        Tue, 25 Aug 2020 18:45:54 +0200 (CEST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 002B15242A9;
        Tue, 25 Aug 2020 18:45:53 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH] clk: sunxi-ng: sun8i: r40: Use sigma delta modulation for audio PLL
Date:   Tue, 25 Aug 2020 18:45:53 +0200
Message-ID: <21600331.3yVNq0iq4W@jernej-laptop>
In-Reply-To: <CAGb2v66q15syd5g-9RUocmEwJyvpbJniTmwLJL4QH5s==fCi2Q@mail.gmail.com>
References: <20200825131049.1277596-1-jernej.skrabec@siol.net> <CAGb2v66q15syd5g-9RUocmEwJyvpbJniTmwLJL4QH5s==fCi2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 25. avgust 2020 ob 16:46:31 CEST je Chen-Yu Tsai napisal(a):
> On Tue, Aug 25, 2020 at 9:11 PM Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > Audio cores need specific clock rates which can't be simply obtained by
> > adjusting integer multipliers and dividers. HW for such cases supports
> > delta-sigma modulation which enables fractional multipliers.
> > 
> > Port H3 delta-sigma table to R40. They have identical audio PLLs.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/clk/sunxi-ng/ccu-sun8i-r40.c | 37 ++++++++++++++++++----------
> >  1 file changed, 24 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
> > b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c index 23bfe1d12f21..84153418453f
> > 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
> > +++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
> > @@ -45,18 +45,29 @@ static struct ccu_nkmp pll_cpu_clk = {
> > 
> >   * the base (2x, 4x and 8x), and one variable divider (the one true
> >   * pll audio).
> >   *
> > 
> > - * We don't have any need for the variable divider for now, so we just
> > - * hardcode it to match with the clock names
> > + * With sigma-delta modulation for fractional-N on the audio PLL,
> > + * we have to use specific dividers. This means the variable divider
> > + * can no longer be used, as the audio codec requests the exact clock
> > + * rates we support through this mechanism. So we now hard code the
> > + * variable divider to 1. This means the clock rates will no longer
> > + * match the clock names.
> > 
> >   */
> >  
> >  #define SUN8I_R40_PLL_AUDIO_REG        0x008
> > 
> > -static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
> > -                                  "osc24M", 0x008,
> > -                                  8, 7,        /* N */
> > -                                  0, 5,        /* M */
> > -                                  BIT(31),     /* gate */
> > -                                  BIT(28),     /* lock */
> > -                                  CLK_SET_RATE_UNGATE);
> > +static struct ccu_sdm_setting pll_audio_sdm_table[] = {
> > +       { .rate = 22579200, .pattern = 0xc0010d84, .m = 8, .n = 7 },
> > +       { .rate = 24576000, .pattern = 0xc000ac02, .m = 14, .n = 14 },
> 
> The user manual has an additional requirement: 3 <= N/M <= 21.
> Though it then says 72 <= 24*N/P <= 504. Not sure which one is
> right...
> 
> Did you run into any glitches or audio distortions?

No, I tested HDMI audio and it seems to work fine.

BSP driver also uses those values:
https://github.com/BPI-SINOVOIP/BPI-M2U-bsp/blob/master/linux-sunxi/drivers/
clk/sunxi/clk-sun8iw11.c#L160

Best regards,
Jernej


