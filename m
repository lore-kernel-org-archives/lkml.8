Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC716C2BA17
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0D6206B8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgDEO1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 10:27:23 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:37452 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgDEO1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 10:27:23 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id D742320160;
        Sun,  5 Apr 2020 16:27:17 +0200 (CEST)
Date:   Sun, 5 Apr 2020 16:27:15 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Joonas =?iso-8859-1?Q?Kylm=E4l=E4?= <joonas.kylmala@iki.fi>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        paul.kocialkowski@bootlin.com, GNUtoo@cyberdimension.org
Subject: Re: [PATCH] drm/panel: samsung: s6e8aa0: Add backlight control
 support
Message-ID: <20200405142715.GA28291@ravnborg.org>
References: <CGME20190921125017epcas3p2f5661cca04f0959f9707f6111102435d@epcas3p2.samsung.com>
 <20190921124843.6967-1-joonas.kylmala@iki.fi>
 <d8a8bf25-0c5e-8d94-9406-b1f74e3edfac@samsung.com>
 <53385e44-1847-ace0-cd87-5571f6acd3f2@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53385e44-1847-ace0-cd87-5571f6acd3f2@iki.fi>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10
        a=8Bv4S_VrHzWzl_PHQgMA:9 a=wPNLvfGTeEIA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joonas.

On Sat, Apr 04, 2020 at 04:27:02PM +0300, Joonas Kylmälä wrote:
> Hi,
> 
> addressing this email to you all since there might be widespread race
> condition issue in the DRM panel drivers that are using MIPI DSI. See
> below for my message.
> 
> Andrzej Hajda:
> >> +static int s6e8aa0_set_brightness(struct backlight_device *bd)
> >> +{
> >> +	struct s6e8aa0 *ctx = bl_get_data(bd);
> >> +	const u8 *gamma;
> >> +
> >> +	if (ctx->error)
> >> +		return;
> >> +
> >> +	gamma = ctx->variant->gamma_tables[bd->props.brightness];
> >> +
> >> +	if (ctx->version >= 142)
> >> +		s6e8aa0_elvss_nvm_set(ctx);
> >> +
> >> +	s6e8aa0_dcs_write(ctx, gamma, GAMMA_TABLE_LEN);
> >> +
> >> +	/* update gamma table. */
> >> +	s6e8aa0_dcs_write_seq_static(ctx, 0xf7, 0x03);
> >> +
> >> +	return s6e8aa0_clear_error(ctx);
> >> +}
> >> +
> >> +static const struct backlight_ops s6e8aa0_backlight_ops = {
> >> +	.update_status	= s6e8aa0_set_brightness,
> > 
> > 
> > This is racy, update_status can be called in any time between probe and
> > remove, particularly:
> > 
> > a) before panel enable,
> > 
> > b) during panel enable,
> > 
> > c) when panel is enabled,
> > 
> > d) during panel disable,
> > 
> > e) after panel disable,
> > 
> > 
> > b and d are racy for sure - backlight and drm callbacks are async.
> > 
> > IMO the best solution would be to register backlight after attaching
> > panel to drm, but for this drm_panel_funcs should have attach/detach
> > callbacks (like drm_bridge_funcs),
> > 
> > then update_status callback should take some drm_connector lock to
> > synchronize with drm, and write to hw only when pipe is enabled.
> 
> I have done now research and if I understand right one issue here might
> be with setting the backlight brightness if the DSI device is not
> attached before calling update_status() since calling it would call
> subsequently s6e8aa0_set_brightness() -> s6e8aa0_dcs_write() ->
> mipi_dsi_dcs_write_buffer(), which then requires DSI to be attached.

Not directly related to your comments above.
But I have looked at the backlight support for the various
samsung panels.

None of them are good examples to follow.
Please have a look at for example panel-novatek-nt35510.c
which is a good example how to have a local backligth
and tie it into the general way it is used by drm_panel.

I have typed patches to fix all three samsung panels, will
post patches later when I get more time.

If we are concerned with set_brightness() being called
while not ready, this can be checked in the
set_brightness() function and return error if not OK.

As the the race concerns see Daniel's reply.

	Sam
