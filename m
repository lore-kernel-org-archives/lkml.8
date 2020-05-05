Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BECBC47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17ED20658
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HySaDe4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgEEIdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 04:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgEEIda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 04:33:30 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21915C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 01:33:30 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r26so1320326wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 01:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F/CJ5NUrRqyL+rMld/C9MVsOTa09vTP6RI4wKJqKWvU=;
        b=HySaDe4VCFfiAe5l8/lVNdscI4BHTkHOPM182GN5IKJ5Yx2z0UZnLJfUgWjMW/s+Id
         hkNuKbJkyWykEIuVozJhcTDSxDueSZkVZMQf/gDdIE3GDvF/khkANZwiaqMNNrzHhJZs
         jzTYqBt+LqEpc2oEJ66KD7Xoyewb29mp/AVbzLpgTTdpoUM15qdw8dvQvgUrSBSdi3eK
         De673jweYJs0LsumAQxqFDtn1GOfIYO+1CP6S1OaimRGJiMIaEHgakWfeRPoecWrtcg+
         pKEX0c02XEs/I3vDMM6iXR7yhHAqeJ5xkpFr6dNFuWdF+lbDoLAK80exh/b4BGFXhsRO
         7pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=F/CJ5NUrRqyL+rMld/C9MVsOTa09vTP6RI4wKJqKWvU=;
        b=jYu28NfDOBOa3cBty3Ob2MeozeTM317IESyu9KXkvz6ZBNZKgcMNeSlv8NIShpQtgS
         l1X7QmXWWPgB4LEQEWAzaT7kHqRwvy64Yg1Y5iGTiPahfTtxg1l76yZ33ueMRb3IKnEA
         FrXyH5n3rw4V9ggVfbcXnAIQF6pvte0MrYHr6EZUDGAAC4NabgzrQbT34ql8Og8sAcMl
         Sn6haBvv2neDqjUyZL3+ETj+YTpIYKwP8+hsH0P1MGG4DdzuYqpQvJervk+R8u5pqqnk
         GA//0G41+p+i4iT03UeBxOwok0Z4ZWg7cVX7XqMkuT0/FuRzWJQq5BNFFrcyrmCYApJd
         fQDw==
X-Gm-Message-State: AGi0PuYU55hGKxjgIpnuLlXJxStSFBqg1QH5W4dKOcF8TgR9kT96fLmi
        ovETy1tTX80aGVpIPtSCzZOjXA==
X-Google-Smtp-Source: APiQypIoL4KhPpubj8k69d1POQqvRyhDdGK1vs/uCmnz77yT9TZFAM4unDd0jhD6wzsztQCSt6A4KA==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr2140930wme.5.1588667608581;
        Tue, 05 May 2020 01:33:28 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:4460:3fd3:382:4a71? ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id i25sm2526213wml.43.2020.05.05.01.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 01:33:27 -0700 (PDT)
Subject: Re: [PATCH v2] drm/meson: add mode selection limits against specific
 SoC revisions
To:     dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com
References: <20200428092147.13698-1-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <aef62be6-8167-a920-38cf-fd4f6da31edc@baylibre.com>
Date:   Tue, 5 May 2020 10:33:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200428092147.13698-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2020 11:21, Neil Armstrong wrote:
> The Amlogic S805X/Y uses the same die as the S905X, but with more
> limited graphics capabilities.
> 
> This adds a soc version detection adding specific limitations on the HDMI
> mode selections.
> 
> Here, we limit to HDMI 1.3a max HDMI PHY clock frequency.
> 
> Changes sinces v1:
> - Moved frequency check in the vclk code, and also checks DMT modes
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_drv.c     | 29 ++++++++++++++++++++++++++-
>  drivers/gpu/drm/meson/meson_drv.h     |  6 ++++++
>  drivers/gpu/drm/meson/meson_dw_hdmi.c |  2 +-
>  drivers/gpu/drm/meson/meson_vclk.c    | 16 ++++++++++++++-
>  drivers/gpu/drm/meson/meson_vclk.h    |  3 ++-
>  5 files changed, 52 insertions(+), 4 deletions(-)
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
> index e8c94915a4fc..5be963e9db05 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -695,7 +695,7 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
>  	dev_dbg(connector->dev->dev, "%s: vclk:%d phy=%d venc=%d hdmi=%d\n",
>  		__func__, phy_freq, vclk_freq, venc_freq, hdmi_freq);
>  
> -	return meson_vclk_vic_supported_freq(phy_freq, vclk_freq);
> +	return meson_vclk_vic_supported_freq(priv, phy_freq, vclk_freq);
>  }
>  
>  /* Encoder */
> diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
> index fdf26dac9fa8..0eb86943a358 100644
> --- a/drivers/gpu/drm/meson/meson_vclk.c
> +++ b/drivers/gpu/drm/meson/meson_vclk.c
> @@ -725,6 +725,13 @@ meson_vclk_dmt_supported_freq(struct meson_drm *priv, unsigned int freq)
>  	/* In DMT mode, path after PLL is always /10 */
>  	freq *= 10;
>  
> +	/* Check against soc revision/package limits */
> +	if (priv->limits) {
> +		if (priv->limits->max_hdmi_phy_freq &&
> +		    freq > priv->limits->max_hdmi_phy_freq)
> +			return MODE_CLOCK_HIGH;
> +	}
> +
>  	if (meson_hdmi_pll_find_params(priv, freq, &m, &frac, &od))
>  		return MODE_OK;
>  
> @@ -762,7 +769,7 @@ static void meson_hdmi_pll_generic_set(struct meson_drm *priv,
>  }
>  
>  enum drm_mode_status
> -meson_vclk_vic_supported_freq(unsigned int phy_freq,
> +meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
>  			      unsigned int vclk_freq)
>  {
>  	int i;
> @@ -770,6 +777,13 @@ meson_vclk_vic_supported_freq(unsigned int phy_freq,
>  	DRM_DEBUG_DRIVER("phy_freq = %d vclk_freq = %d\n",
>  			 phy_freq, vclk_freq);
>  
> +	/* Check against soc revision/package limits */
> +	if (priv->limits) {
> +		if (priv->limits->max_hdmi_phy_freq &&
> +		    phy_freq > priv->limits->max_hdmi_phy_freq)
> +			return MODE_CLOCK_HIGH;
> +	}
> +
>  	for (i = 0 ; params[i].pixel_freq ; ++i) {
>  		DRM_DEBUG_DRIVER("i = %d pixel_freq = %d alt = %d\n",
>  				 i, params[i].pixel_freq,
> diff --git a/drivers/gpu/drm/meson/meson_vclk.h b/drivers/gpu/drm/meson/meson_vclk.h
> index aed0ab2efa71..60617aaf18dd 100644
> --- a/drivers/gpu/drm/meson/meson_vclk.h
> +++ b/drivers/gpu/drm/meson/meson_vclk.h
> @@ -25,7 +25,8 @@ enum {
>  enum drm_mode_status
>  meson_vclk_dmt_supported_freq(struct meson_drm *priv, unsigned int freq);
>  enum drm_mode_status
> -meson_vclk_vic_supported_freq(unsigned int phy_freq, unsigned int vclk_freq);
> +meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
> +			      unsigned int vclk_freq);
>  
>  void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
>  		      unsigned int phy_freq, unsigned int vclk_freq,
> 

Applied to drm-misc-next with commit log fixup
