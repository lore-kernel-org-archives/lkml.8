Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F53CC54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 07:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 836C720735
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 07:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgEKHrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 03:47:18 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:53102 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgEKHrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 03:47:17 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 65F4220080;
        Mon, 11 May 2020 09:47:10 +0200 (CEST)
Date:   Mon, 11 May 2020 09:47:08 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     srk@48.io
Cc:     Andrzej Hajda <a.hajda@samsung.com>, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sean Cross <xobs@kosagi.com>, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/2] drm/panel: simple: Add Innolux N133HSE panel support
Message-ID: <20200511074708.GA2759@ravnborg.org>
References: <20200509111834.26335-1-srk@48.io>
 <20200509111834.26335-3-srk@48.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509111834.26335-3-srk@48.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=YpGV6msqAAAA:8 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8
        a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=grMRCvxJCDGD2aPsybUA:9
        a=CjuIK1q_8ugA:10 a=7Sa5D-Tva0wx0rmpRu8Y:22 a=AjGcO6oz07-iQ99wixmX:22
        a=ST-jHhOKWsTCqRlWije3:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard.

On Sat, May 09, 2020 at 01:18:34PM +0200, srk@48.io wrote:
> From: Sean Cross <xobs@kosagi.com>
> 
> The Innolux N133HSE panel is a 13.3" 1920x1080 panel that contains an
> integrated backlight, and connects via eDP.
> 
> It is used in the Kosagi Novena.

Thanks for the patch.


> 
> Signed-off-by: Sean Cross <xobs@kosagi.com>
> Signed-off-by: Richard Marko <srk@48.io>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> To: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 3ad828eaefe1..c8a93771d398 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1906,6 +1906,30 @@ static const struct panel_desc innolux_n116bge = {
>  	},
>  };
>  
> +static const struct drm_display_mode innolux_n133hse_ea1_mode = {
> +	.clock = 138500,
> +	.hdisplay = 1920,
> +	.hsync_start = 1920 + 46,
> +	.hsync_end = 1920 + 46 + 30,
> +	.htotal = 1920 + 46 + 30 + 84,
> +	.vdisplay = 1080,
> +	.vsync_start = 1080 + 2,
> +	.vsync_end = 1080 + 2 + 4,
> +	.vtotal = 1080 + 2 + 4 + 26,
> +	.vrefresh = 60,
> +};
> +
> +static const struct panel_desc innolux_n133hse_ea1 = {
> +	.modes = &innolux_n133hse_ea1_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 293,
> +		.height = 165,
> +	},
> +	.connector_type = DRM_MODE_CONNECTOR_eDP,
Please include .bus_format and .bus_flags info too.

We are relying more and more on this type of info so we need it to be
present.

	Sam



> +};
> +
>  static const struct drm_display_mode innolux_n156bge_l21_mode = {
>  	.clock = 69300,
>  	.hdisplay = 1366,
> @@ -3577,6 +3601,9 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "innolux,n116bge",
>  		.data = &innolux_n116bge,
> +	}, {
> +		.compatible = "innolux,n133hse-ea1",
> +		.data = &innolux_n133hse_ea1,
>  	}, {
>  		.compatible = "innolux,n156bge-l21",
>  		.data = &innolux_n156bge_l21,
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
