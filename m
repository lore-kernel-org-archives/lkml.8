Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82487C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A99246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="cwlhJHtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgCBJhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:37:54 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:50698 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCBJhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:37:53 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 00E6E54A;
        Mon,  2 Mar 2020 10:37:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1583141872;
        bh=JaiLwKwLjbPQuu84TSj6iCTI4JbyTTiFDByTAxo6at0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cwlhJHtIEgnNQ53Hmp8isgrboXULKcbj4DthZ127fTLcRs2IRyEnA43pDcWOLmgtX
         0/3jRu7JSVq7+lldyxuk8/en/DJHOCMYAPkF/hQ/scvzhICy2dRofuOsoAFgfc+3tR
         bkynMlVN6FWoRhsTQj2kz0BCydMkSLjWhS6RW+gw=
Date:   Mon, 2 Mar 2020 11:37:28 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] drm/bridge: dw-hdmi: do not force "none" scan mode
Message-ID: <20200302093728.GF11960@pendragon.ideasonboard.com>
References: <20200229163043.158262-1-jernej.skrabec@siol.net>
 <20200229163043.158262-4-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200229163043.158262-4-jernej.skrabec@siol.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej and Jonas,

Thank you for the patch.

On Sat, Feb 29, 2020 at 05:30:42PM +0100, Jernej Skrabec wrote:
> From: Jonas Karlman <jonas@kwiboo.se>
> 
> Setting scan mode to "none" confuses some TVs like LG B8, which randomly
> change overscan procentage over time. Digital outputs like HDMI and DVI,

s/procentage/percentage/ ?

> handled by this controller, don't really need overscan, so we can always
> set scan mode to underscan. Actually, this is exactly what
> drm_hdmi_avi_infoframe_from_display_mode() already does, so we can just
> remove offending line.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> [updated commit message]
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 9d7bfb1cb213..3d6021119942 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1655,8 +1655,6 @@ static void hdmi_config_AVI(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>  			HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
>  	}
>  
> -	frame.scan_mode = HDMI_SCAN_MODE_NONE;
> -
>  	/*
>  	 * The Designware IP uses a different byte format from standard
>  	 * AVI info frames, though generally the bits are in the correct

-- 
Regards,

Laurent Pinchart
