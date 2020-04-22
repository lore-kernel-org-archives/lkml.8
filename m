Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3929C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB0D1206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="l+ynLYuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgDVBT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 21:19:27 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:52814 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgDVBT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 21:19:27 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9C654528;
        Wed, 22 Apr 2020 03:19:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1587518363;
        bh=aQO8hkVW8AJTCkqFbuUp2DC5MDJLF/Iapewa2JgbC14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l+ynLYufNvpR4APTfTo+rsAjA5Q3vWXC/0gkTghRxNOkHvNnyUeAr6+rnMWAAOMs8
         btnasNQsjHHGD8qsRE8gRmVQ/see5aInyonQC8nfKDc9kevLsbSRcbGEnvmEQHkJqe
         pdoD50nOtIpGvJUM80xwkIFb6LoH6XNXq3GXMVyk=
Date:   Wed, 22 Apr 2020 04:19:10 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH] drm: imx: Unify encoder creation
Message-ID: <20200422011910.GO5983@pendragon.ideasonboard.com>
References: <20200420100222.1308898-1-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200420100222.1308898-1-adrian.ratiu@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Thank you for the patch.

On Mon, Apr 20, 2020 at 01:02:22PM +0300, Adrian Ratiu wrote:
> imx drivers don't require drm encoders and they all had empty/no-op
> implementations which got converted to simple objects to pacify the
> drm core which still requires something to be defined.
> 
> The problem now is that each driver duplicates the same encoder
> initialization logic and I'm working on adding yet-another driver
> (for imx6 mipi-dsi), so instead of copy-pasting the initialization
> let's move it from the drivers to a shared function in imx-drm-core.

This is one step in the right direction, but only a first small step:
what really needs to be done is to move the calls to
imx_drm_create_encoder() into the i.MX display controller driver core.
This requires turning the ldb, tve and hdmi encoders into drm_bridges.
Parallel display is already architectured in the right way, you can have
a look at it to see how to proceed. I recommend addressing ldb and tve
first, what you need to remove from them through conversion to
drm_bridge is the drm_encoder_helper_funcs.

