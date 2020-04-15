Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B61CC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2420820787
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440817AbgDORwp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:52:45 -0400
Received: from mailoutvs60.siol.net ([185.57.226.251]:54451 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2437449AbgDORwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:52:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 7DA5B523E2D;
        Wed, 15 Apr 2020 19:52:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Mn71HVJwTzMB; Wed, 15 Apr 2020 19:52:38 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 1B19B52389F;
        Wed, 15 Apr 2020 19:52:38 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 832A5523E96;
        Wed, 15 Apr 2020 19:52:34 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sun4i: hdmi ddc clk: Fix size of m divider
Date:   Wed, 15 Apr 2020 19:52:28 +0200
Message-ID: <1785843.taCxCBeP46@jernej-laptop>
In-Reply-To: <20200415104214.ndkkxfnufkxgu53r@gilmour.lan>
References: <20200413095457.1176754-1-jernej.skrabec@siol.net> <1742537.tdWV9SEqCh@jernej-laptop> <20200415104214.ndkkxfnufkxgu53r@gilmour.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 15. april 2020 ob 12:42:14 CEST je Maxime Ripard napisal(a):
> On Mon, Apr 13, 2020 at 06:09:08PM +0200, Jernej Škrabec wrote:
> > Dne ponedeljek, 13. april 2020 ob 16:12:39 CEST je Chen-Yu Tsai 
napisal(a):
> > > On Mon, Apr 13, 2020 at 6:11 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > > > On Mon, Apr 13, 2020 at 5:55 PM Jernej Skrabec
> > > > <jernej.skrabec@siol.net>
> > 
> > wrote:
> > > > > m divider in DDC clock register is 4 bits wide. Fix that.
> > > > > 
> > > > > Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
> > > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > 
> > > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > > 
> > > Cc stable?
> > 
> > I don't think it's necessary:
> > 1. It doesn't change much (anything?) for me when reading EDID. I don't
> > think it's super important to have precise DDC clock in order to properly
> > read EDID. 2. No matter if it has "Cc stable" tag or not, it will be
> > eventually picked for stable due to fixes tag.
> > 
> > This was only small observation when I was researching EDID readout issue
> > on A20 board, but sadly, I wasn't able to figure out why reading it
> > sometimes fails. I noticed similar issue on SoCs with DE2 (most
> > prominently on OrangePi PC2 - H5), but there was easy workaround - I just
> > disabled video driver in U- Boot. However, if A20 display driver gets
> > disabled in U-Boot, it totally breaks video output on my TV when Linux
> > boots (no output). I guess there is more fundamental problem with clocks
> > than just field size. I think we should add more constraints in clock
> > driver, like preset some clock parents and not allow to change parents
> > when setting rate, but carefully, so simplefb doesn't break. Such
> > constraints should also solve problems with dual head setups.
> I disagree here. Doing all sorts of special case just doesn't scale,
> and we'll never have the special cases sorted out on all the boards
> (and it's a nightmare to maintain).
> 
> Especially since it's basically putting a blanket over the actual
> issue and looking the other way. If there's something wrong with how
> we deal with (re)parenting, we should fix that. It impacts more than
> just DRM, and all the SoCs.

I agree with you that automatic solution would be best, but I just don't see 
it how it would be done. Dual head display pipeline is pretty complex for 
clock driver to get it right on it's own. There are different possible setups 
and some of them are hot pluggable, like HDMI. And there are also SoC specific 
quirks, like A64, where for some reason, MIPI DPHY and HDMI PHY share same 
clock parent - PLL_VIDEO0. Technically, MIPI DPHY can be clocked from 
PLL_PERIPH0 (fixed to 600 MHz), but that's not really helpful. I'm not even 
sure if there is any good solution to this - certainly HDMI and MIPI can't 
claim exclusivity and somehow best common rate must be found for PLL_VIDEO0, 
if that's even possible. I was sure that HDMI PHY on A64 can be clocked from 
PLL_VIDEO1, which would solve main issue, but to date, I didn't find any way to 
do that.

That's pretty off topic, so I hope original patch can be merged as-is.

Best regards,
Jernej


