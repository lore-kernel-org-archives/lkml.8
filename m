Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C678DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE983207C3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgHVJXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 05:23:11 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:53058 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgHVJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 05:23:11 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 1FB0180516;
        Sat, 22 Aug 2020 11:23:08 +0200 (CEST)
Date:   Sat, 22 Aug 2020 11:23:06 +0200
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
Subject: Re: [PATCH 2/3] drm/bridge: ps8640: Print an error if VDO control
 fails
Message-ID: <20200822092306.GB430436@ravnborg.org>
References: <20200615205320.790334-1-enric.balletbo@collabora.com>
 <20200615205320.790334-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615205320.790334-3-enric.balletbo@collabora.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=QX4gbG5DAAAA:8 a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8
        a=cf3U8Ll1wViUF6FddlcA:9 a=CjuIK1q_8ugA:10 a=AbAUZ8qAyYyZVLSsDulk:22
        a=E9Po1WZjFZOl8hwRPBS3:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 10:53:19PM +0200, Enric Balletbo i Serra wrote:
> Print an error message inside ps8640_bridge_vdo_control() function when
> it fails so we can simplify a bit the callers, they will only need to
> check the error code.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

> ---
> 
>  drivers/gpu/drm/bridge/parade-ps8640.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index ce3e8b2da8c9b..9f7b7a9c53c52 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -82,8 +82,11 @@ static int ps8640_bridge_vdo_control(struct ps8640 *ps_bridge,
>  	ret = i2c_smbus_write_i2c_block_data(client, PAGE3_SET_ADD,
>  					     sizeof(vdo_ctrl_buf),
>  					     vdo_ctrl_buf);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		DRM_ERROR("failed to %sable VDO: %d\n",
> +			  ctrl == ENABLE ? "en" : "dis", ret);
>  		return ret;
> +	}
>  
>  	return 0;
>  }
> @@ -150,10 +153,8 @@ static void ps8640_pre_enable(struct drm_bridge *bridge)
>  	}
>  
>  	ret = ps8640_bridge_vdo_control(ps_bridge, ENABLE);
> -	if (ret) {
> -		DRM_ERROR("failed to enable VDO: %d\n", ret);
> +	if (ret)
>  		goto err_regulators_disable;
> -	}
>  
>  	/* Switch access edp panel's edid through i2c */
>  	ret = i2c_smbus_write_byte_data(client, PAGE2_I2C_BYPASS,
> @@ -175,9 +176,7 @@ static void ps8640_post_disable(struct drm_bridge *bridge)
>  	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
>  	int ret;
>  
> -	ret = ps8640_bridge_vdo_control(ps_bridge, DISABLE);
> -	if (ret < 0)
> -		DRM_ERROR("failed to disable VDO: %d\n", ret);
> +	ps8640_bridge_vdo_control(ps_bridge, DISABLE);
>  
>  	gpiod_set_value(ps_bridge->gpio_reset, 1);
>  	gpiod_set_value(ps_bridge->gpio_powerdown, 1);
> -- 
> 2.27.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