> The imx_drm_encoder_parse_of() logic is made part of the newly added
> imx_drm_create_encoder() which was its only caller after the move to
> imx-drm-core.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Suggested-by: Enric Balletbo Serra <eballetbo@gmail.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  drivers/gpu/drm/imx/dw_hdmi-imx.c      | 18 ++++++------------
>  drivers/gpu/drm/imx/imx-drm-core.c     | 13 ++++++++++---
>  drivers/gpu/drm/imx/imx-drm.h          |  2 +-
>  drivers/gpu/drm/imx/imx-ldb.c          |  8 ++++----
>  drivers/gpu/drm/imx/imx-tve.c          |  8 ++++----
>  drivers/gpu/drm/imx/parallel-display.c | 11 +++++------
>  6 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/imx/dw_hdmi-imx.c b/drivers/gpu/drm/imx/dw_hdmi-imx.c
> index ba4ca17fd4d8..a710e3d576b4 100644
> --- a/drivers/gpu/drm/imx/dw_hdmi-imx.c
> +++ b/drivers/gpu/drm/imx/dw_hdmi-imx.c
> @@ -18,7 +18,6 @@
>  #include <drm/drm_edid.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_of.h>
> -#include <drm/drm_simple_kms_helper.h>
>  
>  #include "imx-drm.h"
>  
> @@ -218,22 +217,17 @@ static int dw_hdmi_imx_bind(struct device *dev, struct device *master,
>  	hdmi->dev = &pdev->dev;
>  	encoder = &hdmi->encoder;
>  
> -	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
> -	/*
> -	 * If we failed to find the CRTC(s) which this encoder is
> -	 * supposed to be connected to, it's because the CRTC has
> -	 * not been registered yet.  Defer probing, and hope that
> -	 * the required CRTC is added later.
> -	 */
> -	if (encoder->possible_crtcs == 0)
> -		return -EPROBE_DEFER;
> -
>  	ret = dw_hdmi_imx_parse_dt(hdmi);
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = imx_drm_create_encoder(drm, encoder, dev->of_node);
> +	if (ret) {
> +		dev_err(dev, "Failed to create drm encoder\n");
> +		return ret;
> +	}
> +
>  	drm_encoder_helper_add(encoder, &dw_hdmi_imx_encoder_helper_funcs);
> -	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
>  
>  	platform_set_drvdata(pdev, hdmi);
>  
> diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
> index 2e38f1a5cf8d..eaf087ed354f 100644
> --- a/drivers/gpu/drm/imx/imx-drm-core.c
> +++ b/drivers/gpu/drm/imx/imx-drm-core.c
> @@ -23,6 +23,7 @@
>  #include <drm/drm_of.h>
>  #include <drm/drm_plane_helper.h>
>  #include <drm/drm_probe_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
>  #include <drm/drm_vblank.h>
>  
>  #include "imx-drm.h"
> @@ -116,11 +117,11 @@ static const struct drm_mode_config_helper_funcs imx_drm_mode_config_helpers = {
>  	.atomic_commit_tail = imx_drm_atomic_commit_tail,
>  };
>  
> -
> -int imx_drm_encoder_parse_of(struct drm_device *drm,
> +int imx_drm_create_encoder(struct drm_device *drm,
>  	struct drm_encoder *encoder, struct device_node *np)
>  {
>  	uint32_t crtc_mask = drm_of_find_possible_crtcs(drm, np);
> +	int ret;
>  
>  	/*
>  	 * If we failed to find the CRTC(s) which this encoder is
> @@ -136,9 +137,15 @@ int imx_drm_encoder_parse_of(struct drm_device *drm,
>  	/* FIXME: cloning support not clear, disable it all for now */
>  	encoder->possible_clones = 0;
>  
> +	ret = drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_NONE);
> +	if (ret) {
> +		DRM_ERROR("Failed to initialize simple drm encoder\n");
> +		return ret;
> +	}
> +
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(imx_drm_encoder_parse_of);
> +EXPORT_SYMBOL_GPL(imx_drm_create_encoder);
>  
>  static const struct drm_ioctl_desc imx_drm_ioctls[] = {
>  	/* none so far */
> diff --git a/drivers/gpu/drm/imx/imx-drm.h b/drivers/gpu/drm/imx/imx-drm.h
> index c3e1a3f14d30..8573a668a5f5 100644
> --- a/drivers/gpu/drm/imx/imx-drm.h
> +++ b/drivers/gpu/drm/imx/imx-drm.h
> @@ -34,7 +34,7 @@ void imx_drm_mode_config_init(struct drm_device *drm);
>  
>  struct drm_gem_cma_object *imx_drm_fb_get_obj(struct drm_framebuffer *fb);
>  
> -int imx_drm_encoder_parse_of(struct drm_device *drm,
> +int imx_drm_create_encoder(struct drm_device *drm,
>  	struct drm_encoder *encoder, struct device_node *np);
>  
>  void imx_drm_connector_destroy(struct drm_connector *connector);
> diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
> index 66ea68e8da87..a37fa325a8c3 100644
> --- a/drivers/gpu/drm/imx/imx-ldb.c
> +++ b/drivers/gpu/drm/imx/imx-ldb.c
> @@ -26,7 +26,6 @@
>  #include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
>  
>  #include "imx-drm.h"
>  
> @@ -423,9 +422,11 @@ static int imx_ldb_register(struct drm_device *drm,
>  	struct drm_encoder *encoder = &imx_ldb_ch->encoder;
>  	int ret;
>  
> -	ret = imx_drm_encoder_parse_of(drm, encoder, imx_ldb_ch->child);
> -	if (ret)
> +	ret = imx_drm_create_encoder(drm, encoder, imx_ldb_ch->child);
> +	if (ret) {
> +		dev_err(ldb->dev, "Failed to create drm encoder\n");
>  		return ret;
> +	}
>  
>  	ret = imx_ldb_get_clk(ldb, imx_ldb_ch->chno);
>  	if (ret)
> @@ -438,7 +439,6 @@ static int imx_ldb_register(struct drm_device *drm,
>  	}
>  
>  	drm_encoder_helper_add(encoder, &imx_ldb_encoder_helper_funcs);
> -	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_LVDS);
>  
>  	if (imx_ldb_ch->bridge) {
>  		ret = drm_bridge_attach(&imx_ldb_ch->encoder,
> diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
> index ee63782c77e9..2d88aca0f7e7 100644
> --- a/drivers/gpu/drm/imx/imx-tve.c
> +++ b/drivers/gpu/drm/imx/imx-tve.c
> @@ -21,7 +21,6 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
>  
>  #include "imx-drm.h"
>  
> @@ -471,12 +470,13 @@ static int imx_tve_register(struct drm_device *drm, struct imx_tve *tve)
>  	encoder_type = tve->mode == TVE_MODE_VGA ?
>  				DRM_MODE_ENCODER_DAC : DRM_MODE_ENCODER_TVDAC;
>  
> -	ret = imx_drm_encoder_parse_of(drm, &tve->encoder, tve->dev->of_node);
> -	if (ret)
> +	ret = imx_drm_create_encoder(drm, &tve->encoder, tve->dev->of_node);
> +	if (ret) {
> +		dev_err(tve->dev, "failed to create drm encoder\n");
>  		return ret;
> +	}
>  
>  	drm_encoder_helper_add(&tve->encoder, &imx_tve_encoder_helper_funcs);
> -	drm_simple_encoder_init(drm, &tve->encoder, encoder_type);
>  
>  	drm_connector_helper_add(&tve->connector,
>  			&imx_tve_connector_helper_funcs);
> diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
> index 4465e9c602f8..321accb4ca7c 100644
> --- a/drivers/gpu/drm/imx/parallel-display.c
> +++ b/drivers/gpu/drm/imx/parallel-display.c
> @@ -18,7 +18,6 @@
>  #include <drm/drm_of.h>
>  #include <drm/drm_panel.h>
>  #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
>  
>  #include "imx-drm.h"
>  
> @@ -274,10 +273,6 @@ static int imx_pd_register(struct drm_device *drm,
>  	struct drm_encoder *encoder = &imxpd->encoder;
>  	int ret;
>  
> -	ret = imx_drm_encoder_parse_of(drm, encoder, imxpd->dev->of_node);
> -	if (ret)
> -		return ret;
> -
>  	/* set the connector's dpms to OFF so that
>  	 * drm_helper_connector_dpms() won't return
>  	 * immediately since the current state is ON
> @@ -285,7 +280,11 @@ static int imx_pd_register(struct drm_device *drm,
>  	 */
>  	imxpd->connector.dpms = DRM_MODE_DPMS_OFF;
>  
> -	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_NONE);
> +	ret = imx_drm_create_encoder(drm, encoder, imxpd->dev->of_node);
> +	if (ret) {
> +		dev_err(imxpd->dev, "failed to create drm encoder\n");
> +		return ret;
> +	}
>  
>  	imxpd->bridge.funcs = &imx_pd_bridge_funcs;
>  	drm_bridge_attach(encoder, &imxpd->bridge, NULL, 0);

-- 
Regards,

Laurent Pinchart
