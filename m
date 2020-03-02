Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467F7C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80EC2166E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EDu+MPHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgCBKSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:18:48 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:51922 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgCBKSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:18:43 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C025354A;
        Mon,  2 Mar 2020 11:18:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1583144320;
        bh=TLpD2jmm3a/9VwXAcqrEnmBlnHUBd22SyR2WYCtzejE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDu+MPHTyPnQo+DKL/iF/ACXR1Abb0m/tG1Z8Z+HxhzAr69ZNIhnlHz4gUKQMueti
         ak/c2cH5z1ALweFnfHWIi4su0ZCur4SR3ew9HFkB8Gynf4TYLD0Fu5oWsKOwbbwooN
         9XDEwVj70wDnhMlND8OyxUqsaJN0rBuOfKgpekhs=
Date:   Mon, 2 Mar 2020 12:18:15 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     a.hajda@samsung.com, jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com, linux-amlogic@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/11] drm/bridge: synopsys: dw-hdmi: add bus format
 negociation
Message-ID: <20200302101815.GJ11960@pendragon.ideasonboard.com>
References: <20200206191834.6125-1-narmstrong@baylibre.com>
 <20200206191834.6125-5-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200206191834.6125-5-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Thank you for the patch.

On Thu, Feb 06, 2020 at 08:18:27PM +0100, Neil Armstrong wrote:
> Add the atomic_get_output_bus_fmts, atomic_get_input_bus_fmts to negociate
> the possible output and input formats for the current mode and monitor,
> and use the negotiated formats in a basic atomic_check callback.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 272 +++++++++++++++++++++-
>  1 file changed, 268 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index fec4a4bcd1fe..15048ad694bc 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2095,11 +2095,10 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>  	hdmi->hdmi_data.video_mode.mpixelrepetitionoutput = 0;
>  	hdmi->hdmi_data.video_mode.mpixelrepetitioninput = 0;
>  
> -	/* TOFIX: Get input format from plat data or fallback to RGB888 */
>  	if (hdmi->plat_data->input_bus_format)
>  		hdmi->hdmi_data.enc_in_bus_format =
>  			hdmi->plat_data->input_bus_format;
> -	else
> +	else if (hdmi->hdmi_data.enc_in_bus_format == MEDIA_BUS_FMT_FIXED)
>  		hdmi->hdmi_data.enc_in_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>  
>  	/* TOFIX: Get input encoding from plat data or fallback to none */
> @@ -2109,8 +2108,8 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>  	else
>  		hdmi->hdmi_data.enc_in_encoding = V4L2_YCBCR_ENC_DEFAULT;
>  
> -	/* TOFIX: Default to RGB888 output format */
> -	hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> +	if (hdmi->hdmi_data.enc_out_bus_format == MEDIA_BUS_FMT_FIXED)
> +		hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>  
>  	hdmi->hdmi_data.pix_repet_factor = 0;
>  	hdmi->hdmi_data.hdcp_enable = 0;
> @@ -2388,6 +2387,267 @@ static const struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs =
>  	.atomic_check = dw_hdmi_connector_atomic_check,
>  };
>  
> +/*
> + * Possible output formats :
> + * - MEDIA_BUS_FMT_UYYVYY16_0_5X48,
> + * - MEDIA_BUS_FMT_UYYVYY12_0_5X36,
> + * - MEDIA_BUS_FMT_UYYVYY10_0_5X30,
> + * - MEDIA_BUS_FMT_UYYVYY8_0_5X24,
> + * - MEDIA_BUS_FMT_YUV16_1X48,
> + * - MEDIA_BUS_FMT_RGB161616_1X48,
> + * - MEDIA_BUS_FMT_UYVY12_1X24,
> + * - MEDIA_BUS_FMT_YUV12_1X36,
> + * - MEDIA_BUS_FMT_RGB121212_1X36,
> + * - MEDIA_BUS_FMT_UYVY10_1X20,
> + * - MEDIA_BUS_FMT_YUV10_1X30,
> + * - MEDIA_BUS_FMT_RGB101010_1X30,
> + * - MEDIA_BUS_FMT_UYVY8_1X16,
> + * - MEDIA_BUS_FMT_YUV8_1X24,
> + * - MEDIA_BUS_FMT_RGB888_1X24,
> + */

I'd drop this comment as I don't think it brings much, except for a risk
of getting out of sync with the implementation below :-)

> +
> +/* Can return a maximum of 12 possible output formats for a mode/connector */
> +#define MAX_OUTPUT_SEL_FORMATS	12

I count 11 below.

