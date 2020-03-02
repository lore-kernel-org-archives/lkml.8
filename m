Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF433C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5D32146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Qr8r2Ktj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgCBQBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:01:48 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:59512 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgCBQBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:01:48 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9D35E9D0;
        Mon,  2 Mar 2020 17:01:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1583164905;
        bh=8xsW9GAR0aM5jgCKtEVOt61W0h7SwaVnM/ckN7MbJKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qr8r2Ktj7KXelyNGWtC/to2sGwhKDEtdoFo80PR1O/jmYLYEffTuv81qeyshUYH3T
         QqJ1IF3L1qpPhjheuw6vM8MGVil2R1hXt9Cm1ZmidXNKxyn9uQvWYN/kfA/dvf837W
         262ZSoS48nk+e4FkoT9Xr2V0tFJzu31ay1LSzKDQ=
Date:   Mon, 2 Mar 2020 18:01:21 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     a.hajda@samsung.com, jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com, linux-amlogic@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/11] drm/bridge: dw-hdmi: set mtmdsclock for deep
 color
Message-ID: <20200302160121.GR11960@pendragon.ideasonboard.com>
References: <20200206191834.6125-1-narmstrong@baylibre.com>
 <20200206191834.6125-2-narmstrong@baylibre.com>
 <20200302090527.GB11960@pendragon.ideasonboard.com>
 <a5b6d1f2-8f1c-ae3f-529d-baf7f4cecbe9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5b6d1f2-8f1c-ae3f-529d-baf7f4cecbe9@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,
 
On Mon, Mar 02, 2020 at 04:54:17PM +0100, Neil Armstrong wrote:
> On 02/03/2020 10:05, Laurent Pinchart wrote:
> > On Thu, Feb 06, 2020 at 08:18:24PM +0100, Neil Armstrong wrote:
> >> From: Jonas Karlman <jonas@kwiboo.se>
> >>
> >> Configure the correct mtmdsclock for deep colors to prepare support
> >> for 10, 12 & 16bit output.
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 17 +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> index 67fca439bbfb..9e0927d22db6 100644
> >> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> @@ -1818,9 +1818,26 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
> >>  
> >>  	dev_dbg(hdmi->dev, "final pixclk = %d\n", vmode->mpixelclock);
> > 
> > Nitpicking a bit, I would change
> > 
> > -	vmode->mtmdsclock = vmode->mpixelclock = mode->clock * 1000;
> > +	vmode->mpixelclock = mode->clock * 1000;
> > 
> > above, and here add
> > 
> > 	vmode->mtmdsclock = vmode->mpixelclock;
> > 
> > to keep all mtmdsclock calculation in a single place.
> > 
> >> +	if (!hdmi_bus_fmt_is_yuv422(hdmi->hdmi_data.enc_out_bus_format)) {
> >> +		switch (hdmi_bus_fmt_color_depth(
> >> +				hdmi->hdmi_data.enc_out_bus_format)) {
> >> +		case 16:
> >> +			vmode->mtmdsclock = (u64)vmode->mpixelclock * 2;
> > 
> > Both mpixelclock and mtmdsclock are unsigned int. Is the cast to u64
> > needed ?
> > 
> > On a separate but related note, what does the 'm' in tmdsclock stand for
> > ? It seems to originate from the 'm' prefix for mpixelclock, which has
> > been there from the start. Unless there's a good reason for the prefix,
> > renaming mtmdsclock to tmds_clock (and handling the other fields in the
> > hdmi_vmode structure similarly) would increase clarity I think.
> > 
> >> +			break;
> >> +		case 12:
> >> +			vmode->mtmdsclock = (u64)vmode->mpixelclock * 3 / 2;
> >> +			break;
> >> +		case 10:
> >> +			vmode->mtmdsclock = (u64)vmode->mpixelclock * 5 / 4;
> >> +			break;
> >> +		}
> >> +	}
> >> +
> >>  	if (hdmi_bus_fmt_is_yuv420(hdmi->hdmi_data.enc_out_bus_format))
> >>  		vmode->mtmdsclock /= 2;
> >>  
> >> +	dev_dbg(hdmi->dev, "final tmdsclk = %d\n", vmode->mtmdsclock);
> > 
> > s/tmdsclk/tmdsclock/ to match the field name ?
> > 
> >> +
> >>  	/* Set up HDMI_FC_INVIDCONF */
> >>  	inv_val = (hdmi->hdmi_data.hdcp_enable ||
> >>  		   (dw_hdmi_support_scdc(hdmi) &&
> > 
> 
> I fixed the calculus and the cast, but I'll rename the mtmdsclock in a following patch.
> 
> is it ok for you ?

Sure, works for me.

-- 
Regards,

Laurent Pinchart
