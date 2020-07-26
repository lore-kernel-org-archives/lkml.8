Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA16C433E8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 17:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 473C12065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 17:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgGZRJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 13:09:06 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:52532 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgGZRJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 13:09:05 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id F1B5980487;
        Sun, 26 Jul 2020 19:09:00 +0200 (CEST)
Date:   Sun, 26 Jul 2020 19:08:59 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/bridge/adv7511: set the bridge type properly
Message-ID: <20200726170859.GE3275923@ravnborg.org>
References: <20200720124228.12552-1-laurentiu.palcu@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720124228.12552-1-laurentiu.palcu@oss.nxp.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=8AirrxEcAAAA:8 a=e5mUnYsNAAAA:8
        a=Y7K1v_ct7oQ-R3I0n14A:9 a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 03:42:27PM +0300, Laurentiu Palcu wrote:
> From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> 
> After the drm_bridge_connector_init() helper function has been added, the ADV
> driver has been changed accordingly. However, the 'type' field of the bridge
> structure was left unset, which makes the helper function always return -EINVAL.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>

Thanks, applied to drm-misc-fixes.

	Sam

> ---
> Hi,
> 
> I've hit this while trying to use this helper in the new i.MX8MQ DCSS
> driver, as suggested by Sam, and I wanted to test it with NWL MIPI_DSI and
> ADV since support is already in mainline.
> 
> Thanks,
> laurentiu
> 
> 
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index f45cdca9cce5..a0d392c338da 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -1283,6 +1283,7 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
>  	adv7511->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID
>  			    | DRM_BRIDGE_OP_HPD;
>  	adv7511->bridge.of_node = dev->of_node;
> +	adv7511->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
>  
>  	drm_bridge_add(&adv7511->bridge);
>  
> -- 
> 2.23.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
