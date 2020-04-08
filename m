Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD4FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105E220787
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgDHKFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 06:05:02 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:36300 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbgDHKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 06:05:02 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 4D9AB20027;
        Wed,  8 Apr 2020 12:04:58 +0200 (CEST)
Date:   Wed, 8 Apr 2020 12:04:52 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/panel: NT39016: Add support for multiple modes
Message-ID: <20200408100452.GA20795@ravnborg.org>
References: <20200408095830.8131-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408095830.8131-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=7gkXJVJtAAAA:8 a=8HLTJq3glsJ7WriVs_kA:9 a=-XbYOmXvRGsTpmsN:21
        a=WDTzHPRIsYOqDQh2:21 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Wed, Apr 08, 2020 at 11:58:29AM +0200, Paul Cercueil wrote:
> Add support for multiple drm_display_mode entries. This will allow to
> add a 50 Hz mode later.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Patch looks good.

Could we please use lower case in the $subject?

Acked-by: Sam Ravnborg <sam@ravnborg.org>

I asume you will apply yourself.

	Sam

> ---
>  drivers/gpu/drm/panel/panel-novatek-nt39016.c | 33 +++++++++++++------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt39016.c b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
> index a470810f7dbe..f1286cf6528b 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt39016.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
> @@ -49,7 +49,8 @@ enum nt39016_regs {
>  #define NT39016_SYSTEM_STANDBY	BIT(1)
>  
>  struct nt39016_panel_info {
> -	struct drm_display_mode display_mode;
> +	const struct drm_display_mode *display_modes;
> +	unsigned int num_modes;
>  	u16 width_mm, height_mm;
>  	u32 bus_format, bus_flags;
>  };
> @@ -212,15 +213,22 @@ static int nt39016_get_modes(struct drm_panel *drm_panel,
>  	struct nt39016 *panel = to_nt39016(drm_panel);
>  	const struct nt39016_panel_info *panel_info = panel->panel_info;
>  	struct drm_display_mode *mode;
> +	unsigned int i;
>  
> -	mode = drm_mode_duplicate(connector->dev, &panel_info->display_mode);
> -	if (!mode)
> -		return -ENOMEM;
> +	for (i = 0; i < panel_info->num_modes; i++) {
> +		mode = drm_mode_duplicate(connector->dev,
> +					  &panel_info->display_modes[i]);
> +		if (!mode)
> +			return -ENOMEM;
> +
> +		drm_mode_set_name(mode);
>  
> -	drm_mode_set_name(mode);
> +		mode->type = DRM_MODE_TYPE_DRIVER;
> +		if (panel_info->num_modes == 1)
> +			mode->type |= DRM_MODE_TYPE_PREFERRED;
>  
> -	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> -	drm_mode_probed_add(connector, mode);
> +		drm_mode_probed_add(connector, mode);
> +	}
>  
>  	connector->display_info.bpc = 8;
>  	connector->display_info.width_mm = panel_info->width_mm;
> @@ -230,7 +238,7 @@ static int nt39016_get_modes(struct drm_panel *drm_panel,
>  					 &panel_info->bus_format, 1);
>  	connector->display_info.bus_flags = panel_info->bus_flags;
>  
> -	return 1;
> +	return panel_info->num_modes;
>  }
>  
>  static const struct drm_panel_funcs nt39016_funcs = {
> @@ -316,8 +324,8 @@ static int nt39016_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> -static const struct nt39016_panel_info kd035g6_info = {
> -	.display_mode = {
> +static const struct drm_display_mode kd035g6_display_modes[] = {
> +	{
>  		.clock = 6000,
>  		.hdisplay = 320,
>  		.hsync_start = 320 + 10,
> @@ -330,6 +338,11 @@ static const struct nt39016_panel_info kd035g6_info = {
>  		.vrefresh = 60,
>  		.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>  	},
> +};
> +
> +static const struct nt39016_panel_info kd035g6_info = {
> +	.display_modes = kd035g6_display_modes,
> +	.num_modes = ARRAY_SIZE(kd035g6_display_modes),
>  	.width_mm = 71,
>  	.height_mm = 53,
>  	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> -- 
> 2.25.1
