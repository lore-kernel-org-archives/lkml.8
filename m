Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EBFC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0055F2084E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="D03vy1zE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388543AbgCDXry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 18:47:54 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53166 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387931AbgCDXry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 18:47:54 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 62F1533E;
        Thu,  5 Mar 2020 00:47:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1583365671;
        bh=CVzOs6nXVVRXv3pOcJIWVztPVoqRpIhrp3kbugpN03U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D03vy1zEy48QRXTnuRqBwitdr1xjAd+u/tif6XiU/8tm4571CnhA69+V3vSd+5V8T
         v/jeU00zrkuzpJNZRnzS5CJ6YnDiFaoGbyToXl6U1DaB9qH9T9vEP5RDn0Rm4NOy63
         Nxgl8yfIL1RVfbLGG3T0rNHNripCW7eDuYwMSCq8=
Date:   Thu, 5 Mar 2020 01:47:48 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] drm/bridge: dw-hdmi: Add support for RGB limited
 range
Message-ID: <20200304234748.GG28814@pendragon.ideasonboard.com>
References: <20200304232512.51616-1-jernej.skrabec@siol.net>
 <20200304232512.51616-4-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200304232512.51616-4-jernej.skrabec@siol.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

Thank you for the patch.

On Thu, Mar 05, 2020 at 12:25:11AM +0100, Jernej Skrabec wrote:
> CEA 861 standard requestis that RGB quantization range is "limited" for
> CEA modes. Support that by adding CSC matrix which downscales values.
> 
> This allows proper color reproduction on TV and PC monitor at the same
> time. In future, override property can be added, like "Broadcast RGB"
> in i915 driver.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 63 +++++++++++++++++------
>  1 file changed, 46 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index de2c7ec887c8..c8a02e5b5e1b 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -92,6 +92,12 @@ static const u16 csc_coeff_rgb_in_eitu709[3][4] = {
>  	{ 0x6756, 0x78ab, 0x2000, 0x0200 }
>  };
>  
> +static const u16 csc_coeff_rgb_full_to_rgb_limited[3][4] = {
> +	{ 0x1b7c, 0x0000, 0x0000, 0x0020 },
> +	{ 0x0000, 0x1b7c, 0x0000, 0x0020 },
> +	{ 0x0000, 0x0000, 0x1b7c, 0x0020 }
> +};
> +
>  struct hdmi_vmode {
>  	bool mdataenablepolarity;
>  
> @@ -109,6 +115,7 @@ struct hdmi_data_info {
>  	unsigned int pix_repet_factor;
>  	unsigned int hdcp_enable;
>  	struct hdmi_vmode video_mode;
> +	bool rgb_limited_range;
>  };
>  
>  struct dw_hdmi_i2c {
> @@ -956,7 +963,11 @@ static void hdmi_video_sample(struct dw_hdmi *hdmi)
>  
>  static int is_color_space_conversion(struct dw_hdmi *hdmi)
>  {
> -	return hdmi->hdmi_data.enc_in_bus_format != hdmi->hdmi_data.enc_out_bus_format;
> +	return (hdmi->hdmi_data.enc_in_bus_format !=
> +			hdmi->hdmi_data.enc_out_bus_format) ||
> +	       (hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_in_bus_format) &&
> +		hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format) &&
> +		hdmi->hdmi_data.rgb_limited_range);
>  }
>  
>  static int is_color_space_decimation(struct dw_hdmi *hdmi)
> @@ -986,25 +997,27 @@ static int is_color_space_interpolation(struct dw_hdmi *hdmi)
>  static void dw_hdmi_update_csc_coeffs(struct dw_hdmi *hdmi)
>  {
>  	const u16 (*csc_coeff)[3][4] = &csc_coeff_default;
> +	bool is_input_rgb, is_output_rgb;
>  	unsigned i;
>  	u32 csc_scale = 1;
>  
> -	if (is_color_space_conversion(hdmi)) {
> -		if (hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format)) {
> -			if (hdmi->hdmi_data.enc_out_encoding ==
> -						V4L2_YCBCR_ENC_601)
> -				csc_coeff = &csc_coeff_rgb_out_eitu601;
> -			else
> -				csc_coeff = &csc_coeff_rgb_out_eitu709;
> -		} else if (hdmi_bus_fmt_is_rgb(
> -					hdmi->hdmi_data.enc_in_bus_format)) {
> -			if (hdmi->hdmi_data.enc_out_encoding ==
> -						V4L2_YCBCR_ENC_601)
> -				csc_coeff = &csc_coeff_rgb_in_eitu601;
> -			else
> -				csc_coeff = &csc_coeff_rgb_in_eitu709;
> -			csc_scale = 0;
> -		}
> +	is_input_rgb = hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_in_bus_format);
> +	is_output_rgb = hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format);
> +
> +	if (!is_input_rgb && is_output_rgb) {
> +		if (hdmi->hdmi_data.enc_out_encoding == V4L2_YCBCR_ENC_601)
> +			csc_coeff = &csc_coeff_rgb_out_eitu601;
> +		else
> +			csc_coeff = &csc_coeff_rgb_out_eitu709;
> +	} else if (is_input_rgb && !is_output_rgb) {
> +		if (hdmi->hdmi_data.enc_out_encoding == V4L2_YCBCR_ENC_601)
> +			csc_coeff = &csc_coeff_rgb_in_eitu601;
> +		else
> +			csc_coeff = &csc_coeff_rgb_in_eitu709;
> +		csc_scale = 0;
> +	} else if (is_input_rgb && is_output_rgb &&
> +		   hdmi->hdmi_data.rgb_limited_range) {
> +		csc_coeff = &csc_coeff_rgb_full_to_rgb_limited;
>  	}
>  
>  	/* The CSC registers are sequential, alternating MSB then LSB */
> @@ -1614,6 +1627,18 @@ static void hdmi_config_AVI(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>  	drm_hdmi_avi_infoframe_from_display_mode(&frame,
>  						 &hdmi->connector, mode);
>  
> +	if (hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format)) {
> +		drm_hdmi_avi_infoframe_quant_range(&frame, &hdmi->connector,
> +						   mode,
> +						   hdmi->hdmi_data.rgb_limited_range ?
> +						   HDMI_QUANTIZATION_RANGE_LIMITED :
> +						   HDMI_QUANTIZATION_RANGE_FULL);
> +	} else {
> +		frame.quantization_range = HDMI_QUANTIZATION_RANGE_DEFAULT;
> +		frame.ycc_quantization_range =
> +			HDMI_YCC_QUANTIZATION_RANGE_LIMITED;
> +	}
> +
>  	if (hdmi_bus_fmt_is_yuv444(hdmi->hdmi_data.enc_out_bus_format))
>  		frame.colorspace = HDMI_COLORSPACE_YUV444;
>  	else if (hdmi_bus_fmt_is_yuv422(hdmi->hdmi_data.enc_out_bus_format))
> @@ -2099,6 +2124,10 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>  	/* TOFIX: Default to RGB888 output format */
>  	hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>  
> +	hdmi->hdmi_data.rgb_limited_range = hdmi->sink_is_hdmi &&
> +		drm_default_rgb_quant_range(mode) ==
> +		HDMI_QUANTIZATION_RANGE_LIMITED;
> +
>  	hdmi->hdmi_data.pix_repet_factor = 0;
>  	hdmi->hdmi_data.hdcp_enable = 0;
>  	hdmi->hdmi_data.video_mode.mdataenablepolarity = true;

-- 
Regards,

Laurent Pinchart
