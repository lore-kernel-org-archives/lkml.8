Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8973C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF422080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbVWGfyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgHZMpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbgHZMpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:45:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86757C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 05:45:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b18so1662480wrs.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 05:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A+hzTqkFrfNBkiR/rvkXbcN3IkiaGHhlF+bCukUizmc=;
        b=dbVWGfycJceXjQfrYixZwVEtvmxS5R/1rhN1PXiVpdT3TqkG/qmCGhipTD9vd3Qdt4
         QNE9F9OcwhAfjXVvUJv4YhhnMAYmmcXQTks2T+y91ZNsmHLl2szhOHElmCWpQaM7c8QK
         +3JM+aZN5KXXyRB5W+aBVpQQ6kIhiMsR1E0bI0T++AWigtOAEVArjhN0k7IFtMgTidzT
         4nQdCjvnVL/ScIXkNIi+bpOl067uQfsCfPLbxo+y1pIiGhjTWdFLakUT/+hmBZW6fabr
         9yK7Iq771/Gz2rUOVL37ywse8QLWmTmOAgx3AGFTNy2ViyispOgIcBLZab5e/1B2alQc
         kwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A+hzTqkFrfNBkiR/rvkXbcN3IkiaGHhlF+bCukUizmc=;
        b=CzmrYyyLZJ3L0g/jHHBPVD8R1TGg2UBnPZJ4iQUoZUWy/J2l9M3PADytx4C7aXLSjY
         0Ef3BguJHINvvTHYOF67fMbKecu8zxy69T/MhtMKMUf2nzkWdHC9AosSyH2QPUkbLx0d
         8aya4S7uEYDvV/FgvX3RfN2ZkiS7X992JVsrHUx7oaBW9sVoSc9a2SGnb8DqJRbm7uY+
         3ImHzFS3iFhcZ6Y8p7SNfN3cNYiFdKnnBmu9ZA89A3yzWxnMbsnAlwhWwZaDbu/JfUJe
         Xopr+k/lwfn9mJTRyEOToSWfYXM0LKlhMi+i21UEhrSAbu5RwPpPp0GRbf147yp+UCxk
         M//g==
X-Gm-Message-State: AOAM530/1+ynu+AO6VdytdqJo0t4PYRqdzGe8Jw3flsXs5HDnK9Z10Fo
        DM1Uub8gR77MVc7VyrHExno=
X-Google-Smtp-Source: ABdhPJyY6K+/hTlXaz+/ytiMdj2yfOTYMMtVX7sOApplvhHJ10lJyCh3Wsiub7OgzbKIv+8SMwivpw==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr15158232wrw.169.1598445945139;
        Wed, 26 Aug 2020 05:45:45 -0700 (PDT)
Received: from a-VirtualBox ([103.120.71.253])
        by smtp.gmail.com with ESMTPSA id u7sm5642591wmb.16.2020.08.26.05.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 05:45:44 -0700 (PDT)
Date:   Wed, 26 Aug 2020 17:45:40 +0500
From:   Bilal Wasim <bwasim.lkml@gmail.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        laurent.pinchart@ideasonboard.com, sam@ravnborg.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 4/5] drm/bridge: ps8640: Print an error if VDO
 control fails
Message-ID: <20200826174540.19813147@a-VirtualBox>
In-Reply-To: <20200826081526.674866-5-enric.balletbo@collabora.com>
References: <20200826081526.674866-1-enric.balletbo@collabora.com>
        <20200826081526.674866-5-enric.balletbo@collabora.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 10:15:25 +0200
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Print an error message inside ps8640_bridge_vdo_control() function
> when it fails so we can simplify a bit the callers, they will only
> need to check the error code.
> 
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/gpu/drm/bridge/parade-ps8640.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c
> b/drivers/gpu/drm/bridge/parade-ps8640.c index
> ce3e8b2da8c9..9f7b7a9c53c5 100644 ---
> a/drivers/gpu/drm/bridge/parade-ps8640.c +++
> b/drivers/gpu/drm/bridge/parade-ps8640.c @@ -82,8 +82,11 @@ static
> int ps8640_bridge_vdo_control(struct ps8640 *ps_bridge, ret =
> i2c_smbus_write_i2c_block_data(client, PAGE3_SET_ADD,
> sizeof(vdo_ctrl_buf), vdo_ctrl_buf);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		DRM_ERROR("failed to %sable VDO: %d\n",
> +			  ctrl == ENABLE ? "en" : "dis", ret);
>  		return ret;
> +	}
>  
>  	return 0;
>  }
> @@ -150,10 +153,8 @@ static void ps8640_pre_enable(struct drm_bridge
> *bridge) }
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
> @@ -175,9 +176,7 @@ static void ps8640_post_disable(struct drm_bridge
> *bridge) struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
>  	int ret;
>  
> -	ret = ps8640_bridge_vdo_control(ps_bridge, DISABLE);
> -	if (ret < 0)
> -		DRM_ERROR("failed to disable VDO: %d\n", ret);
> +	ps8640_bridge_vdo_control(ps_bridge, DISABLE);
>  
>  	gpiod_set_value(ps_bridge->gpio_reset, 1);
>  	gpiod_set_value(ps_bridge->gpio_powerdown, 1);

Reviewed-by: Bilal Wasim <bwasim.lkml@gmail.com>
Tested-by: Bilal Wasim <bwasim.lkml@gmail.com>

-Bilal
