Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBF5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76BA720771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nXkJuXZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbgGVMQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:16:06 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48600 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgGVMQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:16:03 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 894FF329;
        Wed, 22 Jul 2020 14:15:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1595420159;
        bh=pf3+Ge9hYR6C+05IUL3E6eTSEz6m+aUSIyOHoAkAfho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXkJuXZC6QLfy8hyuh7GRYRQAfAOZCNtQgGFAZ0csQO0aznHtgR5Ef6o0HHt1nSH2
         StrGjoZNBxtlhVGGOZoPO0Q7hdWydbfJS4yR76v4P1K5NblQxzIzTJGT7grwthi/DB
         hOl24I96PIUtNFH8QXPPaB3Ihvw9VWDlNkPpyToM=
Date:   Wed, 22 Jul 2020 15:15:54 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-imx@nxp.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge/adv7511: set the bridge type properly
Message-ID: <20200722121554.GD5833@pendragon.ideasonboard.com>
References: <20200720124228.12552-1-laurentiu.palcu@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720124228.12552-1-laurentiu.palcu@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurentiu,

Thank you for the patch.

On Mon, Jul 20, 2020 at 03:42:27PM +0300, Laurentiu Palcu wrote:
> From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> 
> After the drm_bridge_connector_init() helper function has been added, the ADV
> driver has been changed accordingly. However, the 'type' field of the bridge
> structure was left unset, which makes the helper function always return -EINVAL.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Hi,
> 
> I've hit this while trying to use this helper in the new i.MX8MQ DCSS
> driver, as suggested by Sam, and I wanted to test it with NWL MIPI_DSI and
> ADV since support is already in mainline.
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

-- 
Regards,

Laurent Pinchart
