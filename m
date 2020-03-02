Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16CFC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2C8246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgCBJqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:46:54 -0500
Received: from mailoutvs21.siol.net ([185.57.226.212]:42100 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727490AbgCBJqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:46:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id B64A852352B;
        Mon,  2 Mar 2020 10:46:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LKSd7f3jTVIM; Mon,  2 Mar 2020 10:46:50 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 5AE61523492;
        Mon,  2 Mar 2020 10:46:50 +0100 (CET)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id 7D37A52319A;
        Mon,  2 Mar 2020 10:46:49 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     a.hajda@samsung.com, Neil Armstrong <narmstrong@baylibre.com>
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] drm/bridge: dw-hdmi: Fix color space conversion detection
Date:   Mon, 02 Mar 2020 10:46:49 +0100
Message-ID: <791571909.0ifERbkFSE@jernej-laptop>
In-Reply-To: <c1cbcdc0-61a7-e5cb-4ad0-7057c33da154@baylibre.com>
References: <20200229163043.158262-1-jernej.skrabec@siol.net> <20200229163043.158262-3-jernej.skrabec@siol.net> <c1cbcdc0-61a7-e5cb-4ad0-7057c33da154@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil!

Dne ponedeljek, 02. marec 2020 ob 10:26:09 CET je Neil Armstrong napisal(a):
> Hi Jernej,
> 
> On 29/02/2020 17:30, Jernej Skrabec wrote:
> > Currently, is_color_space_conversion() compares not only color spaces
> > but also formats. For example, function would return true if YCbCr 4:4:4
> > and YCbCr 4:2:2 would be set. Obviously in that case color spaces are
> > the same.
> > 
> > Fix that by comparing if both values represent RGB color space.
> > 
> > Fixes: b21f4b658df8 ("drm: imx: imx-hdmi: move imx-hdmi to
> > bridge/dw_hdmi")
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> > 24965e53d351..9d7bfb1cb213 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -956,7 +956,8 @@ static void hdmi_video_sample(struct dw_hdmi *hdmi)
> > 
> >  static int is_color_space_conversion(struct dw_hdmi *hdmi)
> >  {
> > 
> > -	return hdmi->hdmi_data.enc_in_bus_format !=
> > hdmi->hdmi_data.enc_out_bus_format; +	return
> > hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_in_bus_format) !=
> > +		hdmi_bus_fmt_is_rgb(hdmi-
>hdmi_data.enc_out_bus_format);
> > 
> >  }
> >  
> >  static int is_color_space_decimation(struct dw_hdmi *hdmi)
> 
> I think in this case you should also fix the CEC enablement to:

you mean CSC, right?

> if (is_color_space_conversion(hdmi) || is_color_space_decimation(hdmi))
> 
> in dw_hdmi_enable_video_path() otherwise CSC won't be enabled and will be
> bypassed in decimation case only.
> 

Missed that one. I'll fix in v2.

Best regards,
Jernej



