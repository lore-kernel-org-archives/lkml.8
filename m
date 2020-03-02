Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6849AC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7BA24695
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OoC7vyus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgCBJVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:21:52 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:50334 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgCBJVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:21:51 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B6E8054A;
        Mon,  2 Mar 2020 10:21:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1583140909;
        bh=8sq1wDdWf+IVF9oWteFhFDTlL94c/C1RhHDt8Q2EhfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OoC7vyuscxZDXqoEVaQGvn9gvbAyD6h838LS8clufvzeozKixYdGRw7UItBlKPtZ9
         NDFyfW1oHzTXMajaI3mWvg4qdNBz9fSu1M5yDCA1tCILZy2ywcAB+z5Jf9CSoZaluh
         FZQbY2dC1sPD0sDcw0mYh4Gp6eo/zMFnnHKzzXVY=
Date:   Mon, 2 Mar 2020 11:21:24 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] drm/bridge: dw-hdmi: fix AVI frame colorimetry
Message-ID: <20200302092124.GD11960@pendragon.ideasonboard.com>
References: <20200229163043.158262-1-jernej.skrabec@siol.net>
 <20200229163043.158262-2-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200229163043.158262-2-jernej.skrabec@siol.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

Thank you for the patch.

On Sat, Feb 29, 2020 at 05:30:40PM +0100, Jernej Skrabec wrote:
> CTA-861-F explicitly states that for RGB colorspace colorimetry should
> be set to "none". Fix that.
> 
> Fixes: def23aa7e982 ("drm: bridge: dw-hdmi: Switch to V4L bus format and encodings")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 46 +++++++++++++----------
>  1 file changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 67fca439bbfb..24965e53d351 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1624,28 +1624,34 @@ static void hdmi_config_AVI(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>  		frame.colorspace = HDMI_COLORSPACE_RGB;
>  
>  	/* Set up colorimetry */
> -	switch (hdmi->hdmi_data.enc_out_encoding) {
> -	case V4L2_YCBCR_ENC_601:
> -		if (hdmi->hdmi_data.enc_in_encoding == V4L2_YCBCR_ENC_XV601)
> -			frame.colorimetry = HDMI_COLORIMETRY_EXTENDED;
> -		else
> +	if (!hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format)) {
> +		switch (hdmi->hdmi_data.enc_out_encoding) {
> +		case V4L2_YCBCR_ENC_601:
> +			if (hdmi->hdmi_data.enc_in_encoding == V4L2_YCBCR_ENC_XV601)
> +				frame.colorimetry = HDMI_COLORIMETRY_EXTENDED;
> +			else
> +				frame.colorimetry = HDMI_COLORIMETRY_ITU_601;
> +			frame.extended_colorimetry =
> +					HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
> +			break;
> +		case V4L2_YCBCR_ENC_709:
> +			if (hdmi->hdmi_data.enc_in_encoding == V4L2_YCBCR_ENC_XV709)
> +				frame.colorimetry = HDMI_COLORIMETRY_EXTENDED;
> +			else
> +				frame.colorimetry = HDMI_COLORIMETRY_ITU_709;
> +			frame.extended_colorimetry =
> +					HDMI_EXTENDED_COLORIMETRY_XV_YCC_709;
> +			break;
> +		default: /* Carries no data */
>  			frame.colorimetry = HDMI_COLORIMETRY_ITU_601;
> +			frame.extended_colorimetry =
> +					HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
> +			break;
> +		}
> +	} else {
> +		frame.colorimetry = HDMI_COLORIMETRY_NONE;
>  		frame.extended_colorimetry =
> -				HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
> -		break;
> -	case V4L2_YCBCR_ENC_709:
> -		if (hdmi->hdmi_data.enc_in_encoding == V4L2_YCBCR_ENC_XV709)
> -			frame.colorimetry = HDMI_COLORIMETRY_EXTENDED;
> -		else
> -			frame.colorimetry = HDMI_COLORIMETRY_ITU_709;
> -		frame.extended_colorimetry =
> -				HDMI_EXTENDED_COLORIMETRY_XV_YCC_709;
> -		break;
> -	default: /* Carries no data */
> -		frame.colorimetry = HDMI_COLORIMETRY_ITU_601;
> -		frame.extended_colorimetry =
> -				HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
> -		break;
> +			HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
>  	}
>  
>  	frame.scan_mode = HDMI_SCAN_MODE_NONE;

-- 
Regards,

Laurent Pinchart
