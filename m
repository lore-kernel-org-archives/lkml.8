Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C270FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD6220775
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgGAJK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:10:29 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:51060 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbgGAJK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:10:29 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id ABAC480503;
        Wed,  1 Jul 2020 11:10:22 +0200 (CEST)
Date:   Wed, 1 Jul 2020 11:10:21 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guenter Roeck <linux@roeck-us.net>, g@ravnborg.org
Cc:     Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/aspeed: Call drm_fbdev_generic_setup after
 drm_dev_register
Message-ID: <20200701091021.GA266726@ravnborg.org>
References: <20200701001002.74997-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701001002.74997-1-linux@roeck-us.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=_jlGtV7tAAAA:8 a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8
        a=nW2F_NLVUAjoHKN5T9EA:9 a=CjuIK1q_8ugA:10 a=nlm17XC03S6CtCLSeiRr:22
        a=E9Po1WZjFZOl8hwRPBS3:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter.

On Tue, Jun 30, 2020 at 05:10:02PM -0700, Guenter Roeck wrote:
> The following backtrace is seen when running aspeed G5 kernels.
> 
> WARNING: CPU: 0 PID: 1 at drivers/gpu/drm/drm_fb_helper.c:2233 drm_fbdev_generic_setup+0x138/0x198
> aspeed_gfx 1e6e6000.display: Device has not been registered.
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3 #1
> Hardware name: Generic DT based system
> Backtrace:
> [<8010d6d0>] (dump_backtrace) from [<8010d9b8>] (show_stack+0x20/0x24)
> r7:00000009 r6:60000153 r5:00000000 r4:8119fa94
> [<8010d998>] (show_stack) from [<80b8cb98>] (dump_stack+0xcc/0xec)
> [<80b8cacc>] (dump_stack) from [<80123ef0>] (__warn+0xd8/0xfc)
> r7:00000009 r6:80e62ed0 r5:00000000 r4:974c3ccc
> [<80123e18>] (__warn) from [<80123f98>] (warn_slowpath_fmt+0x84/0xc4)
> r9:00000009 r8:806a0140 r7:000008b9 r6:80e62ed0 r5:80e631f8 r4:974c2000
> [<80123f18>] (warn_slowpath_fmt) from [<806a0140>] (drm_fbdev_generic_setup+0x138/0x198)
> r9:00000001 r8:9758fc10 r7:9758fc00 r6:00000000 r5:00000020 r4:9768a000
> [<806a0008>] (drm_fbdev_generic_setup) from [<806d4558>] (aspeed_gfx_probe+0x204/0x32c)
> r7:9758fc00 r6:00000000 r5:00000000 r4:9768a000
> [<806d4354>] (aspeed_gfx_probe) from [<806dfca0>] (platform_drv_probe+0x58/0xa8)
> 
> Since commit 1aed9509b29a6 ("drm/fb-helper: Remove return value from
> drm_fbdev_generic_setup()"), drm_fbdev_generic_setup() must be called
> after drm_dev_register() to avoid the warning. Do that.
> 
> Fixes: 1aed9509b29a6 ("drm/fb-helper: Remove return value from drm_fbdev_generic_setup()")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

I thought we had this fixed already - but could not find the patch.
Must have been another driver then.

Acked-by: Sam Ravnborg <sam@ravnborg.org>

I assume Joel Stanley will pick up this patch.

	Sam

> ---
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> index 6b27242b9ee3..bca3fcff16ec 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> @@ -173,8 +173,6 @@ static int aspeed_gfx_load(struct drm_device *drm)
>  
>  	drm_mode_config_reset(drm);
>  
> -	drm_fbdev_generic_setup(drm, 32);
> -
>  	return 0;
>  }
>  
> @@ -225,6 +223,7 @@ static int aspeed_gfx_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_unload;
>  
> +	drm_fbdev_generic_setup(&priv->drm, 32);
>  	return 0;
>  
>  err_unload:
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
