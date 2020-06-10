Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2F1C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE9A2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbgFJQCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:02:14 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:35780 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgFJQCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:02:13 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 931FE20025;
        Wed, 10 Jun 2020 18:02:09 +0200 (CEST)
Date:   Wed, 10 Jun 2020 18:02:08 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (EXT) Re: [PATCH 3/4] drm/panel: simple: add CDTech
 S070PWS19HP-FC21 and S070SWV29HG-DC44
Message-ID: <20200610160208.GA138424@ravnborg.org>
References: <20200610120131.3069-1-matthias.schiffer@ew.tq-group.com>
 <20200610120131.3069-4-matthias.schiffer@ew.tq-group.com>
 <20200610145954.GA135509@ravnborg.org>
 <44d3b82a11fc292f0aa3f60a8ccebd4e8ce5d3e8.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44d3b82a11fc292f0aa3f60a8ccebd4e8ce5d3e8.camel@ew.tq-group.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=edQTgYMH c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=8f9FM25-AAAA:8 a=e5mUnYsNAAAA:8
        a=MH3lEQRaDhxj07Duq-8A:9 a=dKu1ZNvqqGtcOEyT:21 a=FKxxUMPwspYndQKg:21
        a=CjuIK1q_8ugA:10 a=uSNRK0Bqq4PXrUp6LDpb:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 05:26:23PM +0200, Matthias Schiffer wrote:
> On Wed, 2020-06-10 at 16:59 +0200, Sam Ravnborg wrote:
> > Hi Matthias.
> > 
> > Thanks, a few details you need to fix. See below.
> > 
> > 	Sam
> > 
> > On Wed, Jun 10, 2020 at 02:01:30PM +0200, Matthias Schiffer wrote:
> > > From: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
> > > 
> > > Add support for the CDTech Electronics displays S070PWS19HP-FC21
> > > (7.0" WSVGA) and S070SWV29HG-DC44 (7.0" WVGA) to panel-simple.
> > > 
> > > Signed-off-by: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > > >
> > > ---
> > >  drivers/gpu/drm/panel/panel-simple.c | 60
> > > ++++++++++++++++++++++++++++
> > >  1 file changed, 60 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/panel/panel-simple.c
> > > b/drivers/gpu/drm/panel/panel-simple.c
> > > index b6ecd1552132..1673113e5a5a 100644
> > > --- a/drivers/gpu/drm/panel/panel-simple.c
> > > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > > @@ -1315,6 +1315,60 @@ static const struct panel_desc
> > > cdtech_s043wq26h_ct7 = {
> > >  	.bus_flags = DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
> > >  };
> > >  
> > > +/* S070PWS19HP-FC21 2017/04/22 */
> > > +static const struct drm_display_mode cdtech_s070pws19hp_fc21_mode
> > > = {
> > > +	.clock = 51200,
> > > +	.hdisplay = 1024,
> > > +	.hsync_start = 1024 + 160,
> > > +	.hsync_end = 1024 + 160 + 20,
> > > +	.htotal = 1024 + 160 + 20 + 140,
> > > +	.vdisplay = 600,
> > > +	.vsync_start = 600 + 12,
> > > +	.vsync_end = 600 + 12 + 3,
> > > +	.vtotal = 600 + 12 + 3 + 20,
> > > +	.vrefresh = 60,
> > 
> > .vrefresh is no longer present, please drop.
> 
> I based my patches on the branch drm-next of 
> https://cgit.freedesktop.org/drm/drm, should I have used a different
> branch?
drm-misc-next would in this case be a better choice.
In most cases both would have worked equally well, but we have nuked
.refresh recently.

	Sam

> 
> 
> > > +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> > > +};
> > > +
> > > +static const struct panel_desc cdtech_s070pws19hp_fc21 = {
> > > +	.modes = &cdtech_s070pws19hp_fc21_mode,
> > > +	.num_modes = 1,
> > > +	.bpc = 6,
> > > +	.size = {
> > > +		.width = 154,
> > > +		.height = 86,
> > > +	},
> > > +	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> > > +	.bus_flags = DRM_BUS_FLAG_DE_HIGH |
> > > DRM_BUS_FLAG_PIXDATA_POSEDGE,
> > > +};
> > 
> > Please add .connector_type - it is mandatory.
> > > +
> > > +/* S070SWV29HG-DC44 2017/09/21 */
> > > +static const struct drm_display_mode cdtech_s070swv29hg_dc44_mode
> > > = {
> > > +	.clock = 33300,
> > > +	.hdisplay = 800,
> > > +	.hsync_start = 800 + 210,
> > > +	.hsync_end = 800 + 210 + 2,
> > > +	.htotal = 800 + 210 + 2 + 44,
> > > +	.vdisplay = 480,
> > > +	.vsync_start = 480 + 22,
> > > +	.vsync_end = 480 + 22 + 2,
> > > +	.vtotal = 480 + 22 + 2 + 21,
> > > +	.vrefresh = 60,
> > 
> > .vrefresh is no longer present, please drop.
> > > +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> > > +};
> > > +
> > > +static const struct panel_desc cdtech_s070swv29hg_dc44 = {
> > > +	.modes = &cdtech_s070swv29hg_dc44_mode,
> > > +	.num_modes = 1,
> > > +	.bpc = 6,
> > > +	.size = {
> > > +		.width = 154,
> > > +		.height = 86,
> > > +	},
> > > +	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> > > +	.bus_flags = DRM_BUS_FLAG_DE_HIGH |
> > > DRM_BUS_FLAG_PIXDATA_POSEDGE,
> > 
> > Please add .connector_type - it is mandatory.
> > > +};
> > > +
> > >  static const struct drm_display_mode cdtech_s070wv95_ct16_mode = {
> > >  	.clock = 35000,
> > >  	.hdisplay = 800,
> > > @@ -3723,6 +3777,12 @@ static const struct of_device_id
> > > platform_of_match[] = {
> > >  	}, {
> > >  		.compatible = "cdtech,s043wq26h-ct7",
> > >  		.data = &cdtech_s043wq26h_ct7,
> > > +	}, {
> > > +		.compatible = "cdtech,s070pws19hp-fc21",
> > > +		.data = &cdtech_s070pws19hp_fc21,
> > > +	}, {
> > > +		.compatible = "cdtech,s070swv29hg-dc44",
> > > +		.data = &cdtech_s070swv29hg_dc44,
> > >  	}, {
> > >  		.compatible = "cdtech,s070wv95-ct16",
> > >  		.data = &cdtech_s070wv95_ct16,
> > > -- 
> > > 2.17.1
