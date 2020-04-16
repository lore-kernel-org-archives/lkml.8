Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D2AC2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E3821924
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="h3iZ4KAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389201AbgDPRWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:22:34 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49292 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388338AbgDPRW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:22:29 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A42A797D;
        Thu, 16 Apr 2020 19:22:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1587057747;
        bh=h7Pg0Y2dXKQzjE9xqP+G1tsaeFjJ76gvJMp9vlOEtg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h3iZ4KAoTnGQsGA/NFPqERbdrTRB2t1MFry/EEFw91i6Tu/Rdr2aaU/wzJ4+INHJC
         1jRxLyzEGbC+hJWu8brX3ud4NWdW3kVXlOKeyfGJGu05x4TuYYe8beDpNHmOQxuxwj
         wfWMi+/rq0KmFnCPt4/BYzCB4TztXSzeWLcOr/40=
Date:   Thu, 16 Apr 2020 20:22:15 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/7] drm/bridge: ps8640: Get the EDID from eDP control
Message-ID: <20200416172215.GK4796@pendragon.ideasonboard.com>
References: <20200416155720.2360443-1-enric.balletbo@collabora.com>
 <20200416155720.2360443-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416155720.2360443-2-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thank you for the patch.

On Thu, Apr 16, 2020 at 05:57:13PM +0200, Enric Balletbo i Serra wrote:
> The PS8640 DSI-to-eDP bridge can retrieve the EDID, so implement the
> .get_edid callback and set the flag to indicate the core to use it.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/gpu/drm/bridge/parade-ps8640.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index d3a53442d449..956b76e0a44d 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -242,8 +242,18 @@ static int ps8640_bridge_attach(struct drm_bridge *bridge,
>  	return ret;
>  }
>  
> +static struct edid *ps8640_bridge_get_edid(struct drm_bridge *bridge,
> +					   struct drm_connector *connector)
> +{
> +	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
> +
> +	return drm_get_edid(connector,
> +			    ps_bridge->page[PAGE0_DP_CNTL]->adapter);

This will only work if the DDC signals are connected to the PS8640
(quite obviously). Is that guaranteed, or could some systems connect
them directory to an SoC I2C controller ? In the latter case we would
have to report this in the DT bindings of the PS8640. That's not
blocking for this patch, I am just wondering, as I would have expected
the driver to already expose EDID one way or another if this was
available and used.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +}
> +
>  static const struct drm_bridge_funcs ps8640_bridge_funcs = {
>  	.attach = ps8640_bridge_attach,
> +	.get_edid = ps8640_bridge_get_edid,
>  	.post_disable = ps8640_post_disable,
>  	.pre_enable = ps8640_pre_enable,
>  };
> @@ -296,6 +306,8 @@ static int ps8640_probe(struct i2c_client *client)
>  
>  	ps_bridge->bridge.funcs = &ps8640_bridge_funcs;
>  	ps_bridge->bridge.of_node = dev->of_node;
> +	ps_bridge->bridge.ops = DRM_BRIDGE_OP_EDID;
> +	ps_bridge->bridge.type = DRM_MODE_CONNECTOR_eDP;
>  
>  	ps_bridge->page[PAGE0_DP_CNTL] = client;
>  

-- 
Regards,

Laurent Pinchart
