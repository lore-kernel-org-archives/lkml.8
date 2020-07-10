Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15839C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3AA52078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGJRfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:35:38 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:49532 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgGJRfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:35:38 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id A9B5E20021;
        Fri, 10 Jul 2020 19:35:34 +0200 (CEST)
Date:   Fri, 10 Jul 2020 19:35:33 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: BACKLIGHT
 CLASS/SUBSYSTEM
Message-ID: <20200710173533.GD17565@ravnborg.org>
References: <20200708163847.15250-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708163847.15250-1-grandmaster@al2klimov.de>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=D19gQVrFAAAA:8 a=sozttTNsAAAA:8 a=977SQLHdAAAA:8
        a=5_BfxKqGAAAA:8 a=e5mUnYsNAAAA:8 a=KDW8W4m8GVoiedxZWeEA:9
        a=tJonOg-6uS59dqR-:21 a=N2so1Rmw42j4sEnq:21 a=CjuIK1q_8ugA:10
        a=W4TVW4IDbPiebHqcZpNg:22 a=aeg5Gbbo78KNqacMgKqU:22
        a=X9mgP9w9NIdro0Z1KHhB:22 a=zA12qxjMqGZfkbtkWw8c:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander.

On Wed, Jul 08, 2020 at 06:38:47PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
> 
>  drivers/video/backlight/led_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
> index 3f66549997c8..2c48957e9b60 100644
> --- a/drivers/video/backlight/led_bl.c
> +++ b/drivers/video/backlight/led_bl.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2015-2019 Texas Instruments Incorporated -  http://www.ti.com/
> + * Copyright (C) 2015-2019 Texas Instruments Incorporated -  https://www.ti.com/
>   * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
>   *
>   * Based on pwm_bl.c

$grep http drivers/video/backlight/*
drivers/video/backlight/cr_bllcd.c: * Intel funded Tungsten Graphics (http://www.tungstengraphics.com) to
drivers/video/backlight/ili9320.c: *	http://armlinux.simtec.co.uk/
drivers/video/backlight/ili9320.h: * http://armlinux.simtec.co.uk/
drivers/video/backlight/led_bl.c: * Copyright (C) 2015-2019 Texas Instruments Incorporated -  http://www.ti.com/
drivers/video/backlight/vgg2432a4.c: *	http://armlinux.simtec.co.uk/

Why are they not covered?

	Sam


> -- 
> 2.27.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
