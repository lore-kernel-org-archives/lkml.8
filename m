Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CDBC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AAB32076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgH2VFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 17:05:20 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:51422 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgH2VFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 17:05:19 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 585F9804A4;
        Sat, 29 Aug 2020 23:05:17 +0200 (CEST)
Date:   Sat, 29 Aug 2020 23:05:15 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     "Robert Chiras (OSS)" <robert.chiras@oss.nxp.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] drm/panel: rm67191: Remove CLOCK_NON_CONTINUOUS flag
Message-ID: <20200829210515.GB796939@ravnborg.org>
References: <1598626713-5595-1-git-send-email-robert.chiras@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598626713-5595-1-git-send-email-robert.chiras@oss.nxp.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=A5ZCwZeG c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=8AirrxEcAAAA:8 a=frjSGtBwQt7bNrbYrbUA:9
        a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 05:58:33PM +0300, Robert Chiras (OSS) wrote:
> From: Robert Chiras <robert.chiras@nxp.com>
> 
> The flag MIPI_DSI_CLOCK_NON_CONTINUOUS was wrong used in the DSI driver,
> so it was added to this panel, but not necessary.
> So, remove this flag since it is not needed.
> 
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>

Thanks, applied to drm-misc-next.

	Sam

> ---
>  drivers/gpu/drm/panel/panel-raydium-rm67191.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67191.c b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
> index 23b6208..572547d 100644
> --- a/drivers/gpu/drm/panel/panel-raydium-rm67191.c
> +++ b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
> @@ -552,8 +552,7 @@ static int rad_panel_probe(struct mipi_dsi_device *dsi)
>  	panel->dsi = dsi;
>  
>  	dsi->format = MIPI_DSI_FMT_RGB888;
> -	dsi->mode_flags =  MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> -			   MIPI_DSI_CLOCK_NON_CONTINUOUS;
> +	dsi->mode_flags =  MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO;
>  
>  	ret = of_property_read_u32(np, "video-mode", &video_mode);
>  	if (!ret) {
> -- 
> 2.7.4
