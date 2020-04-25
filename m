Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AE7C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1FE420704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgDYOsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:48:16 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:43578 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDYOsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 10:48:15 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 9EF6620082;
        Sat, 25 Apr 2020 16:48:12 +0200 (CEST)
Date:   Sat, 25 Apr 2020 16:48:11 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        drinkcat@chromium.org, Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        hsinyi@chromium.org, matthias.bgg@gmail.com,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [PATCH 2/2] drm/bridge: ps8640: Let panel to set the connector
 type
Message-ID: <20200425144811.GD32235@ravnborg.org>
References: <20200416164404.2418426-1-enric.balletbo@collabora.com>
 <20200416164404.2418426-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416164404.2418426-2-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=QX4gbG5DAAAA:8 a=e5mUnYsNAAAA:8
        a=CQXTL9UJpCP97K1xDI4A:9 a=CjuIK1q_8ugA:10 a=AbAUZ8qAyYyZVLSsDulk:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 06:44:04PM +0200, Enric Balletbo i Serra wrote:
> The panel connector type should be set by the panel not the bridge, so
> remove the connector_type assignment.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks, applied to drm-misc-next.

	Sam

> ---
> 
>  drivers/gpu/drm/bridge/parade-ps8640.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 956b76e0a44d..13755d278db6 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -278,8 +278,6 @@ static int ps8640_probe(struct i2c_client *client)
>  	if (!panel)
>  		return -ENODEV;
>  
> -	panel->connector_type = DRM_MODE_CONNECTOR_eDP;
> -
>  	ps_bridge->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
>  	if (IS_ERR(ps_bridge->panel_bridge))
>  		return PTR_ERR(ps_bridge->panel_bridge);
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
