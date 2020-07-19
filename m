Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBE0C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 12:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A3F22B4D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 12:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgGSMSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 08:18:07 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:40094 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgGSMSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 08:18:07 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id CD3AE2001E;
        Sun, 19 Jul 2020 14:17:59 +0200 (CEST)
Date:   Sun, 19 Jul 2020 14:17:58 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] drm/bridge: nwl-dsi: Drop
 DRM_BRIDGE_ATTACH_NO_CONNECTOR check.
Message-ID: <20200719121758.GA31024@ravnborg.org>
References: <cover.1595096667.git.agx@sigxcpu.org>
 <8b6545b991afce6add0a24f5f5d116778b0cb763.1595096667.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b6545b991afce6add0a24f5f5d116778b0cb763.1595096667.git.agx@sigxcpu.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=ze386MxoAAAA:8 a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8
        a=jl-WWmxG2UpaZUGkstgA:9 a=wPNLvfGTeEIA:10 a=iBZjaW-pnkserzjvUTHh:22
        a=E9Po1WZjFZOl8hwRPBS3:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido.

On Sat, Jul 18, 2020 at 08:26:37PM +0200, Guido Günther wrote:
> We don't create a connector but let panel_bridge handle that so there's
> no point in rejecting DRM_BRIDGE_ATTACH_NO_CONNECTOR.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
Looks good and correct.
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

If there is no other feedback I will apply within a few days.
Ping me if I forget it.

	Sam

> ---
>  drivers/gpu/drm/bridge/nwl-dsi.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index 77a79af70914..ce94f797d090 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -918,11 +918,6 @@ static int nwl_dsi_bridge_attach(struct drm_bridge *bridge,
>  	struct drm_panel *panel;
>  	int ret;
>  
> -	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) {
> -		DRM_ERROR("Fix bridge driver to make connector optional!");
> -		return -EINVAL;
> -	}
> -
>  	ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 1, 0, &panel,
>  					  &panel_bridge);
>  	if (ret)
> -- 
> 2.26.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
