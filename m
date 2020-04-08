Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6ABC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D28A20747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgDHKFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 06:05:40 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:36360 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgDHKFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 06:05:40 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 934022002C;
        Wed,  8 Apr 2020 12:05:37 +0200 (CEST)
Date:   Wed, 8 Apr 2020 12:05:36 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panel: NT39016: Add support for 50 Hz refresh
 rate
Message-ID: <20200408100536.GB20795@ravnborg.org>
References: <20200408095830.8131-1-paul@crapouillou.net>
 <20200408095830.8131-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408095830.8131-2-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=7gkXJVJtAAAA:8 a=4Tl8vMu-OU4bpAJtNNUA:9 a=CjuIK1q_8ugA:10
        a=9LHmKk7ezEChjTCyhBa9:22 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Wed, Apr 08, 2020 at 11:58:30AM +0200, Paul Cercueil wrote:
> By changing the pixel clock and the length of the back porch, it is
> possible to obtain a perfect 50 Hz refresh rate.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Lower case in $subject.

Acked-by: Sam Ravnborg <sam@ravnborg.org>

> ---
>  drivers/gpu/drm/panel/panel-novatek-nt39016.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt39016.c b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
> index f1286cf6528b..05cae8d62d56 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt39016.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
> @@ -325,7 +325,7 @@ static int nt39016_remove(struct spi_device *spi)
>  }
>  
>  static const struct drm_display_mode kd035g6_display_modes[] = {
> -	{
> +	{	/* 60 Hz */
>  		.clock = 6000,
>  		.hdisplay = 320,
>  		.hsync_start = 320 + 10,
> @@ -338,6 +338,19 @@ static const struct drm_display_mode kd035g6_display_modes[] = {
>  		.vrefresh = 60,
>  		.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>  	},
> +	{	/* 50 Hz */
> +		.clock = 5400,
> +		.hdisplay = 320,
> +		.hsync_start = 320 + 42,
> +		.hsync_end = 320 + 42 + 50,
> +		.htotal = 320 + 42 + 50 + 20,
> +		.vdisplay = 240,
> +		.vsync_start = 240 + 5,
> +		.vsync_end = 240 + 5 + 1,
> +		.vtotal = 240 + 5 + 1 + 4,
> +		.vrefresh = 50,
> +		.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> +	},
>  };
>  
>  static const struct nt39016_panel_info kd035g6_info = {
> -- 
> 2.25.1
