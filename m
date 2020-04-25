Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CA1C55194
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F83206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDYRCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:02:47 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:55586 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgDYRCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 13:02:47 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id D03B820023;
        Sat, 25 Apr 2020 19:02:38 +0200 (CEST)
Date:   Sat, 25 Apr 2020 19:02:37 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 6/6] drm/tegra: output: rgb: Wrap directly-connected
 panel into DRM bridge
Message-ID: <20200425170237.GA20498@ravnborg.org>
References: <20200418170703.1583-1-digetx@gmail.com>
 <20200418170703.1583-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418170703.1583-7-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=P1BnusSwAAAA:8 a=pGLkceISAAAA:8 a=7gkXJVJtAAAA:8
        a=e5mUnYsNAAAA:8 a=V0GYCF9GdKgsJ-jD5OsA:9 a=CjuIK1q_8ugA:10
        a=D0XLA9XvdZm18NrgonBM:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry

On Sat, Apr 18, 2020 at 08:07:03PM +0300, Dmitry Osipenko wrote:
> Currently Tegra DRM driver manually manages display panel, but this
> management could be moved out into DRM core if we'll wrap panel into
> DRM bridge. This patch wraps RGB panel into a DRM bridge and removes
> manual handling of the panel from the RGB output code.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

This resulted in the expected simplifications - good.
Acked-by: Sam Ravnborg <sam@ravnborg.org>

> ---
>  drivers/gpu/drm/tegra/rgb.c | 53 +++++++++++++------------------------
>  1 file changed, 18 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
> index 9a7024ec96bc..a4c5a6066c54 100644
> --- a/drivers/gpu/drm/tegra/rgb.c
> +++ b/drivers/gpu/drm/tegra/rgb.c
> @@ -8,7 +8,6 @@
>  
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge_connector.h>
> -#include <drm/drm_panel.h>
>  #include <drm/drm_simple_kms_helper.h>
>  
>  #include "drm.h"
> @@ -86,15 +85,6 @@ static void tegra_dc_write_regs(struct tegra_dc *dc,
>  		tegra_dc_writel(dc, table[i].value, table[i].offset);
>  }
>  
> -static const struct drm_connector_funcs tegra_rgb_connector_funcs = {
> -	.reset = drm_atomic_helper_connector_reset,
> -	.detect = tegra_output_connector_detect,
> -	.fill_modes = drm_helper_probe_single_connector_modes,
> -	.destroy = tegra_output_connector_destroy,
> -	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> -	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> -};
> -
>  static enum drm_mode_status
>  tegra_rgb_connector_mode_valid(struct drm_connector *connector,
>  			       struct drm_display_mode *mode)
> @@ -117,14 +107,8 @@ static void tegra_rgb_encoder_disable(struct drm_encoder *encoder)
>  	struct tegra_output *output = encoder_to_output(encoder);
>  	struct tegra_rgb *rgb = to_rgb(output);
>  
> -	if (output->panel)
> -		drm_panel_disable(output->panel);
> -
>  	tegra_dc_write_regs(rgb->dc, rgb_disable, ARRAY_SIZE(rgb_disable));
>  	tegra_dc_commit(rgb->dc);
> -
> -	if (output->panel)
> -		drm_panel_unprepare(output->panel);
>  }
>  
>  static void tegra_rgb_encoder_enable(struct drm_encoder *encoder)
> @@ -133,9 +117,6 @@ static void tegra_rgb_encoder_enable(struct drm_encoder *encoder)
>  	struct tegra_rgb *rgb = to_rgb(output);
>  	u32 value;
>  
> -	if (output->panel)
> -		drm_panel_prepare(output->panel);
> -
>  	tegra_dc_write_regs(rgb->dc, rgb_enable, ARRAY_SIZE(rgb_enable));
>  
>  	value = DE_SELECT_ACTIVE | DE_CONTROL_NORMAL;
> @@ -157,9 +138,6 @@ static void tegra_rgb_encoder_enable(struct drm_encoder *encoder)
>  	tegra_dc_writel(rgb->dc, value, DC_DISP_SHIFT_CLOCK_OPTIONS);
>  
>  	tegra_dc_commit(rgb->dc);
> -
> -	if (output->panel)
> -		drm_panel_enable(output->panel);
>  }
>  
>  static int
> @@ -278,6 +256,23 @@ int tegra_dc_rgb_init(struct drm_device *drm, struct tegra_dc *dc)
>  	drm_encoder_helper_add(&output->encoder,
>  			       &tegra_rgb_encoder_helper_funcs);
>  
> +	/*
> +	 * Wrap directly-connected panel into DRM bridge in order to let
> +	 * DRM core to handle panel for us.
> +	 */
> +	if (output->panel) {
> +		output->bridge = devm_drm_panel_bridge_add(output->dev,
> +							   output->panel);
> +		if (IS_ERR(output->bridge)) {
> +			dev_err(output->dev,
> +				"failed to wrap panel into bridge: %pe\n",
> +				output->bridge);
> +			return PTR_ERR(output->bridge);
> +		}
> +
> +		output->panel = NULL;
> +	}
> +
>  	/*
>  	 * Tegra devices that have LVDS panel utilize LVDS encoder bridge
>  	 * for converting up to 28 LCD LVTTL lanes into 5/4 LVDS lanes that
> @@ -292,8 +287,7 @@ int tegra_dc_rgb_init(struct drm_device *drm, struct tegra_dc *dc)
>  	 * Newer device-trees utilize LVDS encoder bridge, which provides
>  	 * us with a connector and handles the display panel.
>  	 *
> -	 * For older device-trees we fall back to our own connector and use
> -	 * nvidia,panel phandle.
> +	 * For older device-trees we wrapped panel into the panel-bridge.
>  	 */
>  	if (output->bridge) {
>  		err = drm_bridge_attach(&output->encoder, output->bridge,
> @@ -313,17 +307,6 @@ int tegra_dc_rgb_init(struct drm_device *drm, struct tegra_dc *dc)
>  		}
>  
>  		drm_connector_attach_encoder(connector, &output->encoder);
> -	} else {
> -		drm_connector_init(drm, &output->connector,
> -				   &tegra_rgb_connector_funcs,
> -				   DRM_MODE_CONNECTOR_LVDS);
> -		drm_connector_helper_add(&output->connector,
> -					 &tegra_rgb_connector_helper_funcs);
> -		output->connector.dpms = DRM_MODE_DPMS_OFF;
> -
> -		drm_connector_attach_encoder(&output->connector,
> -					     &output->encoder);
> -		drm_connector_register(&output->connector);
>  	}
>  
>  	err = tegra_output_init(drm, output);
> -- 
> 2.26.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
