Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DAEC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DA7208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgBULFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:05:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:42068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727239AbgBULFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:05:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F03F2AE17;
        Fri, 21 Feb 2020 11:05:43 +0000 (UTC)
Date:   Fri, 21 Feb 2020 12:05:41 +0100
From:   Torsten Duwe <duwe@suse.de>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] drm/bridge: anx6345: Fix getting anx6345 regulators
Message-ID: <20200221110541.GA28948@suse.de>
References: <20200220083508.792071-1-anarsoul@gmail.com>
 <20200220083508.792071-2-anarsoul@gmail.com>
 <fc4ed2c4-ae5f-cd67-1c8a-c17e1cb63423@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc4ed2c4-ae5f-cd67-1c8a-c17e1cb63423@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 09:32:01AM +0100, Neil Armstrong wrote:
> On 20/02/2020 09:35, Vasily Khoruzhick wrote:
> > From: Samuel Holland <samuel@sholland.org>
> > 
> > We don't need to pass '-supply' suffix to devm_get_regulator()
> > 
> > Fixes: 6aa192698089 ("drm/bridge: Add Analogix anx6345 support")
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> > index 56f55c53abfd..0d8d083b0207 100644
> > --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> > +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> > @@ -712,14 +712,14 @@ static int anx6345_i2c_probe(struct i2c_client *client,
> >  		DRM_DEBUG("No panel found\n");
> >  
> >  	/* 1.2V digital core power regulator  */
> > -	anx6345->dvdd12 = devm_regulator_get(dev, "dvdd12-supply");
> > +	anx6345->dvdd12 = devm_regulator_get(dev, "dvdd12");
> >  	if (IS_ERR(anx6345->dvdd12)) {
> >  		DRM_ERROR("dvdd12-supply not found\n");
> >  		return PTR_ERR(anx6345->dvdd12);
> >  	}
> >  
> >  	/* 2.5V digital core power regulator  */
> > -	anx6345->dvdd25 = devm_regulator_get(dev, "dvdd25-supply");
> > +	anx6345->dvdd25 = devm_regulator_get(dev, "dvdd25");
> >  	if (IS_ERR(anx6345->dvdd25)) {
> >  		DRM_ERROR("dvdd25-supply not found\n");
> >  		return PTR_ERR(anx6345->dvdd25);
> > 
> 
> This is a duplicate of "drm/bridge: analogix-anx6345: Avoid duplicate -supply suffix" (20200218155440.BEFB968C65@verein.lst.de)
> 
> But this one has fixes and review from laurent, so I'll push this one when the serie is ready

I really don't mind, as long as it gets fixed.
The change is pretty obvious when you look at commit 69511a452e6dc.

Signed-off-by: Torsten Duwe <duwe@suse.de>
Reviewed-by: Mark Brown <broonie@kernel.org>
(broonie had replied to my submission back in November)

There's one other fix required for the anx6345 and, while at it,
I had also fixed the code I copied in that hurry as well. 
What about these? All 3 fixes can go in independently, so I wouldn't
tie them to this series.

	Torsten

