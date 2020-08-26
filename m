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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0067C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7974120707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7pGtrPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgHZNE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730089AbgHZNEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:04:21 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B41FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:04:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so1729356wrl.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F10w2XhjBVUdZ8vWkFZQTROpFgAsaJXU0xiSNlZtOt0=;
        b=Q7pGtrPk8+Xv1pW37QcfUEFQVNWtRmtwZMnWmOT2iCTafBxu4w57J9PjnTS5moUALN
         EUVRe7q1jC3ZwpKMBxeM541vpp8/IjlsGbADICOssGoRfyEl06WpksvDU/7DWpxxn2SO
         XDI0e2zuCrvjwQhHqzSmlIII9AbHimfzMMdrlGNPO/4xmCYp9kEzTDKDJVE8DoDMtOOu
         cYUFkmmYCShjNnzEMe4+CGQorZBF4NDJPKkdUZ3K9JFBec35wH+B8CkUDQQeo7PSYRak
         NZ/Zj8sdtgBCbVb/DNYKV6FckHiKH5MfYmN875XmBMrhfHm7XjkSm703KLV3TbXOr5U8
         ZetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F10w2XhjBVUdZ8vWkFZQTROpFgAsaJXU0xiSNlZtOt0=;
        b=eQdkts2CnSLBl3CQ9GJDf+h4jsfc4er2mhiCd0sBSOFHoIII1vhYwJJ4M3KSvLc3T9
         74veAIpcwMcziPdjltRQxXpySGQp9B+OtwtO6O4LX0XTSwy7JOI4Mci4hOCUVlQl9eFs
         rVOtd1s2cNv1587WxfmF+vJPRFgx66B1k3yNImZ5HYiMgVuj2kMHUKql7ayjkijGQRDa
         XVDithbhgqV7wa/hWT7VoXuUaje/AU8X6Ym+FVn3aF7Ob2AdSHAS3gxdUEkfgq5VIVZG
         Jku1BKmAuDs2vUS/th1WdxHcAXl4Ea8ixDtc7NISFB4OZQOhchXGoBZOnM1ZxE90G2i/
         z/ag==
X-Gm-Message-State: AOAM53168VBzqWukfFJ6HGAwZjjUtCk/8aQgE0ZefxLdttq8hhvX81up
        mYbjqC5RJYJx1uGcb1RnYNE=
X-Google-Smtp-Source: ABdhPJyZKeSWVQI28YaVXzk4ZoW1ozMFV7n3t8LT/mzotKOK5v+kqK0gwXaTe6G3cfY6FmIcLoVtnw==
X-Received: by 2002:a5d:4701:: with SMTP id y1mr16102985wrq.416.1598447059930;
        Wed, 26 Aug 2020 06:04:19 -0700 (PDT)
Received: from a-VirtualBox ([103.120.71.253])
        by smtp.gmail.com with ESMTPSA id g7sm5706889wrv.82.2020.08.26.06.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 06:04:19 -0700 (PDT)
