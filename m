Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B76C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923CC20732
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="X6s4aKYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393852AbgDPREd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393172AbgDPREa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:04:30 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438A1C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 10:04:30 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ADD8D97D;
        Thu, 16 Apr 2020 19:04:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1587056668;
        bh=6anfdQG9yggTGdSflvo7pft6sQkL8/h+L8urd2XHqOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X6s4aKYZ0HnypTp4DjT87L+G9p89XiHG75XXhtgoPJlyuqdJe6jG6rxE1UR1BOVlR
         J9FxNgivCQ2sJ0Mg2ZvkNq3WwWsB8rDs7T5aGPdg/tj5VvO1kh/hjKPtfVMu4QV7iM
         VGQI/Wkc0oD8lObB0dgS7lJPXvjmaWPLautl2Qbg=
Date:   Thu, 16 Apr 2020 20:04:16 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        sam@ravnborg.org, Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/bridge: ps8640: Let panel to set the connector
 type
Message-ID: <20200416170416.GH4796@pendragon.ideasonboard.com>
References: <20200416164404.2418426-1-enric.balletbo@collabora.com>
 <20200416164404.2418426-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416164404.2418426-2-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thank you for the patch.

On Thu, Apr 16, 2020 at 06:44:04PM +0200, Enric Balletbo i Serra wrote:
> The panel connector type should be set by the panel not the bridge, so
> remove the connector_type assignment.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

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

-- 
Regards,

Laurent Pinchart
