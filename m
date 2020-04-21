Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49044C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21DD52071E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Cje0RUyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgDUN7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728745AbgDUN7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:59:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADC6C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:59:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e26so3664548wmk.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=GFhVcwNkH19cbR+cE1ypfH56nXaAVZCLec2xJqB4kFg=;
        b=Cje0RUyUW8yZe79iZsor+8dzm23NXNZJ6S9VH8UVO9QRfVvhQ3rggw5tCYa3jMeE7p
         3qJjIF8mqBY9qgK1Htwamf5L8vvpm7FUqIK8p1ZB11DdtpdZ3YeJxD5P999SiexzhLNA
         P3E77WgVZvTJGej9UVAmIT7dFemOmy5x3SZ20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=GFhVcwNkH19cbR+cE1ypfH56nXaAVZCLec2xJqB4kFg=;
        b=G/Z1o26KnaFjZgZr5hPcADsNsN7YafpqAMnFXHSuxy4T4aCXdFspxiagNhxtd6LYFy
         TTot7q65Kd4adG2LCBXHFOJhkZBiiTcr7KHzMvoCplWHzdsbrbrdIYH5nRmJ4KV11GqZ
         iWsAm93ZiP45jQO8xeEUtVlWy8xwl0plvQ7GigFvkXRO/UsKYdIBGFstxOwG79FTNQTV
         yMlI0IV2i5vLUhU6v1pXAaasfE1k6HJrsEqD4O6CSyvUgjg4CEMDe+rxOMra7G+vMnXP
         /2izwmi2lPf0pHiz2KBamMYCmo2HveOM021pF9y5S6r4qrGVDxHhyFZkRe2jvKAeq85d
         KR5A==
X-Gm-Message-State: AGi0PuahjyX8UCwecqvjGc/j1vDXt0sdi4nrjwnZCse/2J5/tl7BFiIt
        xjuKJCmQusxRQGwapUXSn3k84g==
X-Google-Smtp-Source: APiQypIThebpIsiA00RlINe3F/bJOmBXZSBWSdmsF3bQaYRTVrY4O3DozqrT76sEJG1Uw2UhgdLnBA==
X-Received: by 2002:a7b:cdfa:: with SMTP id p26mr5000192wmj.186.1587477550341;
        Tue, 21 Apr 2020 06:59:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d5sm3863822wrp.44.2020.04.21.06.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:59:09 -0700 (PDT)
Date:   Tue, 21 Apr 2020 15:59:07 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/meson: add mode selection limits against specific
 SoC revisions
Message-ID: <20200421135907.GC3456981@phenom.ffwll.local>
Mail-Followup-To: Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200421134410.30603-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421134410.30603-1-narmstrong@baylibre.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 03:44:10PM +0200, Neil Armstrong wrote:
> The Amlogic S805X/Y uses the same die as the S905X, but with more
> limited graphics capabilities.
> 
> This adds a soc version detection adding specific limitations on the HDMI
> mode selections.
> 
> Here, we limit to HDMI 1.3a max HDMI PHY clock frequency.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Just a drive-by, but the code organization between the dw-hdmi bridge and
the driver looks pretty terribly and really leaky. Can't we do better?
Either by fixing the dw-hdmi bridge abstraction to actually abstract
something, or by givin up the dw-hdmi is a bridge and convert it to some
helper to implement a drm_encoder. Current status just doesn't make too
much sense to me.
-Daniel

> ---
>  drivers/gpu/drm/meson/meson_drv.c     | 29 ++++++++++++++++++++++++++-
>  drivers/gpu/drm/meson/meson_drv.h     |  6 ++++++
>  drivers/gpu/drm/meson/meson_dw_hdmi.c |  7 +++++++
>  3 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index 6f29fab79952..621f6de0f076 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -11,6 +11,7 @@
>  #include <linux/component.h>
>  #include <linux/module.h>
>  #include <linux/of_graph.h>
> +#include <linux/sys_soc.h>
>  #include <linux/platform_device.h>
>  #include <linux/soc/amlogic/meson-canvas.h>
>  
> @@ -183,6 +184,24 @@ static void meson_remove_framebuffers(void)
>  	kfree(ap);
>  }
>  
> +struct meson_drm_soc_attr {
> +	struct meson_drm_soc_limits limits;
> +	const struct soc_device_attribute *attrs;
> +};
> +
> +static const struct meson_drm_soc_attr meson_drm_soc_attrs[] = {
> +	/* S805X/S805Y HDMI PLL won't lock for HDMI PHY freq > 1,65GHz */
> +	{
> +		.limits = {
> +			.max_hdmi_phy_freq = 1650000,
> +		},
> +		.attrs = (const struct soc_device_attribute []) {
> +			{ .soc_id = "GXL (S805*)", },
> +			{ /* sentinel */ },
> +		}
> +	},
> +};
> +
>  static int meson_drv_bind_master(struct device *dev, bool has_components)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> @@ -191,7 +210,7 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  	struct drm_device *drm;
>  	struct resource *res;
>  	void __iomem *regs;
> -	int ret;
> +	int ret, i;
>  
>  	/* Checks if an output connector is available */
>  	if (!meson_vpu_has_available_connectors(dev)) {
> @@ -281,6 +300,14 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  	if (ret)
>  		goto free_drm;
>  
> +	/* Assign limits per soc revision/package */
> +	for (i = 0 ; i < ARRAY_SIZE(meson_drm_soc_attrs) ; ++i) {
> +		if (soc_device_match(meson_drm_soc_attrs[i].attrs)) {
> +			priv->limits = &meson_drm_soc_attrs[i].limits;
> +			break;
> +		}
> +	}
> +
>  	/* Remove early framebuffers (ie. simplefb) */
>  	meson_remove_framebuffers();
>  
> diff --git a/drivers/gpu/drm/meson/meson_drv.h b/drivers/gpu/drm/meson/meson_drv.h
> index 04fdf3826643..5b23704a80d6 100644
> --- a/drivers/gpu/drm/meson/meson_drv.h
> +++ b/drivers/gpu/drm/meson/meson_drv.h
> @@ -30,6 +30,10 @@ struct meson_drm_match_data {
>  	struct meson_afbcd_ops *afbcd_ops;
>  };
>  
> +struct meson_drm_soc_limits {
> +	unsigned int max_hdmi_phy_freq;
> +};
> +
>  struct meson_drm {
>  	struct device *dev;
>  	enum vpu_compatible compat;
> @@ -48,6 +52,8 @@ struct meson_drm {
>  	struct drm_plane *primary_plane;
>  	struct drm_plane *overlay_plane;
>  
> +	const struct meson_drm_soc_limits *limits;
> +
>  	/* Components Data */
>  	struct {
>  		bool osd1_enabled;
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index e8c94915a4fc..dc3d5122475a 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -695,6 +695,13 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
>  	dev_dbg(connector->dev->dev, "%s: vclk:%d phy=%d venc=%d hdmi=%d\n",
>  		__func__, phy_freq, vclk_freq, venc_freq, hdmi_freq);
>  
> +	/* Check against soc revision/package limits */
> +	if (priv->limits) {
> +		if (priv->limits->max_hdmi_phy_freq &&
> +		    phy_freq > priv->limits->max_hdmi_phy_freq)
> +			return MODE_CLOCK_HIGH;
> +	}
> +
>  	return meson_vclk_vic_supported_freq(phy_freq, vclk_freq);
>  }
>  
> -- 
> 2.22.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
