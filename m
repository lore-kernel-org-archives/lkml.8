Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E15C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B432078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgGJUAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:00:51 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:56562 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgGJUAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:00:50 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 8C58A804F2;
        Fri, 10 Jul 2020 22:00:46 +0200 (CEST)
Date:   Fri, 10 Jul 2020 22:00:45 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        huijuan.xie@mediatek.com, stonea168@163.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [v2 PATCH] drm/panel: auo, b116xw03: fix flash backlight when
 power on
Message-ID: <20200710200045.GA690424@ravnborg.org>
References: <20200705094514.34526-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705094514.34526-1-jitao.shi@mediatek.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=mpaa-ttXAAAA:8 a=e5mUnYsNAAAA:8
        a=gnzG3gG3vXdd7EKY-HoA:9 a=CjuIK1q_8ugA:10 a=6heAxKwa5pAsJatQ0mat:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 05:45:14PM +0800, Jitao Shi wrote:
> Delay the backlight on to make sure the video stable.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>

Thanks, fixed up and applied to drm-misc-next.

	Sam

> ---
>  drivers/gpu/drm/panel/panel-simple.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 3ad828eaefe1..61781ffa7840 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -724,6 +724,7 @@ static const struct drm_display_mode auo_b116xw03_mode = {
>  	.vsync_end = 768 + 10 + 12,
>  	.vtotal = 768 + 10 + 12 + 6,
>  	.vrefresh = 60,
> +	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
>  };
>  
>  static const struct panel_desc auo_b116xw03 = {
> @@ -734,6 +735,12 @@ static const struct panel_desc auo_b116xw03 = {
>  		.width = 256,
>  		.height = 144,
>  	},
> +	.delay = {
> +		.enable = 400,
> +	},
> +	.bus_flags = DRM_BUS_FLAG_SYNC_DRIVE_NEGEDGE,
> +	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> +	.connector_type = DRM_MODE_CONNECTOR_eDP,
>  };
>  
>  static const struct drm_display_mode auo_b133xtn01_mode = {
> -- 
> 2.25.1
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
