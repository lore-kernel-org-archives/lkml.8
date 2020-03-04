Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDF9C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B674520866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aBCu3KtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388571AbgCDXvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 18:51:53 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53198 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388535AbgCDXvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 18:51:52 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3CF2333E;
        Thu,  5 Mar 2020 00:51:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1583365911;
        bh=FLq+iBpl9vEs7gfVg5bJpoazZtBqZS7+C6sqlYzZAfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aBCu3KtAxIZ7sKHsRN1aC8XkWOGJIUTcyw2uqYCUau0vQXZqATsBSFvsqmFgCwcYu
         +Ji+pWFWkOl9yHDx52bLpbHJoeAVmVTpnYtOFtOIevPCalAISYHCCHIP/zZp8sE46y
         hJBK9yvN5KxNfYLHvqBL39jHfebYCOzf9U/5+XNQ=
Date:   Thu, 5 Mar 2020 01:51:49 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/bridge: dw-hdmi: rework csc related functions
Message-ID: <20200304235149.GH28814@pendragon.ideasonboard.com>
References: <20200304232512.51616-1-jernej.skrabec@siol.net>
 <20200304232512.51616-5-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200304232512.51616-5-jernej.skrabec@siol.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

Thank you for the patch.

On Thu, Mar 05, 2020 at 12:25:12AM +0100, Jernej Skrabec wrote:
> is_color_space_conversion() is a misnomer. It checks not only if color
> space conversion is needed, but also if format conversion is needed.
> This is actually desired behaviour because result of this function
> determines if CSC block should be enabled or not (CSC block can also do
> format conversion).
> 
> In order to clear misunderstandings, let's rework
> is_color_space_conversion() to do exactly what is supposed to do and add
> another function which will determine if CSC block must be enabled or
> not.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 31 +++++++++++++++--------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index c8a02e5b5e1b..7724191e0a8b 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -963,11 +963,14 @@ static void hdmi_video_sample(struct dw_hdmi *hdmi)
>  
>  static int is_color_space_conversion(struct dw_hdmi *hdmi)
>  {
> -	return (hdmi->hdmi_data.enc_in_bus_format !=
> -			hdmi->hdmi_data.enc_out_bus_format) ||
> -	       (hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_in_bus_format) &&
> -		hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format) &&
> -		hdmi->hdmi_data.rgb_limited_range);
> +	struct hdmi_data_info *hdmi_data = &hdmi->hdmi_data;
> +	bool is_input_rgb, is_output_rgb;
> +
> +	is_input_rgb = hdmi_bus_fmt_is_rgb(hdmi_data->enc_in_bus_format);
> +	is_output_rgb = hdmi_bus_fmt_is_rgb(hdmi_data->enc_out_bus_format);
> +
> +	return (is_input_rgb != is_output_rgb) ||
> +	       (is_input_rgb && is_output_rgb && hdmi_data->rgb_limited_range);
>  }
>  
>  static int is_color_space_decimation(struct dw_hdmi *hdmi)
> @@ -994,6 +997,13 @@ static int is_color_space_interpolation(struct dw_hdmi *hdmi)
>  	return 0;
>  }
>  
> +static bool is_conversion_needed(struct dw_hdmi *hdmi)

Maybe is_csc_needed ?

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +{
> +	return is_color_space_conversion(hdmi) ||
> +	       is_color_space_decimation(hdmi) ||
> +	       is_color_space_interpolation(hdmi);
> +}
> +
>  static void dw_hdmi_update_csc_coeffs(struct dw_hdmi *hdmi)
>  {
>  	const u16 (*csc_coeff)[3][4] = &csc_coeff_default;
> @@ -2014,18 +2024,19 @@ static void dw_hdmi_enable_video_path(struct dw_hdmi *hdmi)
>  	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
>  
>  	/* Enable csc path */
> -	if (is_color_space_conversion(hdmi)) {
> +	if (is_conversion_needed(hdmi)) {
>  		hdmi->mc_clkdis &= ~HDMI_MC_CLKDIS_CSCCLK_DISABLE;
>  		hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
> -	}
>  
> -	/* Enable color space conversion if needed */
> -	if (is_color_space_conversion(hdmi))
>  		hdmi_writeb(hdmi, HDMI_MC_FLOWCTRL_FEED_THROUGH_OFF_CSC_IN_PATH,
>  			    HDMI_MC_FLOWCTRL);
> -	else
> +	} else {
> +		hdmi->mc_clkdis |= HDMI_MC_CLKDIS_CSCCLK_DISABLE;
> +		hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
> +
>  		hdmi_writeb(hdmi, HDMI_MC_FLOWCTRL_FEED_THROUGH_OFF_CSC_BYPASS,
>  			    HDMI_MC_FLOWCTRL);
> +	}
>  }
>  
>  /* Workaround to clear the overflow condition */

-- 
Regards,

Laurent Pinchart
