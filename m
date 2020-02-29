Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87022C3F2D7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 07:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A962469C
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 07:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgB2HmR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 02:42:17 -0500
Received: from mailoutvs10.siol.net ([185.57.226.201]:54964 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725747AbgB2HmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 02:42:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id CE99052215B;
        Sat, 29 Feb 2020 08:42:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wQHFwAuTRgmc; Sat, 29 Feb 2020 08:42:09 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 007665220C7;
        Sat, 29 Feb 2020 08:42:08 +0100 (CET)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 96A51521765;
        Sat, 29 Feb 2020 08:42:07 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, boris.brezillon@collabora.com,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/11] drm/bridge: synopsys: dw-hdmi: add bus format negociation
Date:   Sat, 29 Feb 2020 08:42:06 +0100
Message-ID: <5330543.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20200206191834.6125-5-narmstrong@baylibre.com>
References: <20200206191834.6125-1-narmstrong@baylibre.com> <20200206191834.6125-5-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil!

Dne četrtek, 06. februar 2020 ob 20:18:27 CET je Neil Armstrong napisal(a):
> Add the atomic_get_output_bus_fmts, atomic_get_input_bus_fmts to negociate
> the possible output and input formats for the current mode and monitor,
> and use the negotiated formats in a basic atomic_check callback.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 272 +++++++++++++++++++++-
>  1 file changed, 268 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> fec4a4bcd1fe..15048ad694bc 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2095,11 +2095,10 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi,
> struct drm_display_mode *mode)
> hdmi->hdmi_data.video_mode.mpixelrepetitionoutput = 0;
>  	hdmi->hdmi_data.video_mode.mpixelrepetitioninput = 0;
> 
> -	/* TOFIX: Get input format from plat data or fallback to RGB888 */
>  	if (hdmi->plat_data->input_bus_format)
>  		hdmi->hdmi_data.enc_in_bus_format =
>  			hdmi->plat_data->input_bus_format;
> -	else
> +	else if (hdmi->hdmi_data.enc_in_bus_format == MEDIA_BUS_FMT_FIXED)
>  		hdmi->hdmi_data.enc_in_bus_format = 
MEDIA_BUS_FMT_RGB888_1X24;
> 
>  	/* TOFIX: Get input encoding from plat data or fallback to none */
> @@ -2109,8 +2108,8 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct
> drm_display_mode *mode) else
>  		hdmi->hdmi_data.enc_in_encoding = 
V4L2_YCBCR_ENC_DEFAULT;
> 
> -	/* TOFIX: Default to RGB888 output format */
> -	hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> +	if (hdmi->hdmi_data.enc_out_bus_format == MEDIA_BUS_FMT_FIXED)
> +		hdmi->hdmi_data.enc_out_bus_format = 
MEDIA_BUS_FMT_RGB888_1X24;
> 
>  	hdmi->hdmi_data.pix_repet_factor = 0;
>  	hdmi->hdmi_data.hdcp_enable = 0;
> @@ -2388,6 +2387,267 @@ static const struct drm_connector_helper_funcs
> dw_hdmi_connector_helper_funcs = .atomic_check =
> dw_hdmi_connector_atomic_check,
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
> +
> +/* Can return a maximum of 12 possible output formats for a mode/connector
> */ +#define MAX_OUTPUT_SEL_FORMATS	12
> +
> +static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge
> *bridge, +					struct 
drm_bridge_state *bridge_state,
> +					struct drm_crtc_state 
*crtc_state,
> +					struct 
drm_connector_state *conn_state,
> +					unsigned int 
*num_output_fmts)
> +{
> +	struct drm_connector *conn = conn_state->connector;
> +	struct drm_display_info *info = &conn->display_info;
> +	struct drm_display_mode *mode = &crtc_state->mode;
> +	u8 max_bpc = conn_state->max_requested_bpc;
> +	bool is_hdmi2_sink = info->hdmi.scdc.supported ||
> +			     (info->color_formats & 
DRM_COLOR_FORMAT_YCRCB420);
> +	u32 *output_fmts;
> +	int i = 0;
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
> +	     ())) {
> +
> +		/* Order bus formats from 16bit to 8bit if supported */
> +		if (max_bpc >= 16 && info->bpc == 16 &&
> +		    (info->hdmi.y420_dc_modes & 
DRM_EDID_YCBCR420_DC_48))
> +			output_fmts[i++] = 
MEDIA_BUS_FMT_UYYVYY16_0_5X48;
> +
> +		if (max_bpc >= 12 && info->bpc >= 12 &&
> +		    (info->hdmi.y420_dc_modes & 
DRM_EDID_YCBCR420_DC_36))
> +			output_fmts[i++] = 
MEDIA_BUS_FMT_UYYVYY12_0_5X36;
> +
> +		if (max_bpc >= 10 && info->bpc >= 10 &&
> +		    (info->hdmi.y420_dc_modes & 
DRM_EDID_YCBCR420_DC_30))
> +			output_fmts[i++] = 
MEDIA_BUS_FMT_UYYVYY10_0_5X30;
> +
> +		/* Default 8bit fallback */
> +		output_fmts[i++] = MEDIA_BUS_FMT_UYYVYY8_0_5X24;
> +
> +		*num_output_fmts = i;
> +
> +		return output_fmts;

Driver shouldn't return just yet for case "is_hdmi2_sink && 
drm_mode_is_420_also(info, mode)", because monitor/TV also supports YCbCr 
4:4:4 in that case. IMO YCbCr 4:4:4 should be even prefered. What do you 
think?

Best regards,
Jernej

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
> +
> +/* Can return a maximum of 4 possible input formats for an output format */
> +#define MAX_INPUT_SEL_FORMATS	4
> +
> +static u32 *dw_hdmi_bridge_atomic_get_input_bus_fmts(struct drm_bridge
> *bridge, +					struct 
drm_bridge_state *bridge_state,
> +					struct drm_crtc_state 
*crtc_state,
> +					struct 
drm_connector_state *conn_state,
> +					u32 output_fmt,
> +					unsigned int 
*num_input_fmts)
> +{
> +	u32 *input_fmts;
> +	int i = 0;
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
> +				       struct drm_bridge_state 
*bridge_state,
> +				       struct drm_crtc_state 
*crtc_state,
> +				       struct drm_connector_state 
*conn_state)
> +{
> +	struct dw_hdmi *hdmi = bridge->driver_private;
> +
> +	dev_dbg(hdmi->dev, "selected output format %x\n",
> +			bridge_state->output_bus_cfg.format);
> +
> +	hdmi->hdmi_data.enc_out_bus_format =
> +			bridge_state->output_bus_cfg.format;
> +
> +	dev_dbg(hdmi->dev, "selected input format %x\n",
> +			bridge_state->input_bus_cfg.format);
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
> @@ -2499,6 +2759,9 @@ static const struct drm_bridge_funcs
> dw_hdmi_bridge_funcs = { .atomic_reset = drm_atomic_helper_bridge_reset,
>  	.attach = dw_hdmi_bridge_attach,
>  	.detach = dw_hdmi_bridge_detach,
> +	.atomic_check = dw_hdmi_bridge_atomic_check,
> +	.atomic_get_output_bus_fmts = 
dw_hdmi_bridge_atomic_get_output_bus_fmts,
> +	.atomic_get_input_bus_fmts = 
dw_hdmi_bridge_atomic_get_input_bus_fmts,
>  	.enable = dw_hdmi_bridge_enable,
>  	.disable = dw_hdmi_bridge_disable,
>  	.mode_set = dw_hdmi_bridge_mode_set,
> @@ -2963,6 +3226,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
> 
>  	hdmi->bridge.driver_private = hdmi;
>  	hdmi->bridge.funcs = &dw_hdmi_bridge_funcs;
> +
>  #ifdef CONFIG_OF
>  	hdmi->bridge.of_node = pdev->dev.of_node;
>  #endif




