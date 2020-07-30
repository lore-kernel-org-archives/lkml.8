Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A68C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2A420842
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgG3Fdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 01:33:45 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:42636 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgG3Fdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 01:33:45 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id BA75D804E5;
        Thu, 30 Jul 2020 07:33:41 +0200 (CEST)
Date:   Thu, 30 Jul 2020 07:33:40 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/ingenic: ipu: Only enable clock when needed
Message-ID: <20200730053340.GC1429781@ravnborg.org>
References: <20200730014626.83895-1-paul@crapouillou.net>
 <20200730014626.83895-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730014626.83895-4-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=ER_8r6IbAAAA:8
        a=aZ_HzrPzBHF4GxD21xUA:9 a=THfZoiQRlKttx8i7:21 a=zS6DgMrn1oIVMBE9:21
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22 a=9LHmKk7ezEChjTCyhBa9:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 03:46:26AM +0200, Paul Cercueil wrote:
> Instead of keeping the IPU clock enabled constantly, enable and disable
> it on demand, when the IPU plane is used.

This explains what the patch does - but fails to mention why.
Could you please add the why part too.

With the chagelog updated:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/ingenic/ingenic-ipu.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> index f4f0abcd6692..17e682cf1eba 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> @@ -49,6 +49,7 @@ struct ingenic_ipu {
>  	struct regmap *map;
>  	struct clk *clk;
>  	const struct soc_info *soc_info;
> +	bool clk_enabled;
>  
>  	unsigned int num_w, num_h, denom_w, denom_h;
>  
> @@ -288,12 +289,23 @@ static void ingenic_ipu_plane_atomic_update(struct drm_plane *plane,
>  	const struct drm_format_info *finfo;
>  	u32 ctrl, stride = 0, coef_index = 0, format = 0;
>  	bool needs_modeset, upscaling_w, upscaling_h;
> +	int err;
>  
>  	if (!state || !state->fb)
>  		return;
>  
>  	finfo = drm_format_info(state->fb->format->format);
>  
> +	if (!ipu->clk_enabled) {
> +		err = clk_enable(ipu->clk);
> +		if (err) {
> +			dev_err(ipu->dev, "Unable to enable clock: %d\n", err);
> +			return;
> +		}
> +
> +		ipu->clk_enabled = true;
> +	}
> +
>  	/* Reset all the registers if needed */
>  	needs_modeset = drm_atomic_crtc_needs_modeset(state->crtc->state);
>  	if (needs_modeset) {
> @@ -578,6 +590,11 @@ static void ingenic_ipu_plane_atomic_disable(struct drm_plane *plane,
>  	regmap_clear_bits(ipu->map, JZ_REG_IPU_CTRL, JZ_IPU_CTRL_CHIP_EN);
>  
>  	ingenic_drm_plane_disable(ipu->master, plane);
> +
> +	if (ipu->clk_enabled) {
> +		clk_disable(ipu->clk);
> +		ipu->clk_enabled = false;
> +	}
>  }
>  
>  static const struct drm_plane_helper_funcs ingenic_ipu_plane_helper_funcs = {
> @@ -761,9 +778,9 @@ static int ingenic_ipu_bind(struct device *dev, struct device *master, void *d)
>  	drm_object_attach_property(&plane->base, ipu->sharpness_prop,
>  				   ipu->sharpness);
>  
> -	err = clk_prepare_enable(ipu->clk);
> +	err = clk_prepare(ipu->clk);
>  	if (err) {
> -		dev_err(dev, "Unable to enable clock\n");
> +		dev_err(dev, "Unable to prepare clock\n");
>  		return err;
>  	}
>  
> @@ -775,7 +792,7 @@ static void ingenic_ipu_unbind(struct device *dev,
>  {
>  	struct ingenic_ipu *ipu = dev_get_drvdata(dev);
>  
> -	clk_disable_unprepare(ipu->clk);
> +	clk_unprepare(ipu->clk);
>  }
>  
>  static const struct component_ops ingenic_ipu_ops = {
> -- 
> 2.27.0
