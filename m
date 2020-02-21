Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BA9C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735A724650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgBUPBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:01:22 -0500
Received: from verein.lst.de ([213.95.11.211]:55906 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728690AbgBUPBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:01:22 -0500
Received: by verein.lst.de (Postfix, from userid 2005)
        id 3258468BFE; Fri, 21 Feb 2020 16:01:18 +0100 (CET)
Date:   Fri, 21 Feb 2020 16:01:17 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <treding@nvidia.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [RESEND2][PATCH] drm/bridge: analogix-anx6345: Fix drm_dp_link
 helper removal
Message-ID: <20200221150117.GA6928@lst.de>
References: <20200221140455.8713068BFE@verein.lst.de> <b30435c7-95c5-e21e-ea05-cd3ada20d150@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b30435c7-95c5-e21e-ea05-cd3ada20d150@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 03:39:32PM +0100, Thomas Zimmermann wrote:
> Hi Torsten
> 
> Am 21.02.20 um 15:04 schrieb Torsten Duwe:
> > drm_dp_link_rate_to_bw_code and ...bw_code_to_link_rate simply divide by
> > and multiply with 27000, respectively. Avoid an overflow in the u8 dpcd[0]
> > and the multiply+divide alltogether.
> > 
> > fixes: e1cff82c1097bda2478 ("fix anx6345 compilation for v5.5")
> 
> You have to create the fixes tag and related cc tags with 'dim fixes',
> available at [1]. For this patch, the output is
> 
> Fixes: e1cff82c1097 ("drm/bridge: fix anx6345 compilation for v5.5")
> Cc: Torsten Duwe <duwe@suse.de>
> Cc: Maxime Ripard <maxime@cerno.tech>
> Cc: Torsten Duwe <duwe@lst.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Icenowy Zheng <icenowy@aosc.io>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>

Ah, neat.

> > Signed-off-by: Torsten Duwe <duwe@suse.de>
> 
> You signed off with your SUSE email address, but sent the mail from
> lst.de. I don't know if it's strictly not allowed, but that's at least
> confusing to the tools.

From my understanding, it is legally correct. The work is owned by Suse,
so I have to sign off as an employee, but I'm subscribed with the LST
address, and I'd also like to see all replies there.

> [1] https://gitlab.freedesktop.org/drm/maintainer-tools/

I'll send an appropriate v2 once I get a review for it.

Thanks!

	Torsten



