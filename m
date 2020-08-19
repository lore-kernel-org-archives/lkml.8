Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E240C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 141AE206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgHSNDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:03:48 -0400
Received: from mail.v3.sk ([167.172.186.51]:54522 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728599AbgHSND3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:03:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A815BDFA73;
        Wed, 19 Aug 2020 13:02:23 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SBg0Syt9oXLB; Wed, 19 Aug 2020 13:02:21 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7095DDFA44;
        Wed, 19 Aug 2020 13:02:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mtXcedEM5ITw; Wed, 19 Aug 2020 13:02:21 +0000 (UTC)
Received: from localhost (unknown [77.240.177.143])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 07854DEE69;
        Wed, 19 Aug 2020 13:02:20 +0000 (UTC)
Date:   Wed, 19 Aug 2020 15:03:13 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     srk@48.io, Andrzej Hajda <a.hajda@samsung.com>,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sean Cross <xobs@kosagi.com>, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/2] drm/panel: simple: Add Innolux N133HSE panel support
Message-ID: <20200819130313.GA152043@furthur.local>
References: <20200509111834.26335-1-srk@48.io>
 <20200509111834.26335-3-srk@48.io>
 <20200511074708.GA2759@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511074708.GA2759@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 09:47:08AM +0200, Sam Ravnborg wrote:
> Hi Richard.
> 
> On Sat, May 09, 2020 at 01:18:34PM +0200, srk@48.io wrote:
> > From: Sean Cross <xobs@kosagi.com>
> > 
> > The Innolux N133HSE panel is a 13.3" 1920x1080 panel that contains an
> > integrated backlight, and connects via eDP.
> > 
> > It is used in the Kosagi Novena.
> 
> Thanks for the patch.
> 
> 
> > 
> > Signed-off-by: Sean Cross <xobs@kosagi.com>
> > Signed-off-by: Richard Marko <srk@48.io>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > To: dri-devel@lists.freedesktop.org
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index 3ad828eaefe1..c8a93771d398 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -1906,6 +1906,30 @@ static const struct panel_desc innolux_n116bge = {
> >  	},
> >  };
> >  
> > +static const struct drm_display_mode innolux_n133hse_ea1_mode = {
> > +	.clock = 138500,
> > +	.hdisplay = 1920,
> > +	.hsync_start = 1920 + 46,
> > +	.hsync_end = 1920 + 46 + 30,
> > +	.htotal = 1920 + 46 + 30 + 84,
> > +	.vdisplay = 1080,
> > +	.vsync_start = 1080 + 2,
> > +	.vsync_end = 1080 + 2 + 4,
> > +	.vtotal = 1080 + 2 + 4 + 26,
> > +	.vrefresh = 60,
> > +};
> > +
> > +static const struct panel_desc innolux_n133hse_ea1 = {
> > +	.modes = &innolux_n133hse_ea1_mode,
> > +	.num_modes = 1,
> > +	.bpc = 8,
> > +	.size = {
> > +		.width = 293,
> > +		.height = 165,
> > +	},
> > +	.connector_type = DRM_MODE_CONNECTOR_eDP,
> Please include .bus_format and .bus_flags info too.
> 
> We are relying more and more on this type of info so we need it to be
> present.

I am wondering which of the flags make sense for eDP and how the bus
format should be described?

Some eDP panels seems [1] to specify DRM_BUS_FLAG_DATA_MSB_TO_LSB and 
DRM_BUS_FLAG_SYNC_DRIVE_NEGEDGE, but I am not sure what sense they make
for packet data with embedded clock that eDP uses? (Unless, of course,
my understanding of eDP is entirely missing the point.)

This panel uses RGB888 data over two differential pairs. Would
format = MEDIA_BUS_FMT_RGB888_1X24 be appropriate?

[1] N133HSE-EA1 Datasheet
    http://www.vslcd.com/specification/N133HSE-EA1.pdf

> 	Sam

Thank you,
Lubo