> +
> +static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
> +					struct drm_bridge_state *bridge_state,
> +					struct drm_crtc_state *crtc_state,
> +					struct drm_connector_state *conn_state,
> +					unsigned int *num_output_fmts)
> +{
> +	struct drm_connector *conn = conn_state->connector;
> +	struct drm_display_info *info = &conn->display_info;
> +	struct drm_display_mode *mode = &crtc_state->mode;
> +	u8 max_bpc = conn_state->max_requested_bpc;
> +	bool is_hdmi2_sink = info->hdmi.scdc.supported ||
> +			     (info->color_formats & DRM_COLOR_FORMAT_YCRCB420);
> +	u32 *output_fmts;
> +	int i = 0;

i is never negative, you can make it an unsigned int.

> +
> +	*num_output_fmts = 0;
> +
> +	output_fmts = kcalloc(MAX_OUTPUT_SEL_FORMATS, sizeof(*output_fmts),
> +			      GFP_KERNEL);
> +	if (!output_fmts)
> +		return NULL;
> +
> +	/*
> +	 * If the current mode enforces 4:2:0, force the output but format
> +	 * to 4:2:0 and do not add the YUV422/444/RGB formats
> +	 */
> +	if (conn->ycbcr_420_allowed &&
> +	    (drm_mode_is_420_only(info, mode) ||
> +	     (is_hdmi2_sink && drm_mode_is_420_also(info, mode)))) {
> +
> +		/* Order bus formats from 16bit to 8bit if supported */
> +		if (max_bpc >= 16 && info->bpc == 16 &&
> +		    (info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_48))
> +			output_fmts[i++] = MEDIA_BUS_FMT_UYYVYY16_0_5X48;
> +
> +		if (max_bpc >= 12 && info->bpc >= 12 &&
> +		    (info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_36))
> +			output_fmts[i++] = MEDIA_BUS_FMT_UYYVYY12_0_5X36;
> +
> +		if (max_bpc >= 10 && info->bpc >= 10 &&
> +		    (info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_30))
> +			output_fmts[i++] = MEDIA_BUS_FMT_UYYVYY10_0_5X30;
> +
> +		/* Default 8bit fallback */
> +		output_fmts[i++] = MEDIA_BUS_FMT_UYYVYY8_0_5X24;
> +
> +		*num_output_fmts = i;
> +
> +		return output_fmts;
> +	}
> +
> +	/*
> +	 * Order bus formats from 16bit to 8bit and from YUV422 to RGB
> +	 * if supported. In any case the default RGB888 format is added
> +	 */
> +
> +	if (max_bpc >= 16 && info->bpc == 16) {
> +		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
> +			output_fmts[i++] = MEDIA_BUS_FMT_YUV16_1X48;
> +
> +		output_fmts[i++] = MEDIA_BUS_FMT_RGB161616_1X48;
> +	}
> +
> +	if (max_bpc >= 12 && info->bpc >= 12) {
> +		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
> +			output_fmts[i++] = MEDIA_BUS_FMT_UYVY12_1X24;
> +
> +		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
> +			output_fmts[i++] = MEDIA_BUS_FMT_YUV12_1X36;
> +
> +		output_fmts[i++] = MEDIA_BUS_FMT_RGB121212_1X36;
> +	}
> +
> +	if (max_bpc >= 10 && info->bpc >= 10) {
> +		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
> +			output_fmts[i++] = MEDIA_BUS_FMT_UYVY10_1X20;
> +
> +		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
> +			output_fmts[i++] = MEDIA_BUS_FMT_YUV10_1X30;
> +
> +		output_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
> +	}
> +
> +	if (info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
> +		output_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
> +
> +	if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
> +		output_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
> +
> +	/* Default 8bit RGB fallback */
> +	output_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
> +
> +	*num_output_fmts = i;
> +
> +	return output_fmts;
> +}
> +
> +/*
> + * Possible input formats :
> + * - MEDIA_BUS_FMT_RGB888_1X24
> + * - MEDIA_BUS_FMT_YUV8_1X24
> + * - MEDIA_BUS_FMT_UYVY8_1X16
> + * - MEDIA_BUS_FMT_UYYVYY8_0_5X24
> + * - MEDIA_BUS_FMT_RGB101010_1X30
> + * - MEDIA_BUS_FMT_YUV10_1X30
> + * - MEDIA_BUS_FMT_UYVY10_1X20
> + * - MEDIA_BUS_FMT_UYYVYY10_0_5X30
> + * - MEDIA_BUS_FMT_RGB121212_1X36
> + * - MEDIA_BUS_FMT_YUV12_1X36
> + * - MEDIA_BUS_FMT_UYVY12_1X24
> + * - MEDIA_BUS_FMT_UYYVYY12_0_5X36
> + * - MEDIA_BUS_FMT_RGB161616_1X48
> + * - MEDIA_BUS_FMT_YUV16_1X48
> + * - MEDIA_BUS_FMT_UYYVYY16_0_5X48
> + */

Same here.

> +
> +/* Can return a maximum of 4 possible input formats for an output format */
> +#define MAX_INPUT_SEL_FORMATS	4

As Boris pointed out, that should be 3.

> +
> +static u32 *dw_hdmi_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
> +					struct drm_bridge_state *bridge_state,
> +					struct drm_crtc_state *crtc_state,
> +					struct drm_connector_state *conn_state,
> +					u32 output_fmt,
> +					unsigned int *num_input_fmts)
> +{
> +	u32 *input_fmts;
> +	int i = 0;

i is never negative, you can make it an unsigned int.

> +
> +	*num_input_fmts = 0;
> +
> +	input_fmts = kcalloc(MAX_INPUT_SEL_FORMATS, sizeof(*input_fmts),
> +			     GFP_KERNEL);
> +	if (!input_fmts)
> +		return NULL;
> +
> +	switch (output_fmt) {
> +	/* 8bit */
> +	case MEDIA_BUS_FMT_RGB888_1X24:
> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
> +		break;
> +	case MEDIA_BUS_FMT_YUV8_1X24:
> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
> +		break;
> +	case MEDIA_BUS_FMT_UYVY8_1X16:
> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
> +		break;
> +
> +	/* 10bit */
> +	case MEDIA_BUS_FMT_RGB101010_1X30:
> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV10_1X30;
> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY10_1X20;
> +		break;
> +	case MEDIA_BUS_FMT_YUV10_1X30:
> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV10_1X30;
> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY10_1X20;
> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
> +		break;
> +	case MEDIA_BUS_FMT_UYVY10_1X20:
> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY10_1X20;
> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV10_1X30;
> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
> +		break;
> +
> +	/* 12bit */
> +	case MEDIA_BUS_FMT_RGB121212_1X36:
> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB121212_1X36;
> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV12_1X36;
> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY12_1X24;
> +		break;
> +	case MEDIA_BUS_FMT_YUV12_1X36:
> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV12_1X36;
> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY12_1X24;
> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB121212_1X36;
> +		break;
> +	case MEDIA_BUS_FMT_UYVY12_1X24:
> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY12_1X24;
> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV12_1X36;
> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB121212_1X36;
> +		break;
> +
> +	/* 16bit */
> +	case MEDIA_BUS_FMT_RGB161616_1X48:
> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB161616_1X48;
> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV16_1X48;
> +		break;
> +	case MEDIA_BUS_FMT_YUV16_1X48:
> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV16_1X48;
> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB161616_1X48;
> +		break;
> +
> +	/* 420 */

s/420/YUV 4:2:0/ ?

> +	case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
> +	case MEDIA_BUS_FMT_UYYVYY10_0_5X30:
> +	case MEDIA_BUS_FMT_UYYVYY12_0_5X36:
> +	case MEDIA_BUS_FMT_UYYVYY16_0_5X48:
> +		input_fmts[i++] = output_fmt;
> +		break;
> +	}
> +
> +	*num_input_fmts = i;
> +
> +	if (*num_input_fmts == 0) {
> +		kfree(input_fmts);
> +		input_fmts = NULL;
> +	}
> +
> +	return input_fmts;
> +}
> +
> +static int dw_hdmi_bridge_atomic_check(struct drm_bridge *bridge,
> +				       struct drm_bridge_state *bridge_state,
> +				       struct drm_crtc_state *crtc_state,
> +				       struct drm_connector_state *conn_state)
> +{
> +	struct dw_hdmi *hdmi = bridge->driver_private;
> +
> +	dev_dbg(hdmi->dev, "selected output format %x\n",

s/%x/0x%04x/

> +			bridge_state->output_bus_cfg.format);

Misalignment ?

> +
> +	hdmi->hdmi_data.enc_out_bus_format =
> +			bridge_state->output_bus_cfg.format;
> +
> +	dev_dbg(hdmi->dev, "selected input format %x\n",
> +			bridge_state->input_bus_cfg.format);

Same here. I would combine both messages:

	dev_dbg(hdmi->dev, "input format: 0x%04x, output format: 0x04x\n",
		bridge_state->input_bus_cfg.format,
		bridge_state->output_bus_cfg.format);

> +
> +	hdmi->hdmi_data.enc_in_bus_format =
> +			bridge_state->input_bus_cfg.format;
> +
> +	return 0;
> +}
> +
>  static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
>  {
>  	struct dw_hdmi *hdmi = bridge->driver_private;
> @@ -2499,6 +2759,9 @@ static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
>  	.atomic_reset = drm_atomic_helper_bridge_reset,
>  	.attach = dw_hdmi_bridge_attach,
>  	.detach = dw_hdmi_bridge_detach,
> +	.atomic_check = dw_hdmi_bridge_atomic_check,
> +	.atomic_get_output_bus_fmts = dw_hdmi_bridge_atomic_get_output_bus_fmts,
> +	.atomic_get_input_bus_fmts = dw_hdmi_bridge_atomic_get_input_bus_fmts,
>  	.enable = dw_hdmi_bridge_enable,
>  	.disable = dw_hdmi_bridge_disable,
>  	.mode_set = dw_hdmi_bridge_mode_set,
> @@ -2963,6 +3226,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  
>  	hdmi->bridge.driver_private = hdmi;
>  	hdmi->bridge.funcs = &dw_hdmi_bridge_funcs;
> +

This seems unrelated.

>  #ifdef CONFIG_OF
>  	hdmi->bridge.of_node = pdev->dev.of_node;
>  #endif

-- 
Regards,

Laurent Pinchart
