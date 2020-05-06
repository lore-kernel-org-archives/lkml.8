Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F88C47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E51208CA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgEFQpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:45:23 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:59984 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbgEFQpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:45:21 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 753D08046E;
        Wed,  6 May 2020 18:45:18 +0200 (CEST)
Date:   Wed, 6 May 2020 18:45:17 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Dmitry Osipenko <digetx@gmail.com>, g@ravnborg.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 5/6] drm/tegra: output: rgb: Support LVDS encoder
 bridge
Message-ID: <20200506164517.GE19296@ravnborg.org>
References: <20200418170703.1583-1-digetx@gmail.com>
 <20200418170703.1583-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418170703.1583-6-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=P1BnusSwAAAA:8 a=pGLkceISAAAA:8 a=7gkXJVJtAAAA:8
        a=e5mUnYsNAAAA:8 a=EMU4hVWXcrfB3vzXjuAA:9 a=CjuIK1q_8ugA:10
        a=D0XLA9XvdZm18NrgonBM:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 08:07:02PM +0300, Dmitry Osipenko wrote:
> Newer Tegra device-trees will specify a video output graph, which involves
> LVDS encoder bridge. This patch adds support for the LVDS encoder bridge
> to the RGB output, allowing us to model the display hardware properly.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/tegra/rgb.c | 58 +++++++++++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
> index 0562a7eb793f..9a7024ec96bc 100644
> --- a/drivers/gpu/drm/tegra/rgb.c
> +++ b/drivers/gpu/drm/tegra/rgb.c
> @@ -7,6 +7,7 @@
>  #include <linux/clk.h>
>  
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_bridge_connector.h>
>  #include <drm/drm_panel.h>
>  #include <drm/drm_simple_kms_helper.h>
>  
> @@ -267,24 +268,63 @@ int tegra_dc_rgb_remove(struct tegra_dc *dc)
>  int tegra_dc_rgb_init(struct drm_device *drm, struct tegra_dc *dc)
>  {
>  	struct tegra_output *output = dc->rgb;
> +	struct drm_connector *connector;
>  	int err;
>  
>  	if (!dc->rgb)
>  		return -ENODEV;
>  
> -	drm_connector_init(drm, &output->connector, &tegra_rgb_connector_funcs,
> -			   DRM_MODE_CONNECTOR_LVDS);
> -	drm_connector_helper_add(&output->connector,
> -				 &tegra_rgb_connector_helper_funcs);
> -	output->connector.dpms = DRM_MODE_DPMS_OFF;
> -
>  	drm_simple_encoder_init(drm, &output->encoder, DRM_MODE_ENCODER_LVDS);
>  	drm_encoder_helper_add(&output->encoder,
>  			       &tegra_rgb_encoder_helper_funcs);
>  
> -	drm_connector_attach_encoder(&output->connector,
> -					  &output->encoder);
> -	drm_connector_register(&output->connector);
> +	/*
> +	 * Tegra devices that have LVDS panel utilize LVDS encoder bridge
> +	 * for converting up to 28 LCD LVTTL lanes into 5/4 LVDS lanes that
> +	 * go to display panel's receiver.
> +	 *
> +	 * Encoder usually have a power-down control which needs to be enabled
> +	 * in order to transmit data to the panel.  Historically devices that
> +	 * use an older device-tree version didn't model the bridge, assuming
> +	 * that encoder is turned ON by default, while today's DRM allows us
> +	 * to model LVDS encoder properly.
> +	 *
> +	 * Newer device-trees utilize LVDS encoder bridge, which provides
> +	 * us with a connector and handles the display panel.
> +	 *
> +	 * For older device-trees we fall back to our own connector and use
> +	 * nvidia,panel phandle.
> +	 */
> +	if (output->bridge) {
> +		err = drm_bridge_attach(&output->encoder, output->bridge,
> +					NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> +		if (err) {
> +			dev_err(output->dev, "failed to attach bridge: %d\n",
> +				err);
> +			return err;
> +		}
> +
> +		connector = drm_bridge_connector_init(drm, &output->encoder);
> +		if (IS_ERR(connector)) {
> +			dev_err(output->dev,
> +				"failed to initialize bridge connector: %pe\n",
> +				connector);
> +			return PTR_ERR(connector);
> +		}
> +
> +		drm_connector_attach_encoder(connector, &output->encoder);
> +	} else {
> +		drm_connector_init(drm, &output->connector,
> +				   &tegra_rgb_connector_funcs,
> +				   DRM_MODE_CONNECTOR_LVDS);
> +		drm_connector_helper_add(&output->connector,
> +					 &tegra_rgb_connector_helper_funcs);
> +		output->connector.dpms = DRM_MODE_DPMS_OFF;
> +
> +		drm_connector_attach_encoder(&output->connector,
> +					     &output->encoder);
> +		drm_connector_register(&output->connector);
> +	}
>  
>  	err = tegra_output_init(drm, output);
>  	if (err < 0) {
> -- 
> 2.26.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