Date:   Wed, 26 Aug 2020 18:04:14 +0500
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
Subject: Re: [PATCH v2 5/5] drm/bridge: ps8640: Rework power state handling
Message-ID: <20200826180414.0ad28811@a-VirtualBox>
In-Reply-To: <20200826081526.674866-6-enric.balletbo@collabora.com>
References: <20200826081526.674866-1-enric.balletbo@collabora.com>
        <20200826081526.674866-6-enric.balletbo@collabora.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 10:15:26 +0200
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> The get_edid() callback can be triggered anytime by an ioctl, i.e
> 
>   drm_mode_getconnector (ioctl)
>     -> drm_helper_probe_single_connector_modes
>        -> drm_bridge_connector_get_modes
>           -> ps8640_bridge_get_edid  
> 
> Actually if the bridge pre_enable() function was not called before
> get_edid(), the driver will not be able to get the EDID properly and
> display will not work until a second get_edid() call is issued and if
> pre_enable() is called before. The side effect of this, for example,
> is that you see anything when `Frecon` starts, neither the splash
> screen, until the graphical session manager starts.
> 
> To fix this we need to make sure that all we need is enabled before
> reading the EDID. This means the following:
> 
> 1. If get_edid() is called before having the device powered we need to
>    power on the device. In such case, the driver will power off again
> the device.
> 
> 2. If get_edid() is called after having the device powered, all should
>    just work. We added a powered flag in order to avoid recurrent
> calls to ps8640_bridge_poweron() and unneeded delays.
> 
> 3. This seems to be specific for this device, but we need to make sure
>    the panel is powered on before do a power on cycle on this device.
>    Otherwise the device fails to retrieve the EDID.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2:
> - Use drm_bridge_chain_pre_enable/post_disable() helpers (Sam
> Ravnborg)
> 
>  drivers/gpu/drm/bridge/parade-ps8640.c | 64
> +++++++++++++++++++++++--- 1 file changed, 58 insertions(+), 6
> deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c
> b/drivers/gpu/drm/bridge/parade-ps8640.c index
> 9f7b7a9c53c5..c5d76e209bda 100644 ---
> a/drivers/gpu/drm/bridge/parade-ps8640.c +++
> b/drivers/gpu/drm/bridge/parade-ps8640.c @@ -65,6 +65,7 @@ struct
> ps8640 { struct regulator_bulk_data supplies[2];
>  	struct gpio_desc *gpio_reset;
>  	struct gpio_desc *gpio_powerdown;
> +	bool powered;
>  };
>  
>  static inline struct ps8640 *bridge_to_ps8640(struct drm_bridge *e)
> @@ -91,13 +92,15 @@ static int ps8640_bridge_vdo_control(struct
> ps8640 *ps_bridge, return 0;
>  }
>  
> -static void ps8640_pre_enable(struct drm_bridge *bridge)
> +static void ps8640_bridge_poweron(struct ps8640 *ps_bridge)
>  {
> -	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
>  	struct i2c_client *client = ps_bridge->page[PAGE2_TOP_CNTL];
>  	unsigned long timeout;
>  	int ret, status;
>  
> +	if (ps_bridge->powered)
> +		return;
> +
>  	ret = regulator_bulk_enable(ARRAY_SIZE(ps_bridge->supplies),
>  				    ps_bridge->supplies);
>  	if (ret < 0) {
> @@ -164,6 +167,8 @@ static void ps8640_pre_enable(struct drm_bridge
> *bridge) goto err_regulators_disable;
>  	}
>  
> +	ps_bridge->powered = true;
> +
>  	return;
>  
>  err_regulators_disable:
> @@ -171,12 +176,12 @@ static void ps8640_pre_enable(struct drm_bridge
> *bridge) ps_bridge->supplies);
>  }
>  
> -static void ps8640_post_disable(struct drm_bridge *bridge)
> +static void ps8640_bridge_poweroff(struct ps8640 *ps_bridge)
>  {
> -	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
>  	int ret;
>  
> -	ps8640_bridge_vdo_control(ps_bridge, DISABLE);
> +	if (!ps_bridge->powered)
> +		return;
>  
>  	gpiod_set_value(ps_bridge->gpio_reset, 1);
>  	gpiod_set_value(ps_bridge->gpio_powerdown, 1);
> @@ -184,6 +189,28 @@ static void ps8640_post_disable(struct
> drm_bridge *bridge) ps_bridge->supplies);
>  	if (ret < 0)
>  		DRM_ERROR("cannot disable regulators %d\n", ret);
> +
> +	ps_bridge->powered = false;
> +}
> +
> +static void ps8640_pre_enable(struct drm_bridge *bridge)
> +{
> +	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
> +	int ret;
> +
> +	ps8640_bridge_poweron(ps_bridge);
> +
> +	ret = ps8640_bridge_vdo_control(ps_bridge, DISABLE);
> +	if (ret < 0)
> +		ps8640_bridge_poweroff(ps_bridge);
> +}
> +
> +static void ps8640_post_disable(struct drm_bridge *bridge)
> +{
> +	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
> +
> +	ps8640_bridge_vdo_control(ps_bridge, DISABLE);
> +	ps8640_bridge_poweroff(ps_bridge);
>  }
>  
>  static int ps8640_bridge_attach(struct drm_bridge *bridge,
> @@ -249,9 +276,34 @@ static struct edid
> *ps8640_bridge_get_edid(struct drm_bridge *bridge, struct
> drm_connector *connector) {
>  	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
> +	bool poweroff = !ps_bridge->powered;
> +	struct edid *edid;
> +
> +	/*
> +	 * When we end calling get_edid() triggered by an ioctl, i.e
> +	 *
> +	 *   drm_mode_getconnector (ioctl)
> +	 *     -> drm_helper_probe_single_connector_modes
> +	 *        -> drm_bridge_connector_get_modes
> +	 *           -> ps8640_bridge_get_edid
> +	 *
> +	 * We need to make sure that what we need is enabled before
> reading
> +	 * EDID, for this chip, we need to do a full poweron,
> otherwise it will
> +	 * fail.
> +	 */
> +	drm_bridge_chain_pre_enable(bridge);

Is it safe for a bridge driver to enable power to other devices in the
bridge? Seems somewhat counter-intuitive, though I understand that the
complete chain needs to be enabled before getting EDID in this case.
Can we consider a more generic solution where the DRM stack enables the
bridge-chain before invoking calls to get EDID based on a DT-binding or
Kconfig option?

Also shouldn't the call to pre_enable be followed by a call to
"drm_bridge_chain_enable"? Similarly we should do both
drm_bridge_chain_post_disable / *_disable when
powering the chips off, right?

>  
> -	return drm_get_edid(connector,
> +	edid = drm_get_edid(connector,
>  			    ps_bridge->page[PAGE0_DP_CNTL]->adapter);
> +
> +	/*
> +	 * If we call the get_edid() function without having enabled
> the chip
> +	 * before, return the chip to its original power state.
> +	 */
> +	if (poweroff)
> +		drm_bridge_chain_post_disable(bridge);
> +
> +	return edid;
>  }
>  
>  static const struct drm_bridge_funcs ps8640_bridge_funcs = {

-Bilal
