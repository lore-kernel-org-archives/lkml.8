Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99C6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C802A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387964AbgF2Toy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:44:54 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:39312 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732079AbgF2Tot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:44:49 -0400
X-Greylist: delayed 2416 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jun 2020 15:44:48 EDT
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 6BDD73A6287;
        Mon, 29 Jun 2020 08:15:29 +0000 (UTC)
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id EB831C000E;
        Mon, 29 Jun 2020 08:15:04 +0000 (UTC)
Date:   Mon, 29 Jun 2020 10:15:03 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 2/2] drm/panel: simple: Add Satoz SAT050AT40H12R2
 panel support
Message-ID: <20200629101503.5bae21d6@xps13>
In-Reply-To: <20200628072444.GA8391@pendragon.ideasonboard.com>
References: <20200109184037.9091-1-miquel.raynal@bootlin.com>
        <20200109184037.9091-2-miquel.raynal@bootlin.com>
        <20200628072444.GA8391@pendragon.ideasonboard.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

[...]

> >  
> > +static const struct display_timing satoz_sat050at40h12r2_timing = {
> > +	.pixelclock = {33300000, 33300000, 50000000},
> > +	.hactive = {800, 800, 800},
> > +	.hfront_porch = {16, 210, 354},
> > +	.hback_porch = {46, 46, 46},
> > +	.hsync_len = {1, 1, 40},
> > +	.vactive = {480, 480, 480},
> > +	.vfront_porch = {7, 22, 147},
> > +	.vback_porch = {23, 23, 23},
> > +	.vsync_len = {1, 1, 20},
> > +};
> > +
> > +static const struct panel_desc satoz_sat050at40h12r2 = {
> > +	.timings = &satoz_sat050at40h12r2_timing,
> > +	.num_timings = 1,
> > +	.bpc = 8,
> > +	.size = {
> > +		.width = 108,
> > +		.height = 65,
> > +	},
> > +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> > +	.connector_type = DRM_MODE_CONNECTOR_LVDS,  
> 
> I'm trying to fix inconsistencies in the panel-simple driver, and this
> caught my eyes. MEDIA_BUS_FMT_RGB888_1X24 isn't a correct format for
> LVDS panels. MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
> MEDIA_BUS_FMT_RGB888_1X7X4_SPWG or MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA
> should be used instead. As I couldn't find documentation for the panel,
> I can't tell which format is correct. Could you please help ?

Indeed, I got this datasheet under NDA.

We checked with Paul, we think the right format is:
MEDIA_BUS_FMT_RGB888_1X7X4_SPWG.

Thanks,
Miquèl
