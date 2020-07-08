Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF430C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C779221D80
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGHIbj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgGHIbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:31:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC05EC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 01:31:38 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jt5UL-0008CP-Vq; Wed, 08 Jul 2020 10:31:33 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jt5UL-0006jo-Ge; Wed, 08 Jul 2020 10:31:33 +0200
Message-ID: <a55b91f01a2e795fe2dd38d860e63a63c8c8871c.camel@pengutronix.de>
Subject: Re: [PATCH] drm: imx: Fix occasional screen corruption on modeset.
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Martin Fuzzey <martin.fuzzey@flowbird.group>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 08 Jul 2020 10:31:33 +0200
In-Reply-To: <1594137527-15201-1-git-send-email-martin.fuzzey@flowbird.group>
References: <1594137527-15201-1-git-send-email-martin.fuzzey@flowbird.group>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Tue, 2020-07-07 at 17:56 +0200, Martin Fuzzey wrote:
> When performing a modeset the atomic core calls
> ipu_crtc_atomic_disable() which switches off the DC and DI.
> 
> When we immediately restart as in the modeset case this sometimes
> leads to corruption at the bottom of the screen looking like a mirror
> image of the top.

Could this be just a panel getting confused because the pixel clock is
disabled, or is there really an issue with the IPU? Have you tried just
keeping clk_di_pixel enabled in ipu_di_disable(), but continuing
to disable DI and DC?

> The exact reason isn't understood but it seems timing related.
> 
> This was observed on i.MX6DL on a system that does 2 mode
> transitions on boot (fbcon->android boot animation->android homescreen)
> then no more during normal operation resulting in corruption
> about once every 10 boots that lasted for variable durations
> from a few seconds to several hours.
> 
> Dumping the buffers confirmed that they were correct in memory,
> just the display was wrong.
> 
> For tests the problem was reproduced systematically by forcing
> a full modeset every 10 frames even if when not required.
> 
> Leaving the DC and DI on if the CRTC is staying on fixes this.
> 
> Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
> ---
>  drivers/gpu/drm/imx/ipuv3-crtc.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/imx/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3-crtc.c
> index 63c0284..9137b64 100644
> --- a/drivers/gpu/drm/imx/ipuv3-crtc.c
> +++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
> @@ -84,8 +84,15 @@ static void ipu_crtc_atomic_disable(struct drm_crtc *crtc,
>  	struct ipu_crtc *ipu_crtc = to_ipu_crtc(crtc);
>  	struct ipu_soc *ipu = dev_get_drvdata(ipu_crtc->dev->parent);
>  
> -	ipu_dc_disable_channel(ipu_crtc->dc);
> -	ipu_di_disable(ipu_crtc->di);
> +	/*
> +	 * If we are just doing a modeset don't disable dc/di as that
> +	 * sometimes leads to corruption at the bottom of the screen
> +	 */
> +	if (!crtc->state->active) {
> +		ipu_dc_disable_channel(ipu_crtc->dc);
> +		ipu_di_disable(ipu_crtc->di);

Just removing ipu_di_disable() leaks a clk_prepare_enable refcount on
the di->clk_di_pixel clock.

Also this is followed by an ipu_dc_disable(), which should remove the DC
module's clock if this is the only display. So the DC should be disabled
anyway.

> +	}
> +
>  	/*
>  	 * Planes must be disabled before DC clock is removed, as otherwise the
>  	 * attached IDMACs will be left in undefined state, possibly hanging

regards
Philipp
