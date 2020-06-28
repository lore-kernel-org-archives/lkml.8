Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889B0C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66EDB20768
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="uOXm1rRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgF1H2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 03:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgF1H2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 03:28:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850F0C061794;
        Sun, 28 Jun 2020 00:28:23 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C030C4FB;
        Sun, 28 Jun 2020 09:28:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593329301;
        bh=ck+LjAkxjFbi+T46BUzZf+XpAk4V6f33vhP8DfWZQHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uOXm1rRxayXR+zKQy3KRDZgAUKQTQRWl8eKer9/zKORUNd5yFoInZcCU7aBUs+y6Y
         YOr58xIXYiNhUT0myqyZxMLrTlYE7PeBX/ITh9unu3mm08hj0KPhRkuDwGD1NnIT71
         ZdSA1chOyEZIx1s1yK9BircekQKa03LFbtHav0iw=
Date:   Sun, 28 Jun 2020 10:28:19 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pascal Roeleven <dev@pascalroeleven.nl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 2/5] drm: panel: Add Starry KR070PE2T
Message-ID: <20200628072819.GB8391@pendragon.ideasonboard.com>
References: <20200320112205.7100-1-dev@pascalroeleven.nl>
 <20200320112205.7100-3-dev@pascalroeleven.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200320112205.7100-3-dev@pascalroeleven.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pascal,

On Fri, Mar 20, 2020 at 12:21:33PM +0100, Pascal Roeleven wrote:
> The KR070PE2T is a 7" panel with a resolution of 800x480.
> 
> KR070PE2T is the marking present on the ribbon cable. As this panel is
> probably available under different brands, this marking will catch
> most devices.
> 
> As I can't find a datasheet for this panel, the bus_flags are instead
> from trial-and-error. The flags seem to be common for these kind of
> panels as well.
> 
> Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index e14c14ac6..b3d257257 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2842,6 +2842,32 @@ static const struct panel_desc shelly_sca07010_bfn_lnn = {
>  	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
>  };
>  
> +static const struct drm_display_mode starry_kr070pe2t_mode = {
> +	.clock = 33000,
> +	.hdisplay = 800,
> +	.hsync_start = 800 + 209,
> +	.hsync_end = 800 + 209 + 1,
> +	.htotal = 800 + 209 + 1 + 45,
> +	.vdisplay = 480,
> +	.vsync_start = 480 + 22,
> +	.vsync_end = 480 + 22 + 1,
> +	.vtotal = 480 + 22 + 1 + 22,
> +	.vrefresh = 60,
> +};
> +
> +static const struct panel_desc starry_kr070pe2t = {
> +	.modes = &starry_kr070pe2t_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 152,
> +		.height = 86,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,

I'm trying to fix inconsistencies in the panel-simple driver, and this
caught my eyes. MEDIA_BUS_FMT_RGB888_1X24 isn't a correct format for
LVDS panels. MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
MEDIA_BUS_FMT_RGB888_1X7X4_SPWG or MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA
should be used instead. As I couldn't find documentation for the panel,
I can't tell which format is correct. Could you please help ?

> +};
> +
>  static const struct drm_display_mode starry_kr122ea0sra_mode = {
>  	.clock = 147000,
>  	.hdisplay = 1920,
> @@ -3474,6 +3500,9 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "shelly,sca07010-bfn-lnn",
>  		.data = &shelly_sca07010_bfn_lnn,
> +	}, {
> +		.compatible = "starry,kr070pe2t",
> +		.data = &starry_kr070pe2t,
>  	}, {
>  		.compatible = "starry,kr122ea0sra",
>  		.data = &starry_kr122ea0sra,

-- 
Regards,

Laurent Pinchart
