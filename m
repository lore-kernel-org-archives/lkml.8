Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE4AC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BF520637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgCEQxb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:53:31 -0500
Received: from mailoutvs59.siol.net ([185.57.226.250]:56086 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726036AbgCEQxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:53:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 1829A523028;
        Thu,  5 Mar 2020 17:53:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IahrWYT3sMxp; Thu,  5 Mar 2020 17:53:25 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 9E9BC5230A3;
        Thu,  5 Mar 2020 17:53:25 +0100 (CET)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 9DDB9522F5B;
        Thu,  5 Mar 2020 17:53:23 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/bridge: dw-hdmi: rework csc related functions
Date:   Thu, 05 Mar 2020 17:53:22 +0100
Message-ID: <2518078.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20200304235149.GH28814@pendragon.ideasonboard.com>
References: <20200304232512.51616-1-jernej.skrabec@siol.net> <20200304232512.51616-5-jernej.skrabec@siol.net> <20200304235149.GH28814@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Dne četrtek, 05. marec 2020 ob 00:51:49 CET je Laurent Pinchart napisal(a):
> Hi Jernej,
> 
> Thank you for the patch.
> 
> On Thu, Mar 05, 2020 at 12:25:12AM +0100, Jernej Skrabec wrote:
> > is_color_space_conversion() is a misnomer. It checks not only if color
> > space conversion is needed, but also if format conversion is needed.
> > This is actually desired behaviour because result of this function
> > determines if CSC block should be enabled or not (CSC block can also do
> > format conversion).
> > 
> > In order to clear misunderstandings, let's rework
> > is_color_space_conversion() to do exactly what is supposed to do and add
> > another function which will determine if CSC block must be enabled or
> > not.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 31 +++++++++++++++--------
> >  1 file changed, 21 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> > c8a02e5b5e1b..7724191e0a8b 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -963,11 +963,14 @@ static void hdmi_video_sample(struct dw_hdmi *hdmi)
> > 
> >  static int is_color_space_conversion(struct dw_hdmi *hdmi)
> >  {
> > 
> > -	return (hdmi->hdmi_data.enc_in_bus_format !=
> > -			hdmi->hdmi_data.enc_out_bus_format) ||
> > -	       (hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_in_bus_format) &&
> > -		hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format) 
&&
> > -		hdmi->hdmi_data.rgb_limited_range);
> > +	struct hdmi_data_info *hdmi_data = &hdmi->hdmi_data;
> > +	bool is_input_rgb, is_output_rgb;
> > +
> > +	is_input_rgb = hdmi_bus_fmt_is_rgb(hdmi_data->enc_in_bus_format);
> > +	is_output_rgb = hdmi_bus_fmt_is_rgb(hdmi_data-
>enc_out_bus_format);
> > +
> > +	return (is_input_rgb != is_output_rgb) ||
> > +	       (is_input_rgb && is_output_rgb && hdmi_data-
>rgb_limited_range);
> > 
> >  }
> >  
> >  static int is_color_space_decimation(struct dw_hdmi *hdmi)
> > 
> > @@ -994,6 +997,13 @@ static int is_color_space_interpolation(struct
> > dw_hdmi *hdmi)> 
> >  	return 0;
> >  
> >  }
> > 
> > +static bool is_conversion_needed(struct dw_hdmi *hdmi)
> 
> Maybe is_csc_needed ?

Ok, I'll fix during applying.

> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

Best regards,
Jernej

> 
> > +{
> > +	return is_color_space_conversion(hdmi) ||
> > +	       is_color_space_decimation(hdmi) ||
> > +	       is_color_space_interpolation(hdmi);
> > +}
> > +
> > 
> >  static void dw_hdmi_update_csc_coeffs(struct dw_hdmi *hdmi)
> >  {
> >  
> >  	const u16 (*csc_coeff)[3][4] = &csc_coeff_default;
> > 
> > @@ -2014,18 +2024,19 @@ static void dw_hdmi_enable_video_path(struct
> > dw_hdmi *hdmi)> 
> >  	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
> >  	
> >  	/* Enable csc path */
> > 
> > -	if (is_color_space_conversion(hdmi)) {
> > +	if (is_conversion_needed(hdmi)) {
> > 
> >  		hdmi->mc_clkdis &= ~HDMI_MC_CLKDIS_CSCCLK_DISABLE;
> >  		hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
> > 
> > -	}
> > 
> > -	/* Enable color space conversion if needed */
> > -	if (is_color_space_conversion(hdmi))
> > 
> >  		hdmi_writeb(hdmi, 
HDMI_MC_FLOWCTRL_FEED_THROUGH_OFF_CSC_IN_PATH,
> >  		
> >  			    HDMI_MC_FLOWCTRL);
> > 
> > -	else
> > +	} else {
> > +		hdmi->mc_clkdis |= HDMI_MC_CLKDIS_CSCCLK_DISABLE;
> > +		hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
> > +
> > 
> >  		hdmi_writeb(hdmi, 
HDMI_MC_FLOWCTRL_FEED_THROUGH_OFF_CSC_BYPASS,
> >  		
> >  			    HDMI_MC_FLOWCTRL);
> > 
> > +	}
> > 
> >  }
> >  
> >  /* Workaround to clear the overflow condition */




