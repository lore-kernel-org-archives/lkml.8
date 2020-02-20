Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D21FC11D09
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65534208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wWw0Mo3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgBTN7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:59:51 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:54688 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgBTN7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:59:51 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1814D563;
        Thu, 20 Feb 2020 14:59:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1582207188;
        bh=cXOVS8hXx/ukxmNn0JBNNJRB8BCEUhiM1Fn7R9uSsLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wWw0Mo3btnN0k7EifmoFQf8g9h+NcSHM8egLrEkfLcJm/P0UXu/q+da817lz3fzfB
         O5Tk6uLqVTaHFFTasGhZ2xqq+5cKpoBjdHtIt1IeBkPwItN3+CGHiOkrFleAWdKCts
         k2W9s4Hp10k3DC/9dhZwzhdITKK8X695yoxItqV0=
Date:   Thu, 20 Feb 2020 15:59:29 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>, Torsten Duwe <duwe@suse.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/6] drm/panel: simple: Add NewEast Optoelectronics CO.,
 LTD WJFH116008A panel support
Message-ID: <20200220135929.GF4998@pendragon.ideasonboard.com>
References: <20200220083508.792071-1-anarsoul@gmail.com>
 <20200220083508.792071-6-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200220083508.792071-6-anarsoul@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vasily,

Thank you for the patch.

On Thu, Feb 20, 2020 at 12:35:07AM -0800, Vasily Khoruzhick wrote:
> This commit adds support for the NewEast Optoelectronics CO., LTD
> WJFH116008A 11.6" 1920x1080 TFT LCD panel.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 47 ++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index e14c14ac62b5..aa04afaf3d26 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2224,6 +2224,50 @@ static const struct panel_desc netron_dy_e231732 = {
>  	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
>  };
>  
> +static const struct drm_display_mode neweast_wjfh116008a_modes[] = {
> +{
> +	.clock = 138500,
> +	.hdisplay = 1920,
> +	.hsync_start = 1920 + 48,
> +	.hsync_end = 1920 + 48 + 32,
> +	.htotal = 1920 + 48 + 32 + 80,
> +	.vdisplay = 1080,
> +	.vsync_start = 1080 + 3,
> +	.vsync_end = 1080 + 3 + 5,
> +	.vtotal = 1080 + 3 + 5 + 23,
> +	.vrefresh = 60,
> +	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> +}, {
> +	.clock = 110920,
> +	.hdisplay = 1920,
> +	.hsync_start = 1920 + 48,
> +	.hsync_end = 1920 + 48 + 32,
> +	.htotal = 1920 + 48 + 32 + 80,
> +	.vdisplay = 1080,
> +	.vsync_start = 1080 + 3,
> +	.vsync_end = 1080 + 3 + 5,
> +	.vtotal = 1080 + 3 + 5 + 23,
> +	.vrefresh = 48,
> +	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> +} };

This should be indented one step to the right, see boe_nv101wxmn51_modes
for instance.

The only different between the two modes is the clock, leading to
different refresh rates. Are only those two clock frequencies supported,
or does the panel support anything in-between as well ? In the latter
case, would it make sense to use display_timing instead of
drm_display_mode ? See dlc_dlc0700yzg_1_timing for an example.

> +
> +static const struct panel_desc neweast_wjfh116008a = {
> +	.modes = neweast_wjfh116008a_modes,
> +	.num_modes = 2,
> +	.bpc = 6,
> +	.size = {
> +		.width = 260,
> +		.height = 150,
> +	},
> +	.delay = {
> +		.prepare = 110,
> +		.enable = 20,
> +		.unprepare = 500,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> +	.connector_type = DRM_MODE_CONNECTOR_eDP,
> +};
> +
>  static const struct drm_display_mode newhaven_nhd_43_480272ef_atxl_mode = {
>  	.clock = 9000,
>  	.hdisplay = 480,
> @@ -3399,6 +3443,9 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "netron-dy,e231732",
>  		.data = &netron_dy_e231732,
> +	}, {
> +		.compatible = "neweast,wjfh116008a",
> +		.data = &neweast_wjfh116008a,
>  	}, {
>  		.compatible = "newhaven,nhd-4.3-480272ef-atxl",
>  		.data = &newhaven_nhd_43_480272ef_atxl,

-- 
Regards,

Laurent Pinchart
