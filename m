Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5405C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B359D20936
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgH1SDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 14:03:46 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:47606 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1SDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 14:03:46 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 1DAEB201C1;
        Fri, 28 Aug 2020 20:03:41 +0200 (CEST)
Date:   Fri, 28 Aug 2020 20:03:40 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 2/2] drm: panel: simple: Add AM-1280800N3TZQW-T00H
Message-ID: <20200828180340.GA661644@ravnborg.org>
References: <20200828155938.328982-1-jagan@amarulasolutions.com>
 <20200828155938.328982-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828155938.328982-2-jagan@amarulasolutions.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=CaYmGojl c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=iP-xVBlJAAAA:8 a=Zgqa_LbdGVfCA1qB94sA:9
        a=CjuIK1q_8ugA:10 a=lHLH-nfn2y1bM_0xSXwp:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan.

On Fri, Aug 28, 2020 at 09:29:38PM +0530, Jagan Teki wrote:
> Add Ampire, AM-1280800N3TZQW-T00H 10.1" TFT LCD panel timings.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index b6ecd1552132..c988fe8094f8 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -592,6 +592,31 @@ static void panel_simple_shutdown(struct device *dev)
>  	drm_panel_unprepare(&panel->base);
>  }
>  
> +static const struct drm_display_mode ampire_am_1280800n3tzqw_t00h_mode = {
> +	.clock = 71100,
> +	.hdisplay = 1280,
> +	.hsync_start = 1280 + 40,
> +	.hsync_end = 1280 + 40 + 80,
> +	.htotal = 1280 + 40 + 80 + 40,
> +	.vdisplay = 800,
> +	.vsync_start = 800 + 3,
> +	.vsync_end = 800 + 3 + 10,
> +	.vtotal = 800 + 3 + 10 + 10,
> +	.vrefresh = 60,
No longer preset - delete.

> +	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
> +};
> +
> +static const struct panel_desc ampire_am_1280800n3tzqw_t00h = {
> +	.modes = &ampire_am_1280800n3tzqw_t00h_mode,
> +	.num_modes = 1,
> +	.bpc = 6,
> +	.size = {
> +		.width = 217,
> +		.height = 136,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +};
.connector_type is mandatory today.
And based on connector type you may need to specify .bus_flags.

	Sam

> +
>  static const struct drm_display_mode ampire_am_480272h3tmqw_t01h_mode = {
>  	.clock = 9000,
>  	.hdisplay = 480,
> @@ -3637,6 +3662,9 @@ static const struct panel_desc arm_rtsm = {
>  
>  static const struct of_device_id platform_of_match[] = {
>  	{
> +		.compatible = "ampire,am-1280800n3tzqw-t00h",
> +		.data = &ampire_am_1280800n3tzqw_t00h,
> +	}, {
>  		.compatible = "ampire,am-480272h3tmqw-t01h",
>  		.data = &ampire_am_480272h3tmqw_t01h,
>  	}, {
> -- 
> 2.25.1
