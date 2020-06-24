Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1510C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECA720768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dvKEppls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390498AbgFXVSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389773AbgFXVSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:18:53 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB05CC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 14:18:52 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F38FA2A8;
        Wed, 24 Jun 2020 23:18:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593033530;
        bh=NcYC22Tgplzt+QFJCY6b3NweU1WExHNM69P0i8o2K2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dvKEpplsS2GMLBRJLS2cmP2KIV7Hea2BG8YeIbL7Xe7e9dAZQ5I+eSHbvBoGet6Ge
         AF6UWrpcT3C4BGI7k6OLnQ5vYXQXI/6BFwkF5UfnVXq2UKRnJG6dPsTADF75Sa2NkZ
         UmlobDvVCP4bnOlRzEVLj0BrouPHycCvF0ukgpyQ=
Date:   Thu, 25 Jun 2020 00:18:49 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>, andy.shevchenko@gmail.com,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RESEND PATCH v5 5/5] drm/bridge: lvds-codec: simplify error
 handling code
Message-ID: <20200624211849.GB29023@pendragon.ideasonboard.com>
References: <20200624114127.3016-1-a.hajda@samsung.com>
 <CGME20200624114138eucas1p262505da3ad1067720080d20209ff32de@eucas1p2.samsung.com>
 <20200624114127.3016-6-a.hajda@samsung.com>
 <20200624133312.GC5980@pendragon.ideasonboard.com>
 <e5f9ecbb-a372-5007-f1df-ba7bfd37ded1@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e5f9ecbb-a372-5007-f1df-ba7bfd37ded1@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

On Wed, Jun 24, 2020 at 04:03:30PM +0200, Andrzej Hajda wrote:
> On 24.06.2020 15:33, Laurent Pinchart wrote:
> > On Wed, Jun 24, 2020 at 01:41:27PM +0200, Andrzej Hajda wrote:
> >> Using probe_err code has following advantages:
> >> - shorter code,
> >> - recorded defer probe reason for debugging,
> >> - uniform error code logging.
> >>
> >> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> >> ---
> >>   drivers/gpu/drm/bridge/lvds-codec.c | 9 ++-------
> >>   1 file changed, 2 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/lvds-codec.c b/drivers/gpu/drm/bridge/lvds-codec.c
> >> index 24fb1befdfa2..c76fa0239e39 100644
> >> --- a/drivers/gpu/drm/bridge/lvds-codec.c
> >> +++ b/drivers/gpu/drm/bridge/lvds-codec.c
> >> @@ -71,13 +71,8 @@ static int lvds_codec_probe(struct platform_device *pdev)
> >>   	lvds_codec->connector_type = (uintptr_t)of_device_get_match_data(dev);
> >>   	lvds_codec->powerdown_gpio = devm_gpiod_get_optional(dev, "powerdown",
> >>   							     GPIOD_OUT_HIGH);
> >> -	if (IS_ERR(lvds_codec->powerdown_gpio)) {
> >> -		int err = PTR_ERR(lvds_codec->powerdown_gpio);
> >> -
> >> -		if (err != -EPROBE_DEFER)
> >> -			dev_err(dev, "powerdown GPIO failure: %d\n", err);
> >> -		return err;
> >> -	}
> >> +	if (IS_ERR(lvds_codec->powerdown_gpio))
> >> +		return probe_err(dev, lvds_codec->powerdown_gpio, "powerdown GPIO failure\n");
> >
> > Line wrap please.
> 
> I hoped that with latest checkpatch line length limit increase from 80 
> to 100 it is acceptable :) but apparently not [1].

I'm all for using longer lines when that improves readability, but in
this case I think it's easy enough to split the line. A longer line
limit doesn't mean we're forced to generate longer lines :-)

On a side note, I've been working on a C++ userspace project where we
had to decide on a coding style. Line length was one parameter, and we
went for a soft limit of 80 columns, and a hard limit of 120 columns.
This works quite well so far. The only pain point is that clang-format
(we use it, wrapped in a python script, to detect coding style
violations) doesn't understand soft and hard limits for line lengths.

> [1]: 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144
>
> > It bothers me that the common pattern of writing the error code at the
> > end of the message isn't possible anymore. Maybe I'll get used to it,
> > but it removes some flexibility.
> 
> Yes, but it gives uniformity :) and now with %pe printk format it 
> changes anyway.
> 
> >>   	/* Locate the panel DT node. */
> >>   	panel_node = of_graph_get_remote_node(dev->of_node, 1, 0);

-- 
Regards,

Laurent Pinchart
